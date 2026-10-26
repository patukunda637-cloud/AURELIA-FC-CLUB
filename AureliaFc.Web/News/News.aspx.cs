using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    /// <summary>
    /// Club news: a featured story plus a filterable archive of articles.
    /// </summary>
    public partial class News : AureliaPage
    {
        private readonly ContentRepository _contentRepository = new ContentRepository();

        private string CurrentCategory
        {
            get { return ViewState["NewsCategory"] as string ?? "All"; }
            set { ViewState["NewsCategory"] = value; }
        }

        /// <summary>Slug of the featured story, used to build its detail link.</summary>
        public string FeaturedSlug { get; private set; } = string.Empty;

        /// <summary>Artwork path of the featured story.</summary>
        public string FeaturedImagePath { get; private set; } = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Club announcements, match reports, transfer news and academy stories.";

            if (!IsPostBack)
            {
                var categories = _contentRepository.GetNewsCategories();
                var names = new List<string> { "All" };
                foreach (var category in categories) names.Add(category);
                rptCategories.DataSource = names;
                rptCategories.DataBind();

                var featured = _contentRepository.GetFeatured();
                if (featured != null)
                {
                    pnlFeatured.Visible = true;
                    FeaturedSlug = featured.Slug;
                    FeaturedImagePath = featured.ImagePath ?? string.Empty;
                    phFeaturedImage.Visible = !string.IsNullOrEmpty(FeaturedImagePath);
                    litFeaturedTitle.Text = Server.HtmlEncode(featured.Title);
                    litFeaturedExcerpt.Text = Server.HtmlEncode(featured.Excerpt ?? string.Empty);
                    litFeaturedDate.Text = Server.HtmlEncode(featured.DateLabel);
                }
            }

            var articles = _contentRepository.GetArticles(CurrentCategory, 0);
            pnlEmpty.Visible = articles.Count == 0;
            rptArticles.DataSource = articles;
            rptArticles.DataBind();
        }

        protected string GetCategoryCss(string category)
        {
            return category == CurrentCategory ? "chip chip--active" : "chip";
        }

        protected void Category_Command(object sender, CommandEventArgs e)
        {
            CurrentCategory = e.CommandArgument.ToString();
            var articles = _contentRepository.GetArticles(CurrentCategory, 0);
            pnlEmpty.Visible = articles.Count == 0;
            rptArticles.DataSource = articles;
            rptArticles.DataBind();
            rptCategories.DataBind();
        }
    }
}
