using System.Web.Routing;

namespace AureliaFc.Web
{
    /// <summary>
    /// Friendly URL for the match detail screen: /match/12 maps onto
    /// Matches/MatchDetail.aspx?id=12, which keeps the id out of the visible address.
    /// </summary>
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(
                "match-detail",
                "match/{id}",
                "~/Matches/MatchDetail.aspx",
                false,
                new RouteValueDictionary { { "id", null } });
        }
    }
}
