using System;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;

namespace AureliaFc.Web
{
    public partial class Gallery : AureliaPage
    {
        private readonly ContentRepository _contentRepository = new ContentRepository();

        private string CurrentCategory
        {
            get { return ViewState["GalleryCategory"] as string ?? "All"; }
            set { ViewState["GalleryCategory"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Matchdays, training sessions and unforgettable moments from Aurelia Arena.";

            if (IsPostBack) return;

            var categories = _contentRepository.GetGalleryCategories();
            categories.Insert(0, "All");
            rptCategories.DataSource = categories;
            rptCategories.DataBind();

            BindGallery();
        }

        private void BindGallery()
        {
            var images = _contentRepository.GetGalleryImages(CurrentCategory);
            pnlEmpty.Visible = images.Count == 0;
            rptGallery.DataSource = images;
            rptGallery.DataBind();
        }

        protected string GetCategoryCss(string category)
        {
            return category == CurrentCategory ? "chip chip--active" : "chip";
        }

        protected void Category_Command(object sender, CommandEventArgs e)
        {
            CurrentCategory = e.CommandArgument.ToString();
            BindGallery();
            rptCategories.DataBind();
        }
    }
}
