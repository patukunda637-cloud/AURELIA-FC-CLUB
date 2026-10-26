using System;
using AureliaFc.Web.Services;

namespace AureliaFc.Web
{
    /// <summary>
    /// Ends the session: the auth cookie is cleared and the supporter is returned to
    /// the home page.
    /// </summary>
    public partial class SignOut : AureliaPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthService.SignOut();
            Response.Redirect(ResolveUrl("~/Default.aspx"), false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
