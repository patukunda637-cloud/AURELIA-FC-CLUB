using System;
using System.Collections.Generic;
using AureliaFc.Web.Models;
using MySql.Data.MySqlClient;

namespace AureliaFc.Web.DAL
{
    /// <summary>Reads editorial content: news articles, tags and the media gallery.</summary>
    public class ContentRepository
    {
        private const string CardColumns =
            @"SELECT id, slug, category, title, excerpt, image_path, published_at, is_featured
              FROM news_articles";

        /// <summary>Article cards, newest first. category = null | "All" returns everything.</summary>
        public List<NewsArticle> GetArticles(string category, int limit)
        {
            var filter = string.IsNullOrWhiteSpace(category) ||
                         category.Equals("All", StringComparison.OrdinalIgnoreCase)
                ? string.Empty
                : " WHERE category = @category";

            var sql = CardColumns + filter + " ORDER BY published_at DESC, id DESC" +
                      (limit > 0 ? " LIMIT " + limit : string.Empty);

            var results = new List<NewsArticle>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                if (filter.Length > 0) command.Parameters.AddWithValue("@category", category);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read()) results.Add(MapCard(reader));
                }
            }
            return results;
        }

        /// <summary>The single article flagged as featured on the News page.</summary>
        public NewsArticle GetFeatured()
        {
            const string sql = CardColumns + " WHERE is_featured = 1 ORDER BY published_at DESC LIMIT 1";
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                return reader.Read() ? MapCard(reader) : null;
            }
        }

        /// <summary>Full article by slug, including its tags.</summary>
        public NewsArticle GetArticleBySlug(string slug)
        {
            const string sql =
                @"SELECT id, slug, category, title, excerpt, body, author_name, pull_quote,
                         pull_quote_by, image_path, published_at, is_featured
                  FROM news_articles WHERE slug = @slug LIMIT 1";

            NewsArticle article = null;
            using (var connection = AureliaDatabase.Open())
            {
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@slug", slug);
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) return null;
                        article = new NewsArticle
                        {
                            Id = reader.GetInt32("id"),
                            Slug = reader.GetString("slug"),
                            Category = reader.GetString("category"),
                            Title = reader.GetString("title"),
                            Excerpt = reader.GetString("excerpt"),
                            Body = reader.GetString("body"),
                            AuthorName = reader.GetNullableString("author_name"),
                            PullQuote = reader.GetNullableString("pull_quote"),
                            PullQuoteBy = reader.GetNullableString("pull_quote_by"),
                            ImagePath = reader.GetNullableString("image_path"),
                            PublishedAt = reader.GetDateTime("published_at"),
                            IsFeatured = reader.GetBoolean("is_featured")
                        };
                    }
                }

                using (var tagCommand = new MySqlCommand(
                    "SELECT tag FROM news_tags WHERE article_id = @id ORDER BY id", connection))
                {
                    tagCommand.Parameters.AddWithValue("@id", article.Id);
                    using (var reader = tagCommand.ExecuteReader())
                    {
                        while (reader.Read())
                            article.Tags.Add(reader.IsDBNull(0) ? string.Empty : reader.GetString(0));
                    }
                }
            }
            return article;
        }

        /// <summary>Up to four related articles - same category first, then newest.</summary>
        public List<NewsArticle> GetRelated(string slug, int take)
        {
            var sql =
                @"SELECT a.id, a.slug, a.category, a.title, a.excerpt, a.image_path, a.published_at, a.is_featured
                  FROM news_articles a
                  JOIN news_articles current ON current.slug = @slug
                  WHERE a.id <> current.id
                  ORDER BY (a.category = current.category) DESC, a.published_at DESC
                  LIMIT " + take;

            var results = new List<NewsArticle>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@slug", slug);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read()) results.Add(MapCard(reader));
                }
            }
            return results;
        }

        /// <summary>Gallery images; category = null | "All" returns everything.</summary>
        public List<GalleryImage> GetGalleryImages(string category)
        {
            var filter = string.IsNullOrWhiteSpace(category) ||
                         category.Equals("All", StringComparison.OrdinalIgnoreCase)
                ? string.Empty
                : " WHERE category = @category";

            var sql = @"SELECT id, category, caption, image_path, width_px, height_px, sort_order
                        FROM gallery_images" + filter + " ORDER BY sort_order, id";

            var results = new List<GalleryImage>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            {
                if (filter.Length > 0) command.Parameters.AddWithValue("@category", category);
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        results.Add(new GalleryImage
                        {
                            Id = reader.GetInt32("id"),
                            Category = reader.GetString("category"),
                            Caption = reader.GetString("caption"),
                            ImagePath = reader.GetString("image_path"),
                            WidthPx = reader.GetInt32("width_px"),
                            HeightPx = reader.GetInt32("height_px"),
                            SortOrder = reader.GetInt32("sort_order")
                        });
                    }
                }
            }
            return results;
        }

        /// <summary>Distinct gallery categories, in the order the filter chips show them.</summary>
        public List<string> GetGalleryCategories()
        {
            return DistinctValues("SELECT DISTINCT category FROM gallery_images");
        }

        /// <summary>Distinct news categories, in the order the filter chips show them.</summary>
        public List<string> GetNewsCategories()
        {
            return DistinctValues("SELECT DISTINCT category FROM news_articles");
        }

        private static List<string> DistinctValues(string sql)
        {
            var results = new List<string>();
            using (var connection = AureliaDatabase.Open())
            using (var command = new MySqlCommand(sql, connection))
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0)) results.Add(reader.GetString(0));
                }
            }
            return results;
        }

        private static NewsArticle MapCard(MySqlDataReader reader)
        {
            return new NewsArticle
            {
                Id = reader.GetInt32("id"),
                Slug = reader.GetString("slug"),
                Category = reader.GetString("category"),
                Title = reader.GetString("title"),
                Excerpt = reader.GetString("excerpt"),
                ImagePath = reader.GetNullableString("image_path"),
                PublishedAt = reader.GetDateTime("published_at"),
                IsFeatured = reader.GetBoolean("is_featured")
            };
        }
    }
}
