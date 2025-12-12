<%@ Page Title="Home - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CartProWebApp.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CartPro - Fashion & Style Collection
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Hero Section -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Fashion &amp; Style <span class="d-block"></span>Collection</h1>
                        <p class="mb-4">Discover our curated selection of premium shoes, perfumes, belts, and watches to elevate your style and complement your modern lifestyle.</p>
                        <p><a href="Shop.aspx" class="btn btn-secondary me-2">Shop Now</a><a href="#" class="btn btn-white-outline">Explore</a></p>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="hero-img-wrap">
                        <img src="images/couch.png" class="img-fluid" style="width: 90%; margin-left: 15%;" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Hero Section -->

    <!-- Start Product Section -->
    <div class="product-section">
        <div class="container">
            <div class="row">
                <!-- Start Column 1 -->
                <div class="col-md-12 col-lg-3 mb-5 mb-lg-0">
                    <h2 class="mb-4 section-title">Explore Our Collections</h2>
                    <p class="mb-4">From timeless watches to elegant shoes, our collections are crafted to perfection. Discover accessories that define your style.</p>
                    <p><a href="Shop.aspx" class="btn">Explore</a></p>
                </div>
                <!-- End Column 1 -->

                <!-- Start Column 2 -->
                <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                    <a class="product-item" href="Cart.aspx">
                        <img src="/admin/images/products/prod_639000441083957172_9faa.jpg" class="img-fluid product-thumbnail" />
                        <h3 class="product-title">Classic Shoes</h3>

                        <span class="icon-cross">
                            <img src="images/cross.svg" class="img-fluid" />
                        </span>
                    </a>
                </div>
                <!-- End Column 2 -->

                <!-- Start Column 3 -->
                <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                    <a class="product-item" href="Cart.aspx">
                        <img src="admin\images\products\638997525110768975_perfumehb.jpg" class="img-fluid product-thumbnail" />
                        <h3 class="product-title">Luxury Perfume</h3>

                        <span class="icon-cross">
                            <img src="images/cross.svg" class="img-fluid" />
                        </span>
                    </a>
                </div>
                <!-- End Column 3 -->

                <!-- Start Column 4 -->
                <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                    <a class="product-item" href="Cart.aspx">
                        <img src="admin\images\products\638997530806746057_bagadidas.jpg" class="img-fluid product-thumbnail" />
                        <h3 class="product-title">Elegant Bag</h3>

                        <span class="icon-cross">
                            <img src="images/cross.svg" class="img-fluid" />
                        </span>
                    </a>
                </div>
                <!-- End Column 4 -->
            </div>
        </div>
    </div>
    <!-- End Product Section -->

    <!-- Start Why Choose Us Section -->
    <div class="why-choose-section">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-6">
                    <h2 class="section-title">Why Choose Us</h2>
                    <p>We provide high-quality, stylish fashion accessories to enhance your personal style. Our commitment to excellence ensures you receive the best products and services.</p>

                    <div class="row my-5">
                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/truck.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>Fast &amp; Free Shipping</h3>
                                <p>Enjoy fast and free shipping on all orders. We ensure your new accessories arrive at your doorstep promptly and without any extra cost.</p>
                            </div>
                        </div>

                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/bag.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>Easy to Shop</h3>
                                <p>Our user-friendly website makes it easy to browse, select, and purchase your favorite accessories from the comfort of your home.</p>
                            </div>
                        </div>

                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/support.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>24/7 Support</h3>
                                <p>Our dedicated support team is available 24/7 to assist you with any questions or concerns you may have.</p>
                            </div>
                        </div>

                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/return.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>Hassle Free Returns</h3>
                                <p>We offer hassle-free returns within 30 days of purchase, so you can shop with confidence.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="img-wrap">
                        <img src="images/why-choose-us-img.png" alt="Image" class="img-fluid" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Why Choose Us Section -->

    <!-- Start We Help Section -->
    <div class="we-help-section">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5 ps-lg-5">
                    <h2 class="section-title mb-4">Elevate Your Style</h2>
                    <p>Our fashion accessories are designed to elevate your style, offering a perfect blend of elegance and functionality. Whether you're dressing up for a special occasion or adding a touch of class to your everyday look, our collection has something for everyone.</p>
                    <ul class="list-unstyled custom-list my-4">
                        <li>Discover our range of stylish shoes for every occasion.</li>
                        <li>Find your signature scent from our collection of luxury perfumes.</li>
                        <li>Complete your look with our premium leather belts.</li>
                        <li>Make a statement with our collection of elegant watches.</li>
                    </ul>
                    <p><a href="#" class="btn">Explore</a></p>
                </div>
                <div class="col-lg-7 mb-5 mb-lg-0">
                    <div class="imgs-grid">
                        <div class="grid grid-1">
                            <img src="images/img-grid-1.jpg" alt="Untree.co" />
                        </div>
                        <div class="grid grid-2">
                            <img src="images/img-grid-2.jpg" alt="Untree.co" />
                        </div>
                        <div class="grid grid-3">
                            <img src="images/img-grid-3.jpg" alt="Untree.co" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End We Help Section -->

    <!-- Start Popular Product -->

    <!-- End Popular Product -->

    <!-- Start Testimonial Slider -->
    <div class="testimonial-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 mx-auto text-center">
                    <h2 class="section-title">Testimonials</h2>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="testimonial-slider-wrap text-center">
                        <div id="testimonial-nav">
                            <span class="prev" data-controls="prev"><span class="fa fa-chevron-left"></span></span>
                            <span class="next" data-controls="next"><span class="fa fa-chevron-right"></span></span>
                        </div>

                        <div class="testimonial-slider">
                            <div class="item">
                                <div class="row justify-content-center">
                                    <div class="col-lg-8 mx-auto">
                                        <div class="testimonial-block text-center">
                                            <blockquote class="mb-5">
                                                <p>&ldquo;The shoes I bought are not only stylish but also incredibly comfortable. The customer service was exceptional, and the delivery was fast and free. I highly recommend this store to anyone looking for quality footwear.&rdquo;</p>
                                            </blockquote>
                                            <div class="author-info">
                                                <div class="author-pic">
                                                    <img src="images/person-1.png" alt="Maria Jones" class="img-fluid" />
                                                </div>
                                                <h3 class="font-weight-bold">Maria Jones</h3>
                                                <span class="position d-block mb-3">Satisfied Customer</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item">
                                <div class="row justify-content-center">
                                    <div class="col-lg-8 mx-auto">
                                        <div class="testimonial-block text-center">
                                            <blockquote class="mb-5">
                                                <p>&ldquo;The perfume I ordered exceeded my expectations. The scent is captivating and long-lasting. The customer support was very helpful, and my order arrived earlier than expected. I'm thrilled with my purchase.&rdquo;</p>
                                            </blockquote>
                                            <div class="author-info">
                                                <div class="author-pic">
                                                    <img src="images/person-1.png" alt="John Smith" class="img-fluid" />
                                                </div>
                                                <h3 class="font-weight-bold">John Smith</h3>
                                                <span class="position d-block mb-3">Satisfied Customer</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item">
                                <div class="row justify-content-center">
                                    <div class="col-lg-8 mx-auto">
                                        <div class="testimonial-block text-center">
                                            <blockquote class="mb-5">
                                                <p>&ldquo;The watch I bought is absolutely stunning. The quality is top-notch, and I always get compliments on it. The shopping experience was smooth, and the delivery was quick. I'll definitely be back for more.&rdquo;</p>
                                            </blockquote>
                                            <div class="author-info">
                                                <div class="author-pic">
                                                    <img src="images/person-1.png" alt="James Anderson" class="img-fluid" />
                                                </div>
                                                <h3 class="font-weight-bold">James Anderson</h3>
                                                <span class="position d-block mb-3">Satisfied Customer</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Testimonial Slider -->
</asp:Content>
