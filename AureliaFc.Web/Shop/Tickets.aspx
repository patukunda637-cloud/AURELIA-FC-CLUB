<%@ Page Title="Match Tickets - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tickets.aspx.cs" Inherits="AureliaFc.Web.Tickets" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Match Tickets - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero" style="background-image: linear-gradient(90deg, rgba(5,9,24,0.94) 0%, rgba(5,9,24,0.72) 55%, rgba(5,9,24,0.9) 100%), url(<%= ResolveUrl("~/assets/images/hero-tickets.jpg") %>);">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Box Office</p>
            <h1 class="page-hero__title">Match Tickets</h1>
            <p class="page-hero__sub">Secure your seat at Aurelia Arena for every home fixture this season.</p>
        </div>
    </section>

    <asp:Panel ID="pnlNotice" runat="server" Visible="false">
        <div class="container" style="padding-top:24px;">
            <div class="alert alert--success"><asp:Literal ID="litNotice" runat="server" /></div>
        </div>
    </asp:Panel>

    <!-- ---------- Match tickets ---------- -->
    <section class="section">
        <div class="container">
            <p class="eyebrow">Upcoming Fixtures</p>
            <h2 class="tickets-heading">Match Tickets</h2>

            <asp:Panel ID="pnlNoFixtures" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">Tickets are not on sale right now.</h3></div>
            </asp:Panel>

            <div class="ticket-list">
                <asp:Repeater ID="rptFixtures" runat="server">
                    <ItemTemplate>
                        <article class="ticket-row">
                            <div class="ticket-row__date">
                                <span class="ticket-row__day"><%# Eval("DayLabel") %></span>
                                <span class="ticket-row__month"><%# ((string)Eval("MonthLabel")).Substring(0, 3).ToUpperInvariant() %></span>
                            </div>
                            <div class="ticket-row__main">
                                <p class="ticket-row__tournament"><%# Enc(Eval("Match.Competition")) %></p>
                                <h3><%# Enc(Eval("MatchLabel")) %></h3>
                                <p class="dim"><%# Enc(Eval("Venue")) %> · <%# Enc(Eval("KickoffLabel")) %></p>
                                <div class="ticket-row__seats">
                                    <span><%# AureliaFc.Web.Services.Formatting.Number((int)Eval("AvailableSeats")) %> seats available</span>
                                    <span class='<%# (bool)Eval("IsSellingFast") ? "badge badge--solid" : "badge badge--gold" %>'><%# Enc(Eval("StatusLabel")) %></span>
                                </div>
                            </div>
                            <div class="ticket-row__action">
                                <p class="ticket-row__price"><%# AureliaFc.Web.Services.Formatting.MoneyRange((decimal)Eval("PriceMin"), (decimal)Eval("PriceMax")) %></p>
                                <asp:Button ID="btnBuy" runat="server" CssClass="btn btn--primary"
                                    Text='<%# (int)Eval("AvailableSeats") > 0 ? "BUY TICKETS" : "SOLD OUT" %>'
                                    Enabled='<%# (int)Eval("AvailableSeats") > 0 %>'
                                    CommandName="AddTicket" CommandArgument='<%# Eval("MatchId") %>' OnCommand="AddItem_Command" />
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- ---------- Season tickets ---------- -->
    <section class="section section--surface">
        <div class="container">
            <p class="eyebrow">Membership</p>
            <h2 class="tickets-heading">Season Tickets</h2>

            <asp:Panel ID="pnlNoTiers" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">Season tickets are not on sale right now.</h3></div>
            </asp:Panel>

            <div class="grid grid--3">
                <asp:Repeater ID="rptTiers" runat="server">
                    <ItemTemplate>
                        <article class="tier-card">
                            <h3><%# Enc(Eval("Name")) %></h3>
                            <p class="tier-card__price"><%# AureliaFc.Web.Services.Formatting.Money((decimal)Eval("Price")) %><span class="tier-card__unit">/season</span></p>
                            <p class="tier-card__desc"><%# Enc(Eval("Description")) %></p>
                            <ul class="tier-card__features">
                                <asp:Repeater ID="rptFeatures" runat="server" DataSource='<%# Eval("Features") %>'>
                                    <ItemTemplate><li><%# Enc(Container.DataItem) %></li></ItemTemplate>
                                </asp:Repeater>
                            </ul>
                            <asp:Button ID="btnSelectTier" runat="server" CssClass="btn btn--gold-outline btn--block" Text="SELECT TIER"
                                CommandName="AddSeason" CommandArgument='<%# Eval("Id") %>' OnCommand="AddItem_Command" />
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- ---------- Hospitality ---------- -->
    <section class="section">
        <div class="container">
            <p class="eyebrow">Premium</p>
            <h2 class="tickets-heading">Hospitality</h2>

            <asp:Panel ID="pnlNoHospitality" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">Hospitality packages are not available right now.</h3></div>
            </asp:Panel>

            <div class="grid grid--2">
                <asp:Repeater ID="rptHospitality" runat="server">
                    <ItemTemplate>
                        <article class="hosp-card">
                            <asp:PlaceHolder runat="server" Visible='<%# HasImage(Eval("ImagePath")) %>'>
                                <div class="hosp-card__media">
                                    <img src="<%# ImageUrl((string)Eval("ImagePath")) %>" alt="<%# Enc(Eval("Name")) %>" loading="lazy" />
                                </div>
                            </asp:PlaceHolder>
                            <div class="hosp-card__body">
                                <h3><%# Enc(Eval("Name")) %></h3>
                                <p class="hosp-card__price"><%# AureliaFc.Web.Services.Formatting.Money((decimal)Eval("Price")) %><span class="tier-card__unit"><%# Enc(Eval("PriceUnit")) %></span></p>
                                <p><%# Enc(Eval("Description")) %></p>
                                <asp:Button ID="btnEnquire" runat="server" CssClass="btn btn--primary" Text="ENQUIRE NOW"
                                    CommandName="AddHospitality" CommandArgument='<%# Eval("Id") %>' OnCommand="AddItem_Command" />
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>