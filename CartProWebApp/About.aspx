<%@ Page Title="About - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="CartProWebApp.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    About Us - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Hero Section -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>About Us</h1>
                        <p class="mb-4">Welcome to CartPro, your ultimate destination for premium fashion accessories. We specialize in watches, shoes, perfumes, and belts, offering a curated selection of high-quality products to elevate your style.</p>
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
