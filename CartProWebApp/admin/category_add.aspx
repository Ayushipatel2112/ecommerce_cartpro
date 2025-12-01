<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="category_add.aspx.cs" Inherits="CartProWebApp.admin.category_add" %>

<!DOCTYPE html>
<html lang="en">

<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="light-mode">
    <form id="form1" runat="server">
        <div class="container">

            <!-- Sidebar -->
            <% Server.Execute("include/sidebar.aspx"); %>

            <main class="main-content">

                <!-- Header -->
                <% Server.Execute("include/header.aspx"); %>

                <div id="page-content">
                    <section id="category-add" class="page">

                        <div class="page-header">
                            <h1>Add New Category</h1>
                            <div class="header-actions">
                                <a href="category.aspx" class="btn-secondary"><i class="fas fa-arrow-left"></i>Back to Categories</a>
                            </div>
                        </div>

                        <!-- Error Message Label -->
                        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="table-container" Style="margin-bottom: 15px; background-color: #fee; border-left: 4px solid #f00; padding: 15px;">
                            <div style="color: #c00;">
                                <i class="fas fa-exclamation-circle"></i>
                                <asp:Literal ID="litError" runat="server"></asp:Literal>
                            </div>
                        </asp:Panel>

                        <div class="table-container">
                            <!-- Form Content -->
                            <div style="max-width: 600px;">

                                <div class="form-group">
                                    <label for="txtName">Category Name *</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <label for="txtDescription">Description</label>
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <label for="fuImage">Category Image</label>
                                    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" Style="padding: 10px;" />
                                    <small style="color: #666; display: block; margin-top: 5px;">Supported formats: JPG, PNG, GIF</small>
                                </div>

                                <div class="modal-actions" style="margin-top: 20px;">
                                    <a href="category.aspx" class="btn-secondary" style="text-decoration: none; display: inline-block; padding: 10px 20px; margin-right: 10px;">Cancel</a>
                                    <asp:Button ID="btnSave" runat="server" Text="Save Category" CssClass="btn-primary" OnClick="btnSave_Click" Style="border: none; cursor: pointer; padding: 10px 20px;" />
                                </div>

                            </div>
                        </div>

                    </section>
                </div>
            </main>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
