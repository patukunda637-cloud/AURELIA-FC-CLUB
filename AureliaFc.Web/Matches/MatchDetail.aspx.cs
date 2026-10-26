using System;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    public partial class MatchDetail : AureliaPage
    {
        private readonly MatchRepository _matchRepository = new MatchRepository();
        private Match _match;

        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(Request.QueryString["id"], out id))
            {
                pnlMatch.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            _match = _matchRepository.GetMatch(id);
            if (_match == null)
            {
                pnlMatch.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            MetaDescription = _match.HomeTeam + " vs " + _match.AwayTeam + " - " + _match.Competition + " match centre.";

            litTitle.Text = Server.HtmlEncode(_match.HomeTeam + " vs " + _match.AwayTeam);
            litStatus.Text = Server.HtmlEncode(_match.StatusLabel);
            litCompetitionUpper.Text = Server.HtmlEncode((_match.Competition ?? string.Empty).ToUpperInvariant());
            litHomeTeam.Text = Server.HtmlEncode(_match.HomeTeam);
            litAwayTeam.Text = Server.HtmlEncode(_match.AwayTeam);
            litScore.Text = _match.IsCompleted
                ? _match.HomeScore.Value + " – " + _match.AwayScore.Value
                : "VS";

            var meta = _match.DateLabel + " · " + _match.Venue;
            if (_match.Attendance.HasValue)
                meta += " · Attendance: " + Services.Formatting.Number(_match.Attendance.Value);
            litMeta.Text = Server.HtmlEncode(meta);

            var events = _matchRepository.GetEvents(id);
            pnlNoEvents.Visible = events.Count == 0;
            rptEvents.DataSource = events;
            rptEvents.DataBind();

            var stats = _matchRepository.GetStats(id);
            pnlNoStats.Visible = stats.Count == 0;
            pnlStats.Visible = stats.Count > 0;
            litStatsHome.Text = Server.HtmlEncode(_match.HomeTeam);
            litStatsAway.Text = Server.HtmlEncode(_match.AwayTeam);
            rptStats.DataSource = stats;
            rptStats.DataBind();

            var home = _matchRepository.GetLineups(id, "Home");
            var away = _matchRepository.GetLineups(id, "Away");

            litHomeLineupTitle.Text = Server.HtmlEncode(_match.HomeTeam);
            litAwayLineupTitle.Text = Server.HtmlEncode(_match.AwayTeam);

            HomeFormation = home.Count > 0 ? home[0].Formation : string.Empty;
            AwayFormation = away.Count > 0 ? away[0].Formation : string.Empty;
            pnlHomeFormation.Visible = !string.IsNullOrEmpty(HomeFormation);
            pnlAwayFormation.Visible = !string.IsNullOrEmpty(AwayFormation);
            litHomeFormation.Text = Server.HtmlEncode(HomeFormation);
            litAwayFormation.Text = Server.HtmlEncode(AwayFormation);
            pnlNoHomeLineup.Visible = home.Count == 0;
            pnlNoAwayLineup.Visible = away.Count == 0;
            rptHomeLineup.DataSource = home;
            rptHomeLineup.DataBind();
            rptAwayLineup.DataSource = away;
            rptAwayLineup.DataBind();

            if (!string.IsNullOrWhiteSpace(_match.MatchReport))
            {
                pnlReport.Visible = true;
                litReport.Text = Server.HtmlEncode(_match.MatchReport);
            }
        }

        public string HomeFormation { get; set; }
        public string AwayFormation { get; set; }

        protected string GetEventTeam(object dataItem)
        {
            var evt = dataItem as MatchEvent;
            if (evt == null || _match == null) return string.Empty;
            return evt.IsHome ? _match.HomeTeam : _match.AwayTeam;
        }
    }
}
