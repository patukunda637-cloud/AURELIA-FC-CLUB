using System;

namespace AureliaFc.Web.Models
{
    /// <summary>Club identity, stadium facts and contact details (table: club_info).</summary>
    public class ClubInfo
    {
        public int Id { get; set; }
        public string ClubName { get; set; }
        public string Motto { get; set; }
        public int FoundedYear { get; set; }
        public string Description { get; set; }
        public string StadiumName { get; set; }
        public int Capacity { get; set; }
        public int BuiltYear { get; set; }
        public int RecordAttendance { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
    }

    public class ClubMilestone
    {
        public int Id { get; set; }
        public string YearLabel { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }
        public int SortOrder { get; set; }
    }

    public class ClubValue
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }
        public int SortOrder { get; set; }
    }

    public class ClubHonour
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Years { get; set; }
        public string CountLabel { get; set; }
        public int SortOrder { get; set; }
    }

    public class ClubExecutive
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string RoleTitle { get; set; }
        public string ImagePath { get; set; }
        public int SortOrder { get; set; }
    }

    public class Partner
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int SortOrder { get; set; }
    }

    public class QuickLink
    {
        public int Id { get; set; }
        public string Label { get; set; }
        public string Href { get; set; }
        public int SortOrder { get; set; }
    }

    public class ContactDepartment
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Note { get; set; }
        public int SortOrder { get; set; }
    }

    public class Faq
    {
        public int Id { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public int SortOrder { get; set; }
    }

    public class GalleryImage
    {
        public int Id { get; set; }
        public string Category { get; set; }
        public string Caption { get; set; }
        public string ImagePath { get; set; }
        public int WidthPx { get; set; }
        public int HeightPx { get; set; }
        public int SortOrder { get; set; }
    }

    public class NewsArticle
    {
        public int Id { get; set; }
        public string Slug { get; set; }
        public string Category { get; set; }
        public string Title { get; set; }
        public string Excerpt { get; set; }
        public string Body { get; set; }
        public string AuthorName { get; set; }
        public string PullQuote { get; set; }
        public string PullQuoteBy { get; set; }
        public string ImagePath { get; set; }
        public DateTime PublishedAt { get; set; }
        public bool IsFeatured { get; set; }

        /// <summary>Hashtags shown beneath the article body (table: news_tags).</summary>
        public System.Collections.Generic.List<string> Tags { get; set; }

        public NewsArticle()
        {
            Tags = new System.Collections.Generic.List<string>();
        }

        /// <summary>Published date formatted as the design shows it ("Sep 5, 2026").</summary>
        public string DateLabel { get { return Services.Formatting.ShortDate(PublishedAt); } }
    }
}
