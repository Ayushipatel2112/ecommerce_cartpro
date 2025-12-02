<%@ Page Title="Services - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="CartProWebApp.Services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Services - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Hero Section -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Services</h1>
                        <p class="mb-4">Experience luxury redefined with our curated selection of premium accessories. From Swiss-made timepieces that capture timeless elegance to handcrafted leather goods and exclusive fragrances, we bring you the finest in fashion. Our expert stylists ensure every piece complements your unique personality and lifestyle.</p>
                        <p><a href="Shop.aspx" class="btn btn-secondary me-2">Explore Collection</a><a href="#featured" class="btn btn-white-outline ms-2">Discover Services</a></p>
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

    <!-- Start Why Choose Us Section -->
    <div class="why-choose-section">
        <div class="container">
            <div class="row my-5">
                <div class="col-6 col-md-6 col-lg-3 mb-4">
                    <div class="feature">
                        <div class="icon">
                            <img src="images/truck.svg" alt="Image" class="imf-fluid" />
                        </div>
                        <h3>Fast & Free Shipping</h3>
                        <p>Free express shipping with 2-3 day delivery. Track your order in real-time.</p>
                    </div>
                </div>

                <div class="col-6 col-md-6 col-lg-3 mb-4">
                    <div class="feature">
                        <div class="icon">
                            <img src="images/bag.svg" alt="Image" class="imf-fluid" />
                        </div>
                        <h3>Easy to Shop</h3>
                        <p>Effortless shopping with smart filters for style, price, and occasion.</p>
                    </div>
                </div>

                <div class="col-6 col-md-6 col-lg-3 mb-4">
                    <div class="feature">
                        <div class="icon">
                            <img src="images/support.svg" alt="Image" class="imf-fluid" />
                        </div>
                        <h3>24/7 Support</h3>
                        <p>24/7 support for all your styling and sizing questions.</p>
                    </div>
                </div>

                <div class="col-6 col-md-6 col-lg-3 mb-4">
                    <div class="feature">
                        <div class="icon">
                            <img src="images/return.svg" alt="Image" class="imf-fluid" />
                        </div>
                        <h3>Hassle Free Returns</h3>
                        <p>30-day hassle-free returns. No questions asked.</p>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <!-- End Why Choose Us Section -->

    <!-- Start Product Section -->

    <!-- End Product Section -->
</asp:Content>
