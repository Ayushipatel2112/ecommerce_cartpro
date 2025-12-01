<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="product_edit.aspx.cs" Inherits="CartProWebApp.admin.product_edit" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body class="light-mode">
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container">
            <div class="sidebar">
                <h3>Sidebar</h3>
            </div>

            <main class="main-content">
                <div id="page-content">
                    <section id="product-edit" class="page">

                        <div class="page-header">
                            <h1>Edit Product</h1>
                            <div class="header-actions">
                                <a href="product.aspx" class="btn-secondary"><i class="fas fa-arrow-left"></i>Back to Products</a>
                            </div>
                        </div>

                        <asp:Panel ID="pnlError" runat="server" Visible="false" class="table-container" Style="margin-bottom: 15px; background-color: #fee; border-left: 4px solid #f00; padding: 15px;">
                            <div style="color: #c00;">
                                <i class="fas fa-exclamation-circle"></i>
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" class="table-container" Style="margin-bottom: 15px; background-color: #efe; border-left: 4px solid #0c0; padding: 15px;">
                            <div style="color: #060;">
                                <i class="fas fa-check-circle"></i>
                                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>

                        <div class="table-container">

                            <div class="form-group">
                                <label for="txtName">Product Name *</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="ddlCategory">Category *</label>
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" DataTextField="category_name" DataValueField="id" required="true">
                                        <asp:ListItem Value="" Text="Select Category"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label for="txtPrice">Price *</label>
                                    <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" step="0.01" min="0.01" CssClass="form-control" required="true"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="ddlStockStatus">Stock Status *</label>
                                <asp:DropDownList ID="ddlStockStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="In Stock">In Stock</asp:ListItem>
                                    <asp:ListItem Value="Low Stock">Low Stock</asp:ListItem>
                                    <asp:ListItem Value="Out of Stock">Out of Stock</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label for="txtDescription">Product Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="fuImage">Product Image</label>

                                <div id="divCurrentImage" runat="server" visible="false" style="margin-bottom: 10px;">
                                    <asp:Image ID="imgCurrent" runat="server" Style="max-width: 200px; height: auto; border-radius: 6px; border: 1px solid #ddd;" />
                                    <p style="margin-top: 5px; color: #666; font-size: 14px;">Current Image</p>
                                    <asp:HiddenField ID="hfCurrentImagePath" runat="server" />
                                </div>

                                <asp:FileUpload ID="fuImage" runat="server" accept="image/*" />
                                <small style="display: block; margin-top: 5px; color: #666;">Leave empty to keep current image. Allowed formats: JPG, JPEG, PNG, GIF, WEBP</small>
                            </div>

                            <div class="modal-actions">
                                <a href="product.aspx" class="btn-secondary">Cancel</a>
                                <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn-primary" OnClick="btnUpdate_Click">
                                    <i class="fas fa-save"></i> Update Product
                                </asp:LinkButton>
                            </div>

                        </div>
                    </section>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
