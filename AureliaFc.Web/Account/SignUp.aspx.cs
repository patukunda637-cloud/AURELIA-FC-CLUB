using System;
using System.Web;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Services;

namespace AureliaFc.Web
{
    /// <summary>
    /// Creates a supporter account. The password policy is enforced on the server
    /// exactly as the API does it: at least eight characters with an upper-case
    /// letter, a lower-case letter and a digit.
    /// </summary>
    public partial class SignUp : AureliaPage
    {
        private readonly UserRepository _userRepository = new UserRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Create an Aurelia FC account to buy tickets, unlock membership tiers and store your purchase history.";

            if (AuthService.IsAuthenticated)
            {
                Response.Redirect(ResolveUrl("~/Account/Account.aspx"), true);
                return;
            }
        }

        protected void lnkTogglePassword_Click(object sender, EventArgs e)
        {
            if (txtPassword.TextMode == TextBoxMode.Password)
            {
                txtPassword.TextMode = TextBoxMode.SingleLine;
                txtConfirmPassword.TextMode = TextBoxMode.SingleLine;
                lnkTogglePassword.Text = "HIDE";
            }
            else
            {
                txtPassword.TextMode = TextBoxMode.Password;
                txtConfirmPassword.TextMode = TextBoxMode.Password;
                lnkTogglePassword.Text = "SHOW";
            }
        }

        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            pnlFormError.Visible = false;
            lblFirstNameError.Visible = false;
            lblLastNameError.Visible = false;
            lblEmailError.Visible = false;
            lblPasswordError.Visible = false;
            lblConfirmPasswordError.Visible = false;
            lblAgreedError.Visible = false;

            var firstName = (txtFirstName.Text ?? string.Empty).Trim();
            var lastName = (txtLastName.Text ?? string.Empty).Trim();
            var email = (txtEmail.Text ?? string.Empty).Trim();
            var password = txtPassword.Text ?? string.Empty;
            var confirmPassword = txtConfirmPassword.Text ?? string.Empty;

            var hasError = false;

            if (firstName.Length < 2)
            {
                lblFirstNameError.Text = "Please enter your first name.";
                lblFirstNameError.Visible = true;
                hasError = true;
            }

            if (lastName.Length < 2)
            {
                lblLastNameError.Text = "Please enter your last name.";
                lblLastNameError.Visible = true;
                hasError = true;
            }

            if (!ValidationService.IsEmail(email))
            {
                lblEmailError.Text = "Enter a valid email address.";
                lblEmailError.Visible = true;
                hasError = true;
            }

            if (!ValidationService.IsStrongPassword(password))
            {
                lblPasswordError.Text = password.Length < 8
                    ? "Use at least 8 characters."
                    : "Include an upper-case letter and a number.";
                lblPasswordError.Visible = true;
                hasError = true;
            }

            if (confirmPassword != password)
            {
                lblConfirmPasswordError.Text = "Passwords do not match.";
                lblConfirmPasswordError.Visible = true;
                hasError = true;
            }

            if (!chkAgreed.Checked)
            {
                lblAgreedError.Text = "Please accept the Terms & Conditions to continue.";
                lblAgreedError.Visible = true;
                hasError = true;
            }

            if (hasError) return;

            var normalized = ValidationService.Normalize(email);
            if (_userRepository.EmailExists(normalized))
            {
                litFormError.Text = "An account with that email already exists.";
                pnlFormError.Visible = true;
                return;
            }

            try
            {
                var hash = PasswordHasher.Hash(password);
                var userId = _userRepository.Create(firstName, lastName, normalized, hash, "Member");
                var user = _userRepository.FindById(userId);

                AuthService.SignIn(user, true);
                Response.Redirect(ResolveUrl("~/Account/Account.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {
                litFormError.Text = "We could not create your account. Please try again.";
                pnlFormError.Visible = true;
                txtPassword.Text = string.Empty;
                txtConfirmPassword.Text = string.Empty;
            }
        }
    }
}
