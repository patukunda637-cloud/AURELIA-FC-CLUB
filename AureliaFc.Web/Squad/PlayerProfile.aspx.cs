using System;
using AureliaFc.Web.DAL;

namespace AureliaFc.Web
{
    public partial class PlayerProfile : AureliaPage
    {
        private readonly SquadRepository _squadRepository = new SquadRepository();

        public string PlayerImagePath { get; private set; }
        public string PlayerName { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(Request.QueryString["id"], out id))
            {
                pnlProfile.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            var player = _squadRepository.GetPlayer(id);
            if (player == null)
            {
                pnlProfile.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            MetaDescription = player.FullName + " - " + player.Position + " at Aurelia FC.";
            PlayerImagePath = player.ImagePath ?? string.Empty;
            PlayerName = player.FullName;
            phPlayerImage.Visible = !string.IsNullOrEmpty(PlayerImagePath);
            phPlayerPlaceholder.Visible = string.IsNullOrEmpty(PlayerImagePath);

            litTitle.Text = Server.HtmlEncode(player.FullName);
            litEyebrow.Text = Server.HtmlEncode(player.Position.ToUpperInvariant());
            litSquadNo.Text = player.SquadNumber.ToString();
            litName.Text = Server.HtmlEncode(player.FullName);
            litBio.Text = Server.HtmlEncode(player.Bio ?? string.Empty);
            litNationality.Text = Server.HtmlEncode(player.Nationality ?? "—");
            litHeight.Text = player.HeightCm.HasValue ? player.HeightCm.Value + " cm" : "—";
            litDob.Text = player.DateOfBirth.HasValue ? player.DateOfBirth.Value.ToString("yyyy-MM-dd") : "—";
            litTeam.Text = Server.HtmlEncode(player.TeamName ?? string.Empty);

            litGoals.Text = player.Goals.ToString();
            litAssists.Text = player.Assists.ToString();
            litApps.Text = player.Appearances.ToString();
            litRating.Text = player.AvgRating.ToString("0.0");

            litCurrentClub.Text = Server.HtmlEncode(player.TeamName ?? "Aurelia FC");
            litCurrentApps.Text = player.Appearances.ToString();
            litCurrentGoals.Text = player.Goals.ToString();

            var seasonStats = _squadRepository.GetSeasonStats(id);
            litSeason.Text = seasonStats.Count > 0 ? seasonStats[0].Season : "2026/2027";
            pnlNoSeasonStats.Visible = seasonStats.Count == 0;
            rptSeasonStats.DataSource = seasonStats;
            rptSeasonStats.DataBind();

            rptCareer.DataSource = _squadRepository.GetCareerHistory(id);
            rptCareer.DataBind();
        }
    }
}
