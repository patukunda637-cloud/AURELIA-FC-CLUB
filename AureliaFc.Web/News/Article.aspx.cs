using System;
using System.Collections.Generic;
using System.Web;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;

namespace AureliaFc.Web
{
    /// <summary>
    /// A single club story: the article body, pull quote, sharing links, tags and the
    /// related stories shown underneath.
    /// </summary>
    public partial class Article : AureliaPage
    {
        private readonly ContentRepository _contentRepository = new ContentRepository();

        /// <summary>Artwork path of the article, used by the hero figure.</summary>
        public string ArticleImagePath { get; private set; } = string.Empty;

        /// <summary>Absolute URL of the article, used by the share links.</summary>
        public string ShareUrl { get; private set; } = string.Empty;

        /// <summary>Absolute URL of the article, escaped for use inside a script block.</summary>
        public string ShareUrlJs { get; private set; } = string.Empty;

        /// <summary>Headline of the article, used by the share links.</summary>
        public string ShareTitle { get; private set; } = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            var slug = Request.QueryString["slug"];
            var article = string.IsNullOrWhiteSpace(slug) ? null : _contentRepository.GetArticleBySlug(slug);

            if (article == null)
            {
                pnlArticle.Visible = false;
                pnlNotFound.Visible = true;
                Response.StatusCode = 404;
                return;
            }

            ShareUrl = Request.Url.AbsoluteUri;
            ShareUrlJs = HttpUtility.JavaScriptStringEncode(ShareUrl);
            ShareTitle = article.Title ?? string.Empty;
            ArticleImagePath = article.ImagePath ?? string.Empty;

            MetaDescription = article.Excerpt ?? article.Title;
            litTitle.Text = Server.HtmlEncode(article.Title);
            litHeadline.Text = Server.HtmlEncode(article.Title);
            litExcerpt.Text = Server.HtmlEncode(article.Excerpt ?? string.Empty);

            var meta = article.Category + " · " + article.DateLabel;
            if (!string.IsNullOrWhiteSpace(article.AuthorName)) meta += " · By " + article.AuthorName;
            litMeta.Text = Server.HtmlEncode(meta);

            phHeroImage.Visible = !string.IsNullOrEmpty(ArticleImagePath);

            var paragraphs = new List<string>();
            if (!string.IsNullOrWhiteSpace(article.Body))
            {
                foreach (var raw in article.Body.Split('\n'))
                {
                    var line = raw.Trim();
                    if (line.Length > 0) paragraphs.Add(line);
                }
            }
            rptParagraphs.DataSource = paragraphs;
            rptParagraphs.DataBind();

            if (!string.IsNullOrWhiteSpace(article.PullQuote))
            {
                pnlQuote.Visible = true;
                litQuote.Text = Server.HtmlEncode(article.PullQuote);
                phQuoteBy.Visible = !string.IsNullOrWhiteSpace(article.PullQuoteBy);
                litQuoteBy.Text = Server.HtmlEncode(article.PullQuoteBy ?? string.Empty);
            }

            var tags = article.Tags ?? new List<string>();
            pnlTags.Visible = tags.Count > 0;
            rptTags.DataSource = tags;
            rptTags.DataBind();

            var related = _contentRepository.GetRelated(article.Slug, 4);
            rptRelated.DataSource = related;
            rptRelated.DataBind();
        }
    }
}
