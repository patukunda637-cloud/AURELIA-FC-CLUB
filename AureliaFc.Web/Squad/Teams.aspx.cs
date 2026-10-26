using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    public partial class Teams : AureliaPage
    {
        private readonly SquadRepository _squadRepository = new SquadRepository();

        private int? OpenTeamId
        {
            get { return ViewState["OpenTeamId"] as int?; }
            set { ViewState["OpenTeamId"] = value; }
        }

        private Dictionary<int, List<Player>> _rosters;

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "From the first team to the academy, every Aurelia FC squad shares one identity.";
            if (IsPostBack) return;

            _rosters = new Dictionary<int, List<Player>>();
            rptTeams.DataSource = _squadRepository.GetTeams();
            rptTeams.DataBind();
        }

        protected void Team_Toggle(object sender, CommandEventArgs e)
        {
            int teamId;
            if (!int.TryParse(e.CommandArgument.ToString(), out teamId)) return;

            if (OpenTeamId.HasValue && OpenTeamId.Value == teamId)
                OpenTeamId = null;
            else
                OpenTeamId = teamId;

            rptTeams.DataSource = _squadRepository.GetTeams();
            rptTeams.DataBind();
        }

        protected string GetToggleLabel(int teamId)
        {
            return OpenTeamId.HasValue && OpenTeamId.Value == teamId ? "HIDE SQUAD" : "VIEW SQUAD";
        }

        protected bool IsRosterOpen(int teamId)
        {
            return OpenTeamId.HasValue && OpenTeamId.Value == teamId;
        }

        protected List<Player> GetRoster(int teamId)
        {
            if (_rosters == null) _rosters = new Dictionary<int, List<Player>>();
            if (!_rosters.ContainsKey(teamId))
                _rosters[teamId] = _squadRepository.GetPlayers(teamId, null, null);
            return _rosters[teamId];
        }

        protected int GetRosterCount(int teamId)
        {
            return GetRoster(teamId).Count;
        }
    }
}
