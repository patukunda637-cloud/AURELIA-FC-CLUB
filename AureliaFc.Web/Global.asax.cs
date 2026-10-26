using System;
using System.Web;
using System.Web.Routing;

namespace AureliaFc.Web
{
    /// <summary>
    /// Application entry point. Web Forms pages are served by their own physical
    /// paths; the only routing rule maps the friendly match URL onto MatchDetail.aspx
    /// so links can read /Matches/MatchDetail.aspx rather than a query string.
    /// </summary>
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        /// <summary>
        /// Records unhandled errors so the custom error page can show a support reference
        /// instead of a raw stack trace.
        /// </summary>
        protected void Application_Error(object sender, EventArgs e)
        {
            var error = Server.GetLastError();
            if (error == null) return;

            var context = HttpContext.Current;
            context.Items["AureliaErrorReference"] =
                "ERR-" + DateTime.UtcNow.ToString("yyMMddHHmmss");

            try
            {
                var folder = Server.MapPath("~/App_Data/logs");
                System.IO.Directory.CreateDirectory(folder);
                var log = System.IO.Path.Combine(folder, "errors.log");
                System.IO.File.AppendAllText(
                    log,
                    DateTime.Now.ToString("s") + Environment.NewLine +
                    error + Environment.NewLine +
                    new string('-', 60) + Environment.NewLine);
            }
            catch
            {
                // Diagnostics only - never let logging break the request.
            }
        }
    }
}
