<%@ Page Title="Our Teams - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Teams.aspx.cs" Inherits="AureliaFc.Web.Teams" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Our Teams - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Squads</p>
            <h1 class="page-hero__title">Our Teams</h1>
            <p class="page-hero__sub">From the first team to the academy, every Aurelia FC squad shares one identity.</p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <div class="grid grid--3">
                <asp:Repeater ID="rptTeams" runat="server">
                    <ItemTemplate>
                        <article class="team-card">
                            <div class="team-card__media">
                                <asp:PlaceHolder runat="server" Visible='<%# HasImage(Eval("ImagePath")) %>'>
                                    <img src="<%# ImageUrl((string)Eval("ImagePath")) %>" alt="<%# Enc(Eval("Name")) %>" loading="lazy" />
                                </asp:PlaceHolder>
                            </div>
                            <div class="team-card__body">
                                <h3><%# Enc(Eval("Name")) %></h3>
                                <p class="team-card__desc"><%# Enc(Eval("Description")) %></p>
                                <dl class="team-card__facts">
                                    <div>
                                        <dt>COACH</dt>
                                        <dd><%# Enc(Eval("Coach")) %></dd>
                                    </div>
                                    <div>
                                        <dt>PLAYERS</dt>
                                        <dd><%# Eval("PlayerCount") %></dd>
                                    </div>
                                </dl>
                                <div class="team-card__actions">
                                    <asp:LinkButton ID="lnkToggle" runat="server" CssClass="btn btn--gold-outline" CommandName="Toggle" CommandArgument='<%# Eval("Id") %>' OnCommand="Team_Toggle">
                                        <%# GetToggleLabel((int)Eval("Id")) %>
                                    </asp:LinkButton>
                                    <a class="btn btn--ghost" href="<%= ResolveUrl("~/Squad/Players.aspx") %>">ALL PLAYERS</a>
                                </div>

                                <asp:Panel ID="pnlRoster" runat="server" CssClass="team-card__roster" Visible='<%# IsRosterOpen((int)Eval("Id")) %>'>
                                    <asp:Repeater ID="rptRoster" runat="server" DataSource='<%# GetRoster((int)Eval("Id")) %>'>
                                        <HeaderTemplate><ul></HeaderTemplate>
                                        <ItemTemplate>
                                            <li>
                                                <a href="<%# ResolveUrl("~/Squad/PlayerProfile.aspx?id=" + Eval("Id")) %>">
                                                    <span class="gold">#<%# Eval("SquadNumber") %></span>
                                                    <span><%# Enc(Eval("FullName")) %></span>
                                                    <span class="dim"><%# Enc(Eval("Position")) %></span>
                                                </a>
                                            </li>
                                        </ItemTemplate>
                                        <FooterTemplate></ul></FooterTemplate>
                                    </asp:Repeater>
                                    <asp:Panel ID="pnlNoRoster" runat="server" Visible='<%# GetRosterCount((int)Eval("Id")) == 0 %>'>
                                        <p class="dim">No players listed.</p>
                                    </asp:Panel>
                                </asp:Panel>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>