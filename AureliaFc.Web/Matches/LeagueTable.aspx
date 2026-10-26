<%@ Page Title="League Table - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeagueTable.aspx.cs" Inherits="AureliaFc.Web.LeagueTablePage" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">League Table - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Standings</p>
            <h1 class="page-hero__title">League Table</h1>
            <p class="page-hero__sub"><asp:Literal ID="litSubtitle" runat="server" /></p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">No standings published yet.</h3></div>
            </asp:Panel>

            <asp:Panel ID="pnlTable" runat="server">
                <div class="table-wrap">
                    <table class="table league-table">
                        <caption class="visually-hidden"><asp:Literal ID="litCaption" runat="server" /></caption>
                        <thead>
                            <tr>
                                <th scope="col">POS</th>
                                <th scope="col">CLUB</th>
                                <th scope="col">P</th>
                                <th scope="col">W</th>
                                <th scope="col">D</th>
                                <th scope="col">L</th>
                                <th scope="col">GF</th>
                                <th scope="col">GA</th>
                                <th scope="col">GD</th>
                                <th scope="col">PTS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptStandings" runat="server">
                                <ItemTemplate>
                                    <tr class='<%# GetRowCss(Container.DataItem) %>'>
                                        <td class="league-table__pos"><%# Eval("Position") %></td>
                                        <td class="league-table__club"><%# Enc(Eval("ClubName")) %></td>
                                        <td><%# Eval("Played") %></td>
                                        <td><%# Eval("Won") %></td>
                                        <td><%# Eval("Drawn") %></td>
                                        <td><%# Eval("Lost") %></td>
                                        <td><%# Eval("GoalsFor") %></td>
                                        <td><%# Eval("GoalsAgainst") %></td>
                                        <td><%# (int)Eval("GoalDifference") > 0 ? "+" + Eval("GoalDifference") : Eval("GoalDifference") %></td>
                                        <td class="league-table__pts"><%# Eval("Points") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>

                <div class="legend">
                    <span class="legend__item"><i class="legend__swatch legend__swatch--ucl"></i> UEFA Champions League Spots</span>
                    <span class="legend__item"><i class="legend__swatch legend__swatch--rel"></i> Relegation Zone</span>
                </div>
            </asp:Panel>
        </div>
    </section>
</asp:Content>