using System;
using System.Collections.Generic;
using AureliaFc.Web.Models;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>Reads the store catalogue, ticket availability and hospitality packages.</summary>
    public class CommerceRepository
    {
        public List<ProductCategory> GetCategories()
        {
            const string sql = "SELECT id, name, sort_order FROM product_categories ORDER BY sort_order, id";
            var results = new List<ProductCategory>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    results.Add(new ProductCategory
                    {
                        Id = reader.GetInt32("id"),
                        Name = reader.GetString("name"),
                        SortOrder = reader.GetInt32("sort_order")
                    });
                }
            }
            return results;
        }

        /// <summary>Products; category = null | "All" returns everything.</summary>
        public List<Product> GetProducts(string category)
        {
            var filter = string.IsNullOrWhiteSpace(category) ||
                         category.Equals("All", StringComparison.OrdinalIgnoreCase)
                ? string.Empty
                : " WHERE c.name = @category";

            var sql =
                @"SELECT p.id, p.category_id, p.name, p.price, p.image_path, p.badge, p.is_featured,
                         p.description, p.sort_order, c.name AS category_name
                  FROM products p
                  LEFT JOIN product_categories c ON c.id = p.category_id" +
                filter + " ORDER BY p.sort_order, p.id";

            var results = new List<Product>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                if (filter.Length > 0) command.Parameters.AddWithValue("@category", category);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read()) results.Add(MapProduct(reader));
                }
            }
            return results;
        }

        public Product GetProduct(int id)
        {
            const string sql =
                @"SELECT p.id, p.category_id, p.name, p.price, p.image_path, p.badge, p.is_featured,
                         p.description, p.sort_order, c.name AS category_name
                  FROM products p
                  LEFT JOIN product_categories c ON c.id = p.category_id
                  WHERE p.id = @id LIMIT 1";

            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", id);
                using (var reader = command.ExecuteReader())
                {
                    return reader.Read() ? MapProduct(reader) : null;
                }
            }
        }

        /// <summary>The single product flagged as featured in the store hero.</summary>
        public Product GetFeaturedProduct()
        {
            const string sql =
                @"SELECT p.id, p.category_id, p.name, p.price, p.image_path, p.badge, p.is_featured,
                         p.description, p.sort_order, c.name AS category_name
                  FROM products p
                  LEFT JOIN product_categories c ON c.id = p.category_id
                  WHERE p.is_featured = 1 ORDER BY p.sort_order, p.id LIMIT 1";

            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                return reader.Read() ? MapProduct(reader) : null;
            }
        }

        /// <summary>Match ticket availability rows on the Tickets page.</summary>
        public List<TicketFixture> GetTicketFixtures()
        {
            const string sql =
                @"SELECT tf.id, tf.match_id, tf.price_min, tf.price_max, tf.available_seats, tf.status_label,
                         m.home_team, m.away_team, m.kickoff_at, m.venue, c.name AS competition_name
                  FROM ticket_fixtures tf
                  JOIN matches m ON m.id = tf.match_id
                  LEFT JOIN competitions c ON c.id = m.competition_id
                  ORDER BY m.kickoff_at, tf.id";

            var results = new List<TicketFixture>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    var match = new Match
                    {
                        Id = reader.GetInt32("match_id"),
                        HomeTeam = reader.GetString("home_team"),
                        AwayTeam = reader.GetString("away_team"),
                        KickoffAt = reader.GetDateTime("kickoff_at"),
                        Venue = reader.GetString("venue"),
                        Competition = reader.GetString("competition_name")
                    };

                    results.Add(new TicketFixture
                    {
                        Id = reader.GetInt32("id"),
                        MatchId = match.Id,
                        PriceMin = reader.GetDecimal("price_min"),
                        PriceMax = reader.GetDecimal("price_max"),
                        AvailableSeats = reader.GetInt32("available_seats"),
                        StatusLabel = reader.GetString("status_label"),
                        Match = match
                    });
                }
            }
            return results;
        }

        public List<SeasonTicketTier> GetSeasonTiers()
        {
            var tiers = new List<SeasonTicketTier>();
            using (var connection = AureliaDatabase.Open())
            {
                using (var command = new MySqlCommand(
                    "SELECT id, name, price, description, sort_order FROM season_ticket_tiers ORDER BY sort_order, id",
                    connection))
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        tiers.Add(new SeasonTicketTier
                        {
                            Id = reader.GetInt32("id"),
                            Name = reader.GetString("name"),
                            Price = reader.GetDecimal("price"),
                            Description = reader.GetString("description"),
                            SortOrder = reader.GetInt32("sort_order")
                        });
                    }
                }

                using (var featureCommand = new MySqlCommand(
                    "SELECT tier_id, feature FROM season_ticket_features ORDER BY sort_order, id", connection))
                using (var reader = featureCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var tierId = reader.GetInt32("tier_id");
                        var feature = reader.GetString("feature");
                        foreach (var tier in tiers)
                            if (tier.Id == tierId) tier.Features.Add(feature);
                    }
                }
            }
            return tiers;
        }

        public List<HospitalityPackage> GetHospitality()
        {
            const string sql = @"SELECT id, name, price, price_unit, description, image_path, sort_order
                                 FROM hospitality_packages ORDER BY sort_order, id";
            var results = new List<HospitalityPackage>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    results.Add(new HospitalityPackage
                    {
                        Id = reader.GetInt32("id"),
                        Name = reader.GetString("name"),
                        Price = reader.GetDecimal("price"),
                        PriceUnit = reader.GetString("price_unit"),
                        Description = reader.GetString("description"),
                        ImagePath = reader.GetNullableString("image_path"),
                        SortOrder = reader.GetInt32("sort_order")
                    });
                }
            }
            return results;
        }

        /// <summary>
        /// Resolves a basket line back to the catalogue so the cart can never show a
        /// price that differs from the database. Returns false when the referenced
        /// record no longer exists.
        /// </summary>
        public bool TryResolveOrderItem(string itemType, int? itemRefId, out string description, out decimal unitPrice)
        {
            description = null;
            unitPrice = 0m;

            if (string.IsNullOrWhiteSpace(itemType)) return false;

            if (itemType.Equals("Product", StringComparison.OrdinalIgnoreCase))
            {
                if (!itemRefId.HasValue) return false;
                var product = GetProduct(itemRefId.Value);
                if (product == null) return false;
                description = product.Name;
                unitPrice = product.Price;
                return true;
            }

            if (itemType.Equals("MatchTicket", StringComparison.OrdinalIgnoreCase))
            {
                if (!itemRefId.HasValue) return false;
                const string sql =
                    @"SELECT tf.price_min, m.home_team, m.away_team, m.kickoff_at
                      FROM ticket_fixtures tf JOIN matches m ON m.id = tf.match_id
                      WHERE tf.match_id = @matchId ORDER BY tf.id LIMIT 1";
                using (var connection = AureliaDatabase.Open())
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@matchId", itemRefId.Value);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return false;
                        description = reader.GetString("home_team") + " vs " + reader.GetString("away_team") +
                                      " \u00b7 " + Services.Formatting.LongDateWithDay(reader.GetDateTime("kickoff_at"));
                        unitPrice = reader.GetDecimal("price_min");
                        return true;
                    }
                }
            }

            if (itemType.Equals("SeasonTicket", StringComparison.OrdinalIgnoreCase))
            {
                if (!itemRefId.HasValue) return false;
                using (var connection = AureliaDatabase.Open())
                using (var command = new MySqlCommand(
                    "SELECT name, price FROM season_ticket_tiers WHERE id = @id LIMIT 1", connection))
                {
                    command.Parameters.AddWithValue("@id", itemRefId.Value);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return false;
                        description = reader.GetString("name") + " Season Ticket";
                        unitPrice = reader.GetDecimal("price");
                        return true;
                    }
                }
            }

            if (itemType.Equals("Hospitality", StringComparison.OrdinalIgnoreCase))
            {
                if (!itemRefId.HasValue) return false;
                using (var connection = AureliaDatabase.Open())
                using (var command = new MySqlCommand(
                    "SELECT name, price FROM hospitality_packages WHERE id = @id LIMIT 1", connection))
                {
                    command.Parameters.AddWithValue("@id", itemRefId.Value);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return false;
                        description = reader.GetString("name");
                        unitPrice = reader.GetDecimal("price");
                        return true;
                    }
                }
            }

            return false;
        }

        private static Product MapProduct(MySqlDataReader reader)
        {
            return new Product
            {
                Id = reader.GetInt32("id"),
                CategoryId = reader.GetInt32("category_id"),
                Name = reader.GetString("name"),
                Price = reader.GetDecimal("price"),
                ImagePath = reader.GetNullableString("image_path"),
                Badge = reader.GetNullableString("badge"),
                IsFeatured = reader.GetBoolean("is_featured"),
                Description = reader.GetNullableString("description"),
                SortOrder = reader.GetInt32("sort_order"),
                Category = reader.GetString("category_name")
            };
        }
    }
}
