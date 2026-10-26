using System;
using System.Collections.Generic;
using System.Web.UI;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    /// <summary>
    /// The club home page: hero, next fixture, league table, club statistics,
    /// recent results, featured players and the latest news.
    /// </summary>
    public partial class Default : AureliaPage
    {
        private readonly ClubRepository _clubRepository = new ClubRepository();
        private readonly MatchRepository _matchRepository = new MatchRepository();
        private readonly SquadRepository _squadRepository = new SquadRepository();
        private readonly ContentRepository _contentRepository = new ContentRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Aurelia Football Club - Rise. Unite. Conquer. Official club website, match fixtures, league table, squad and store.";

            if (IsPostBack) return;

            var club = _clubRepository.GetClubInfo();
            if (club != null)
            {
                litClubName.Text = Server.HtmlEncode(club.ClubName);
                litMotto.Text = Server.HtmlEncode(club.Motto);
                litFounded.Text = club.FoundedYear.ToString();
                litYears.Text = (DateTime.Now.Year - club.FoundedYear).ToString();
                litCapacity.Text = Services.Formatting.Number(club.Capacity);
                litStadium.Text = Server.HtmlEncode(club.StadiumName.ToUpperInvariant());
            }
            else
            {
                litClubName.Text = "Aurelia FC";
                litMotto.Text = "Rise. Unite. Conquer.";
                litFounded.Text = "1987";
                litYears.Text = (DateTime.Now.Year - 1987).ToString();
                litCapacity.Text = "45,000";
                litStadium.Text = "AURELIA ARENA";
            }

            BindNextMatch();
            BindStandings();
            BindResults();
            BindFeaturedPlayers();
            BindNews();
        }

        private void BindNextMatch()
        {
            var next = _matchRepository.GetNextMatch();
            if (next == null)
            {
                pnlNoNextMatch.Visible = true;
                pnlNextMatch.Visible = false;
                return;
            }

            pnlNoNextMatch.Visible = false;
            pnlNextMatch.Visible = true;

            litNextDate.Text = Server.HtmlEncode(next.DateLabel.ToUpperInvariant());
            litNextComp.Text = Server.HtmlEncode((next.Competition ?? string.Empty).ToUpperInvariant());
            litNextHomeAway.Text = next.HomeAwayLabel;
            litNextHome.Text = Server.HtmlEncode(next.HomeTeam);
            litNextAway.Text = Server.HtmlEncode(next.AwayTeam);
            litNextVenue.Text = Server.HtmlEncode(next.Venue);
            litNextTime.Text = next.TimeLabel;
        }

        private void BindStandings()
        {
            var table = _matchRepository.GetStandings(null);
            if (table == null || table.Rows.Count == 0) return;

            var rows = table.Rows;
            if (rows.Count > 5) rows = rows.GetRange(0, 5);

            rptStandings.DataSource = rows;
            rptStandings.DataBind();
        }

        private void BindResults()
        {
            var results = _matchRepository.GetRecentResults(3);
            if (results.Count == 0)
            {
                pnlNoResults.Visible = true;
                return;
            }

            pnlNoResults.Visible = false;
            rptResults.DataSource = results;
            rptResults.DataBind();
        }

        private void BindFeaturedPlayers()
        {
            var players = _squadRepository.GetFeaturedPlayers(1, 3);
            if (players.Count == 0)
            {
                pnlNoPlayers.Visible = true;
                return;
            }

            pnlNoPlayers.Visible = false;
            rptPlayers.DataSource = players;
            rptPlayers.DataBind();
        }

        private void BindNews()
        {
            var news = _contentRepository.GetArticles(null, 3);
            if (news.Count == 0)
            {
                pnlNoNews.Visible = true;
                return;
            }

            pnlNoNews.Visible = false;
            rptNews.DataSource = news;
            rptNews.DataBind();
        }
    }
}
