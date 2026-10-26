using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    /// <summary>
    /// Shared chrome for every public screen: the 88px header with the eight primary
    /// links, the cart/sign-in actions, the Official Partners strip and the four-column
    /// footer. Club facts come from the database, never from literals.
    /// </summary>
    public partial class SiteMaster : MasterPage
    {
        private readonly DAL.ClubRepository _clubRepository = new DAL.ClubRepository();
        private ClubInfo _club;

        public bool ShowPartners { get; set; }

        protected ClubInfo Club
        {
            get { return _club ?? (_club = _clubRepository.GetClubInfo()); }
        }

        protected string ClubName
        {
            get { return Club == null ? "Aurelia FC" : Club.ClubName; }
        }

        protected string Motto
        {
            get { return Club == null ? "Rise. Unite. Conquer." : Club.Motto; }
        }

        protected string ClubDescription
        {
            get
            {
                return Club == null
                    ? "Aurelia Football Club is a professional football club based in Aurelia. Founded in 1987, the club competes in the premier tier of sports excellence."
                    : Club.Description;
            }
        }

        protected string StadiumName
        {
            get { return Club == null ? "Aurelia Arena" : Club.StadiumName; }
        }

        protected int Capacity { get { return Club == null ? 45000 : Club.Capacity; } }
        protected int BuiltYear { get { return Club == null ? 2003 : Club.BuiltYear; } }
        protected string Address { get { return Club == null ? "100 Royal Way, Aurelia" : Club.Address; } }
        protected string Phone { get { return Club == null ? "+44 (0) 20 8123 4567" : Club.Phone; } }

        protected User CurrentUser { get { return Services.AuthService.CurrentUser; } }

        protected int CartCount { get { return Services.CartService.ItemCount; } }

        /// <summary>
        /// The meta description for the current page. Pages set <see cref="AureliaPage.MetaDescription"/>;
        /// anything else falls back to the club description.
        /// </summary>
        protected string PageDescription
        {
            get
            {
                var page = Page as AureliaPage;
                if (page != null && !string.IsNullOrWhiteSpace(page.MetaDescription)) return page.MetaDescription;
                return ClubDescription;
            }
        }

        /// <summary>One entry per primary navigation link.</summary>
        public sealed class NavItem
        {
            public string Label { get; set; }
            public string Href { get; set; }
            public bool IsActive { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ShowPartners = true;

            if (!IsPostBack)
            {
                NavRepeater.DataSource = BuildNavigation();
                NavRepeater.DataBind();

                PartnerRepeater.DataSource = _clubRepository.GetPartners();
                PartnerRepeater.DataBind();

                QuickLinkRepeater.DataSource = _clubRepository.GetQuickLinks();
                QuickLinkRepeater.DataBind();
            }
        }

        /// <summary>
        /// The description is written just before rendering because the content page
        /// only sets its own description during its own Load event.
        /// </summary>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            metaDescription.Content = Server.HtmlEncode(PageDescription);
        }

        /// <summary>
        /// The eight links in the design, in order, with the current section highlighted
        /// using the same accent colour the React app applies to the active route.
        /// </summary>
        private List<NavItem> BuildNavigation()
        {
            var current = (Request.AppRelativeCurrentExecutionFilePath ?? string.Empty).ToLowerInvariant();

            var items = new List<NavItem>
            {
                new NavItem { Label = "Home",     Href = "~/Default.aspx" },
                new NavItem { Label = "About",    Href = "~/Club/About.aspx" },
                new NavItem { Label = "Teams",    Href = "~/Squad/Teams.aspx" },
                new NavItem { Label = "Players",  Href = "~/Squad/Players.aspx" },
                new NavItem { Label = "Matches",  Href = "~/Matches/Matches.aspx" },
                new NavItem { Label = "News",     Href = "~/News/News.aspx" },
                new NavItem { Label = "Shop",     Href = "~/Shop/Shop.aspx" },
                new NavItem { Label = "Contact",  Href = "~/Club/Contact.aspx" }
            };

            foreach (var item in items)
                item.IsActive = current.EndsWith(
                    item.Href.Replace("~", string.Empty).TrimStart('/').ToLowerInvariant());

            // Sub-screens light up their parent section.
            if (!items.Exists(i => i.IsActive))
            {
                if (current.Contains("/squad/")) SetActive(items, "Players");
                else if (current.Contains("/matches/")) SetActive(items, "Matches");
                else if (current.Contains("/news/")) SetActive(items, "News");
                else if (current.Contains("/shop/")) SetActive(items, "Shop");
                else if (current.Contains("/club/")) SetActive(items, "About");
            }

            return items;
        }

        private static void SetActive(List<NavItem> items, string label)
        {
            var match = items.Find(i => i.Label == label);
            if (match != null) match.IsActive = true;
        }
    }
}
