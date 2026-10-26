using System;
using System.Collections.Generic;
using AureliaFc.Web.Models;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>Reads club identity, history, honours, partners and FAQ content.</summary>
    public class ClubRepository
    {
        public ClubInfo GetClubInfo()
        {
            const string sql = @"SELECT id, club_name, motto, founded_year, description, stadium_name,
                                        capacity, built_year, record_attendance, address, phone
                                 FROM club_info ORDER BY id LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                if (!reader.Read()) return null;
                return new ClubInfo
                {
                    Id = reader.GetInt32("id"),
                    ClubName = reader.GetString("club_name"),
                    Motto = reader.GetString("motto"),
                    FoundedYear = reader.GetInt32("founded_year"),
                    Description = reader.GetString("description"),
                    StadiumName = reader.GetString("stadium_name"),
                    Capacity = reader.GetInt32("capacity"),
                    BuiltYear = reader.GetInt32("built_year"),
                    RecordAttendance = reader.GetInt32("record_attendance"),
                    Address = reader.GetString("address"),
                    Phone = reader.GetString("phone")
                };
            }
        }

        public List<ClubMilestone> GetMilestones()
        {
            const string sql = @"SELECT id, year_label, title, body, sort_order
                                 FROM club_milestones ORDER BY sort_order, id";
            return ReadList(sql, r => new ClubMilestone
            {
                Id = r.GetInt32("id"),
                YearLabel = r.GetString("year_label"),
                Title = r.GetString("title"),
                Body = r.GetString("body"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        public List<ClubValue> GetValues()
        {
            const string sql = @"SELECT id, title, body, sort_order
                                 FROM club_values ORDER BY sort_order, id";
            return ReadList(sql, r => new ClubValue
            {
                Id = r.GetInt32("id"),
                Title = r.GetString("title"),
                Body = r.GetString("body"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        public List<ClubHonour> GetHonours()
        {
            const string sql = @"SELECT id, title, years, count_label, sort_order
                                 FROM club_honours ORDER BY sort_order, id";
            return ReadList(sql, r => new ClubHonour
            {
                Id = r.GetInt32("id"),
                Title = r.GetString("title"),
                Years = r.GetString("years"),
                CountLabel = r.GetString("count_label"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        public List<ClubExecutive> GetExecutives()
        {
            const string sql = @"SELECT id, full_name, role_title, image_path, sort_order
                                 FROM club_executives ORDER BY sort_order, id";
            return ReadList(sql, r => new ClubExecutive
            {
                Id = r.GetInt32("id"),
                FullName = r.GetString("full_name"),
                RoleTitle = r.GetString("role_title"),
                ImagePath = r.GetNullableString("image_path"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        public List<Partner> GetPartners()
        {
            const string sql = @"SELECT id, name, sort_order FROM partners ORDER BY sort_order, id";
            return ReadList(sql, r => new Partner
            {
                Id = r.GetInt32("id"),
                Name = r.GetString("name"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        public List<QuickLink> GetQuickLinks()
        {
            const string sql = @"SELECT id, label, href, sort_order FROM quick_links ORDER BY sort_order, id";
            return ReadList(sql, r => new QuickLink
            {
                Id = r.GetInt32("id"),
                Label = r.GetString("label"),
                Href = r.GetString("href"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        public List<ContactDepartment> GetDepartments()
        {
            const string sql = @"SELECT id, name, email, phone, note, sort_order
                                 FROM contact_departments ORDER BY sort_order, id";
            return ReadList(sql, r => new ContactDepartment
            {
                Id = r.GetInt32("id"),
                Name = r.GetString("name"),
                Email = r.GetString("email"),
                Phone = r.GetNullableString("phone"),
                Note = r.GetNullableString("note"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        public List<Faq> GetFaqs()
        {
            const string sql = @"SELECT id, question, answer, sort_order FROM faqs ORDER BY sort_order, id";
            return ReadList(sql, r => new Faq
            {
                Id = r.GetInt32("id"),
                Question = r.GetString("question"),
                Answer = r.GetString("answer"),
                SortOrder = r.GetInt32("sort_order")
            });
        }

        private static List<T> ReadList<T>(string sql, Func<MySqlDataReader, T> map)
        {
            var results = new List<T>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read()) results.Add(map(reader));
            }
            return results;
        }

        /// <summary>Persists a message submitted through the Contact form and returns its new id.</summary>
        public int CreateMessage(string fullName, string email, string subject, string message, int? userId)
        {
            const string sql =
                @"INSERT INTO contact_messages (full_name, email, subject, message, user_id, created_at, is_handled)
                  VALUES (@fullName, @email, @subject, @message, @userId, UTC_TIMESTAMP(), 0);
                  SELECT LAST_INSERT_ID();";

            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@fullName", fullName);
                command.Parameters.AddWithValue("@email", email);
                command.Parameters.AddWithValue("@subject", subject);
                command.Parameters.AddWithValue("@message", message);
                command.Parameters.AddWithValue("@userId", (object)userId ?? DBNull.Value);
                return Convert.ToInt32(command.ExecuteScalar());
            }
        }

        /// <summary>Stored contact messages for the admin reporting view, newest first.</summary>
        public List<ContactMessage> GetMessages(int limit)
        {
            var sql = @"SELECT id, full_name, email, subject, message, user_id, created_at, is_handled
                        FROM contact_messages ORDER BY created_at DESC, id DESC" +
                      (limit > 0 ? " LIMIT " + limit : string.Empty);

            return ReadList(sql, r => new ContactMessage
            {
                Id = r.GetInt32("id"),
                FullName = r.GetString("full_name"),
                Email = r.GetString("email"),
                Subject = r.GetString("subject"),
                Message = r.GetString("message"),
                UserId = r.GetNullableInt32("user_id"),
                CreatedAt = r.GetDateTime("created_at"),
                IsHandled = r.GetBoolean("is_handled")
            });
        }
    }
}
