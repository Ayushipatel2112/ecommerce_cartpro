<%@ Page Title="Shop - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="CartProWebApp.Shop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Shop - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Shop</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="untree_co-section product-section before-footer-section">
        <div class="container">

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <div class="row">


                        <%-- 2. Changed col-md-9 to col-12 so products take full width --%>
                        <div class="col-12">
                            <div class="row">
                                <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                                    <ItemTemplate>
                                        <%-- Adjusted column sizes for better full-width layout --%>
                                        <div class="col-12 col-md-4 col-lg-3 mb-5">
                                            <div class="product-item">

                                                <asp:LinkButton ID="btnViewPopup" runat="server"
                                                    CommandName="ViewDetails"
                                                    CommandArgument='<%# Eval("id") %>'
                                                    CausesValidation="false"
                                                    Style="text-decoration: none; color: inherit;">
                                
                                <img src='<%# GetImageUrl(Eval("image")) %>' class="img-fluid product-thumbnail" 
                                     style="height: 250px; object-fit: contain; width: 100%; background-color: #fff; padding: 10px; border-radius: 8px;"
                                     onerror="this.src='admin/images/no-image.png'" />
                                
                                <h3 class="product-title"><%# Eval("productname") %></h3>
                                <strong class="product-price"><%# Eval("productprice", "{0:C}") %></strong>

                                <div class="product-rating">
                                    <%# GetStarRating(Eval("id"), Eval("avg_rating"), Eval("total_ratings")) %>
                                </div>
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="icon-cross"
                                                    CommandName="AddToCart"
                                                    CommandArgument='<%# Eval("id") %>'
                                                    CausesValidation="false">
                                <img src="images/cross.svg" class="img-fluid" />
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <asp:Label ID="lblNoProducts" runat="server" Visible="false" CssClass="col-12 text-center">
                <h3>No products found.</h3>
                                </asp:Label>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true" style="z-index: 1055;">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header border-0">
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <asp:Image ID="imgPopup" runat="server" CssClass="img-fluid rounded" Style="max-height: 400px; width: 100%; object-fit: contain;" />
                                        </div>
                                        <div class="col-md-6">
                                            <h2 class="text-black">
                                                <asp:Label ID="lblPopupName" runat="server"></asp:Label></h2>
                                            <p class="text-muted">
                                                <asp:Label ID="lblPopupCategory" runat="server"></asp:Label>
                                            </p>
                                            <h3 class="text-primary font-weight-bold mb-3">
                                                <asp:Label ID="lblPopupPrice" runat="server"></asp:Label></h3>
                                            <p>
                                                <asp:Label ID="lblPopupDesc" runat="server"></asp:Label>
                                            </p>

                                            <div class="mb-4">
                                                <label>Status:</label>
                                                <asp:Label ID="lblPopupStatus" runat="server" Font-Bold="true"></asp:Label>
                                            </div>

                                            <div class="input-group mb-3" style="max-width: 150px;">
                                                <span class="input-group-text">Qty</span>
                                                <asp:TextBox ID="txtPopupQty" runat="server" CssClass="form-control text-center" Text="1" TextMode="Number"></asp:TextBox>
                                            </div>

                                            <div class="d-flex gap-2">
                                                <asp:Button ID="btnPopupAddToCart" runat="server" Text="Add to Cart"
                                                    CssClass="btn btn-black flex-grow-1" OnClick="btnPopupAddToCart_Click" CausesValidation="false" />

                                                <asp:LinkButton ID="btnPopupWishlist" runat="server" CssClass="btn btn-outline-danger"
                                                    OnClick="btnPopupWishlist_Click" ToolTip="Add to Wishlist" CausesValidation="false">
                                                    <i class="far fa-heart"></i>
                                                </asp:LinkButton>
                                            </div>

                                            <asp:HiddenField ID="hfPopupProductId" runat="server" />
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

    <script type="text/javascript">
        // Function to Open Modal
        function openProductModal() {
            var modalElement = document.getElementById('productModal');
            if (modalElement) {
                // Try Bootstrap 5 Method
                if (typeof bootstrap !== 'undefined') {
                    var modal = bootstrap.Modal.getOrCreateInstance(modalElement);
                    modal.show();
                }
                // Fallback for Bootstrap 4 / jQuery
                else if (typeof $ !== 'undefined') {
                    $('#productModal').modal('show');
                }
                else {
                    alert("Bootstrap library not loaded properly!");
                }
            }
        }

        // Function to Close Modal
        function closeProductModal() {
            var modalElement = document.getElementById('productModal');
            if (modalElement) {
                if (typeof bootstrap !== 'undefined') {
                    var modal = bootstrap.Modal.getInstance(modalElement);
                    if (modal) modal.hide();
                } else if (typeof $ !== 'undefined') {
                    $('#productModal').modal('hide');
                }
            }
        }
    </script>

</asp:Content>
