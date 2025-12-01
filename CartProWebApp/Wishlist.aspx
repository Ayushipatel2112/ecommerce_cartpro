<%@ Page Title="My Wishlist" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="CartProWebApp.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    My Wishlist - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>My Wishlist</h1>
                        <p class="mb-4">Items you saved for later.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

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
                                    <th class="product-quantity">Stock Status</th>
                                    <th class="product-total">Action</th>
                                    <th class="product-remove">Remove</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptWishlist" runat="server" OnItemCommand="rptWishlist_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="product-thumbnail">
                                                <img src='<%# GetImageUrl(Eval("image")) %>' alt="Image" class="img-fluid"
                                                    style="max-width: 80px; height: 80px; object-fit: contain;">
                                            </td>
                                            <td class="product-name">
                                                <h2 class="h5 text-black"><%# Eval("productname") %></h2>
                                            </td>
                                            <td><%# Eval("productprice", "{0:C}") %></td>
                                            <td>
                                                <span class="badge bg-secondary"><%# Eval("stock_status") %></span>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnAddToCart" runat="server" CommandName="AddToCart"
                                                    CommandArgument='<%# Eval("id") %>' CssClass="btn btn-black btn-sm">
                                                    Add to Cart
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnRemove" runat="server" CommandName="Remove"
                                                    CommandArgument='<%# Eval("id") %>' CssClass="btn btn-outline-danger btn-sm">
                                                    X
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>

                    <asp:Label ID="lblEmpty" runat="server" Visible="false" CssClass="text-center d-block mt-5">
                        <h3>Your wishlist is empty.</h3>
                        <a href="Shop.aspx" class="btn btn-secondary mt-3">Continue Shopping</a>
                    </asp:Label>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
