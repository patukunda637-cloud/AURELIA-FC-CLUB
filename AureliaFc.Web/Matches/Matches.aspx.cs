using System;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    public partial class Matches : AureliaPage
    {
        private readonly MatchRepository _matchRepository = new MatchRepository();

        private string Tab
        {
            get { return ViewState["MatchTab"] as string ?? "upcoming"; }
            set { ViewState["MatchTab"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Every upcoming kick-off and completed result for the 2026/2027 season.";
            if (IsPostBack) return;
            ApplyTab();
        }

        protected void Tab_Command(object sender, CommandEventArgs e)
        {
            Tab = e.CommandArgument.ToString();
            ApplyTab();
        }

        private void ApplyTab()
        {
            lnkUpcoming.CssClass = Tab == "upcoming" ? "chip chip--active" : "chip";
            lnkResults.CssClass = Tab == "results" ? "chip chip--active" : "chip";
            lnkAll.CssClass = Tab == "all" ? "chip chip--active" : "chip";

            var matches = _matchRepository.GetMatches(Tab);
            pnlEmpty.Visible = matches.Count == 0;
            rptFixtures.DataSource = matches;
            rptFixtures.DataBind();
        }

        protected string GetScoreLabel(object dataItem)
        {
            var match = dataItem as Match;
            if (match == null) return string.Empty;
            if (!match.IsCompleted) return "VS";
            return match.HomeScore.Value + " – " + match.AwayScore.Value;
        }
    }
}
