using System;
using AureliaFc.Web.Models;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>Reads and writes supporter accounts (table: users).</summary>
    public class UserRepository
    {
        public User FindByEmail(string email)
        {
            const string sql = @"SELECT id, first_name, last_name, email, password_hash, role, created_at, updated_at
                                 FROM users WHERE email = @email LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@email", email);
                using (var reader = command.ExecuteReader())
                {
                    return reader.Read() ? Map(reader) : null;
                }
            }
        }

        public User FindById(int id)
        {
            const string sql = @"SELECT id, first_name, last_name, email, password_hash, role, created_at, updated_at
                                 FROM users WHERE id = @id LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@id", id);
                using (var reader = command.ExecuteReader())
                {
                    return reader.Read() ? Map(reader) : null;
                }
            }
        }

        public bool EmailExists(string email)
        {
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand("SELECT COUNT(*) FROM users WHERE email = @email", connection))
            {
                command.Parameters.AddWithValue("@email", email);
                return Convert.ToInt64(command.ExecuteScalar()) > 0;
            }
        }

        /// <summary>Inserts a new supporter and returns the generated id.</summary>
        public int Create(string firstName, string lastName, string email, string passwordHash, string role)
        {
            const string sql =
                @"INSERT INTO users (first_name, last_name, email, password_hash, role, created_at, updated_at)
                  VALUES (@firstName, @lastName, @email, @passwordHash, @role, UTC_TIMESTAMP(), UTC_TIMESTAMP());
                  SELECT LAST_INSERT_ID();";

            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@firstName", firstName);
                command.Parameters.AddWithValue("@lastName", lastName);
                command.Parameters.AddWithValue("@email", email);
                command.Parameters.AddWithValue("@passwordHash", passwordHash);
                command.Parameters.AddWithValue("@role", role);
                return Convert.ToInt32(command.ExecuteScalar());
            }
        }

        private static User Map(MySqlDataReader reader)
        {
            return new User
            {
                Id = reader.GetInt32("id"),
                FirstName = reader.GetString("first_name"),
                LastName = reader.GetString("last_name"),
                Email = reader.GetString("email"),
                PasswordHash = reader.GetString("password_hash"),
                Role = reader.GetString("role"),
                CreatedAt = reader.GetDateTime("created_at"),
                UpdatedAt = reader.GetDateTime("updated_at")
            };
        }
    }
}
