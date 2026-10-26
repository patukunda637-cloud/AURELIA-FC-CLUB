<%@ Page Title="Squad - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Players.aspx.cs" Inherits="AureliaFc.Web.Players" %>
<%@ Import Namespace="AureliaFc.Web" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Squad - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">First Team</p>
            <h1 class="page-hero__title">Squad</h1>
            <p class="page-hero__sub">Meet the players wearing the royal gold this season.</p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <div class="squad-toolbar">
                <div class="chips" role="group" aria-label="Filter by position">
                    <asp:LinkButton ID="lnkAll" runat="server" CssClass="chip" CommandArgument="All" OnCommand="Filter_Command">All</asp:LinkButton>
                    <asp:LinkButton ID="lnkGK" runat="server" CssClass="chip" CommandArgument="Goalkeepers" OnCommand="Filter_Command">Goalkeepers</asp:LinkButton>
                    <asp:LinkButton ID="lnkDF" runat="server" CssClass="chip" CommandArgument="Defenders" OnCommand="Filter_Command">Defenders</asp:LinkButton>
                    <asp:LinkButton ID="lnkMF" runat="server" CssClass="chip" CommandArgument="Midfielders" OnCommand="Filter_Command">Midfielders</asp:LinkButton>
                    <asp:LinkButton ID="lnkFW" runat="server" CssClass="chip" CommandArgument="Forwards" OnCommand="Filter_Command">Forwards</asp:LinkButton>
                </div>

                <div class="squad-search" style="display:flex; gap:10px;">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="input" placeholder="Search squad players..." />
                    <asp:Button ID="btnSearch" runat="server" Text="SEARCH" CssClass="btn btn--gold-outline" OnClick="btnSearch_Click" />
                </div>
            </div>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="state">
                    <h3 class="state__title">No players found</h3>
                    <p>Try a different position filter or clear your search.</p>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlCount" runat="server">
                <p class="squad-count dim">
                    <asp:Literal ID="litCount" runat="server" />
                </p>
            </asp:Panel>

            <div class="grid grid--4 squad-grid">
                <asp:Repeater ID="rptPlayers" runat="server">
                    <ItemTemplate>
                        <article class="player-card">
                            <a class="player-card__media" href="<%# ResolveUrl("~/Squad/PlayerProfile.aspx?id=" + Eval("Id")) %>">
                                <asp:PlaceHolder runat="server" Visible='<%# HasImage(Eval("ImagePath")) %>'>
                                    <img src="<%# ImageUrl((string)Eval("ImagePath")) %>" alt="<%# Enc(Eval("FullName")) %>" loading="lazy" />
                                </asp:PlaceHolder>
                                <asp:PlaceHolder runat="server" Visible='<%# !HasImage(Eval("ImagePath")) %>'>
                                    <div class="player-card__placeholder" aria-hidden="true"><%# ((string)Eval("FirstName")).Substring(0,1) %><%# ((string)Eval("LastName")).Substring(0,1) %></div>
                                </asp:PlaceHolder>
                                <span class="player-card__number">#<%# Eval("SquadNumber") %></span>
                            </a>
                            <div class="player-card__body">
                                <h3 class="player-card__name"><a href="<%# ResolveUrl("~/Squad/PlayerProfile.aspx?id=" + Eval("Id")) %>"><%# Enc(Eval("FullName")) %></a></h3>
                                <p class="player-card__meta">
                                    <span class="player-card__position"><%# AureliaFc.Web.Services.Formatting.PositionAbbreviation((string)Eval("Position")) %></span>
                                    <span class="player-card__dot">•</span>
                                    <span><%# Enc(Eval("Nationality")) %></span>
                                </p>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>