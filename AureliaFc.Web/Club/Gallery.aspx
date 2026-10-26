<%@ Page Title="Media Gallery - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="AureliaFc.Web.Gallery" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Media Gallery - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Media</p>
            <h1 class="page-hero__title">Media Gallery</h1>
            <p class="page-hero__sub">Matchdays, training sessions and unforgettable moments from Aurelia Arena.</p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <div class="chips gallery-filters">
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkCat" runat="server" CssClass="<%# GetCategoryCss(Container.DataItem.ToString()) %>"
                            CommandName="Filter" CommandArgument="<%# Container.DataItem.ToString() %>" OnCommand="Category_Command">
                            <%# Container.DataItem.ToString() %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="state"><h3 class="state__title">No images in this collection</h3><p>Try a different filter.</p></div>
            </asp:Panel>

            <div class="gallery-grid">
                <asp:Repeater ID="rptGallery" runat="server">
                    <ItemTemplate>
                        <figure class='<%# (Container.ItemIndex % 5 == 0) ? "gallery-item gallery-item--wide" : "gallery-item" %>'>
                            <img src="<%# ImageUrl((string)Eval("ImagePath")) %>" alt="<%# Enc(Eval("Caption")) %>" loading="lazy" style="aspect-ratio: <%# Eval("WidthPx") %> / <%# Eval("HeightPx") %>;" />
                            <figcaption>
                                <span><%# Enc(Eval("Caption")) %></span>
                                <span class="badge badge--muted"><%# Enc(Eval("Category")) %></span>
                            </figcaption>
                        </figure>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>