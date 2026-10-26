using System;
using System.Web.UI.WebControls;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Services;

namespace AureliaFc.Web
{
    /// <summary>
    /// The Official Store. It renders the featured product banner, the filterable
    /// catalogue and the shared basket. Checkout posts every line to
    /// <c>OrderRepository.Create</c>, which re-prices the lines from the catalogue
    /// inside a transaction before the total is stored.
    /// </summary>
    public partial class Shop : AureliaPage
    {
        private readonly CommerceRepository _commerceRepository = new CommerceRepository();

        private string CurrentCategory
        {
            get { return ViewState["ShopCategory"] as string ?? "All"; }
            set { ViewState["ShopCategory"] = value; }
        }

        /// <summary>Path of the featured product's artwork, used by the banner markup.</summary>
        public string FeaturedImagePath { get; private set; } = "assets/images/shop-hero-kit.jpg";

        protected void Page_Load(object sender, EventArgs e)
        {
            MetaDescription = "Shop official Aurelia FC kits, training wear, accessories and lifestyle products.";

            if (!IsPostBack)
            {
                var categories = _commerceRepository.GetCategories();
                var names = new System.Collections.Generic.List<string> { "All" };
                foreach (var category in categories) names.Add(category.Name);
                rptCategories.DataSource = names;
                rptCategories.DataBind();

                var featured = _commerceRepository.GetFeaturedProduct();
                if (featured != null)
                {
                    pnlBanner.Visible = true;
                    if (!string.IsNullOrWhiteSpace(featured.ImagePath))
                        FeaturedImagePath = featured.ImagePath.Replace('\\', '/').TrimStart('/');
                    litFeaturedName.Text = Server.HtmlEncode(featured.Name);
                    litFeaturedDescription.Text = Server.HtmlEncode(featured.Description ?? string.Empty);
                    litFeaturedPrice.Text = Services.Formatting.Money(featured.Price);
                    btnShopNow.CommandArgument = featured.Id.ToString();
                }
            }

            BindProducts();
            BindBasket();
        }

        private void BindProducts()
        {
            var products = _commerceRepository.GetProducts(CurrentCategory);
            pnlNoProducts.Visible = products.Count == 0;
            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }

        private void BindBasket()
        {
            var items = CartService.GetItems();
            var count = CartService.ItemCount;

            litBasketCount.Text = count == 1 ? "1 item" : count + " items";
            pnlEmptyBasket.Visible = items.Count == 0;
            pnlBasket.Visible = items.Count > 0;
            rptBasket.DataSource = items;
            rptBasket.DataBind();
            litSubtotal.Text = Services.Formatting.Money(CartService.Subtotal);

            var authenticated = AuthService.IsAuthenticated;
            lnkCheckout.Visible = items.Count > 0 && authenticated;
            lnkSignIn.Visible = items.Count > 0 && !authenticated;
            pnlGuestNote.Visible = items.Count > 0 && !authenticated;
        }

        protected string GetCategoryCss(string category)
        {
            return category == CurrentCategory ? "chip chip--active" : "chip";
        }

        protected void Category_Command(object sender, CommandEventArgs e)
        {
            CurrentCategory = e.CommandArgument.ToString();
            BindProducts();
            rptCategories.DataBind();
        }

        protected void AddItem_Command(object sender, CommandEventArgs e)
        {
            int id;
            if (!int.TryParse(e.CommandArgument.ToString(), out id)) return;

            CartService.Add("Product", id, 1);
            BindBasket();
        }

        protected void Basket_Command(object sender, CommandEventArgs e)
        {
            var key = e.CommandArgument.ToString();
            var line = FindLine(key);
            if (line == null) return;

            switch (e.CommandName)
            {
                case "Increase":
                    CartService.SetQuantity(key, line.Quantity + 1);
                    break;
                case "Decrease":
                    CartService.SetQuantity(key, line.Quantity - 1);
                    break;
                case "Remove":
                    CartService.Remove(key);
                    break;
            }

            BindBasket();
        }

        private CartService.Line FindLine(string key)
        {
            foreach (var line in CartService.CurrentLines)
                if (line.Key == key) return line;
            return null;
        }

        protected void Checkout_Click(object sender, EventArgs e)
        {
            pnlConfirmation.Visible = false;
            pnlCheckoutError.Visible = false;

            var userId = AuthService.CurrentUserId;
            if (!userId.HasValue)
            {
                Response.Redirect(ResolveUrl("~/Account/SignIn.aspx"));
                return;
            }

            var items = CartService.GetItems();
            if (items.Count == 0) return;

            var requested = new System.Collections.Generic.List<Models.OrderItem>();
            foreach (var item in items)
            {
                requested.Add(new Models.OrderItem
                {
                    ItemType = item.ItemType,
                    ItemRefId = item.ItemRefId,
                    Description = item.Description,
                    Quantity = item.Quantity,
                    UnitPrice = item.UnitPrice
                });
            }

            try
            {
                var orderType = ResolveOrderType(items);
                var orderId = new OrderRepository().Create(userId, orderType, requested);
                var order = new OrderRepository().GetOrder(orderId);
                CartService.Clear();
                BindBasket();

                litConfirmation.Text = Server.HtmlEncode(
                    "Order " + order.Reference + " placed successfully. Total " + Services.Formatting.Money(order.TotalAmount) + ".");
                pnlConfirmation.Visible = true;
            }
            catch (Exception)
            {
                litCheckoutError.Text = "We could not place your order. Please try again.";
                pnlCheckoutError.Visible = true;
            }
        }

        /// <summary>
        /// Chooses the order type the way the reference front end does: a basket made
        /// only of shop goods is a Shop order, otherwise it is a Tickets order.
        /// </summary>
        private static string ResolveOrderType(System.Collections.Generic.List<CartService.CartItem> items)
        {
            foreach (var item in items)
                if (!item.ItemType.Equals("Product", StringComparison.OrdinalIgnoreCase))
                    return "Tickets";
            return "Shop";
        }
    }
}
