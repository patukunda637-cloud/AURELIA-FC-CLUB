<%@ Page Title="News &amp; Updates - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="AureliaFc.Web.News" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">News &amp; Updates - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Media</p>
            <h1 class="page-hero__title">News &amp; Updates</h1>
            <p class="page-hero__sub">Club announcements, match reports, transfer news and academy stories.</p>
        </div>
    </section>

    <!-- ---------- Featured story ---------- -->
    <section class="section">
        <div class="container">
            <asp:Panel ID="pnlFeatured" runat="server" Visible="false">
                <article class="featured-article">
                    <div class="featured-article__media">
                        <asp:PlaceHolder ID="phFeaturedImage" runat="server" Visible="false">
                            <img src="<%= ImageUrl(FeaturedImagePath) %>" alt="" loading="lazy" />
                        </asp:PlaceHolder>
                    </div>
                    <div class="featured-article__body">
                        <p class="eyebrow">FEATURED CLUB NEWS &middot; <asp:Literal ID="litFeaturedDate" runat="server" /></p>
                        <h2><asp:Literal ID="litFeaturedTitle" runat="server" /></h2>
                        <p><asp:Literal ID="litFeaturedExcerpt" runat="server" /></p>
                        <a class="btn btn--primary" href="<%= ResolveUrl("~/News/Article.aspx?slug=" + UrlEncode(FeaturedSlug)) %>">READ FULL ARTICLE</a>
                    </div>
                </article>
            </asp:Panel>
        </div>
    </section>

    <!-- ---------- Archive ---------- -->
    <section class="section section--surface">
        <div class="container">
            <div class="chips news-filters" role="group" aria-label="Filter news">
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkCat" runat="server" CssClass="<%# GetCategoryCss(Container.DataItem.ToString()) %>"
                            CommandName="Filter" CommandArgument="<%# Container.DataItem.ToString() %>" OnCommand="Category_Command">
                            <%# Container.DataItem.ToString() %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">No articles in this category</h3><p>Try a different filter.</p></div>
            </asp:Panel>

            <div class="grid grid--3">
                <asp:Repeater ID="rptArticles" runat="server">
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
</asp:Content>
