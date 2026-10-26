namespace AureliaFc.Web.Models
{
    public class ProductCategory
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int SortOrder { get; set; }
    }

    /// <summary>An item sold in the Official Store (table: products).</summary>
    public class Product
    {
        public int Id { get; set; }
        public int CategoryId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string ImagePath { get; set; }
        public string Badge { get; set; }
        public bool IsFeatured { get; set; }
        public string Description { get; set; }
        public int SortOrder { get; set; }

        /// <summary>Joined from the product_categories lookup.</summary>
        public string Category { get; set; }

        public string PriceLabel { get { return Services.Formatting.Money(Price); } }
    }

    /// <summary>Ticket availability for a home fixture (table: ticket_fixtures).</summary>
    public class TicketFixture
    {
        public int Id { get; set; }
        public int MatchId { get; set; }
        public decimal PriceMin { get; set; }
        public decimal PriceMax { get; set; }
        public int AvailableSeats { get; set; }
        public string StatusLabel { get; set; }

        /// <summary>Joined from the matches lookup.</summary>
        public Match Match { get; set; }

        public string DateLabel
        {
            get { return Match == null ? string.Empty : Services.Formatting.LongDateWithDay(Match.KickoffAt); }
        }

        public string MonthLabel { get { return Match == null ? string.Empty : Services.Formatting.FullMonth(Match.KickoffAt); } }
        public string DayLabel { get { return Match == null ? "00" : Match.KickoffAt.Day.ToString("00"); } }

        public string Tournament
        {
            get { return Match == null ? string.Empty : (Match.Competition ?? string.Empty); }
        }

        public string MatchLabel
        {
            get { return Match == null ? string.Empty : Match.HomeTeam + " vs " + Match.AwayTeam; }
        }

        public string Venue { get { return Match == null ? string.Empty : Match.Venue; } }
        public string HomeTeam { get { return Match == null ? string.Empty : Match.HomeTeam; } }
        public string AwayTeam { get { return Match == null ? string.Empty : Match.AwayTeam; } }
        public string KickoffLabel { get { return Match == null ? string.Empty : Match.TimeLabel; } }

        public string PriceRange { get { return Services.Formatting.Money(PriceMin) + " \u2013 " + Services.Formatting.Money(PriceMax); } }

        public bool IsSellingFast { get { return StatusLabel == "Selling Fast"; } }
    }

    public class SeasonTicketTier
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public int SortOrder { get; set; }

        public System.Collections.Generic.List<string> Features { get; set; }

        public SeasonTicketTier()
        {
            Features = new System.Collections.Generic.List<string>();
        }

        public string PriceLabel { get { return Services.Formatting.Money(Price) + " / season"; } }
    }

    public class HospitalityPackage
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string PriceUnit { get; set; }
        public string Description { get; set; }
        public string ImagePath { get; set; }
        public int SortOrder { get; set; }

        public string PriceLabel { get { return Services.Formatting.Money(Price) + " " + PriceUnit; } }
    }
}
