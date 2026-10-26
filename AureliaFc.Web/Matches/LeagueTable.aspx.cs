using System;
using System.Collections.Generic;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    public partial class LeagueTablePage : AureliaPage
    {
        private readonly MatchRepository _matchRepository = new MatchRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            var standings = _matchRepository.GetStandings(null);

            if (standings == null || standings.Competition == null)
            {
                litSubtitle.Text = "Premier Division · 2026/2027";
                MetaDescription = "The latest league standings for Aurelia FC.";
                pnlEmpty.Visible = true;
                pnlTable.Visible = false;
                return;
            }

            var competition = standings.Competition;
            litSubtitle.Text = Server.HtmlEncode(competition.Name + " · " + competition.Season);
            litCaption.Text = Server.HtmlEncode(competition.Name + " " + competition.Season + " table");
            MetaDescription = "The " + competition.Name + " " + competition.Season + " league table.";

            pnlTable.Visible = standings.Rows.Count > 0;
            pnlEmpty.Visible = standings.Rows.Count == 0;
            rptStandings.DataSource = standings.Rows;
            rptStandings.DataBind();
        }

        protected string GetRowCss(object dataItem)
        {
            var row = dataItem as LeagueStanding;
            if (row == null) return null;

            var classes = new List<string>();
            if (row.IsAurelia) classes.Add("league-table__row--ours");
            if (row.Position <= 4) classes.Add("league-table__row--ucl");
            if (row.Position >= 11) classes.Add("league-table__row--relegation");
            return classes.Count == 0 ? null : string.Join(" ", classes);
        }
    }
}
