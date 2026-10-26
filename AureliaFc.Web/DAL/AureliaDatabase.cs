using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>
    /// Central place that resolves the MySQL connection string and opens connections.
    ///
    /// Resolution order (first match wins):
    ///   1. the ConnectionStrings__Aurelia environment variable
    ///   2. the AURELIA_CONNECTION_STRING environment variable
    ///   3. the "Aurelia" connection string in Web.config (development fallback)
    ///
    /// No credential is ever compiled into the assembly; the Web.config entry is a
    /// documented, overridable development fallback only.
    /// </summary>
    public static class AureliaDatabase
    {
        private static readonly string Resolved = Resolve();

        public static string ConnectionString { get { return Resolved; } }

        private static string Resolve()
        {
            var fromEnvironment = Environment.GetEnvironmentVariable("ConnectionStrings__Aurelia");
            if (!string.IsNullOrWhiteSpace(fromEnvironment)) return fromEnvironment.Trim();

            var altEnvironment = Environment.GetEnvironmentVariable("AURELIA_CONNECTION_STRING");
            if (!string.IsNullOrWhiteSpace(altEnvironment)) return altEnvironment.Trim();

            var setting = ConfigurationManager.ConnectionStrings["Aurelia"];
            if (setting != null && !string.IsNullOrWhiteSpace(setting.ConnectionString))
                return setting.ConnectionString;

            throw new ConfigurationErrorsException(
                "No MySQL connection string configured. Set the ConnectionStrings__Aurelia " +
                "environment variable, or add an 'Aurelia' entry under <connectionStrings> in Web.config.");
        }

        /// <summary>Opens a new, already-open connection to the aurelia_fc schema.</summary>
        public static MySqlConnection Open()
        {
            var connection = new MySqlConnection(Resolved);
            connection.Open();
            return connection;
        }

        /// <summary>True when the database is reachable - used by the diagnostics page.</summary>
        public static bool CanConnect(out string error)
        {
            error = null;
            try
            {
                using (var connection = Open())
                using (var command = new MySqlCommand("SELECT 1", connection))
                {
                    command.ExecuteScalar();
                }
                return true;
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return false;
            }
        }
    }
}
