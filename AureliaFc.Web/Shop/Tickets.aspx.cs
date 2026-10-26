using System;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Services;

namespace AureliaFc.Web
{
    /// <summary>
    /// Box office: match tickets, season-ticket tiers and hospitality packages. Every
    /// "buy" action adds a line to the server-side basket; the basket re-prices each
    /// line from the catalogue so nothing is trusted from the browser.
    /// </summary>
    public partial class Tickets : AureliaPage
    {
        private readonly CommerceRepository _commerceRepository = new CommerceRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Buy match tickets, season tickets and hospitality for Aurelia FC home fixtures.";
            if (IsPostBack) return;

            var fixtures = _commerceRepository.GetTicketFixtures();
            pnlNoFixtures.Visible = fixtures.Count == 0;
            rptFixtures.DataSource = fixtures;
            rptFixtures.DataBind();

            var tiers = _commerceRepository.GetSeasonTiers();
            pnlNoTiers.Visible = tiers.Count == 0;
            rptTiers.DataSource = tiers;
            rptTiers.DataBind();

            var hospitality = _commerceRepository.GetHospitality();
            pnlNoHospitality.Visible = hospitality.Count == 0;
            rptHospitality.DataSource = hospitality;
            rptHospitality.DataBind();
        }

        protected void AddItem_Command(object sender, CommandEventArgs e)
        {
            int id;
            if (!int.TryParse(e.CommandArgument.ToString(), out id)) return;

            switch (e.CommandName)
            {
                case "AddTicket":
                    CartService.Add("MatchTicket", id, 1);
                    ShowNotice("Ticket added to your basket. <a href=\"" +
                               ResolveUrl("~/Shop/Shop.aspx#basket") + "\" class=\"gold\">View basket</a>");
                    break;

                case "AddSeason":
                    CartService.Add("SeasonTicket", id, 1);
                    ShowNotice("Season ticket added to your basket. <a href=\"" +
                               ResolveUrl("~/Shop/Shop.aspx#basket") + "\" class=\"gold\">View basket</a>");
                    break;

                case "AddHospitality":
                    CartService.Add("Hospitality", id, 1);
                    ShowNotice("Hospitality package added to your basket. <a href=\"" +
                               ResolveUrl("~/Shop/Shop.aspx#basket") + "\" class=\"gold\">View basket</a>");
                    break;
            }
        }

        private void ShowNotice(string html)
        {
            pnlNotice.Visible = true;
            litNotice.Text = html;
        }
    }
}
