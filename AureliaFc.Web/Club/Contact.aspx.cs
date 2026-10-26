using System;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;
using AureliaFc.Web.Services;

namespace AureliaFc.Web
{
    /// <summary>
    /// Enquiries page: department contacts, a validated message form posted to
    /// <c>contact_messages</c>, stadium location and the FAQ accordion.
    /// </summary>
    public partial class Contact : AureliaPage
    {
        private readonly ClubRepository _clubRepository = new ClubRepository();

        private int? OpenFaqIndex
        {
            get { return ViewState["OpenFaqIndex"] as int?; }
            set { ViewState["OpenFaqIndex"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Contact Aurelia FC about tickets, membership, media enquiries and general questions.";

            if (IsPostBack) return;

            var club = _clubRepository.GetClubInfo();
            if (club != null)
            {
                litStadiumName.Text = Server.HtmlEncode(club.StadiumName);
                litAddress.Text = Server.HtmlEncode(club.Address);
                litPhone.Text = Server.HtmlEncode(club.Phone);
            }

            var departments = _clubRepository.GetDepartments();
            rptDepartments.DataSource = departments;
            rptDepartments.DataBind();

            foreach (var dept in departments)
                ddlSubject.Items.Add(new ListItem(dept.Name, dept.Name));

            rptFaqs.DataSource = _clubRepository.GetFaqs();
            rptFaqs.DataBind();
        }

        protected string GetFaqIcon(int index)
        {
            return OpenFaqIndex.HasValue && OpenFaqIndex.Value == index ? "−" : "+";
        }

        protected bool IsFaqOpen(int index)
        {
            return OpenFaqIndex.HasValue && OpenFaqIndex.Value == index;
        }

        protected void Faq_Toggle(object sender, CommandEventArgs e)
        {
            int index;
            if (!int.TryParse(e.CommandArgument.ToString(), out index)) return;

            if (OpenFaqIndex.HasValue && OpenFaqIndex.Value == index)
                OpenFaqIndex = null;
            else
                OpenFaqIndex = index;

            rptFaqs.DataSource = _clubRepository.GetFaqs();
            rptFaqs.DataBind();
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            pnlResult.Visible = false;
            pnlFormError.Visible = false;
            lblFullNameError.Visible = false;
            lblEmailError.Visible = false;
            lblSubjectError.Visible = false;
            lblMessageError.Visible = false;

            var fullName = (txtFullName.Text ?? string.Empty).Trim();
            var email = (txtEmail.Text ?? string.Empty).Trim();
            var subject = ddlSubject.SelectedValue;
            var message = (txtMessage.Text ?? string.Empty).Trim();

            var hasError = false;

            if (fullName.Length < 2)
            {
                lblFullNameError.Text = "Please enter your full name.";
                lblFullNameError.Visible = true;
                hasError = true;
            }
            if (!ValidationService.IsEmail(email))
            {
                lblEmailError.Text = "Enter a valid email address.";
                lblEmailError.Visible = true;
                hasError = true;
            }
            if (string.IsNullOrEmpty(subject))
            {
                lblSubjectError.Text = "Please choose a subject.";
                lblSubjectError.Visible = true;
                hasError = true;
            }
            if (message.Length < 10)
            {
                lblMessageError.Text = "Your message must be at least 10 characters.";
                lblMessageError.Visible = true;
                hasError = true;
            }

            if (hasError) return;

            try
            {
                int? userId = AuthService.CurrentUserId;
                _clubRepository.CreateMessage(fullName, email, subject, message, userId);
                litResult.Text = Server.HtmlEncode(
                    "Thank you for getting in touch. We'll respond to your enquiry as soon as possible. Your reference is MSG-" +
                    DateTime.UtcNow.ToString("HHmmss") + ".");
                pnlResult.Visible = true;
                txtFullName.Text = string.Empty;
                txtEmail.Text = string.Empty;
                ddlSubject.SelectedIndex = 0;
                txtMessage.Text = string.Empty;
            }
            catch (Exception)
            {
                litFormError.Text = "We could not send your message. Please try again.";
                pnlFormError.Visible = true;
            }
        }
    }
}
