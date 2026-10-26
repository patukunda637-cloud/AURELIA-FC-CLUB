<%@ Page Title="Contact Us - Aurelia FC" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="AureliaFc.Web.Contact" %>

<asp:Content ID="TitleContentBlock" ContentPlaceHolderID="TitleContent" runat="server">Contact Us - Aurelia FC</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ---------- Page hero ---------- -->
    <section class="page-hero page-hero--compact">
        <div class="container page-hero__inner">
            <p class="eyebrow page-hero__eyebrow">Support</p>
            <h1 class="page-hero__title">Contact Us</h1>
            <p class="page-hero__sub">Questions about tickets, membership or matchday? We're here to help.</p>
        </div>
    </section>

    <section class="section">
        <div class="container contact-grid">
            <!-- ---------- Form ---------- -->
            <div>
                <h2 class="contact-heading">Send a Message</h2>

                <asp:Panel ID="pnlResult" runat="server" Visible="false">
                    <div class="alert alert--success"><asp:Literal ID="litResult" runat="server" /></div>
                </asp:Panel>
                <asp:Panel ID="pnlFormError" runat="server" Visible="false">
                    <div class="alert alert--error"><asp:Literal ID="litFormError" runat="server" /></div>
                </asp:Panel>

                <div class="contact-form">
                    <div class="field">
                        <label class="field__label" for="<%= txtFullName.ClientID %>">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="input" />
                        <asp:Label ID="lblFullNameError" runat="server" CssClass="field__error" Visible="false" />
                    </div>

                    <div class="field">
                        <label class="field__label" for="<%= txtEmail.ClientID %>">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email" />
                        <asp:Label ID="lblEmailError" runat="server" CssClass="field__error" Visible="false" />
                    </div>

                    <div class="field">
                        <label class="field__label" for="<%= ddlSubject.ClientID %>">Subject</label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="select">
                            <asp:ListItem Value="" Text="Select a subject…" />
                        </asp:DropDownList>
                        <asp:Label ID="lblSubjectError" runat="server" CssClass="field__error" Visible="false" />
                    </div>

                    <div class="field">
                        <label class="field__label" for="<%= txtMessage.ClientID %>">Message</label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="textarea" TextMode="MultiLine" />
                        <asp:Label ID="lblMessageError" runat="server" CssClass="field__error" Visible="false" />
                    </div>

                    <asp:Button ID="btnSend" runat="server" Text="SEND MESSAGE" CssClass="btn btn--primary" OnClick="btnSend_Click" />
                </div>
            </div>

            <!-- ---------- Departments ---------- -->
            <aside>
                <h2 class="contact-heading">Contact Details</h2>
                <asp:Repeater ID="rptDepartments" runat="server">
                    <HeaderTemplate><div class="dept-list"></HeaderTemplate>
                    <ItemTemplate>
                        <article class="dept-card">
                            <h3><%# Enc(Eval("Name")) %></h3>
                            <a href="mailto:<%# Enc(Eval("Email")) %>" class="gold"><%# Enc(Eval("Email")) %></a>
                            <asp:PlaceHolder runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Phone") as string) %>'>
                                <p><%# Enc(Eval("Phone")) %></p>
                            </asp:PlaceHolder>
                        </article>
                    </ItemTemplate>
                    <FooterTemplate></div></FooterTemplate>
                </asp:Repeater>
            </aside>
        </div>
    </section>

    <!-- ---------- Stadium location ---------- -->
    <section class="section section--surface">
        <div class="container">
            <h2 class="contact-heading">Stadium Location</h2>
            <div class="location">
                <div class="location__copy">
                    <h3><asp:Literal ID="litStadiumName" runat="server" /></h3>
                    <p><asp:Literal ID="litAddress" runat="server" /></p>
                    <p class="gold"><asp:Literal ID="litPhone" runat="server" /></p>
                </div>
                <div class="location__map">
                    <img src="<%= ResolveUrl("~/assets/images/stadium-map.jpg") %>" alt="Map showing the location of Aurelia Arena" loading="lazy" />
                </div>
            </div>
        </div>
    </section>

    <!-- ---------- FAQ ---------- -->
    <section class="section">
        <div class="container contact-faq">
            <h2 class="contact-heading">Frequently Asked Questions</h2>
            <asp:Repeater ID="rptFaqs" runat="server">
                <HeaderTemplate><div class="accordion"></HeaderTemplate>
                <ItemTemplate>
                    <div class='<%# IsFaqOpen(Container.ItemIndex) ? "accordion__item accordion__item--open" : "accordion__item" %>'>
                        <h3>
                            <asp:LinkButton ID="lnkFaq" runat="server" CssClass="accordion__trigger" CommandName="Toggle" CommandArgument="<%# Container.ItemIndex %>" OnCommand="Faq_Toggle">
                                <span><%# Enc(Eval("Question")) %></span>
                                <span aria-hidden="true" class="accordion__icon"><%# GetFaqIcon(Container.ItemIndex) %></span>
                            </asp:LinkButton>
                        </h3>
                        <asp:Panel ID="pnlFaqPanel" runat="server" CssClass="accordion__panel" Visible='<%# IsFaqOpen(Container.ItemIndex) %>'>
                            <p><%# Enc(Eval("Answer")) %></p>
                        </asp:Panel>
                    </div>
                </ItemTemplate>
                <FooterTemplate></div></FooterTemplate>
            </asp:Repeater>
        </div>
    </section>
</asp:Content>