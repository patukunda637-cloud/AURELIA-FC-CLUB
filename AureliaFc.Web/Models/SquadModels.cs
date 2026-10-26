namespace AureliaFc.Web.Models
{
    /// <summary>A squad within the club structure (table: teams).</summary>
    public class Team
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Coach { get; set; }
        public int PlayerCount { get; set; }
        public string Description { get; set; }
        public string ImagePath { get; set; }
        public int SortOrder { get; set; }
    }

    /// <summary>Playing position lookup (table: positions).</summary>
    public class Position
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    /// <summary>A footballer registered to a squad (table: players).</summary>
    public class Player
    {
        public int Id { get; set; }
        public int TeamId { get; set; }
        public int PositionId { get; set; }
        public int SquadNumber { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Nationality { get; set; }
        public System.DateTime? DateOfBirth { get; set; }
        public int? HeightCm { get; set; }
        public string Bio { get; set; }
        public string ImagePath { get; set; }
        public int Goals { get; set; }
        public int Assists { get; set; }
        public int Appearances { get; set; }
        public decimal AvgRating { get; set; }

        /// <summary>Joined from the positions lookup.</summary>
        public string Position { get; set; }

        /// <summary>Joined from the teams lookup.</summary>
        public string TeamName { get; set; }

        public string FullName { get { return (FirstName + " " + LastName).Trim(); } }

        /// <summary>Goalkeepers | Defenders | Midfielders | Forwards - matches the filter chips.</summary>
        public string PositionGroup { get { return Services.Formatting.PositionGroup(PositionId); } }
    }

    /// <summary>Per-month statistics shown in the Season Statistics table.</summary>
    public class PlayerSeasonStat
    {
        public int Id { get; set; }
        public int PlayerId { get; set; }
        public string Season { get; set; }
        public string MonthLabel { get; set; }
        public int SortOrder { get; set; }
        public int Apps { get; set; }
        public int Goals { get; set; }
        public int Assists { get; set; }
    }

    /// <summary>A previous club spell shown in the Career History panel.</summary>
    public class PlayerCareerEntry
    {
        public int Id { get; set; }
        public int PlayerId { get; set; }
        public string ClubName { get; set; }
        public string Period { get; set; }
        public int? Appearances { get; set; }
        public int? Goals { get; set; }
        public string Note { get; set; }
        public int SortOrder { get; set; }
    }
}
