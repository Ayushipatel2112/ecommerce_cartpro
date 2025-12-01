<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="orders.aspx.cs" Inherits="CartProWebApp.admin.orders" %>

<!DOCTYPE html>
<html lang="en">

<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management | E-commerce Admin</title>
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
                    <section id="orders" class="page">
                        <div class="page-header">
                            <h1>Order Management</h1>
                            <div class="header-actions">
                                <asp:Button ID="btnExport" runat="server" Text="Export CSV" CssClass="btn-secondary" OnClick="btnExport_Click" />
                            </div>
                        </div>

                        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="table-container" Style="margin-bottom: 15px;">
                            <div class="alert-success">
                                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                            </div>
                        </asp:Panel>

                        <div class="filters-bar">
                            <div style="display: flex; gap: 10px;">
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                                    <asp:ListItem Text="All Orders" Value="" />
                                    <asp:ListItem Text="Pending" Value="pending" />
                                    <asp:ListItem Text="Processing" Value="processing" />
                                    <asp:ListItem Text="Shipped" Value="shipped" />
                                    <asp:ListItem Text="Delivered" Value="delivered" />
                                    <asp:ListItem Text="Cancelled" Value="cancelled" />
                                </asp:DropDownList>

                                <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="filter-input" AutoPostBack="true" OnTextChanged="Filter_Changed"></asp:TextBox>

                                <asp:Button ID="btnClear" runat="server" Text="Clear Filters" CssClass="btn-secondary" OnClick="btnClear_Click" Visible="false" Style="padding: 8px 15px;" />
                            </div>
                        </div>

                        <div class="table-container">
                            <table width="100%">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Total</th>
                                        <th>Payment</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptOrders" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>#<%# Eval("id") %></td>
                                                <td>
                                                    <%# Eval("customer_name") %>
                                                    <br>
                                                    <small style="color: #666;"><%# Eval("customer_email") %></small>
                                                </td>
                                                <td><%# Convert.ToDateTime(Eval("date")).ToString("MMM dd, yyyy") %></td>
                                                <td>₹<%# Eval("total_amount", "{0:N2}") %></td>
                                                <td>
                                                    <span class='badge badge-<%# Eval("payment").ToString().ToLower() == "paid" ? "success" : "warning" %>'>
                                                        <%# UppercaseFirst(Eval("payment").ToString()) %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class='badge badge-<%# GetStatusBadgeClass(Eval("status").ToString()) %>'>
                                                        <%# UppercaseFirst(Eval("status").ToString()) %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href='order_view.aspx?id=<%# Eval("id") %>' class="action-btn" title="View">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href='order_edit.aspx?id=<%# Eval("id") %>' class="action-btn" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("id") %>' OnClick="btnDelete_Click" CssClass="action-btn" OnClientClick="return confirm('Are you sure you want to delete this order?');" title="Delete">
                                                        <i class="fas fa-trash"></i>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:Panel ID="pnlNoData" runat="server" Visible="false">
                                        <tr>
                                            <td colspan="7" style="text-align: center;">No orders found.</td>
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
