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
    <!-- Start Why Choose Us Section -->
    <div class="why-choose-section">
        <div class="container">
            <div class="row justify-content-between align-items-center">
                <div class="col-lg-6">
                    <h2 class="section-title">Why Choose Us</h2>
                    <p>At CartPro, we believe that the right accessories can transform an outfit and express your unique personality. Our mission is to provide you with timeless pieces that combine quality craftsmanship with modern design.</p>

                    <div class="row my-5">
                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/truck.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>Fast &amp; Free Shipping</h3>
                                <p>We offer fast and free shipping on all orders, ensuring your new accessories arrive quickly and securely.</p>
                            </div>
                        </div>

                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/bag.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>Easy to Shop</h3>
                                <p>Our user-friendly website makes it easy to find and purchase the perfect accessories to match your style.</p>
                            </div>
                        </div>

                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/support.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>24/7 Support</h3>
                                <p>Our dedicated support team is available around the clock to assist you with any questions or concerns.</p>
                            </div>
                        </div>

                        <div class="col-6 col-md-6">
                            <div class="feature">
                                <div class="icon">
                                    <img src="images/return.svg" alt="Image" class="imf-fluid" />
                                </div>
                                <h3>Hassle Free Returns</h3>
                                <p>Shop with confidence knowing that we offer hassle-free returns on all of our products.</p>
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

    <!-- Start Team Section -->
    <div class="untree_co-section py-4">
        <div class="container">
            <div class="row mb-4">
                <div class="col-12 text-center">
                    <h2 class="section-title mb-3">Our Team</h2>
                </div>
            </div>

            <div class="row justify-content-center text-center">
                <div class="col-12 col-md-4 mb-4 mb-md-0">
                    <div class="team-img-wrapper">
                        <img src="images/person_1.jpg" class="img-fluid rounded-circle mb-3" alt="Lawson Arnold" style="width: 150px; height: 150px; object-fit: cover;" />
                    </div>
                    <h4 class="mb-1"><a href="#">Lawson Arnold</a></h4>
                    <span class="text-muted d-block mb-2"></span>
                    <p class="small mb-0">Visionary founder making luxury accessible.</p>
                </div>

                <div class="col-12 col-md-4 mb-4 mb-md-0">
                    <div class="team-img-wrapper">
                        <img src="images/person_2.jpg" class="img-fluid rounded-circle mb-3" alt="Jeremy Walker" style="width: 150px; height: 150px; object-fit: cover;" />
                    </div>
                    <h4 class="mb-1"><a href="#">Jeremy Walker</a></h4>
                    <span class="text-muted d-block mb-2"></span>
                    <p class="small mb-0">Marketing maven crafting exceptional shopping journeys.</p>
                </div>

                <div class="col-12 col-md-4">
                    <div class="team-img-wrapper">
                        <img src="images/person_3.jpg" class="img-fluid rounded-circle mb-3" alt="Patrik White" style="width: 150px; height: 150px; object-fit: cover;" />
                    </div>
                    <h4 class="mb-1"><a href="#">Patrik White</a></h4>
                    <span class="text-muted d-block mb-2"></span>
                    <p class="small mb-0">Creative genius behind every product's soul.</p>
                </div>
            </div>
        </div>
    </div>
    <!-- End Team Section -->

    <!-- Start Testimonial Slider -->
    <div class="testimonial-section before-footer-section">
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
                                                <p>&ldquo;The watch I purchased from CartPro is a true masterpiece. The quality and design are exceptional, and I receive compliments every time I wear it. The customer service was also outstanding.&rdquo;</p>
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
                                                <p>&ldquo;The shoes I bought are not only stylish but also incredibly comfortable. The customer service was exceptional, and the delivery was fast and free. I highly recommend this store to anyone looking for quality footwear.&rdquo;</p>
                                            </blockquote>
                                            <div class="author-info">
                                                <div class="author-pic">
                                                    <img src="images/person-2.png" alt="John Smith" class="img-fluid" />
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
                                                <p>&ldquo;The perfume I ordered exceeded my expectations. The scent is captivating and long-lasting. The customer support was very helpful, and my order arrived earlier than expected. I'm thrilled with my purchase.&rdquo;</p>
                                            </blockquote>
                                            <div class="author-info">
                                                <div class="author-pic">
                                                    <img src="images/person-3.png" alt="Emily Chen" class="img-fluid" />
                                                </div>
                                                <h3 class="font-weight-bold">Emily Chen</h3>
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
