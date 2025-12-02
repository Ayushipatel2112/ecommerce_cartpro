<%@ Page Title="Cart - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="CartProWebApp.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Cart - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Hero Section -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Cart</h1>
                    </div>
                </div>
                <div class="col-lg-7">
                </div>
            </div>
        </div>
    </div>
    <!-- End Hero Section -->

    <div class="untree_co-section before-footer-section">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12">
                    <div class="site-blocks-table">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th class="product-thumbnail">Image</th>
                                    <th class="product-name">Product</th>
                                    <th class="product-price">Price</th>
                                    <th class="product-quantity">Quantity</th>
                                    <th class="product-total">Total</th>
                                    <th class="product-remove">Remove</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="product-thumbnail">
                                        <img src="images/product-1.png" alt="Image" class="img-fluid" />
                                    </td>
                                    <td class="product-name">
                                        <h2 class="h5 text-black">Product 1</h2>
                                    </td>
                                    <td>$49.00</td>
                                    <td>
                                        <div class="input-group mb-3 d-flex align-items-center quantity-container" style="max-width: 120px;">
                                            <div class="input-group-prepend">
                                                <button class="btn btn-outline-black decrease" type="button">&minus;</button>
                                            </div>
                                            <input type="text" class="form-control text-center quantity-amount" value="1" />
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-black increase" type="button">&plus;</button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>$49.00</td>
                                    <td><a href="#" class="btn btn-black btn-sm">X</a></td>
                                </tr>

                                <tr>
                                    <td class="product-thumbnail">
                                        <img src="images/product-2.png" alt="Image" class="img-fluid" />
                                    </td>
                                    <td class="product-name">
                                        <h2 class="h5 text-black">Product 2</h2>
                                    </td>
                                    <td>$49.00</td>
                                    <td>
                                        <div class="input-group mb-3 d-flex align-items-center quantity-container" style="max-width: 120px;">
                                            <div class="input-group-prepend">
                                                <button class="btn btn-outline-black decrease" type="button">&minus;</button>
                                            </div>
                                            <input type="text" class="form-control text-center quantity-amount" value="1" />
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-black increase" type="button">&plus;</button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>$49.00</td>
                                    <td><a href="#" class="btn btn-black btn-sm">X</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
