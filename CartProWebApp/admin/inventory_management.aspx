<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inventory_management.aspx.cs" Inherits="CartProWebApp.admin.inventory_management" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inventory Management | CartPro Admin</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <% Server.Execute("include/header.aspx"); %>


            <main class="main-content">
                <% Server.Execute("include/sidebar.aspx"); %>


                <section id="inventory" class="page">
                    <div class="page-header">
                        <h1>Inventory Management</h1>
                        <button class="btn-secondary" id="exportInventory" type="button"><i class="fas fa-download"></i>Export</button>
                    </div>

                    <div class="inventory-alerts">
                        <div class="alert-card warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            <div>
                                <h4>Low Stock Alert</h4>
                                <p>
                                    <asp:Label ID="lblLowStockCount" runat="server" Text="0"></asp:Label>
                                    products need attention
                                </p>
                            </div>
                        </div>
                        <div class="alert-card danger">
                            <i class="fas fa-times-circle"></i>
                            <div>
                                <h4>Out of Stock</h4>
                                <p>
                                    <asp:Label ID="lblOutOfStockCount" runat="server" Text="0"></asp:Label>
                                    products unavailable
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptInventory" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <img src='../<%# Eval("image") %>' alt="Product" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                                            </td>
                                            <td><%# Eval("productname") %></td>
                                            <td>₹<%# Eval("productprice") %></td>
                                            <td>
                                                <%# GetStatusBadge(Convert.ToString(Eval("stock_status"))) %>
                                            </td>
                                            <td>
                                                <a href='product_edit.aspx?id=<%# Eval("id") %>' class="action-btn" title="Edit Product">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Label ID="lblNoData" runat="server" Text="No products found." Visible="false" ForeColor="Red"></asp:Label>
                    </div>
                </section>
            </main>
        </div>
    </form>
</body>
</html>
