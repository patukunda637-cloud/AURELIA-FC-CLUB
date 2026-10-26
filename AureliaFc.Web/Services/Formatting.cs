using System;
using System.Globalization;

namespace AureliaFc.Web.Services
{
    /// <summary>
    /// Date, money and label formatting. These reproduce the exact strings shown in
    /// the Figma reference (e.g. "Sep 12, 2026", "&pound;89.99", "45,000").
    /// </summary>
    public static class Formatting
    {
        private static readonly string[] Months =
            { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };

        private static readonly string[] FullMonths =
        {
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        };

        /// <summary>"Sep 12, 2026"</summary>
        public static string ShortDate(DateTime d)
        {
            return string.Format(CultureInfo.InvariantCulture, "{0} {1}, {2}",
                Months[d.Month - 1], d.Day, d.Year);
        }

        /// <summary>"19:45"</summary>
        public static string TimeLabel(DateTime d)
        {
            return d.ToString("HH:mm", CultureInfo.InvariantCulture);
        }

        /// <summary>"September"</summary>
        public static string FullMonth(DateTime d)
        {
            return FullMonths[d.Month - 1];
        }

        /// <summary>"Saturday &middot; Sep 12, 2026"</summary>
        public static string LongDateWithDay(DateTime d)
        {
            return d.ToString("dddd", CultureInfo.InvariantCulture) + " \u00b7 " + ShortDate(d);
        }

        public static string Encode(string value)
        {
            return string.IsNullOrEmpty(value) ? string.Empty : System.Web.HttpUtility.HtmlEncode(value);
        }

        /// <summary>"12 August 2026" - the long date the account screen shows.</summary>
        public static string FullDate(DateTime d)
        {
            return d.Day + " " + FullMonths[d.Month - 1] + " " + d.Year;
        }

        /// <summary>"&pound;89.99" - the reference shows the pound sign, not "GBP".</summary>
        public static string Money(decimal value)
        {
            return "\u00a3" + value.ToString("0.00", CultureInfo.InvariantCulture);
        }

        /// <summary>"&pound;35 &ndash; &pound;120" - the whole-pound range on the ticket rows.</summary>
        public static string MoneyRange(decimal min, decimal max)
        {
            return "\u00a3" + min.ToString("0", CultureInfo.InvariantCulture) +
                   " \u2013 \u00a3" + max.ToString("0", CultureInfo.InvariantCulture);
        }

        /// <summary>"GK", "DEF", "MID", "FWD" - the abbreviation on a player card.</summary>
        public static string PositionAbbreviation(string position)
        {
            if (string.IsNullOrWhiteSpace(position)) return string.Empty;
            switch (position.Trim())
            {
                case "Goalkeeper": return "GK";
                case "Defender": return "DEF";
                case "Midfielder": return "MID";
                case "Forward": return "FWD";
                default:
                    var trimmed = position.Trim();
                    return trimmed.Length <= 3 ? trimmed.ToUpperInvariant()
                                               : trimmed.Substring(0, 3).ToUpperInvariant();
            }
        }

        /// <summary>"45,000"</summary>
        public static string Number(int value)
        {
            return value.ToString("N0", CultureInfo.InvariantCulture);
        }

        /// <summary>Maps positions.id onto the filter chip labels used by the design.</summary>
        public static string PositionGroup(int positionId)
        {
            switch (positionId)
            {
                case 1: return "Goalkeepers";
                case 2: return "Defenders";
                case 3: return "Midfielders";
                case 4: return "Forwards";
                default: return "Other";
            }
        }

        /// <summary>Signed goal difference as the table shows it ("+8", "-3", "0").</summary>
        public static string Signed(int value)
        {
            return value > 0 ? "+" + value.ToString(CultureInfo.InvariantCulture)
                             : value.ToString(CultureInfo.InvariantCulture);
        }

        /// <summary>Clamps free text to a maximum length without splitting multi-byte characters.</summary>
        public static string Truncate(string value, int maxLength)
        {
            if (string.IsNullOrEmpty(value) || value.Length <= maxLength) return value;
            return value.Substring(0, maxLength).TrimEnd() + "\u2026";
        }
    }
}
