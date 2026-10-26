<%@ Page Title="Aurelia FC - Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AureliaFc.Web.Default" %>
<%@ Import Namespace="AureliaFc.Web.Services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">Aurelia FC - Home</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ---------- Hero ---------- -->
    <section class="page-hero" style="background-image: linear-gradient(90deg, rgba(5,9,24,0.94) 0%, rgba(5,9,24,0.72) 55%, rgba(5,9,24,0.9) 100%), url(<%= ResolveUrl("~/assets/images/hero-home.jpg") %>);">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">THE ROYALS · EST. 1987</p>
            <h1 class="page-hero__title"><asp:Literal ID="litClubName" runat="server" /></h1>
            <p class="page-hero__sub"><asp:Literal ID="litMotto" runat="server" /></p>
            <div class="page-hero__actions">
                <a class="btn btn--primary" href="<%= ResolveUrl("~/Squad/Players.aspx") %>">EXPLORE SQUAD</a>
                <a class="btn btn--ghost" href="<%= ResolveUrl("~/Matches/Matches.aspx") %>">LATEST FIXTURES</a>
            </div>
        </div>
    </section>

    <!-- ---------- Next match + standings ---------- -->
    <section class="section">
        <div class="container home-next">
            <div>
                <p class="eyebrow">Matchday</p>
                <h2 class="home-heading">Next Match</h2>

                <asp:Panel ID="pnlNoNextMatch" runat="server" Visible="false">
                    <div class="state">
                        <h3 class="state__title">No fixtures scheduled</h3>
                        <p>Check back soon for the next match announcement.</p>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlNextMatch" runat="server" Visible="false">
                    <article class="next-match">
                        <p class="next-match__meta">
                            <asp:Literal ID="litNextDate" runat="server" /> · <asp:Literal ID="litNextComp" runat="server" />
                            <span class="badge badge--gold next-match__badge"><asp:Literal ID="litNextHomeAway" runat="server" /></span>
                        </p>
                        <div class="next-match__teams">
                            <span class="next-match__team"><asp:Literal ID="litNextHome" runat="server" /></span>
                            <span class="next-match__vs">VS</span>
                            <span class="next-match__team"><asp:Literal ID="litNextAway" runat="server" /></span>
                        </div>
                        <dl class="next-match__facts">
                            <div>
                                <dt>STADIUM</dt>
                                <dd><asp:Literal ID="litNextVenue" runat="server" /></dd>
                            </div>
                            <div>
                                <dt>KICK OFF</dt>
                                <dd><asp:Literal ID="litNextTime" runat="server" /> BST</dd>
                            </div>
                        </dl>
                        <a class="btn btn--primary next-match__cta" href="<%= ResolveUrl("~/Shop/Tickets.aspx") %>">PURCHASE MATCH TICKETS</a>
                    </article>
                </asp:Panel>
            </div>

            <div>
                <p class="eyebrow">Table</p>
                <h2 class="home-heading">League Standings</h2>
                <asp:Repeater ID="rptStandings" runat="server">
                    <HeaderTemplate>
                        <div class="standings">
                            <table class="table standings__table">
                                <thead>
                                    <tr>
                                        <th scope="col">POS</th>
                                        <th scope="col">CLUB</th>
                                        <th scope="col">P</th>
                                        <th scope="col">GD</th>
                                        <th scope="col">PTS</th>
                                    </tr>
                                </thead>
                                <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr class='<%# Eval("ClubName").ToString() == "Aurelia FC" ? "standings__row--highlight" : "" %>'>
                            <td class="standings__pos"><%# Eval("Position") %></td>
                            <td class="standings__club"><%# Eval("ClubName").ToString() == "Aurelia FC" ? "<a href=\"" + ResolveUrl("~/Matches/LeagueTable.aspx") + "\">" + Eval("ClubName") + "</a>" : Eval("ClubName") %></td>
                            <td><%# Eval("Played") %></td>
                            <td><%# (int)Eval("GoalDifference") > 0 ? "+" + Eval("GoalDifference") : Eval("GoalDifference") %></td>
                            <td class="standings__pts"><%# Eval("Points") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                                </tbody>
                            </table>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
                <p class="home-table-link">
                    <a href="<%= ResolveUrl("~/Matches/LeagueTable.aspx") %>" class="gold">VIEW FULL TABLE →</a>
                </p>
            </div>
        </div>
    </section>

    <!-- ---------- Stats band ---------- -->
    <section class="section section--surface stats-band">
        <div class="container stats-band__grid">
            <div class="stat">
                <p class="stat__value"><asp:Literal ID="litYears" runat="server" /> YEARS</p>
                <p class="stat__label">CLUB HISTORY (EST. <asp:Literal ID="litFounded" runat="server" />)</p>
            </div>
            <div class="stat">
                <p class="stat__value">12 TROPHIES</p>
                <p class="stat__label">CHAMPIONSHIPS &amp; CUPS WON</p>
            </div>
            <div class="stat">
                <p class="stat__value"><asp:Literal ID="litCapacity" runat="server" /> Seats</p>
                <p class="stat__label"><asp:Literal ID="litStadium" runat="server" /> CAPACITY</p>
            </div>
        </div>
    </section>

    <!-- ---------- Recent results ---------- -->
    <section class="section">
        <div class="container">
            <p class="eyebrow">Competitions</p>
            <h2 class="home-heading home-heading--lg">Recent Results</h2>

            <asp:Panel ID="pnlNoResults" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">No completed matches yet this season.</h3></div>
            </asp:Panel>

            <asp:Repeater ID="rptResults" runat="server">
                <HeaderTemplate>
                    <div class="grid grid--3">
                </HeaderTemplate>
                <ItemTemplate>
                    <a href="<%# ResolveUrl("~/Matches/MatchDetail.aspx?id=" + Eval("Id")) %>" class="result-card">
                        <p class="result-card__meta"><%# Eval("DateLabel") %> · <%# Eval("Competition") %></p>
                        <p class="result-card__score"><%# Eval("ScoreLabel") %></p>
                        <div class="result-card__teams">
                            <span><%# Eval("HomeTeam") %></span>
                            <span class="dim"><%# Eval("AwayTeam") %></span>
                        </div>
                    </a>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </section>

    <!-- ---------- Featured players ---------- -->
    <section class="section section--surface">
        <div class="container">
            <p class="eyebrow">Squad Highlight</p>
            <h2 class="home-heading home-heading--lg">Featured Players</h2>

            <asp:Panel ID="pnlNoPlayers" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">No featured players available.</h3></div>
            </asp:Panel>

            <asp:Repeater ID="rptPlayers" runat="server">
                <HeaderTemplate>
                    <div class="grid grid--3">
                </HeaderTemplate>
                <ItemTemplate>
                    <article class="featured-player">
                        <div class="featured-player__media">
                            <asp:Image runat="server" ImageUrl='<%# Eval("ImagePath") != null ? ResolveUrl("~/" + Eval("ImagePath")) : "" %>' Visible='<%# Eval("ImagePath") != null %>' AlternateText='<%# Eval("FullName") %>' />
                        </div>
                        <div class="featured-player__body">
                            <h3><%# Eval("FullName") %></h3>
                            <p class="featured-player__meta">
                                <span class="gold"><%# Eval("Position") %></span>
                                <span class="muted">#<%# Eval("SquadNumber") %></span>
                                <a href="<%# ResolveUrl("~/Squad/PlayerProfile.aspx?id=" + Eval("Id")) %>" class="featured-player__link">VIEW PROFILE</a>
                            </p>
                        </div>
                    </article>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </section>

    <!-- ---------- Latest news ---------- -->
    <section class="section">
        <div class="container">
            <p class="eyebrow">Media</p>
            <h2 class="home-heading home-heading--lg">Latest News</h2>

            <asp:Panel ID="pnlNoNews" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">No news published yet.</h3></div>
            </asp:Panel>

            <asp:Repeater ID="rptNews" runat="server">
                <HeaderTemplate>
                    <div class="grid grid--3">
                </HeaderTemplate>
                <ItemTemplate>
                    <article class="news-card">
                        <a href="<%# ResolveUrl("~/News/Article.aspx?slug=" + Eval("Slug")) %>" class="news-card__media" aria-label='<%# Eval("Title") %>'>
                            <asp:Image runat="server" ImageUrl='<%# Eval("ImagePath") != null ? ResolveUrl("~/" + Eval("ImagePath")) : "" %>' Visible='<%# Eval("ImagePath") != null %>' AlternateText="" />
                            <span class="badge badge--gold news-card__badge"><%# Eval("Category") %></span>
                        </a>
                        <div class="news-card__body">
                            <p class="news-card__date"><%# Eval("DateLabel") %></p>
                            <h3 class="news-card__title">
                                <a href="<%# ResolveUrl("~/News/Article.aspx?slug=" + Eval("Slug")) %>"><%# Eval("Title") %></a>
                            </h3>
                            <p class="news-card__excerpt"><%# Eval("Excerpt") %></p>
                            <a href="<%# ResolveUrl("~/News/Article.aspx?slug=" + Eval("Slug")) %>" class="news-card__more">READ MORE →</a>
                        </div>
                    </article>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <p class="home-more">
                <a href="<%= ResolveUrl("~/News/News.aspx") %>" class="btn btn--gold-outline">ALL NEWS</a>
            </p>
        </div>
    </section>
</asp:Content>
