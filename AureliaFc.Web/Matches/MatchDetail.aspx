<%@ Page Title="Match Centre - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MatchDetail.aspx.cs" Inherits="AureliaFc.Web.MatchDetail" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server"><asp:Literal ID="litTitle" runat="server" /> - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlNotFound" runat="server" Visible="false">
        <section class="section"><div class="container"><div class="state"><h3 class="state__title">Match not found</h3><p>The fixture you were looking for is not available.</p></div></div></section>
    </asp:Panel>

    <asp:Panel ID="pnlMatch" runat="server">
        <section class="match-hero">
            <div class="container">
                <p class="eyebrow"><asp:Literal ID="litStatus" runat="server" /> — <asp:Literal ID="litCompetitionUpper" runat="server" /></p>
                <div class="match-hero__scoreboard">
                    <div class="match-hero__team">
                        <span class="match-hero__name"><asp:Literal ID="litHomeTeam" runat="server" /></span>
                        <span class="badge badge--gold">HOME</span>
                    </div>
                    <span class="match-hero__score"><asp:Literal ID="litScore" runat="server" /></span>
                    <div class="match-hero__team match-hero__team--away">
                        <span class="match-hero__name"><asp:Literal ID="litAwayTeam" runat="server" /></span>
                        <span class="badge badge--muted">AWAY</span>
                    </div>
                </div>
                <p class="match-hero__meta"><asp:Literal ID="litMeta" runat="server" /></p>
            </div>
        </section>

        <section class="section">
            <div class="container match-grid">
                <div>
                    <h2 class="match-heading">Match Events</h2>
                    <asp:Panel ID="pnlNoEvents" runat="server" Visible="false">
                        <p class="dim">No events recorded for this match.</p>
                    </asp:Panel>
                    <ul class="timeline-events">
                        <asp:Repeater ID="rptEvents" runat="server">
                            <ItemTemplate>
                                <li class="timeline-events__item">
                                    <span class="timeline-events__minute"><%# Enc(Eval("MinuteLabel")) %></span>
                                    <div>
                                        <span class="timeline-events__player"><%# Enc(Eval("PlayerName")) %></span>
                                        <span class="timeline-events__type"><%# Enc(Eval("EventType")) %></span>
                                    </div>
                                    <span class='<%# (bool)Eval("IsHome") ? "badge badge--gold" : "badge badge--muted" %>'><%# Enc(GetEventTeam(Container.DataItem)) %></span>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>

                <div>
                    <h2 class="match-heading">Match Stats</h2>
                    <asp:Panel ID="pnlNoStats" runat="server" Visible="false">
                        <p class="dim">No statistics recorded for this match.</p>
                    </asp:Panel>

                    <asp:Panel ID="pnlStats" runat="server">
                        <table class="table match-stats">
                            <caption class="visually-hidden">Match statistics</caption>
                            <thead>
                                <tr>
                                    <th scope="col"><asp:Literal ID="litStatsHome" runat="server" /></th>
                                    <th scope="col" style="text-align:center;">STAT</th>
                                    <th scope="col" style="text-align:right;"><asp:Literal ID="litStatsAway" runat="server" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptStats" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="match-stats__home"><%# Enc(Eval("HomeValue")) %></td>
                                            <td style="text-align:center;" class="dim"><%# Enc(Eval("StatLabel")) %></td>
                                            <td class="match-stats__away"><%# Enc(Eval("AwayValue")) %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </asp:Panel>
                </div>
            </div>
        </section>

        <section class="section section--surface">
            <div class="container">
                <h2 class="match-heading">Starting XI</h2>
                <div class="match-grid">
                    <div class="lineup">
                        <div class="lineup__head">
                            <h3><asp:Literal ID="litHomeLineupTitle" runat="server" /></h3>
                            <asp:Panel ID="pnlHomeFormation" runat="server" Visible="false">
                                <span class="badge badge--gold"><asp:Literal ID="litHomeFormation" runat="server" /></span>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pnlNoHomeLineup" runat="server" Visible="false"><p class="dim">Lineup not available.</p></asp:Panel>
                        <ul class="lineup__list">
                            <asp:Repeater ID="rptHomeLineup" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <span class="lineup__no"><%# Enc(Eval("SquadNo")) %></span>
                                        <span class="lineup__name"><%# Enc(Eval("PlayerName")) %></span>
                                        <span class="lineup__role dim"><%# Enc(Eval("RoleCode")) %></span>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>

                    <div class="lineup">
                        <div class="lineup__head">
                            <h3><asp:Literal ID="litAwayLineupTitle" runat="server" /></h3>
                            <asp:Panel ID="pnlAwayFormation" runat="server" Visible="false">
                                <span class="badge badge--gold"><asp:Literal ID="litAwayFormation" runat="server" /></span>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pnlNoAwayLineup" runat="server" Visible="false"><p class="dim">Lineup not available.</p></asp:Panel>
                        <ul class="lineup__list">
                            <asp:Repeater ID="rptAwayLineup" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <span class="lineup__no"><%# Enc(Eval("SquadNo")) %></span>
                                        <span class="lineup__name"><%# Enc(Eval("PlayerName")) %></span>
                                        <span class="lineup__role dim"><%# Enc(Eval("RoleCode")) %></span>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <asp:Panel ID="pnlReport" runat="server" Visible="false">
            <section class="section">
                <div class="container">
                    <h2 class="match-heading">Match Report</h2>
                    <p class="match-report"><asp:Literal ID="litReport" runat="server" /></p>
                    <a class="btn btn--gold-outline" href="<%= ResolveUrl("~/News/News.aspx") %>">CLUB NEWS</a>
                </div>
            </section>
        </asp:Panel>
    </asp:Panel>
</asp:Content>