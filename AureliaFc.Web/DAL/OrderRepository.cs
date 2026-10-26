using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using AureliaFc.Web.Models;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>
    /// Writes orders and order items, and reads them back.
    ///
    /// Product lines are ALWAYS re-priced from the products table inside a transaction
    /// before the total is calculated, so a tampered client-side price can never change
    /// what is charged - the same guarantee the JSON API provides.
    /// </summary>
    public class OrderRepository
    {
        private static readonly HashSet<string> OrderTypes =
            new HashSet<string>(StringComparer.OrdinalIgnoreCase) { "Shop", "Tickets", "SeasonTicket", "Hospitality" };

        private static readonly HashSet<string> ItemTypes =
            new HashSet<string>(StringComparer.OrdinalIgnoreCase) { "Product", "MatchTicket", "SeasonTicket", "Hospitality" };

        public static bool IsKnownOrderType(string value) { return value != null && OrderTypes.Contains(value); }
        public static bool IsKnownItemType(string value) { return value != null && ItemTypes.Contains(value); }

        /// <summary>
        /// Persists an order. Returns the new order id.
        /// Callers must have already validated the request and confirmed the user (if any).
        /// </summary>
        public int Create(int? userId, string orderType, List<OrderItem> requestedItems)
        {
            var verified = new List<OrderItem>();
            int orderId;

            using (var connection = AureliaDatabase.Open())
            using (var transaction = connection.BeginTransaction())
            {
                // ---- 1. re-price every line from the catalogue ----
                foreach (var item in requestedItems)
                {
                    if (!IsKnownItemType(item.ItemType))
                        throw new InvalidOperationException("Unknown item type '" + item.ItemType + "'.");
                    if (item.Quantity < 1 || item.Quantity > 99)
                        throw new InvalidOperationException("Item quantity must be between 1 and 99.");

                    var description = (item.Description ?? string.Empty).Trim();
                    var unitPrice = item.UnitPrice;

                    // Every known line kind is re-priced from its own table, so neither a
                    // tampered price nor a stale basket can change what is charged.
                    string catalogueDescription;
                    decimal cataloguePrice;
                    if (item.ItemRefId.HasValue &&
                        TryReadCatalogueItem(connection, transaction, item.ItemType, item.ItemRefId.Value,
                                             out catalogueDescription, out cataloguePrice))
                    {
                        description = catalogueDescription;
                        unitPrice = cataloguePrice;
                    }
                    else if (item.ItemType.Equals("Product", StringComparison.OrdinalIgnoreCase))
                    {
                        throw new InvalidOperationException("Unknown product " + item.ItemRefId + ".");
                    }

                    if (description.Length == 0) description = item.ItemType;

                    verified.Add(new OrderItem
                    {
                        ItemType = item.ItemType,
                        ItemRefId = item.ItemRefId,
                        Description = description,
                        Quantity = item.Quantity,
                        UnitPrice = unitPrice
                    });
                }

                var total = 0m;
                foreach (var item in verified) total += item.UnitPrice * item.Quantity;

                // ---- 2. insert the order header ----
                const string orderSql =
                    @"INSERT INTO orders (user_id, reference, order_type, status, total_amount, created_at)
                      VALUES (@userId, @reference, @orderType, 'Pending', @total, UTC_TIMESTAMP());
                      SELECT LAST_INSERT_ID();";

                using (var command = new MySqlCommand(orderSql, connection, transaction))
                {
                    command.Parameters.AddWithValue("@userId", (object)userId ?? DBNull.Value);
                    command.Parameters.AddWithValue("@reference", NewReference("AUR"));
                    command.Parameters.AddWithValue("@orderType", orderType);
                    command.Parameters.AddWithValue("@total", total);
                    orderId = Convert.ToInt32(command.ExecuteScalar());
                }

                // ---- 3. insert the verified lines ----
                const string itemSql =
                    @"INSERT INTO order_items (order_id, item_type, item_ref_id, description, quantity, unit_price)
                      VALUES (@orderId, @itemType, @itemRefId, @description, @quantity, @unitPrice)";

                foreach (var item in verified)
                {
                    using (var command = new MySqlCommand(itemSql, connection, transaction))
                    {
                        command.Parameters.AddWithValue("@orderId", orderId);
                        command.Parameters.AddWithValue("@itemType", item.ItemType);
                        command.Parameters.AddWithValue("@itemRefId", (object)item.ItemRefId ?? DBNull.Value);
                        command.Parameters.AddWithValue("@description", item.Description);
                        command.Parameters.AddWithValue("@quantity", item.Quantity);
                        command.Parameters.AddWithValue("@unitPrice", item.UnitPrice);
                        command.ExecuteNonQuery();
                    }
                }

                transaction.Commit();
            }

            return orderId;
        }

        public Order GetOrder(int id)
        {
            const string sql = @"SELECT id, user_id, reference, order_type, status, total_amount, created_at
                                 FROM orders WHERE id = @id LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            {
                Order order = null;
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@id", id);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return null;
                        order = new Order
                        {
                            Id = reader.GetInt32("id"),
                            UserId = reader.GetNullableInt32("user_id"),
                            Reference = reader.GetString("reference"),
                            OrderType = reader.GetString("order_type"),
                            Status = reader.GetString("status"),
                            TotalAmount = reader.GetDecimal("total_amount"),
                            CreatedAt = reader.GetDateTime("created_at")
                        };
                    }
                }
                order.Items = LoadItems(connection, order.Id);
                return order;
            }
        }

        /// <summary>Order history for one supporter, newest first.</summary>
        public List<Order> GetOrdersForUser(int userId)
        {
            const string sql = @"SELECT id, user_id, reference, order_type, status, total_amount, created_at
                                 FROM orders WHERE user_id = @userId ORDER BY created_at DESC, id DESC";
            var orders = new List<Order>();
            using (var connection = AureliaDatabase.Open())
            {
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@userId", userId);
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new Order
                            {
                                Id = reader.GetInt32("id"),
                                UserId = reader.GetNullableInt32("user_id"),
                                Reference = reader.GetString("reference"),
                                OrderType = reader.GetString("order_type"),
                                Status = reader.GetString("status"),
                                TotalAmount = reader.GetDecimal("total_amount"),
                                CreatedAt = reader.GetDateTime("created_at")
                            });
                        }
                    }
                }

                foreach (var order in orders) order.Items = LoadItems(connection, order.Id);
            }
            return orders;
        }

        private static List<OrderItem> LoadItems(MySqlConnection connection, int orderId)
        {
            const string sql = @"SELECT id, order_id, item_type, item_ref_id, description, quantity, unit_price
                                 FROM order_items WHERE order_id = @orderId ORDER BY id";
            var items = new List<OrderItem>();
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@orderId", orderId);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        items.Add(new OrderItem
                        {
                            Id = reader.GetInt32("id"),
                            OrderId = reader.GetInt32("order_id"),
                            ItemType = reader.GetString("item_type"),
                            ItemRefId = reader.GetNullableInt32("item_ref_id"),
                            Description = reader.GetString("description"),
                            Quantity = reader.GetInt32("quantity"),
                            UnitPrice = reader.GetDecimal("unit_price")
                        });
                    }
                }
            }
            return items;
        }

        /// <summary>
        /// Reads the authoritative description and price for one line kind inside the
        /// order transaction. Returns false when the catalogue row no longer exists.
        /// </summary>
        private static bool TryReadCatalogueItem(MySqlConnection connection, MySqlTransaction transaction,
                                                 string itemType, int itemRefId,
                                                 out string description, out decimal price)
        {
            description = null;
            price = 0m;

            if (itemType.Equals("Product", StringComparison.OrdinalIgnoreCase))
            {
                using (var command = new MySqlCommand("SELECT name, price FROM products WHERE id = @id LIMIT 1",
                                                      connection, transaction))
                {
                    command.Parameters.AddWithValue("@id", itemRefId);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return false;
                        description = reader.GetString("name");
                        price = reader.GetDecimal("price");
                        return true;
                    }
                }
            }

            if (itemType.Equals("MatchTicket", StringComparison.OrdinalIgnoreCase))
            {
                const string sql =
                    @"SELECT tf.price_min, m.home_team, m.away_team, m.kickoff_at
                      FROM ticket_fixtures tf JOIN matches m ON m.id = tf.match_id
                      WHERE tf.match_id = @id ORDER BY tf.id LIMIT 1";
                using (var command = new MySqlCommand(sql, connection, transaction))
                {
                    command.Parameters.AddWithValue("@id", itemRefId);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return false;
                        description = reader.GetString("home_team") + " vs " + reader.GetString("away_team") +
                                      " \u00b7 " + Services.Formatting.LongDateWithDay(reader.GetDateTime("kickoff_at"));
                        price = reader.GetDecimal("price_min");
                        return true;
                    }
                }
            }

            if (itemType.Equals("SeasonTicket", StringComparison.OrdinalIgnoreCase))
            {
                using (var command = new MySqlCommand(
                    "SELECT name, price FROM season_ticket_tiers WHERE id = @id LIMIT 1", connection, transaction))
                {
                    command.Parameters.AddWithValue("@id", itemRefId);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return false;
                        description = reader.GetString("name") + " Season Ticket";
                        price = reader.GetDecimal("price");
                        return true;
                    }
                }
            }

            if (itemType.Equals("Hospitality", StringComparison.OrdinalIgnoreCase))
            {
                using (var command = new MySqlCommand(
                    "SELECT name, price FROM hospitality_packages WHERE id = @id LIMIT 1", connection, transaction))
                {
                    command.Parameters.AddWithValue("@id", itemRefId);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return false;
                        description = reader.GetString("name");
                        price = reader.GetDecimal("price");
                        return true;
                    }
                }
            }

            return false;
        }

        private const string Alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

        /// <summary>Generates the same 12-character reference format the API issues ("AUR" + 9).</summary>
        public static string NewReference(string prefix)
        {
            var builder = new StringBuilder(prefix);
            // RNGCryptoServiceProvider is the .NET Framework 4.8 CSPRNG
            // (RandomNumberGenerator.GetBytes(int) is .NET Core only).
            using (var random = new RNGCryptoServiceProvider())
            {
                var buffer = new byte[9];
                random.GetBytes(buffer);
                for (var i = 0; i < 9; i++)
                    builder.Append(Alphabet[buffer[i] % Alphabet.Length]);
            }
            return builder.ToString();
        }
    }
}
