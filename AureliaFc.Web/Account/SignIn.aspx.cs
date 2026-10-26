using System;
using System.Web;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Services;

namespace AureliaFc.Web
{
    /// <summary>
    /// Supporter sign-in. The password is verified against the stored BCrypt hash and
    /// a signed JWT is stored in an HttpOnly cookie, so no token is ever exposed to
    /// page markup.
    /// </summary>
    public partial class SignIn : AureliaPage
    {
        private readonly UserRepository _userRepository = new UserRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Sign in to access your Aurelia FC tickets, order history and membership portal.";

            if (AuthService.IsAuthenticated)
            {
                Response.Redirect(ResolveUrl("~/Account/Account.aspx"), true);
                return;
            }

            if (!IsPostBack)
            {
                var returnUrl = Request.QueryString["ReturnUrl"];
                if (!string.IsNullOrWhiteSpace(returnUrl) && IsLocalUrl(returnUrl))
                    ViewState["ReturnUrl"] = returnUrl;
            }
        }

        protected void lnkTogglePassword_Click(object sender, EventArgs e)
        {
            if (txtPassword.TextMode == TextBoxMode.Password)
            {
                txtPassword.TextMode = TextBoxMode.SingleLine;
                lnkTogglePassword.Text = "HIDE";
            }
            else
            {
                txtPassword.TextMode = TextBoxMode.Password;
                lnkTogglePassword.Text = "SHOW";
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            pnlFormError.Visible = false;
            lblEmailError.Visible = false;
            lblPasswordError.Visible = false;

            var email = (txtEmail.Text ?? string.Empty).Trim();
            var password = txtPassword.Text ?? string.Empty;
            var hasError = false;

            if (!ValidationService.IsEmail(email))
            {
                lblEmailError.Text = "Enter a valid email address.";
                lblEmailError.Visible = true;
                hasError = true;
            }

            if (password.Length == 0)
            {
                lblPasswordError.Text = "Enter your password.";
                lblPasswordError.Visible = true;
                hasError = true;
            }

            if (hasError) return;

            var user = _userRepository.FindByEmail(ValidationService.Normalize(email));
            if (user == null || !PasswordHasher.Verify(password, user.PasswordHash))
            {
                litFormError.Text = "The email or password is incorrect.";
                pnlFormError.Visible = true;
                txtPassword.Text = string.Empty;
                return;
            }

            AuthService.SignIn(user, chkRemember.Checked);

            var returnUrl = ViewState["ReturnUrl"] as string;
            var destination = !string.IsNullOrEmpty(returnUrl) && IsLocalUrl(returnUrl)
                ? returnUrl
                : ResolveUrl("~/Account/Account.aspx");

            Response.Redirect(destination, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        /// <summary>Only same-site paths are accepted as a post-login destination.</summary>
        private bool IsLocalUrl(string url)
        {
            if (string.IsNullOrWhiteSpace(url)) return false;
            if (!url.StartsWith("/", StringComparison.Ordinal)) return false;
            if (url.StartsWith("//", StringComparison.Ordinal)) return false;
            if (url.StartsWith("/\\", StringComparison.Ordinal)) return false;
            return url.IndexOf("://", StringComparison.Ordinal) < 0;
        }
    }
}
