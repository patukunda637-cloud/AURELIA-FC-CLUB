<%@ Page Title="My Account - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="AureliaFc.Web.Account" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">My Account - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Membership Portal</p>
            <h1 class="page-hero__title"><asp:Literal ID="litWelcome" runat="server" /></h1>
            <p class="page-hero__sub">Track your orders, tickets and account details in one place.</p>
        </div>
    </section>

    <section class="section">
        <div class="container account-grid">
            <!-- ---------- Profile ---------- -->
            <aside class="account-side">
                <div class="account-identity">
                    <span class="account-avatar" aria-hidden="true"><asp:Literal ID="litInitials" runat="server" /></span>
                    <h2><asp:Literal ID="litFullName" runat="server" /></h2>
                    <p class="muted account-email"><asp:Literal ID="litEmail" runat="server" /></p>
                    <span class="badge badge--gold"><asp:Literal ID="litRole" runat="server" /></span>
                </div>

                <dl class="account-stats">
                    <div>
                        <dt>Orders</dt>
                        <dd><asp:Literal ID="litOrderCount" runat="server" /></dd>
                    </div>
                    <div>
                        <dt>Tickets</dt>
                        <dd><asp:Literal ID="litTicketCount" runat="server" /></dd>
                    </div>
                    <div>
                        <dt>Total Spent</dt>
                        <dd><asp:Literal ID="litTotalSpent" runat="server" /></dd>
                    </div>
                </dl>

                <div class="account-actions">
                    <a class="btn btn--primary btn--block" href="<%= ResolveUrl("~/Shop/Shop.aspx") %>">Visit Shop</a>
                    <a class="btn btn--ghost btn--block" href="<%= ResolveUrl("~/Shop/Tickets.aspx") %>">Buy Tickets</a>
                    <asp:Button ID="btnSignOut" runat="server" CssClass="btn btn--ghost btn--block" Text="Sign Out" OnClick="btnSignOut_Click" />
                </div>
            </aside>

            <!-- ---------- Orders ---------- -->
            <div class="account-main">
                <div class="section-head">
                    <div>
                        <p class="eyebrow">Purchase History</p>
                        <h2 class="section-title">Your Orders</h2>
                    </div>
                    <a class="auth-card__link" href="<%= ResolveUrl("~/Shop/Shop.aspx") %>">Order again &rarr;</a>
                </div>

                <asp:Panel ID="pnlNoOrders" runat="server" Visible="false">
                    <div class="state">
                        <h3 class="state__title">No orders yet</h3>
                        <p>Anything you buy from the shop or box office will appear here. <a class="gold" href="<%= ResolveUrl("~/Shop/Shop.aspx") %>">Start shopping</a>.</p>
                    </div>
                </asp:Panel>

                <div class="order-list">
                    <asp:Repeater ID="rptOrders" runat="server">
                        <ItemTemplate>
                            <article class="order-card">
                                <header class="order-card__head">
                                    <div>
                                        <h3><%# Enc(Eval("Reference")) %></h3>
                                        <p class="dim"><%# Enc(Eval("OrderType")) %> order &middot; <%# AureliaFc.Web.Services.Formatting.ShortDate((DateTime)Eval("CreatedAt")) %></p>
                                    </div>
                                    <div class="order-card__right">
                                        <span class='<%# GetStatusCss((string)Eval("Status")) %>'><%# Enc(Eval("Status")) %></span>
                                        <strong class="order-card__total"><%# Enc(Eval("TotalLabel")) %></strong>
                                    </div>
                                </header>

                                <ul class="order-card__items">
                                    <asp:Repeater ID="rptItems" runat="server" DataSource='<%# Eval("Items") %>'>
                                        <ItemTemplate>
                                            <li>
                                                <span><%# GetItemDescription(Container.DataItem) %></span>
                                                <span class="dim"><%# GetItemQuantity(Container.DataItem) %> &times; <%# GetItemUnitPrice(Container.DataItem) %></span>
                                                <span><%# GetItemLineTotal(Container.DataItem) %></span>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
