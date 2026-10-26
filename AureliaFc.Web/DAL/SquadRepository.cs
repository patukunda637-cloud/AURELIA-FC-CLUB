using System;
using System.Collections.Generic;
using AureliaFc.Web.Models;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>Reads squads, players, season statistics and career history.</summary>
    public class SquadRepository
    {
        private const string PlayerColumns =
            @"SELECT p.id, p.team_id, p.position_id, p.squad_number, p.first_name, p.last_name,
                     p.nationality, p.date_of_birth, p.height_cm, p.bio, p.image_path,
                     p.goals, p.assists, p.appearances, p.avg_rating,
                     pos.name AS position_name, t.name AS team_name
              FROM players p
              LEFT JOIN positions pos ON pos.id = p.position_id
              LEFT JOIN teams t ON t.id = p.team_id";

        public List<Team> GetTeams()
        {
            const string sql = @"SELECT id, name, coach, player_count, description, image_path, sort_order
                                 FROM teams ORDER BY sort_order, id";
            var results = new List<Team>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    results.Add(new Team
                    {
                        Id = reader.GetInt32("id"),
                        Name = reader.GetString("name"),
                        Coach = reader.GetString("coach"),
                        PlayerCount = reader.GetInt32("player_count"),
                        Description = reader.GetNullableString("description"),
                        ImagePath = reader.GetNullableString("image_path"),
                        SortOrder = reader.GetInt32("sort_order")
                    });
                }
            }
            return results;
        }

        public Team GetTeam(int id)
        {
            const string sql = @"SELECT id, name, coach, player_count, description, image_path, sort_order
                                 FROM teams WHERE id = @id LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", id);
                using (var reader = command.ExecuteReader())
                {
                    if (!reader.Read()) return null;
                    return new Team
                    {
                        Id = reader.GetInt32("id"),
                        Name = reader.GetString("name"),
                        Coach = reader.GetString("coach"),
                        PlayerCount = reader.GetInt32("player_count"),
                        Description = reader.GetNullableString("description"),
                        ImagePath = reader.GetNullableString("image_path"),
                        SortOrder = reader.GetInt32("sort_order")
                    };
                }
            }
        }

        /// <summary>
        /// Squad listing. Filters mirror the Players page chips and search box.
        /// positionGroup is "All"/null for no filter; search matches name, position or nationality.
        /// </summary>
        public List<Player> GetPlayers(int? teamId, string positionGroup, string search)
        {
            var where = new List<string>();
            var parameters = new List<MySqlParameter>();

            if (teamId.HasValue)
            {
                where.Add("p.team_id = @teamId");
                parameters.Add(new MySqlParameter("@teamId", teamId.Value));
            }

            var group = MapPositionGroup(positionGroup);
            if (group.HasValue)
            {
                where.Add("p.position_id = @positionId");
                parameters.Add(new MySqlParameter("@positionId", group.Value));
            }

            if (!string.IsNullOrWhiteSpace(search))
            {
                where.Add("(CONCAT(p.first_name, ' ', p.last_name) LIKE @term " +
                          "OR pos.name LIKE @term OR p.nationality LIKE @term)");
                parameters.Add(new MySqlParameter("@term", "%" + search.Trim() + "%"));
            }

            var sql = PlayerColumns +
                      (where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : string.Empty) +
                      " ORDER BY p.team_id, p.squad_number";

            var results = new List<Player>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                foreach (var parameter in parameters) command.Parameters.Add(parameter);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read()) results.Add(MapPlayer(reader));
                }
            }
            return results;
        }

        public Player GetPlayer(int id)
        {
            var sql = PlayerColumns + " WHERE p.id = @id LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", id);
                using (var reader = command.ExecuteReader())
                {
                    return reader.Read() ? MapPlayer(reader) : null;
                }
            }
        }

        public List<PlayerSeasonStat> GetSeasonStats(int playerId)
        {
            const string sql = @"SELECT id, player_id, season, month_label, sort_order, apps, goals, assists
                                 FROM player_season_stats WHERE player_id = @id ORDER BY sort_order, id";
            var results = new List<PlayerSeasonStat>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", playerId);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        results.Add(new PlayerSeasonStat
                        {
                            Id = reader.GetInt32("id"),
                            PlayerId = reader.GetInt32("player_id"),
                            Season = reader.GetString("season"),
                            MonthLabel = reader.GetString("month_label"),
                            SortOrder = reader.GetInt32("sort_order"),
                            Apps = reader.GetInt32("apps"),
                            Goals = reader.GetInt32("goals"),
                            Assists = reader.GetInt32("assists")
                        });
                    }
                }
            }
            return results;
        }

        public List<PlayerCareerEntry> GetCareerHistory(int playerId)
        {
            const string sql = @"SELECT id, player_id, club_name, period, appearances, goals, note, sort_order
                                 FROM player_career_history WHERE player_id = @id ORDER BY sort_order, id";
            var results = new List<PlayerCareerEntry>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", playerId);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        results.Add(new PlayerCareerEntry
                        {
                            Id = reader.GetInt32("id"),
                            PlayerId = reader.GetInt32("player_id"),
                            ClubName = reader.GetString("club_name"),
                            Period = reader.GetString("period"),
                            Appearances = reader.GetNullableInt32("appearances"),
                            Goals = reader.GetNullableInt32("goals"),
                            Note = reader.GetNullableString("note"),
                            SortOrder = reader.GetInt32("sort_order")
                        });
                    }
                }
            }
            return results;
        }

        /// <summary>Players whose squad numbers are highlighted on the home page (9, 7, 4).</summary>
        public List<Player> GetFeaturedPlayers(int teamId, int take)
        {
            var sql = PlayerColumns +
                      @" WHERE p.team_id = @teamId AND p.squad_number IN (9, 7, 4)
                          ORDER BY FIELD(p.squad_number, 9, 7, 4) LIMIT " + take;

            var results = new List<Player>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@teamId", teamId);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read()) results.Add(MapPlayer(reader));
                }
            }
            return results;
        }

        private static int? MapPositionGroup(string positionGroup)
        {
            if (string.IsNullOrWhiteSpace(positionGroup) ||
                positionGroup.Equals("All", StringComparison.OrdinalIgnoreCase))
                return null;

            switch (positionGroup.Trim())
            {
                case "Goalkeepers": return 1;
                case "Defenders": return 2;
                case "Midfielders": return 3;
                case "Forwards": return 4;
                default: return null;
            }
        }

        private static Player MapPlayer(MySqlDataReader reader)
        {
            return new Player
            {
                Id = reader.GetInt32("id"),
                TeamId = reader.GetInt32("team_id"),
                PositionId = reader.GetInt32("position_id"),
                SquadNumber = reader.GetInt32("squad_number"),
                FirstName = reader.GetString("first_name"),
                LastName = reader.GetString("last_name"),
                Nationality = reader.GetString("nationality"),
                DateOfBirth = reader.GetNullableDateTime("date_of_birth"),
                HeightCm = reader.GetNullableInt32("height_cm"),
                Bio = reader.GetNullableString("bio"),
                ImagePath = reader.GetNullableString("image_path"),
                Goals = reader.GetInt32("goals"),
                Assists = reader.GetInt32("assists"),
                Appearances = reader.GetInt32("appearances"),
                AvgRating = reader.GetDecimal("avg_rating"),
                Position = reader.GetString("position_name"),
                TeamName = reader.GetString("team_name")
            };
        }
    }
}
