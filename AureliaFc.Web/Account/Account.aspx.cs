using System;
using System.Collections.Generic;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;
using AureliaFc.Web.Services;

namespace AureliaFc.Web
{
    /// <summary>
    /// The membership portal: the supporter's profile, lifetime totals and the
    /// purchase history stored in <c>orders</c> / <c>order_items</c>.
    /// </summary>
    public partial class Account : AureliaPage
    {
        private readonly OrderRepository _orderRepository = new OrderRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            var user = AuthService.CurrentUser;
            if (user == null)
            {
                var returnUrl = Server.UrlEncode(Request.RawUrl ?? "~/Account/Account.aspx");
                Response.Redirect(ResolveUrl("~/Account/SignIn.aspx?ReturnUrl=" + returnUrl), true);
                return;
            }

            MetaDescription = "Manage your Aurelia FC orders, tickets and account details.";

            litWelcome.Text = Server.HtmlEncode("Welcome back, " + user.FirstName);
            litInitials.Text = Server.HtmlEncode(
                ((user.FirstName ?? string.Empty) + (user.LastName ?? string.Empty)).Trim().ToUpperInvariant());
            litFullName.Text = Server.HtmlEncode(user.FullName);
            litEmail.Text = Server.HtmlEncode(user.Email);
            litRole.Text = Server.HtmlEncode(user.IsAdmin ? "Club Administrator" : "Member");

            var orders = _orderRepository.GetOrdersForUser(user.Id);

            var spend = 0m;
            var tickets = 0;
            foreach (var order in orders)
            {
                spend += order.TotalAmount;
                foreach (var item in order.Items)
                {
                    if (item.ItemType == "MatchTicket" || item.ItemType == "SeasonTicket")
                        tickets += item.Quantity;
                }
            }

            litOrderCount.Text = orders.Count.ToString();
            litTicketCount.Text = tickets.ToString();
            litTotalSpent.Text = Services.Formatting.Money(spend);

            pnlNoOrders.Visible = orders.Count == 0;
            rptOrders.DataSource = orders;
            rptOrders.DataBind();
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            AuthService.SignOut();
            Response.Redirect(ResolveUrl("~/Default.aspx"), false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected string GetStatusCss(string status)
        {
            switch (status)
            {
                case "Paid":
                case "Confirmed":
                    return "badge badge--gold";
                default:
                    return "badge badge--muted";
            }
        }

        protected string GetItemDescription(object dataItem)
        {
            var item = dataItem as OrderItem;
            return item == null ? string.Empty : Server.HtmlEncode(item.Description ?? string.Empty);
        }

        protected string GetItemQuantity(object dataItem)
        {
            var item = dataItem as OrderItem;
            return item == null ? string.Empty : item.Quantity.ToString();
        }

        protected string GetItemUnitPrice(object dataItem)
        {
            var item = dataItem as OrderItem;
            return item == null ? string.Empty : Server.HtmlEncode(item.UnitPriceLabel);
        }

        protected string GetItemLineTotal(object dataItem)
        {
            var item = dataItem as OrderItem;
            return item == null ? string.Empty : Server.HtmlEncode(item.LineTotalLabel);
        }
    }
}
