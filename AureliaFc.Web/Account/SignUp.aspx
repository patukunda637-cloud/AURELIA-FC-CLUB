<%@ Page Title="Sign Up - Aurelia FC" Language="C#" MasterPageFile="~/Auth.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="AureliaFc.Web.SignUp" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Sign Up - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-card">
        <h1 class="auth-card__title">Create Your Account</h1>
        <p class="auth-card__sub">Join Aurelia FC today to buy tickets, unlock membership tiers, and store secure purchase histories.</p>

        <asp:Panel ID="pnlFormError" runat="server" Visible="false">
            <div class="auth-alert" role="alert"><asp:Literal ID="litFormError" runat="server" /></div>
        </asp:Panel>

        <div>
            <div class="auth-card__pair">
                <div class="field">
                    <label class="field__label" for="<%= txtFirstName.ClientID %>">First Name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="input" placeholder="Arthur" autocomplete="given-name" />
                    <asp:Label ID="lblFirstNameError" runat="server" CssClass="field__error" Visible="false" />
                </div>

                <div class="field">
                    <label class="field__label" for="<%= txtLastName.ClientID %>">Last Name</label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="input" placeholder="Sterling" autocomplete="family-name" />
                    <asp:Label ID="lblLastNameError" runat="server" CssClass="field__error" Visible="false" />
                </div>
            </div>

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
                        placeholder="RoyalPassword123" autocomplete="new-password" />
                    <asp:LinkButton ID="lnkTogglePassword" runat="server" CssClass="auth-password__toggle"
                        Text="SHOW" CausesRedirect="false" OnClick="lnkTogglePassword_Click" />
                </div>
                <div class="password-strength" id="strengthBlock" style="display:none;" aria-hidden="true">
                    <span class="password-strength__bar" id="bar1"></span>
                    <span class="password-strength__bar" id="bar2"></span>
                    <span class="password-strength__bar" id="bar3"></span>
                </div>
                <p class="password-strength__label" id="strengthLabel" style="display:none;">Strength: Too short</p>
                <asp:Label ID="lblPasswordError" runat="server" CssClass="field__error" Visible="false" />
            </div>

            <div class="field">
                <label class="field__label" for="<%= txtConfirmPassword.ClientID %>">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input" TextMode="Password"
                    placeholder="Re-enter password" autocomplete="new-password" />
                <asp:Label ID="lblConfirmPasswordError" runat="server" CssClass="field__error" Visible="false" />
            </div>

            <div class="field">
                <label class="auth-card__check auth-card__check--terms">
                    <asp:CheckBox ID="chkAgreed" runat="server" />
                    <span>I agree to the Terms &amp; Conditions and Privacy Policy.</span>
                </label>
                <asp:Label ID="lblAgreedError" runat="server" CssClass="field__error" Visible="false" />
            </div>

            <asp:Button ID="btnCreateAccount" runat="server" Text="CREATE ACCOUNT" CssClass="btn btn--primary btn--block" OnClick="btnCreateAccount_Click" />
        </div>

        <p class="auth-card__divider">or continue with</p>

        <div class="auth-card__oauth">
            <button type="button" class="btn btn--outline" disabled="disabled">Google</button>
            <button type="button" class="btn btn--outline" disabled="disabled">Apple</button>
        </div>

        <p class="auth-card__foot">
            Already have an account? <a class="auth-card__link" href="<%= ResolveUrl("~/Account/SignIn.aspx") %>">Sign In</a>
        </p>
    </div>

    <script type="text/javascript">
        (function () {
            var input = document.getElementById('<%= txtPassword.ClientID %>');
            var block = document.getElementById('strengthBlock');
            var label = document.getElementById('strengthLabel');
            var bars = [document.getElementById('bar1'), document.getElementById('bar2'), document.getElementById('bar3')];

            function score(value) {
                var meets = value.length >= 8 && /[a-z]/.test(value) && /[A-Z]/.test(value) && /\d/.test(value);
                if (!meets) {
                    return {
                        score: value.length === 0 ? 0 : 1,
                        label: value.length < 8 ? 'Too short' : 'Needs upper, lower & a number'
                    };
                }
                if (value.length >= 12 && /[^A-Za-z0-9]/.test(value)) return { score: 3, label: 'Strong' };
                if (value.length >= 10) return { score: 2, label: 'Good' };
                return { score: 1, label: 'Acceptable' };
            }

            function update() {
                var value = input.value;
                if (value.length === 0) {
                    block.style.display = 'none';
                    label.style.display = 'none';
                    return;
                }
                var result = score(value);
                block.style.display = 'flex';
                label.style.display = 'block';
                label.textContent = 'Strength: ' + result.label;
                for (var i = 0; i < bars.length; i++) {
                    bars[i].className = 'password-strength__bar' + (i < result.score ? ' password-strength__bar--on' : '');
                }
            }

            input.addEventListener('input', update);
            update();
        })();
    </script>
</asp:Content>
