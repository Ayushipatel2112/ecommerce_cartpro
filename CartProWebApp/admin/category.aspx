<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="category.aspx.cs" Inherits="CartProWebApp.admin.category" %>

<!DOCTYPE html>
<html lang="en">

<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="light-mode">
    <form id="form1" runat="server">
        <div class="container">

            <% Server.Execute("include/sidebar.aspx"); %>

            <main class="main-content">

                <% Server.Execute("include/header.aspx"); %>

                <div id="page-content">
                    <section id="category" class="page">

                        <div class="page-header">
                            <h1>Category Management</h1>
                            <div class="header-actions">
                                <a href="category_add.aspx" class="btn-primary"><i class="fas fa-plus"></i>Add Category</a>
                            </div>
                        </div>

                        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="table-container" Style="margin-bottom: 15px;">
                            <div style="color: green; font-weight: bold;">
                                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                            </div>
                        </asp:Panel>

                        <div class="table-container">
                            <table width="100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Category Name</th>
                                        <th>Category Description</th>
                                        <th>Image</th>
                                        <th>Created</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptCategories" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id") %></td>
                                                <td><%# Eval("category_name") %></td>
                                                <td><%# Eval("category_description") %></td>
                                                <td>
                                                    <img src='<%# Eval("image") %>'
                                                        alt='<%# Eval("category_name") %>'
                                                        style="width: 50px; height: 50px; object-fit: cover; border-radius: 6px;"
                                                        onerror="this.style.display='none'" />
                                                </td>
                                                <td><%# Eval("created_at", "{0:yyyy-MM-dd}") %></td>
                                                <td>
                                                    <a href='category_edit.aspx?id=<%# Eval("id") %>' class="action-btn" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href='category_delete.aspx?id=<%# Eval("id") %>' class="action-btn" title="Delete" onclick="return confirm('Are you sure you want to delete this category?');">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:Panel ID="pnlNoData" runat="server" Visible="false">
                                        <tr>
                                            <td colspan="6" style="text-align: center;">No categories found.</td>
                                        </tr>
                                    </asp:Panel>
                                </tbody>
                            </table>
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
