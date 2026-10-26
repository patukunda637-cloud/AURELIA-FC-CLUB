<%@ Page Title="About Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="AureliaFc.Web.About" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">About Aurelia FC - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ---------- Page hero ---------- -->
    <section class="page-hero" style="background-image: linear-gradient(90deg, rgba(5,9,24,0.94) 0%, rgba(5,9,24,0.72) 55%, rgba(5,9,24,0.9) 100%), url(<%= ResolveUrl("~/assets/images/hero-about.jpg") %>);">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">The Club</p>
            <h1 class="page-hero__title">About Aurelia FC</h1>
            <p class="page-hero__sub"><asp:Literal ID="litClubDescription" runat="server" /></p>
        </div>
    </section>

    <!-- ---------- History timeline ---------- -->
    <section class="section">
        <div class="container">
            <p class="eyebrow">Our Journey</p>
            <h2 class="about-heading">Club History Timeline</h2>

            <ol class="timeline">
                <asp:Repeater ID="rptMilestones" runat="server">
                    <ItemTemplate>
                        <li class="timeline__item">
                            <span class="timeline__year"><%# Enc(Eval("YearLabel")) %></span>
                            <div class="timeline__content">
                                <h3><%# Enc(Eval("Title")) %></h3>
                                <p><%# Enc(Eval("Body")) %></p>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ol>

            <asp:Panel ID="pnlNoMilestones" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">Club history is being written.</h3></div>
            </asp:Panel>
        </div>
    </section>

    <!-- ---------- Mission & values ---------- -->
    <section class="section section--surface">
        <div class="container">
            <p class="eyebrow">Mission &amp; Values</p>
            <h2 class="about-heading">What We Stand For</h2>

            <div class="grid grid--3">
                <asp:Repeater ID="rptValues" runat="server">
                    <ItemTemplate>
                        <article class="value-card">
                            <h3><%# Enc(Eval("Title")) %></h3>
                            <p><%# Enc(Eval("Body")) %></p>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- ---------- Arena feature ---------- -->
    <section class="section">
        <div class="container arena">
            <div class="arena__media">
                <img src="<%= ResolveUrl("~/assets/images/arena-aerial.jpg") %>" alt="Aurelia Arena aerial view" loading="lazy" />
            </div>
            <div class="arena__copy">
                <p class="eyebrow">Our Home</p>
                <h2 class="about-heading"><asp:Literal ID="litStadiumName" runat="server" /></h2>
                <p>
                    A cathedral of modern football, <asp:Literal ID="litStadiumNameInline" runat="server" /> has been the proud home of the
                    Royals since <asp:Literal ID="litBuiltYear" runat="server" />. Every matchday, the arena comes alive with the passion of our
                    supporters.
                </p>
                <dl class="arena__facts">
                    <div>
                        <dt>CAPACITY</dt>
                        <dd><asp:Literal ID="litCapacity" runat="server" /> Seats</dd>
                    </div>
                    <div>
                        <dt>RECORD ATTENDANCE</dt>
                        <dd><asp:Literal ID="litRecordAttendance" runat="server" /> Fans</dd>
                    </div>
                </dl>
            </div>
        </div>
    </section>

    <!-- ---------- Honours ---------- -->
    <section class="section section--surface">
        <div class="container">
            <p class="eyebrow">Trophy Room</p>
            <h2 class="about-heading">Honours Cabinet</h2>

            <div class="grid grid--3">
                <asp:Repeater ID="rptHonours" runat="server">
                    <ItemTemplate>
                        <article class="honour-card">
                            <h3><%# Enc(Eval("Title")) %></h3>
                            <p class="honour-card__years"><%# Enc(Eval("Years")) %></p>
                            <span class="badge badge--gold"><%# Enc(Eval("CountLabel")) %></span>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- ---------- Executives ---------- -->
    <section class="section">
        <div class="container">
            <p class="eyebrow">Leadership</p>
            <h2 class="about-heading">Key Executives</h2>

            <div class="grid grid--2">
                <asp:Repeater ID="rptExecutives" runat="server">
                    <ItemTemplate>
                        <article class="exec-card">
                            <div class="exec-card__media">
                                <asp:PlaceHolder runat="server" Visible='<%# HasImage(Eval("ImagePath")) %>'>
                                    <img src='<%# ImageUrl((string)Eval("ImagePath")) %>' alt='<%# Enc(Eval("FullName")) %>' loading="lazy" />
                                </asp:PlaceHolder>
                            </div>
                            <div class="exec-card__body">
                                <h3><%# Enc(Eval("FullName")) %></h3>
                                <p class="gold"><%# Enc(Eval("RoleTitle")) %></p>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>
