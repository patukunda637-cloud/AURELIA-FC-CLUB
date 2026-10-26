using System;
using System.Collections.Generic;
using AureliaFc.Web.Models;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>Reads fixtures, results, the league table and match detail.</summary>
    public class MatchRepository
    {
        private const string MatchColumns =
            @"SELECT m.id, m.competition_id, m.home_team, m.away_team, m.kickoff_at, m.venue,
                     m.is_home, m.status, m.home_score, m.away_score, m.attendance, m.match_report,
                     c.name AS competition_name, c.type AS competition_type,
                     tf.id AS ticket_id, tf.price_min, tf.price_max, tf.available_seats, tf.status_label
              FROM matches m
              LEFT JOIN competitions c ON c.id = m.competition_id
              LEFT JOIN ticket_fixtures tf ON tf.match_id = m.id";

        /// <summary>
        /// Fixtures and results, newest first.
        /// status = null/"all" | "upcoming" | "results".
        /// </summary>
        public List<Match> GetMatches(string status)
        {
            var filter = string.Empty;
            switch ((status ?? "all").ToLowerInvariant())
            {
                case "upcoming":
                    filter = " WHERE m.status = 'Scheduled'";
                    break;
                case "results":
                    filter = " WHERE m.status = 'Completed'";
                    break;
            }

            var sql = MatchColumns + filter + " ORDER BY m.kickoff_at DESC, m.id DESC";
            var results = new List<Match>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read()) results.Add(MapMatch(reader));
            }
            return results;
        }

        /// <summary>The next scheduled fixture (earliest upcoming kick-off).</summary>
        public Match GetNextMatch()
        {
            var sql = MatchColumns + " WHERE m.status = 'Scheduled' ORDER BY m.kickoff_at ASC, m.id ASC LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                return reader.Read() ? MapMatch(reader) : null;
            }
        }

        /// <summary>The most recent completed matches, newest first.</summary>
        public List<Match> GetRecentResults(int take)
        {
            var sql = MatchColumns + " WHERE m.status = 'Completed' ORDER BY m.kickoff_at DESC, m.id DESC LIMIT " + take;
            var results = new List<Match>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read()) results.Add(MapMatch(reader));
            }
            return results;
        }

        public Match GetMatch(int id)
        {
            var sql = MatchColumns + " WHERE m.id = @id LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", id);
                using (var reader = command.ExecuteReader())
                {
                    return reader.Read() ? MapMatch(reader) : null;
                }
            }
        }

        public List<MatchEvent> GetEvents(int matchId)
        {
            const string sql = @"SELECT id, match_id, minute, team_side, player_name, event_type, sort_order
                                 FROM match_events WHERE match_id = @id ORDER BY sort_order, id";
            var results = new List<MatchEvent>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", matchId);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        results.Add(new MatchEvent
                        {
                            Id = reader.GetInt32("id"),
                            MatchId = reader.GetInt32("match_id"),
                            Minute = reader.GetInt32("minute"),
                            TeamSide = reader.GetString("team_side"),
                            PlayerName = reader.GetString("player_name"),
                            EventType = reader.GetString("event_type"),
                            SortOrder = reader.GetInt32("sort_order")
                        });
                    }
                }
            }
            return results;
        }

        public List<MatchStat> GetStats(int matchId)
        {
            const string sql = @"SELECT id, match_id, stat_label, home_value, away_value, sort_order
                                 FROM match_stats WHERE match_id = @id ORDER BY sort_order, id";
            var results = new List<MatchStat>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", matchId);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        results.Add(new MatchStat
                        {
                            Id = reader.GetInt32("id"),
                            MatchId = reader.GetInt32("match_id"),
                            StatLabel = reader.GetString("stat_label"),
                            HomeValue = reader.GetString("home_value"),
                            AwayValue = reader.GetString("away_value"),
                            SortOrder = reader.GetInt32("sort_order")
                        });
                    }
                }
            }
            return results;
        }

        /// <summary>Starting XI entries, home side first. side = null returns both.</summary>
        public List<MatchLineup> GetLineups(int matchId, string side)
        {
            const string sql = @"SELECT id, match_id, side, formation, squad_no, player_name, role_code, sort_order
                                 FROM match_lineups
                                 WHERE match_id = @id AND (@side IS NULL OR side = @side)
                                 ORDER BY (side = 'Home') DESC, sort_order, id";
            var results = new List<MatchLineup>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", matchId);
                command.Parameters.AddWithValue("@side", (object)side ?? DBNull.Value);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        results.Add(new MatchLineup
                        {
                            Id = reader.GetInt32("id"),
                            MatchId = reader.GetInt32("match_id"),
                            Side = reader.GetString("side"),
                            Formation = reader.GetString("formation"),
                            SquadNo = reader.GetString("squad_no"),
                            PlayerName = reader.GetString("player_name"),
                            RoleCode = reader.GetString("role_code"),
                            SortOrder = reader.GetInt32("sort_order")
                        });
                    }
                }
            }
            return results;
        }

        /// <summary>
        /// The league table. goal_difference and points are derived here in SQL because
        /// the schema stores only the raw played/won/drawn/lost/goals columns.
        /// </summary>
        public LeagueTable GetStandings(string season)
        {
            var competition = GetCompetition(season);
            if (competition == null) return null;

            // The goals columns are unsigned, so the subtraction has to be cast to a
            // signed value first: otherwise a club that has conceded more than it
            // scored makes MySQL raise "BIGINT UNSIGNED value is out of range".
            const string sql =
                @"SELECT id, competition_id, position, club_name, played, won, drawn, lost,
                         goals_for, goals_against,
                         (CAST(goals_for AS SIGNED) - CAST(goals_against AS SIGNED)) AS goal_difference,
                         (won * 3 + drawn) AS points
                  FROM league_standings
                  WHERE competition_id = @competitionId
                  ORDER BY position, id";

            var table = new LeagueTable { Competition = competition, Rows = new List<LeagueStanding>() };
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@competitionId", competition.Id);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        table.Rows.Add(new LeagueStanding
                        {
                            Id = reader.GetInt32("id"),
                            CompetitionId = reader.GetInt32("competition_id"),
                            Position = reader.GetInt32("position"),
                            ClubName = reader.GetString("club_name"),
                            Played = reader.GetInt32("played"),
                            Won = reader.GetInt32("won"),
                            Drawn = reader.GetInt32("drawn"),
                            Lost = reader.GetInt32("lost"),
                            GoalsFor = reader.GetInt32("goals_for"),
                            GoalsAgainst = reader.GetInt32("goals_against")
                        });
                    }
                }
            }
            return table;
        }

        public Competition GetCompetition(string season)
        {
            var sql = "SELECT id, name, type, season FROM competitions" +
                      (string.IsNullOrWhiteSpace(season) ? string.Empty : " WHERE season = @season") +
                      " ORDER BY id LIMIT 1";

            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                if (!string.IsNullOrWhiteSpace(season)) command.Parameters.AddWithValue("@season", season);
                using (var reader = command.ExecuteReader())
                {
                    if (!reader.Read()) return null;
                    return new Competition
                    {
                        Id = reader.GetInt32("id"),
                        Name = reader.GetString("name"),
                        Type = reader.GetString("type"),
                        Season = reader.GetString("season")
                    };
                }
            }
        }

        private static Match MapMatch(MySqlDataReader reader)
        {
            var match = new Match
            {
                Id = reader.GetInt32("id"),
                CompetitionId = reader.GetInt32("competition_id"),
                HomeTeam = reader.GetString("home_team"),
                AwayTeam = reader.GetString("away_team"),
                KickoffAt = reader.GetDateTime("kickoff_at"),
                Venue = reader.GetString("venue"),
                IsHome = reader.GetBoolean("is_home"),
                Status = reader.GetString("status"),
                HomeScore = reader.GetNullableInt32("home_score"),
                AwayScore = reader.GetNullableInt32("away_score"),
                Attendance = reader.GetNullableInt32("attendance"),
                MatchReport = reader.GetNullableString("match_report"),
                Competition = reader.GetString("competition_name"),
                CompetitionType = reader.GetString("competition_type")
            };

            var ticketId = reader.GetNullableInt32("ticket_id");
            if (ticketId.HasValue)
            {
                match.Ticket = new TicketFixture
                {
                    Id = ticketId.Value,
                    MatchId = match.Id,
                    PriceMin = reader.GetDecimal("price_min"),
                    PriceMax = reader.GetDecimal("price_max"),
                    AvailableSeats = reader.GetInt32("available_seats"),
                    StatusLabel = reader.GetString("status_label"),
                    Match = match
                };
            }
            return match;
        }
    }
}
