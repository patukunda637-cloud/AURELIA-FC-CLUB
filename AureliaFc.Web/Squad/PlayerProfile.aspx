<%@ Page Title="Player Profile - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlayerProfile.aspx.cs" Inherits="AureliaFc.Web.PlayerProfile" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server"><asp:Literal ID="litTitle" runat="server" /> - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlNotFound" runat="server" Visible="false">
        <section class="section"><div class="container"><div class="state"><h3 class="state__title">Player not found</h3></div></div></section>
    </asp:Panel>

    <asp:Panel ID="pnlProfile" runat="server">
        <section class="profile-hero">
            <div class="container profile-hero__inner">
                <div class="profile-hero__media">
                    <asp:PlaceHolder ID="phPlayerImage" runat="server" Visible="false">
                        <img src="<%= ImageUrl(PlayerImagePath) %>" alt="<%= Server.HtmlEncode(PlayerName) %>" />
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="phPlayerPlaceholder" runat="server">
                        <div class="profile-hero__placeholder" aria-hidden="true"></div>
                    </asp:PlaceHolder>
                </div>

                <div class="profile-hero__copy">
                    <p class="eyebrow"><asp:Literal ID="litEyebrow" runat="server" /> · SQUAD NO. <asp:Literal ID="litSquadNo" runat="server" /></p>
                    <h1><asp:Literal ID="litName" runat="server" /></h1>
                    <p class="profile-hero__bio"><asp:Literal ID="litBio" runat="server" /></p>

                    <dl class="profile-hero__meta">
                        <div>
                            <dt>NATIONALITY</dt>
                            <dd><asp:Literal ID="litNationality" runat="server" /></dd>
                        </div>
                        <div>
                            <dt>HEIGHT</dt>
                            <dd><asp:Literal ID="litHeight" runat="server" /></dd>
                        </div>
                        <div>
                            <dt>DATE OF BIRTH</dt>
                            <dd><asp:Literal ID="litDob" runat="server" /></dd>
                        </div>
                        <div>
                            <dt>SQUAD</dt>
                            <dd><a href="<%= ResolveUrl("~/Squad/Teams.aspx") %>"><asp:Literal ID="litTeam" runat="server" /></a></dd>
                        </div>
                    </dl>
                </div>
            </div>
        </section>

        <section class="section section--surface">
            <div class="container">
                <div class="grid grid--4">
                    <div class="stat-tile">
                        <p class="stat-tile__value"><asp:Literal ID="litGoals" runat="server" /></p>
                        <p class="stat-tile__label">GOALS SCORED</p>
                    </div>
                    <div class="stat-tile">
                        <p class="stat-tile__value"><asp:Literal ID="litAssists" runat="server" /></p>
                        <p class="stat-tile__label">ASSISTS DELIVERED</p>
                    </div>
                    <div class="stat-tile">
                        <p class="stat-tile__value"><asp:Literal ID="litApps" runat="server" /></p>
                        <p class="stat-tile__label">APPEARANCES</p>
                    </div>
                    <div class="stat-tile">
                        <p class="stat-tile__value"><asp:Literal ID="litRating" runat="server" /></p>
                        <p class="stat-tile__label">AVERAGE MATCH RATING</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container profile-panels">
                <div>
                    <h2 class="profile-heading">Season Statistics</h2>
                    <p class="dim profile-season"><asp:Literal ID="litSeason" runat="server" /></p>
                    <asp:Panel ID="pnlNoSeasonStats" runat="server" Visible="false">
                        <p class="dim">No monthly statistics recorded for this season.</p>
                    </asp:Panel>
                    <asp:Repeater ID="rptSeasonStats" runat="server">
                        <HeaderTemplate>
                            <table class="table">
                                <thead><tr><th scope="col">MONTH</th><th scope="col">APPS</th><th scope="col">GOALS</th><th scope="col">ASSISTS</th></tr></thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="standings__club"><%# Enc(Eval("MonthLabel")) %></td>
                                <td><%# Eval("Apps") %></td>
                                <td><%# Eval("Goals") %></td>
                                <td><%# Eval("Assists") %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate></tbody></table></FooterTemplate>
                    </asp:Repeater>
                </div>

                <div>
                    <h2 class="profile-heading">Career History</h2>
                    <ul class="career">
                        <li class="career__current">
                            <div>
                                <span class="career__club"><asp:Literal ID="litCurrentClub" runat="server" /></span>
                                <span class="dim career__period">2023 – Present</span>
                            </div>
                            <div class="career__stats">
                                <span><strong><asp:Literal ID="litCurrentApps" runat="server" /></strong> Matches</span>
                                <span><strong><asp:Literal ID="litCurrentGoals" runat="server" /></strong> Goals</span>
                            </div>
                        </li>
                        <asp:Repeater ID="rptCareer" runat="server">
                            <ItemTemplate>
                                <li>
                                    <div>
                                        <span class="career__club"><%# Enc(Eval("ClubName")) %></span>
                                        <span class="dim career__period"><%# Enc(Eval("Period")) %></span>
                                    </div>
                                    <div class="career__stats">
                                        <asp:PlaceHolder runat="server" Visible='<%# Eval("Appearances") != DBNull.Value && Eval("Appearances") != null %>'>
                                            <span><strong><%# Eval("Appearances") %></strong> Matches</span>
                                        </asp:PlaceHolder>
                                        <asp:PlaceHolder runat="server" Visible='<%# Eval("Goals") != DBNull.Value && Eval("Goals") != null %>'>
                                            <span><strong><%# Eval("Goals") %></strong> Goals</span>
                                        </asp:PlaceHolder>
                                        <asp:PlaceHolder runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Note") as string) %>'>
                                            <span class="gold"><%# Enc(Eval("Note")) %></span>
                                        </asp:PlaceHolder>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </section>
    </asp:Panel>
</asp:Content>