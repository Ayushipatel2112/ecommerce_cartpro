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

            <%-- UpdatePanel allows quantity changes/removals without full page refresh --%>
            <asp:UpdatePanel ID="upCart" runat="server">
                <ContentTemplate>

                    <!-- Cart Table Section -->
                    <div class="row mb-5" id="divCartItems" runat="server">
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
                                        <%-- Repeater to display dynamic cart items --%>
                                        <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="product-thumbnail">
                                                        <img src='<%# GetImageUrl(Eval("image")) %>' alt="Image" class="img-fluid"
                                                            style="max-width: 100px; height: auto;"
                                                            onerror="this.src='admin/images/no-image.png'" />
                                                    </td>
                                                    <td class="product-name">
                                                        <h2 class="h5 text-black"><%# Eval("productname") %></h2>
                                                    </td>
                                                    <td><%# Eval("productprice", "{0:C}") %></td>
                                                    <td>
                                                        <div class="input-group mb-3 d-flex align-items-center quantity-container" style="max-width: 120px; margin: 0 auto;">
                                                            <div class="input-group-prepend">
                                                                <%-- Decrease Quantity Button --%>
                                                                <asp:LinkButton ID="btnMinus" runat="server" CssClass="btn btn-outline-black decrease"
                                                                    CommandName="Decrease" CommandArgument='<%# Eval("id") %>'>&minus;</asp:LinkButton>
                                                            </div>

                                                            <%-- Display Quantity --%>
                                                            <asp:TextBox ID="txtQty" runat="server" CssClass="form-control text-center quantity-amount"
                                                                Text='<%# Eval("quantity") %>' ReadOnly="true"></asp:TextBox>

                                                            <div class="input-group-append">
                                                                <%-- Increase Quantity Button --%>
                                                                <asp:LinkButton ID="btnPlus" runat="server" CssClass="btn btn-outline-black increase"
                                                                    CommandName="Increase" CommandArgument='<%# Eval("id") %>'>&plus;</asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <%-- Calculated Row Total --%>
                                                    <td>
                                                        <asp:Label ID="lblRowTotal" runat="server" Text='<%# Eval("total_price", "{0:C}") %>'></asp:Label></td>
                                                    <td>
                                                        <%-- Remove Button --%>
                                                        <asp:LinkButton ID="btnRemove" runat="server" CssClass="btn btn-black btn-sm"
                                                            CommandName="Remove" CommandArgument='<%# Eval("id") %>'>X</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Empty Cart Message (Dynamically shown/hidden) -->
                    <div class="row mb-5" id="divEmptyCart" runat="server" visible="false">
                        <div class="col-md-12 text-center">
                            <h3>Your Cart is Empty</h3>
                            <p class="mb-5">Looks like you haven't added anything yet.</p>
                            <a href="Shop.aspx" class="btn btn-black btn-lg">Start Shopping</a>
                        </div>
                    </div>

                    <!-- Cart Totals Section (Dynamically shown/hidden) -->
                    <div class="row" id="divCartTotals" runat="server">
                        <div class="col-md-6">
                            <div class="row mb-5">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <%-- Update Cart Button (Triggers PostBack/UpdatePanel) --%>
                                    <asp:Button ID="btnUpdateCart" runat="server" Text="Update Cart" CssClass="btn btn-black btn-sm btn-block" OnClick="btnUpdateCart_Click" />
                                </div>
                                <div class="col-md-6">
                                    <button type="button" class="btn btn-outline-black btn-sm btn-block" onclick="window.location='Shop.aspx'">Continue Shopping</button>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="text-black h4" for="coupon">Coupon</label>
                                    <p>Enter your coupon code if you have one.</p>
                                </div>
                                <div class="col-md-8 mb-3 mb-md-0">
                                    <input type="text" class="form-control py-3" id="coupon" placeholder="Coupon Code" />
                                </div>
                                <div class="col-md-4">
                                    <button class="btn btn-black">Apply Coupon</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 pl-5">
                            <div class="row justify-content-end">
                                <div class="col-md-7">
                                    <div class="row">
                                        <div class="col-md-12 text-right border-bottom mb-5">
                                            <h3 class="text-black h4 text-uppercase">Cart Totals</h3>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <span class="text-black">Subtotal</span>
                                        </div>
                                        <div class="col-md-6 text-right">
                                            <strong class="text-black">
                                                <asp:Label ID="lblSubtotal" runat="server" Text="$0.00"></asp:Label>
                                            </strong>
                                        </div>
                                    </div>
                                    <div class="row mb-5">
                                        <div class="col-md-6">
                                            <span class="text-black">Total</span>
                                        </div>
                                        <div class="col-md-6 text-right">
                                            <strong class="text-black">
                                                <asp:Label ID="lblTotal" runat="server" Text="$0.00"></asp:Label>
                                            </strong>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <button class="btn btn-black btn-lg py-3 btn-block" type="button" onclick="window.location='Checkout.aspx'">Proceed To Checkout</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </div>
</asp:Content>
