<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="product_details.aspx.cs" Inherits="CartProWebApp.product_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Product Details - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Product Details</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="untree_co-section">
        <div class="container">
            <div class="row">
                <div class="col-md-6 mb-5 mb-md-0">
                    <asp:Image ID="imgProduct" runat="server" CssClass="img-fluid rounded" Style="width: 100%; max-height: 500px; object-fit: contain;" />
                </div>

                <div class="col-md-6">
                    <h2 class="text-black">
                        <asp:Label ID="lblProductName" runat="server"></asp:Label></h2>
                    <p class="mb-3 text-muted">
                        Category:
                        <asp:Label ID="lblCategory" runat="server"></asp:Label>
                    </p>

                    <div class="mb-3">
                        <asp:Literal ID="litStars" runat="server"></asp:Literal>
                    </div>

                    <h3 class="text-primary font-weight-bold mb-4">
                        <asp:Label ID="lblPrice" runat="server"></asp:Label>
                    </h3>

                    <p>
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </p>

                    <p>
                        Status:
                        <asp:Label ID="lblStockStatus" runat="server" Font-Bold="true"></asp:Label>
                    </p>

                    <div class="mb-5">
                        <div class="input-group mb-3" style="max-width: 120px;">
                            <span class="input-group-text">Qty</span>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control text-center" Text="1" TextMode="Number"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-black btn-lg py-3 btn-block" OnClick="btnAddToCart_Click" />
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-12">
                    <h3 class="h4 text-black mb-4">Customer Reviews</h3>
                    <div class="bg-light p-4 rounded">

                        <asp:Repeater ID="rptReviews" runat="server">
                            <ItemTemplate>
                                <div class="review-item mb-4 border-bottom pb-3">
                                    <div class="d-flex justify-content-between">
                                        <strong>User</strong> <small class="text-muted"><%# Eval("created_at", "{0:MMM dd, yyyy}") %></small>
                                    </div>
                                    <div class="text-warning mb-2">
                                        <%# GetReviewStars(Eval("rating")) %>
                                    </div>
                                    <p class="mb-0"><%# Eval("review") %></p>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:Label ID="lblNoReviews" runat="server" Text="No reviews yet." Visible="false" CssClass="text-muted"></asp:Label>
                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
