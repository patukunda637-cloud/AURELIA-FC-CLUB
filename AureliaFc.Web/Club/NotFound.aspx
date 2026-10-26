<%@ Page Title="Page Not Found - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NotFound.aspx.cs" Inherits="AureliaFc.Web.NotFound" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Page Not Found - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="section">
        <div class="container center notfound">
            <p class="notfound__code">404</p>
            <h1 class="notfound__title">This page has left the pitch.</h1>
            <p class="notfound__body">The page you're looking for doesn't exist, has moved, or is temporarily unavailable.</p>
            <div class="notfound__actions">
                <a class="btn btn--primary" href="<%= ResolveUrl("~/Default.aspx") %>">BACK TO HOME</a>
                <a class="btn btn--ghost" href="<%= ResolveUrl("~/Matches/Matches.aspx") %>">VIEW FIXTURES</a>
            </div>
        </div>
    </section>
</asp:Content>