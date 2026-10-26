using System;
using System.Web;

namespace AureliaFc.Web
{
    /// <summary>
    /// Base class for every Aurelia FC page. It exposes the small formatting and URL
    /// helpers the ASPX markup needs inside data-binding expressions, so the pages
    /// never have to repeat encoding logic.
    /// </summary>
    public abstract class AureliaPage : System.Web.UI.Page
    {
        /// <summary>HTML-encodes a bound value so it is safe to write into markup.</summary>
        protected string Enc(object value)
        {
            if (value == null) return string.Empty;
            var text = value as string ?? value.ToString();
            return string.IsNullOrEmpty(text) ? string.Empty : Server.HtmlEncode(text);
        }

        /// <summary>Encodes a value for safe use inside a URL query string.</summary>
        protected string UrlEncode(object value)
        {
            if (value == null) return string.Empty;
            return HttpUtility.UrlEncode(value.ToString());
        }

        /// <summary>
        /// Turns a stored image path ("assets/images/foo.jpg") into an
        /// application-relative URL that IIS Express can serve.
        /// </summary>
        protected string ImageUrl(string imagePath)
        {
            if (string.IsNullOrWhiteSpace(imagePath)) return string.Empty;

            var path = imagePath.Replace('\\', '/').TrimStart('/');
            if (path.StartsWith("~/", StringComparison.Ordinal)) path = path.Substring(2);
            if (path.StartsWith("assets/", StringComparison.OrdinalIgnoreCase) ||
                path.StartsWith("Content/", StringComparison.OrdinalIgnoreCase))
                return ResolveUrl("~/" + path);

            return ResolveUrl("~/assets/images/" + path);
        }

        /// <summary>True when the bound image path is present.</summary>
        protected bool HasImage(object imagePath)
        {
            return imagePath != null && !string.IsNullOrWhiteSpace(imagePath.ToString());
        }

        /// <summary>
        /// Optional per-page meta description. The master page falls back to the club
        /// description when a page does not set one.
        /// </summary>
        public new string MetaDescription { get; set; }
    }
}
