<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="product_add.aspx.cs" Inherits="CartProWebApp.admin.product_add" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="light-mode">
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container">

            <% Server.Execute("include/sidebar.aspx"); %>

            <main class="main-content">

                <% Server.Execute("include/header.aspx"); %>

                <div id="page-content">
                    <section id="product-add" class="page">

                        <div class="page-header">
                            <h1>Add New Product</h1>
                            <div class="header-actions">
                                <a href="product.aspx" class="btn-secondary"><i class="fas fa-arrow-left"></i>Back to Products</a>
                            </div>
                        </div>

                        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="table-container" Style="margin-bottom: 15px; background-color: #fee; border-left: 4px solid #f00; padding: 15px;">
                            <div style="color: #c00;">
                                <i class="fas fa-exclamation-circle"></i>
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>

                        <div class="table-container">
                            <div class="form-group">
                                <label for="txtName">Product Name *</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>

                            <div class="form-row" style="display: flex; gap: 20px; flex-wrap: wrap;">
                                <div class="form-group" style="flex: 1;">
                                    <label for="ddlCategory">Category *</label>
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                        <asp:ListItem Text="Select Category" Value="0" />
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group" style="flex: 1;">
                                    <label for="txtPrice">Price *</label>
                                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" step="0.01" min="0.01" required="required"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="ddlStockStatus">Stock Status *</label>
                                <asp:DropDownList ID="ddlStockStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="In Stock" Value="In Stock" />
                                    <asp:ListItem Text="Low Stock" Value="Low Stock" />
                                    <asp:ListItem Text="Out of Stock" Value="Out of Stock" />
                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label for="txtDescription">Product Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Product Image</label>
                                <asp:FileUpload ID="fileImage" runat="server" accept="image/*" />
                                <small style="display: block; margin-top: 5px; color: #666;">Allowed formats: JPG, PNG, GIF, WEBP</small>
                            </div>

                            <div class="modal-actions">
                                <a href="product.aspx" class="btn-secondary">Cancel</a>
                                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn-primary" OnClick="btnSave_Click">
                                    <i class="fas fa-save"></i> Save Product
                                </asp:LinkButton>
                            </div>

                        </div>
                    </section>
                </div>
            </main>
        </div>
    </form>
    <script src="js/main.js"></script>
</body>
</html>
