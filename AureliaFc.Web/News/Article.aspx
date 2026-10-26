<%@ Page Title="Club News - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Article.aspx.cs" Inherits="AureliaFc.Web.Article" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server"><asp:Literal ID="litTitle" runat="server" /> - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlNotFound" runat="server" Visible="false">
        <section class="section"><div class="container"><div class="state"><h3 class="state__title">Article not found</h3><p>The story you were looking for is no longer available.</p></div></div></section>
    </asp:Panel>

    <asp:Panel ID="pnlArticle" runat="server">
        <article class="container section article">
            <p class="eyebrow"><asp:Literal ID="litMeta" runat="server" /></p>
            <h1 class="article__title"><asp:Literal ID="litHeadline" runat="server" /></h1>
            <p class="article__excerpt"><asp:Literal ID="litExcerpt" runat="server" /></p>

            <asp:PlaceHolder ID="phHeroImage" runat="server" Visible="false">
                <figure class="article__hero">
                    <img src="<%= ImageUrl(ArticleImagePath) %>" alt="" />
                </figure>
            </asp:PlaceHolder>

            <div class="article__body">
                <asp:Repeater ID="rptParagraphs" runat="server">
                    <ItemTemplate>
                        <p><%# Enc(Container.DataItem) %></p>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlQuote" runat="server" Visible="false">
                <blockquote class="article__quote">
                    <p>&ldquo;<asp:Literal ID="litQuote" runat="server" />&rdquo;</p>
                    <asp:PlaceHolder ID="phQuoteBy" runat="server">
                        <cite>&mdash; <asp:Literal ID="litQuoteBy" runat="server" /></cite>
                    </asp:PlaceHolder>
                </blockquote>
            </asp:Panel>

            <section class="article__share" aria-label="Share this story">
                <h2>Share This Story</h2>
                <div class="article__share-actions">
                    <a class="btn btn--ghost" target="_blank" rel="noopener noreferrer"
                       href="https://www.facebook.com/sharer/sharer.php?u=<%= UrlEncode(ShareUrl) %>">Facebook</a>
                    <a class="btn btn--ghost" target="_blank" rel="noopener noreferrer"
                       href="https://twitter.com/intent/tweet?url=<%= UrlEncode(ShareUrl) %>&text=<%= UrlEncode(ShareTitle) %>">Twitter</a>
                    <a class="btn btn--ghost" target="_blank" rel="noopener noreferrer"
                       href="https://www.linkedin.com/sharing/share-offsite/?url=<%= UrlEncode(ShareUrl) %>">LinkedIn</a>
                    <a class="btn btn--gold-outline" href="#" id="lnkCopyLink" onclick="return aureliaCopyLink();">COPY LINK</a>
                </div>
                <div class="alert alert--success" id="copyStatus" style="display:none;">Link copied to your clipboard.</div>
            </section>

            <asp:Panel ID="pnlTags" runat="server" Visible="false">
                <ul class="article__tags" aria-label="Tags">
                    <asp:Repeater ID="rptTags" runat="server">
                        <ItemTemplate>
                            <li><%# Enc(Container.DataItem) %></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </asp:Panel>
        </article>

        <section class="section section--surface">
            <div class="container">
                <h2 class="article__related-heading">Related Articles</h2>
                <div class="grid grid--4">
                    <asp:Repeater ID="rptRelated" runat="server">
                        <ItemTemplate>
                            <article class="news-card">
                                <a class="news-card__media" href="<%# ResolveUrl("~/News/Article.aspx?slug=" + UrlEncode((string)Eval("Slug"))) %>" aria-label="<%# Enc(Eval("Title")) %>">
                                    <asp:PlaceHolder runat="server" Visible='<%# HasImage(Eval("ImagePath")) %>'>
                                        <img src="<%# ImageUrl((string)Eval("ImagePath")) %>" alt="" loading="lazy" />
                                    </asp:PlaceHolder>
                                    <asp:PlaceHolder runat="server" Visible='<%# !HasImage(Eval("ImagePath")) %>'>
                                        <div class="news-card__placeholder" aria-hidden="true"></div>
                                    </asp:PlaceHolder>
                                    <span class="badge badge--gold news-card__badge"><%# Enc(Eval("Category")) %></span>
                                </a>
                                <div class="news-card__body">
                                    <p class="news-card__date"><%# Enc(Eval("DateLabel")) %></p>
                                    <h3 class="news-card__title">
                                        <a href="<%# ResolveUrl("~/News/Article.aspx?slug=" + UrlEncode((string)Eval("Slug"))) %>"><%# Enc(Eval("Title")) %></a>
                                    </h3>
                                    <p class="news-card__excerpt"><%# Enc(Eval("Excerpt")) %></p>
                                    <a class="news-card__more" href="<%# ResolveUrl("~/News/Article.aspx?slug=" + UrlEncode((string)Eval("Slug"))) %>">READ MORE &rarr;</a>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

        <div class="container section--tight">
            <a class="btn btn--ghost" href="<%= ResolveUrl("~/News/News.aspx") %>">&larr; BACK TO ALL NEWS</a>
        </div>
    </asp:Panel>

    <script type="text/javascript">
        function aureliaCopyLink() {
            var url = '<%= ShareUrlJs %>';
            var status = document.getElementById('copyStatus');
            var button = document.getElementById('lnkCopyLink');
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(url);
                status.style.display = 'block';
                button.textContent = 'COPIED!';
                window.setTimeout(function () {
                    status.style.display = 'none';
                    button.textContent = 'COPY LINK';
                }, 2500);
            }
            return false;
        }
    </script>
</asp:Content>
