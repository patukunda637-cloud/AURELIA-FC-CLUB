<%@ Page Title="Official Store - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="AureliaFc.Web.Shop" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Official Store - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="section shop-banner-section">
        <div class="container">
            <div class="chips shop-filters" role="group" aria-label="Filter products">
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkCat" runat="server" CssClass="<%# GetCategoryCss(Container.DataItem.ToString()) %>"
                            CommandName="Filter" CommandArgument="<%# Container.DataItem.ToString() %>" OnCommand="Category_Command">
                            <%# Container.DataItem.ToString() %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlBanner" runat="server" Visible="false">
                <article class="shop-banner">
                    <img class="shop-banner__img" src="<%= ResolveUrl("~/" + FeaturedImagePath) %>" alt="" />
                    <div class="shop-banner__overlay" aria-hidden="true"></div>
                    <div class="shop-banner__body">
                        <p class="eyebrow shop-banner__eyebrow">NEW ARRIVAL</p>
                        <h1 class="shop-banner__title"><asp:Literal ID="litFeaturedName" runat="server" /></h1>
                        <p class="shop-banner__desc"><asp:Literal ID="litFeaturedDescription" runat="server" /></p>
                        <div class="shop-banner__actions">
                            <span class="shop-banner__price"><asp:Literal ID="litFeaturedPrice" runat="server" /></span>
                            <asp:Button ID="btnShopNow" runat="server" CssClass="btn btn--primary" Text="SHOP NOW" CommandName="AddProduct" CommandArgument="0" OnCommand="AddItem_Command" />
                        </div>
                    </div>
                </article>
            </asp:Panel>
        </div>
    </section>

    <!-- ---------- Catalogue ---------- -->
    <section class="section section--surface">
        <div class="container">
            <asp:Panel ID="pnlNoProducts" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">No products in this category</h3><p>Try a different filter.</p></div>
            </asp:Panel>

            <div class="grid grid--4">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <article class="product-card">
                            <div class="product-card__media">
                                <asp:PlaceHolder runat="server" Visible='<%# HasImage(Eval("ImagePath")) %>'>
                                    <img src="<%# ImageUrl((string)Eval("ImagePath")) %>" alt="<%# Enc(Eval("Name")) %>" loading="lazy" />
                                </asp:PlaceHolder>
                                <asp:PlaceHolder runat="server" Visible='<%# !HasImage(Eval("ImagePath")) %>'>
                                    <div class="product-card__placeholder" aria-hidden="true"></div>
                                </asp:PlaceHolder>
                                <asp:PlaceHolder runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Badge") as string) %>'>
                                    <span class="badge badge--gold product-card__badge"><%# Enc(Eval("Badge")) %></span>
                                </asp:PlaceHolder>
                            </div>
                            <div class="product-card__body">
                                <p class="product-card__category"><%# Enc(Eval("Category")) %></p>
                                <h3 class="product-card__name"><%# Enc(Eval("Name")) %></h3>
                                <p class="product-card__price"><%# AureliaFc.Web.Services.Formatting.Money((decimal)Eval("Price")) %></p>
                                <asp:Button ID="btnAdd" runat="server" CssClass="btn btn--gold-outline btn--block" Text="ADD TO BASKET"
                                    CommandName="AddProduct" CommandArgument='<%# Eval("Id") %>' OnCommand="AddItem_Command" />
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- ---------- Basket ---------- -->
    <section class="section" id="basket" aria-label="Shopping basket">
        <div class="container">
            <div class="basket">
                <div class="basket__head">
                    <h2>Your Basket</h2>
                    <span class="badge badge--gold"><asp:Literal ID="litBasketCount" runat="server" /></span>
                </div>

                <asp:Panel ID="pnlConfirmation" runat="server" Visible="false">
                    <div class="alert alert--success"><asp:Literal ID="litConfirmation" runat="server" /></div>
                </asp:Panel>
                <asp:Panel ID="pnlCheckoutError" runat="server" Visible="false">
                    <div class="alert alert--error"><asp:Literal ID="litCheckoutError" runat="server" /></div>
                </asp:Panel>

                <asp:Panel ID="pnlEmptyBasket" runat="server" Visible="false">
                    <div class="state">
                        <h3 class="state__title">Your basket is empty</h3>
                        <p>Add products from the store to get started.</p>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlBasket" runat="server">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">ITEM</th>
                                <th scope="col">QTY</th>
                                <th scope="col">UNIT</th>
                                <th scope="col">TOTAL</th>
                                <th scope="col"><span class="visually-hidden">Actions</span></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptBasket" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="standings__club"><%# Enc(Eval("Description")) %></td>
                                        <td>
                                            <div class="qty">
                                                <asp:LinkButton ID="btnDecrease" runat="server" Text="−" CommandName="Decrease" CommandArgument='<%# Eval("Key") %>' OnCommand="Basket_Command" />
                                                <span><%# Eval("Quantity") %></span>
                                                <asp:LinkButton ID="btnIncrease" runat="server" Text="+" CommandName="Increase" CommandArgument='<%# Eval("Key") %>' OnCommand="Basket_Command" />
                                            </div>
                                        </td>
                                        <td><%# Enc(Eval("UnitPriceLabel")) %></td>
                                        <td class="gold"><%# Enc(Eval("LineTotalLabel")) %></td>
                                        <td>
                                            <asp:LinkButton ID="btnRemove" runat="server" CssClass="basket__remove" Text="Remove" CommandName="Remove" CommandArgument='<%# Eval("Key") %>' OnCommand="Basket_Command" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>

                    <div class="basket__summary">
                        <div>
                            <span class="dim">Subtotal</span>
                            <strong class="basket__total"><asp:Literal ID="litSubtotal" runat="server" /></strong>
                        </div>
                        <asp:LinkButton ID="lnkCheckout" runat="server" CssClass="btn btn--primary" Text="PLACE ORDER" Visible="false" OnClick="Checkout_Click" />
                        <asp:HyperLink ID="lnkSignIn" runat="server" CssClass="btn btn--primary" Text="SIGN IN TO CHECKOUT" NavigateUrl="~/Account/SignIn.aspx" Visible="false" />
                    </div>

                    <asp:Panel ID="pnlGuestNote" runat="server" Visible="false">
                        <p class="dim basket__note">You are browsing as a guest. Sign in to save your order history.</p>
                    </asp:Panel>
                </asp:Panel>
            </div>
        </div>
    </section>
</asp:Content>