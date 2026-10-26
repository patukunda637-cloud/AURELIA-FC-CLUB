using System;

namespace AureliaFc.Web.Models
{
    public class Competition
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Season { get; set; }
    }

    /// <summary>One row of the league table (table: league_standings).</summary>
    public class LeagueStanding
    {
        public int Id { get; set; }
        public int CompetitionId { get; set; }
        public int Position { get; set; }
        public string ClubName { get; set; }
        public int Played { get; set; }
        public int Won { get; set; }
        public int Drawn { get; set; }
        public int Lost { get; set; }
        public int GoalsFor { get; set; }
        public int GoalsAgainst { get; set; }

        /// <summary>Derived in SQL - goal_difference is not a stored column.</summary>
        public int GoalDifference { get { return GoalsFor - GoalsAgainst; } }

        /// <summary>Derived in SQL - points is not a stored column.</summary>
        public int Points { get { return (Won * 3) + Drawn; } }

        /// <summary>The club's own row is highlighted in the design.</summary>
        public bool IsAurelia { get { return ClubName == "Aurelia FC"; } }
    }

    public class LeagueTable
    {
        public Competition Competition { get; set; }
        public System.Collections.Generic.List<LeagueStanding> Rows { get; set; }
    }

    /// <summary>A fixture or completed match (table: matches).</summary>
    public class Match
    {
        public int Id { get; set; }
        public int CompetitionId { get; set; }
        public string HomeTeam { get; set; }
        public string AwayTeam { get; set; }
        public DateTime KickoffAt { get; set; }
        public string Venue { get; set; }
        public bool IsHome { get; set; }
        public string Status { get; set; }
        public int? HomeScore { get; set; }
        public int? AwayScore { get; set; }
        public int? Attendance { get; set; }
        public string MatchReport { get; set; }

        /// <summary>Joined from the competitions lookup.</summary>
        public string Competition { get; set; }
        public string CompetitionType { get; set; }

        /// <summary>Ticket availability joined from ticket_fixtures when present.</summary>
        public TicketFixture Ticket { get; set; }

        public string DateLabel { get { return Services.Formatting.ShortDate(KickoffAt); } }
        public string TimeLabel { get { return Services.Formatting.TimeLabel(KickoffAt); } }
        public string KickoffIso { get { return KickoffAt.ToString("yyyy-MM-ddTHH:mm:ss"); } }
        public string StatusLabel { get { return Status == "Completed" ? "COMPLETED MATCH" : "UPCOMING FIXTURE"; } }

        public string ScoreLabel
        {
            get
            {
                return IsCompleted ? HomeScore + " - " + AwayScore : "VS";
            }
        }

        /// <summary>En-dash separator used on the match detail screen ("3 – 1").</summary>
        public string DetailScoreLabel
        {
            get { return HomeScore.HasValue && AwayScore.HasValue ? HomeScore + " \u2013 " + AwayScore : "\u2013"; }
        }

        public bool IsCompleted { get { return Status == "Completed" && HomeScore.HasValue && AwayScore.HasValue; } }

        public bool TicketsAvailable { get { return Ticket != null && Ticket.AvailableSeats > 0; } }

        public string Outcome
        {
            get
            {
                if (!IsCompleted) return string.Empty;
                var us = IsHome ? HomeScore.Value : AwayScore.Value;
                var them = IsHome ? AwayScore.Value : HomeScore.Value;
                if (us > them) return "W";
                if (us < them) return "L";
                return "D";
            }
        }

        public string HomeAwayLabel { get { return IsHome ? "HOME GAME" : "AWAY GAME"; } }
    }

    public class MatchEvent
    {
        public int Id { get; set; }
        public int MatchId { get; set; }
        public int Minute { get; set; }
        public string TeamSide { get; set; }
        public string PlayerName { get; set; }
        public string EventType { get; set; }
        public int SortOrder { get; set; }

        public bool IsHome { get { return TeamSide == "Home"; } }
        public string MinuteLabel { get { return Minute + "'"; } }
    }

    public class MatchStat
    {
        public int Id { get; set; }
        public int MatchId { get; set; }
        public string StatLabel { get; set; }
        public string HomeValue { get; set; }
        public string AwayValue { get; set; }
        public int SortOrder { get; set; }
    }

    public class MatchLineup
    {
        public int Id { get; set; }
        public int MatchId { get; set; }
        public string Side { get; set; }
        public string Formation { get; set; }
        public string SquadNo { get; set; }
        public string PlayerName { get; set; }
        public string RoleCode { get; set; }
        public int SortOrder { get; set; }

        public bool IsHome { get { return Side == "Home"; } }
    }
}
