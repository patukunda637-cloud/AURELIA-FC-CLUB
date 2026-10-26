using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    public partial class Players : AureliaPage
    {
        private readonly SquadRepository _squadRepository = new SquadRepository();

        private string Position
        {
            get { return ViewState["Position"] as string ?? "All"; }
            set { ViewState["Position"] = value; }
        }

        private string Search
        {
            get { return ViewState["Search"] as string ?? string.Empty; }
            set { ViewState["Search"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Meet the players wearing the royal gold this season.";
            if (IsPostBack) return;
            ApplyFilter();
        }

        protected void Filter_Command(object sender, CommandEventArgs e)
        {
            Position = e.CommandArgument.ToString();
            ApplyFilter();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Search = (txtSearch.Text ?? string.Empty).Trim();
            ApplyFilter();
        }

        private void ApplyFilter()
        {
            // update active chips
            lnkAll.CssClass = Position == "All" ? "chip chip--active" : "chip";
            lnkGK.CssClass = Position == "Goalkeepers" ? "chip chip--active" : "chip";
            lnkDF.CssClass = Position == "Defenders" ? "chip chip--active" : "chip";
            lnkMF.CssClass = Position == "Midfielders" ? "chip chip--active" : "chip";
            lnkFW.CssClass = Position == "Forwards" ? "chip chip--active" : "chip";

            string positionGroup = Position == "All" ? null : Position;
            var players = _squadRepository.GetPlayers(null, positionGroup, Search);
            pnlEmpty.Visible = players.Count == 0;
            pnlCount.Visible = players.Count > 0;
            if (players.Count > 0)
            {
                var label = players.Count == 1 ? "1 player" : players.Count + " players";
                if (Position != "All") label += " · " + Position;
                if (!string.IsNullOrEmpty(Search)) label += " · \"" + Enc(Search) + "\"";
                litCount.Text = label;
            }

            rptPlayers.DataSource = players;
            rptPlayers.DataBind();
        }
    }
}
