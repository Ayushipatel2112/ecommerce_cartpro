<%@ Page Title="Contact - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="CartProWebApp.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Contact Us - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Hero Section -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Contact</h1>
                        <p class="mb-4">We'd love to hear from you! Whether you have questions about our premium collections, need styling advice, or want to explore partnership opportunities, our team is here to help. Reach out and let's start a conversation.</p>
                        <p><a href="Shop.aspx" class="btn btn-secondary me-2">Shop Now</a><a href="#" class="btn btn-white-outline">Explore</a></p>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="hero-img-wrap">
                        <img src="images/couch.png" class="img-fluid" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Hero Section -->

    <!-- Start Contact Form -->
    <div class="untree_co-section">
        <div class="container">
            <div class="block">
                <div class="row justify-content-center">
                    <div class="col-md-6 col-lg-8 pb-4">

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label class="text-black" for="txtFirstName">First name</label>
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label class="text-black" for="txtLastName">Last name</label>
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="text-black" for="txtEmail">Email address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="form-group mb-5">
                            <label class="text-black" for="txtMessage">Message</label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnSendMessage" runat="server" CssClass="btn btn-primary-hover-outline" Text="Send Message" OnClick="btnSendMessage_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Contact Form -->
</asp:Content>
