<%@ Page Title="Checkout - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="CartProWebApp.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Checkout - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Hero Section -->
    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Checkout</h1>
                    </div>
                </div>
                <div class="col-lg-7">
                </div>
            </div>
        </div>
    </div>
    <!-- End Hero Section -->

    <div class="untree_co-section">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12">
                    <div class="border p-4 rounded" role="alert">
                        Returning customer? <a href="Login.aspx">Click here</a> to login
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-5 mb-md-0">
                    <h2 class="h3 mb-3 text-black">Billing Details</h2>
                    <div class="p-3 p-lg-5 border bg-white">
                        <div class="form-group">
                            <label for="c_country" class="text-black">Country <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">Select a country</asp:ListItem>
                                <asp:ListItem Value="1">Bangladesh</asp:ListItem>
                                <asp:ListItem Value="2">Algeria</asp:ListItem>
                                <asp:ListItem Value="3">Afghanistan</asp:ListItem>
                                <asp:ListItem Value="4">Ghana</asp:ListItem>
                                <asp:ListItem Value="5">Albania</asp:ListItem>
                                <asp:ListItem Value="6">Bahrain</asp:ListItem>
                                <asp:ListItem Value="7">Colombia</asp:ListItem>
                                <asp:ListItem Value="8">Dominican Republic</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6">
                                <label for="txtFirstName" class="text-black">First Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtLastName" class="text-black">Last Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-md-12">
                                <label for="txtCompanyName" class="text-black">Company Name </label>
                                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-md-12">
                                <label for="txtAddress" class="text-black">Address <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Street address"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group mt-3">
                            <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control" placeholder="Apartment, suite, unit etc. (optional)"></asp:TextBox>
                        </div>

                        <div class="form-group row">
                            <div class="col-md-6">
                                <label for="txtState" class="text-black">State / Country <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtZip" class="text-black">Postal / Zip <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtZip" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group row mb-5">
                            <div class="col-md-6">
                                <label for="txtEmail" class="text-black">Email Address <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtPhone" class="text-black">Phone <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone Number"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="txtOrderNotes" class="text-black">Order Notes</label>
                            <asp:TextBox ID="txtOrderNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Write your notes here..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row mb-5">
                        <div class="col-md-12">
                            <h2 class="h3 mb-3 text-black">Coupon Code</h2>
                            <div class="p-3 p-lg-5 border bg-white">
                                <label for="txtCoupon" class="text-black mb-3">Enter your coupon code if you have one</label>
                                <div class="input-group w-75 couponcode-wrap">
                                    <asp:TextBox ID="txtCoupon" runat="server" CssClass="form-control me-2" placeholder="Coupon Code"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button ID="btnApplyCoupon" runat="server" CssClass="btn btn-black btn-sm" Text="Apply" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-5">
                        <div class="col-md-12">
                            <h2 class="h3 mb-3 text-black">Your Order</h2>
                            <div class="p-3 p-lg-5 border bg-white">
                                <table class="table site-block-order-table mb-5">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Top Up T-Shirt <strong class="mx-2">x</strong> 1</td>
                                            <td>$250.00</td>
                                        </tr>
                                        <tr>
                                            <td>Polo Shirt <strong class="mx-2">x</strong> 1</td>
                                            <td>$100.00</td>
                                        </tr>
                                        <tr>
                                            <td class="text-black font-weight-bold"><strong>Cart Subtotal</strong></td>
                                            <td class="text-black">$350.00</td>
                                        </tr>
                                        <tr>
                                            <td class="text-black font-weight-bold"><strong>Order Total</strong></td>
                                            <td class="text-black font-weight-bold"><strong>$350.00</strong></td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="border p-3 mb-3">
                                    <h3 class="h6 mb-0"><a class="d-block" data-bs-toggle="collapse" href="#collapsebank" role="button" aria-expanded="false">Direct Bank Transfer</a></h3>
                                    <div class="collapse" id="collapsebank">
                                        <div class="py-2">
                                            <p class="mb-0">Make your payment directly into our bank account. Please use your Order ID as the payment reference.</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="border p-3 mb-3">
                                    <h3 class="h6 mb-0"><a class="d-block" data-bs-toggle="collapse" href="#collapsecheque" role="button" aria-expanded="false">Cheque Payment</a></h3>
                                    <div class="collapse" id="collapsecheque">
                                        <div class="py-2">
                                            <p class="mb-0">Make your payment directly into our bank account. Please use your Order ID as the payment reference.</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="border p-3 mb-5">
                                    <h3 class="h6 mb-0"><a class="d-block" data-bs-toggle="collapse" href="#collapsepaypal" role="button" aria-expanded="false">Paypal</a></h3>
                                    <div class="collapse" id="collapsepaypal">
                                        <div class="py-2">
                                            <p class="mb-0">Make your payment directly into our bank account. Please use your Order ID as the payment reference.</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Button ID="btnPlaceOrder" runat="server" CssClass="btn btn-black btn-lg py-3 btn-block" Text="Place Order" OnClick="btnPlaceOrder_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
