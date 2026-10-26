using System.Text.RegularExpressions;

namespace AureliaFc.Web.Services
{
    /// <summary>
    /// Input validation. The password and email rules are byte-for-byte the same as
    /// the ones the existing API enforces, so a credential that is accepted by one
    /// host is accepted by the other.
    /// </summary>
    public static class ValidationService
    {
        private static readonly Regex StrongPassword =
            new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$", RegexOptions.Compiled);

        private static readonly Regex Email =
            new Regex(@"^[^@\s]+@[^@\s]+\.[^@\s]{2,}$", RegexOptions.Compiled);

        public static bool IsEmail(string value)
        {
            return !string.IsNullOrWhiteSpace(value) && Email.IsMatch(value.Trim());
        }

        public static bool IsStrongPassword(string value)
        {
            return !string.IsNullOrEmpty(value) && StrongPassword.IsMatch(value);
        }

        public static bool HasText(string value, int min, int max)
        {
            if (string.IsNullOrWhiteSpace(value)) return false;
            var length = value.Trim().Length;
            return length >= min && length <= max;
        }

        /// <summary>Normalises an email to its lower-case trimmed form.</summary>
        public static string Normalize(string email)
        {
            return email == null ? string.Empty : email.Trim().ToLowerInvariant();
        }

        /// <summary>Strength score 0-3 used by the sign-up meter (length, mixed case, digit).</summary>
        public static int PasswordStrength(string password)
        {
            if (string.IsNullOrEmpty(password)) return 0;
            var score = 0;
            if (password.Length >= 8) score++;
            if (Regex.IsMatch(password, "[a-z]") && Regex.IsMatch(password, "[A-Z]")) score++;
            if (Regex.IsMatch(password, @"\d")) score++;
            return score;
        }

        public static string PasswordStrengthLabel(string password)
        {
            switch (PasswordStrength(password))
            {
                case 0: return string.Empty;
                case 1: return "Weak";
                case 2: return "Fair";
                default: return "Strong";
            }
        }
    }
}
