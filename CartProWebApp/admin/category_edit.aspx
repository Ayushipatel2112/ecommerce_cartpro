<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="category_edit.aspx.cs" Inherits="CartProWebApp.admin.category_edit" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="light-mode">
    <form id="form1" runat="server" enctype="multipart/form-data">

        <asp:HiddenField ID="hfOldImagePath" runat="server" />

        <div class="container">
            <%-- Assuming you use a sidebar/header include logic --%>
            <%-- <% Server.Execute("include/sidebar.aspx"); %> --%>

            <main class="main-content">
                <div id="page-content">
                    <section id="category-edit" class="page">

                        <div class="page-header">
                            <h1>Edit Category</h1>
                            <div class="header-actions">
                                <a href="category.aspx" class="btn-secondary"><i class="fas fa-arrow-left"></i>Back to Categories</a>
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
                                <label for="txtName">Category Name *</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="txtDescription">Category Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Category Image</label>

                                <div id="divCurrentImage" runat="server" visible="false" style="margin-bottom: 10px;">
                                    <asp:Image ID="imgPreview" runat="server" Style="width: 100px; height: 100px; object-fit: cover; border-radius: 6px; border: 2px solid #ddd;" />
                                    <p style="margin-top: 5px; color: #666; font-size: 14px;">Current image</p>
                                </div>

                                <asp:FileUpload ID="fileImage" runat="server" accept="image/*" />
                                <small style="display: block; margin-top: 5px; color: #666;">Leave empty to keep current image. Allowed formats: JPG, PNG, GIF, WEBP</small>
                            </div>

                            <div class="modal-actions">
                                <a href="category.aspx" class="btn-secondary">Cancel</a>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update Category" CssClass="btn-primary" OnClick="btnUpdate_Click" />
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
