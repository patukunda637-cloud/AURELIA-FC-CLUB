namespace AureliaFc.Web.Models
{
    /// <summary>Purchase record for shop items, tickets or packages (table: orders).</summary>
    public class Order
    {
        public int Id { get; set; }
        public int? UserId { get; set; }
        public string Reference { get; set; }
        public string OrderType { get; set; }
        public string Status { get; set; }
        public decimal TotalAmount { get; set; }
        public System.DateTime CreatedAt { get; set; }

        public System.Collections.Generic.List<OrderItem> Items { get; set; }

        public Order()
        {
            Items = new System.Collections.Generic.List<OrderItem>();
        }

        public string TotalLabel { get { return Services.Formatting.Money(TotalAmount); } }
        public string CreatedLabel { get { return CreatedAt.ToString("yyyy-MM-dd HH:mm:ss"); } }
    }

    public class OrderItem
    {
        public int Id { get; set; }
        public int OrderId { get; set; }
        public string ItemType { get; set; }
        public int? ItemRefId { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }

        public string UnitPriceLabel { get { return Services.Formatting.Money(UnitPrice); } }
        public string LineTotalLabel { get { return Services.Formatting.Money(UnitPrice * Quantity); } }
    }

    /// <summary>Message submitted through the Contact form (table: contact_messages).</summary>
    public class ContactMessage
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Subject { get; set; }
        public string Message { get; set; }
        public int? UserId { get; set; }
        public System.DateTime CreatedAt { get; set; }
        public bool IsHandled { get; set; }

        public string Reference { get { return "MSG-" + Id.ToString("000000"); } }
        public string CreatedLabel { get { return CreatedAt.ToString("yyyy-MM-dd HH:mm"); } }
    }
}
