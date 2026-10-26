<%@ Page Title="Matches &amp; Fixtures - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Matches.aspx.cs" Inherits="AureliaFc.Web.Matches" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Matches &amp; Fixtures - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Fixtures</p>
            <h1 class="page-hero__title">Matches &amp; Fixtures</h1>
            <p class="page-hero__sub">Every upcoming kick-off and completed result for the 2026/2027 season.</p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <div class="chips matches-tabs" role="tablist" aria-label="Filter matches">
                <asp:LinkButton ID="lnkUpcoming" runat="server" CssClass="chip" CommandArgument="upcoming" OnCommand="Tab_Command">Upcoming</asp:LinkButton>
                <asp:LinkButton ID="lnkResults" runat="server" CssClass="chip" CommandArgument="results" OnCommand="Tab_Command">Results</asp:LinkButton>
                <asp:LinkButton ID="lnkAll" runat="server" CssClass="chip" CommandArgument="all" OnCommand="Tab_Command">All</asp:LinkButton>
            </div>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="state">
                    <h3 class="state__title">No matches in this view</h3>
                    <p>Try another tab.</p>
                </div>
            </asp:Panel>

            <div class="fixture-list">
                <asp:Repeater ID="rptFixtures" runat="server">
                    <ItemTemplate>
                        <article class="fixture-row">
                            <div class="fixture-row__date">
                                <span class="fixture-row__date-main"><%# Enc(Eval("DateLabel")) %></span>
                                <span class="fixture-row__date-sub"><%# Enc(Eval("TimeLabel")) %> • <%# Enc(Eval("Competition")) %></span>
                            </div>

                            <div class="fixture-row__teams">
                                <span class="fixture-row__team fixture-row__team--home"><%# Enc(Eval("HomeTeam")) %></span>
                                <span class='<%# (bool)Eval("IsCompleted") ? "fixture-row__score" : "fixture-row__score fixture-row__score--vs" %>'><%# Enc(GetScoreLabel(Container.DataItem)) %></span>
                                <span class="fixture-row__team fixture-row__team--away"><%# Enc(Eval("AwayTeam")) %></span>
                            </div>

                            <div class="fixture-row__venue">
                                <span><%# Enc(Eval("Venue")) %></span>
                                <span class="dim"><%# Enc(Eval("HomeAwayLabel")) %></span>
                            </div>

                            <div class="fixture-row__actions">
                                <a class="btn btn--ghost" href="<%# ResolveUrl("~/Matches/MatchDetail.aspx?id=" + Eval("Id")) %>">MATCH CENTRE</a>
                                <asp:PlaceHolder runat="server" Visible='<%# (bool)Eval("TicketsAvailable") %>'>
                                    <a class="btn btn--primary" href="<%= ResolveUrl("~/Shop/Tickets.aspx") %>">BUY TICKETS</a>
                                </asp:PlaceHolder>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>