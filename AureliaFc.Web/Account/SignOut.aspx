<%@ Page Title="Sign Out - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignOut.aspx.cs" Inherits="AureliaFc.Web.SignOut" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Sign Out - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="section">
        <div class="container center notfound">
            <h1 class="notfound__title">You have been signed out</h1>
            <p class="notfound__body">Thanks for visiting Aurelia FC. Sign back in whenever you need your tickets or order history.</p>
            <div class="notfound__actions">
                <a class="btn btn--primary" href="<%= ResolveUrl("~/Default.aspx") %>">BACK TO HOME</a>
                <a class="btn btn--ghost" href="<%= ResolveUrl("~/Account/SignIn.aspx") %>">SIGN IN</a>
            </div>
        </div>
    </section>
</asp:Content>
