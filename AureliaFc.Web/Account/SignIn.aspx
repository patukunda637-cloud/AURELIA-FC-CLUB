<%@ Page Title="Sign In - Aurelia FC" Language="C#" MasterPageFile="~/Auth.Master" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="AureliaFc.Web.SignIn" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Sign In - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-card">
        <h1 class="auth-card__title">Sign In to Aurelia FC</h1>
        <p class="auth-card__sub">Access your tickets, order history and membership portal.</p>

        <asp:Panel ID="pnlFormError" runat="server" Visible="false">
            <div class="auth-alert" role="alert"><asp:Literal ID="litFormError" runat="server" /></div>
        </asp:Panel>

        <div>
            <div class="field">
                <label class="field__label" for="<%= txtEmail.ClientID %>">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email"
                    placeholder="you@domain.com" autocomplete="email" />
                <asp:Label ID="lblEmailError" runat="server" CssClass="field__error" Visible="false" />
            </div>

            <div class="field">
                <label class="field__label" for="<%= txtPassword.ClientID %>">Password</label>
                <div class="auth-password">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password"
                        placeholder="RoyalPassword123" autocomplete="current-password" />
                    <asp:LinkButton ID="lnkTogglePassword" runat="server" CssClass="auth-password__toggle"
                        Text="SHOW" CausesRedirect="false" OnClick="lnkTogglePassword_Click" />
                </div>
                <asp:Label ID="lblPasswordError" runat="server" CssClass="field__error" Visible="false" />
            </div>

            <div class="auth-card__row">
                <label class="auth-card__check">
                    <asp:CheckBox ID="chkRemember" runat="server" Checked="true" />
                    <span>Remember me</span>
                </label>
                <a class="auth-card__link" href="<%= ResolveUrl("~/Club/Contact.aspx") %>">Forgot Password?</a>
            </div>

            <asp:Button ID="btnSignIn" runat="server" Text="SIGN IN" CssClass="btn btn--primary btn--block" OnClick="btnSignIn_Click" />
        </div>

        <p class="auth-card__divider">or continue with</p>

        <div class="auth-card__oauth">
            <button type="button" class="btn btn--outline" disabled="disabled">Google</button>
            <button type="button" class="btn btn--outline" disabled="disabled">Apple</button>
        </div>

        <p class="auth-card__foot">
            Don't have an account? <a class="auth-card__link" href="<%= ResolveUrl("~/Account/SignUp.aspx") %>">Sign Up</a>
        </p>
    </div>
</asp:Content>
