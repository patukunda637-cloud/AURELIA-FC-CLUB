using System;
using System.Web.UI;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    /// <summary>
    /// About the club: the history timeline, mission and values, the stadium feature,
    /// the honours cabinet and the club's key executives.
    /// </summary>
    public partial class About : AureliaPage
    {
        private readonly ClubRepository _clubRepository = new ClubRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "The history, values, honours and leadership of Aurelia Football Club.";

            var club = _clubRepository.GetClubInfo();
            if (club != null)
            {
                litClubDescription.Text = Server.HtmlEncode(club.Description);
                litStadiumName.Text = Server.HtmlEncode(club.StadiumName);
                litStadiumNameInline.Text = Server.HtmlEncode(club.StadiumName);
                litBuiltYear.Text = club.BuiltYear.ToString();
                litCapacity.Text = Services.Formatting.Number(club.Capacity);
                litRecordAttendance.Text = Services.Formatting.Number(club.RecordAttendance);
            }
            else
            {
                litClubDescription.Text = "Aurelia Football Club is a professional football club based in Aurelia.";
                litStadiumName.Text = "Aurelia Arena";
                litStadiumNameInline.Text = "Aurelia Arena";
                litBuiltYear.Text = "2003";
                litCapacity.Text = "45,000";
                litRecordAttendance.Text = "45,210";
            }

            if (IsPostBack) return;

            var milestones = _clubRepository.GetMilestones();
            if (milestones.Count == 0)
            {
                pnlNoMilestones.Visible = true;
            }
            else
            {
                rptMilestones.DataSource = milestones;
                rptMilestones.DataBind();
            }

            rptValues.DataSource = _clubRepository.GetValues();
            rptValues.DataBind();

            rptHonours.DataSource = _clubRepository.GetHonours();
            rptHonours.DataBind();

            rptExecutives.DataSource = _clubRepository.GetExecutives();
            rptExecutives.DataBind();
        }
    }
}
