using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>
    /// Small helpers over <see cref="MySqlDataReader"/> so the repositories can map rows
    /// without repeating null checks. All lookups are by column name, so adding a column
    /// to a SELECT never silently shifts the mapping.
    /// </summary>
    internal static class ReaderExtensions
    {
        public static string GetString(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            return reader.IsDBNull(index) ? string.Empty : reader.GetString(index);
        }

        public static string GetNullableString(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            return reader.IsDBNull(index) ? null : reader.GetString(index);
        }

        public static int GetInt32(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            return reader.IsDBNull(index) ? 0 : reader.GetInt32(index);
        }

        public static int? GetNullableInt32(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            return reader.IsDBNull(index) ? (int?)null : reader.GetInt32(index);
        }

        public static decimal GetDecimal(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            return reader.IsDBNull(index) ? 0m : reader.GetDecimal(index);
        }

        public static bool GetBoolean(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            if (reader.IsDBNull(index)) return false;
            var value = reader.GetValue(index);
            if (value is bool) return (bool)value;
            return Convert.ToInt32(value) != 0;
        }

        public static DateTime GetDateTime(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            return reader.IsDBNull(index) ? DateTime.MinValue : reader.GetDateTime(index);
        }

        public static DateTime? GetNullableDateTime(this MySqlDataReader reader, string column)
        {
            var index = reader.GetOrdinal(column);
            return reader.IsDBNull(index) ? (DateTime?)null : reader.GetDateTime(index);
        }
    }
}
