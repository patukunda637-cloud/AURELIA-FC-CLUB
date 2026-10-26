namespace AureliaFc.Web.Services
{
    /// <summary>
    /// BCrypt password hashing, matching the work factor (11) and algorithm prefix
    /// ("$2a$") of the hashes already stored in the <c>users</c> table.
    /// </summary>
    public static class PasswordHasher
    {
        private const int WorkFactor = 11;

        public static string Hash(string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(password, workFactor: WorkFactor);
        }

        /// <summary>
        /// Verifies a candidate password. Corrupt or legacy hashes return false rather
        /// than throwing, so a bad row cannot take the sign-in page down.
        /// </summary>
        public static bool Verify(string password, string hash)
        {
            if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(hash)) return false;
            try
            {
                return BCrypt.Net.BCrypt.Verify(password, hash);
            }
            catch (BCrypt.Net.SaltParseException)
            {
                return false;
            }
        }
    }
}
