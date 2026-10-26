using System;
using System.Collections.Generic;
using System.Web;
using AureliaFc.Web.Models;

namespace AureliaFc.Web.Services
{
    /// <summary>
    /// Server-side basket held in Session. It carries the same four line kinds the
    /// storefront and box office sell (product, match ticket, season ticket and
    /// hospitality package), and never trusts a client-supplied price: every line is
    /// re-resolved against the catalogue whenever it is displayed or checked out.
    /// </summary>
    public static class CartService
    {
        private const string SessionKey = "aurelia_cart";

        /// <summary>A basket line: what is wanted and how many.</summary>
        [Serializable]
        public sealed class Line
        {
            public string ItemType { get; set; }
            public int? ItemRefId { get; set; }
            public int Quantity { get; set; }

            public string Key
            {
                get { return ItemType + ":" + (ItemRefId.HasValue ? ItemRefId.Value.ToString() : "0"); }
            }
        }

        private static List<Line> Lines
        {
            get
            {
                var session = HttpContext.Current == null ? null : HttpContext.Current.Session;
                if (session == null) return new List<Line>();
                var lines = session[SessionKey] as List<Line>;
                if (lines == null)
                {
                    lines = new List<Line>();
                    session[SessionKey] = lines;
                }
                return lines;
            }
        }

        private static Line Find(string itemType, int? itemRefId)
        {
            return Lines.Find(l =>
                string.Equals(l.ItemType, itemType, StringComparison.OrdinalIgnoreCase) &&
                l.ItemRefId == itemRefId);
        }

        public static void Add(string itemType, int? itemRefId, int quantity)
        {
            if (string.IsNullOrWhiteSpace(itemType)) return;
            if (!DAL.OrderRepository.IsKnownItemType(itemType)) return;
            if (!itemRefId.HasValue || itemRefId.Value <= 0) return;
            if (quantity < 1) quantity = 1;
            if (quantity > 99) quantity = 99;

            var existing = Find(itemType, itemRefId);
            if (existing == null)
                Lines.Add(new Line { ItemType = itemType, ItemRefId = itemRefId, Quantity = quantity });
            else
                existing.Quantity = Math.Min(99, existing.Quantity + quantity);
        }

        public static void SetQuantity(string key, int quantity)
        {
            var lines = Lines;
            var existing = lines.Find(l => l.Key == key);
            if (existing == null) return;
            if (quantity < 1) lines.Remove(existing);
            else existing.Quantity = Math.Min(99, quantity);
        }

        public static void Remove(string key)
        {
            Lines.RemoveAll(l => l.Key == key);
        }

        public static void Clear()
        {
            var session = HttpContext.Current == null ? null : HttpContext.Current.Session;
            if (session != null) session[SessionKey] = new List<Line>();
        }

        public static IList<Line> CurrentLines { get { return Lines.AsReadOnly(); } }

        /// <summary>Total number of items, shown next to the Cart link in the header.</summary>
        public static int ItemCount
        {
            get
            {
                var total = 0;
                foreach (var line in Lines) total += line.Quantity;
                return total;
            }
        }

        /// <summary>
        /// Materialises the basket against the live catalogue so the basket screen shows
        /// names and prices that always match the database. Lines whose catalogue record
        /// has disappeared are dropped.
        /// </summary>
        public static List<CartItem> GetItems()
        {
            var items = new List<CartItem>();
            var repository = new DAL.CommerceRepository();

            foreach (var line in Lines)
            {
                string description;
                decimal unitPrice;
                if (!repository.TryResolveOrderItem(line.ItemType, line.ItemRefId, out description, out unitPrice))
                    continue;

                items.Add(new CartItem
                {
                    Key = line.Key,
                    ItemType = line.ItemType,
                    ItemRefId = line.ItemRefId,
                    Description = description,
                    UnitPrice = unitPrice,
                    Quantity = line.Quantity
                });
            }

            return items;
        }

        /// <summary>Basket total, recomputed from the catalogue prices.</summary>
        public static decimal Subtotal
        {
            get
            {
                var total = 0m;
                foreach (var item in GetItems()) total += item.LineTotal;
                return total;
            }
        }

        public sealed class CartItem
        {
            public string Key { get; set; }
            public string ItemType { get; set; }
            public int? ItemRefId { get; set; }
            public string Description { get; set; }
            public decimal UnitPrice { get; set; }
            public int Quantity { get; set; }

            public decimal LineTotal { get { return UnitPrice * Quantity; } }
            public string UnitPriceLabel { get { return Formatting.Money(UnitPrice); } }
            public string LineTotalLabel { get { return Formatting.Money(LineTotal); } }
        }
    }
}
