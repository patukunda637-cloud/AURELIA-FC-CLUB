using System;

namespace AureliaFc.Web
{
    public partial class NotFound : AureliaPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "The page you were looking for could not be found.";
            Response.TrySkipIisCustomErrors = true;
            Response.StatusCode = 404;
            Response.StatusDescription = "Not Found";
        }
    }
}
