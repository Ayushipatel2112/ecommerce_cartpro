<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="order_edit.aspx.cs" Inherits="CartProWebApp.admin.order_edit" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Edit Order | Admin</title>
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
                    <section id="order-edit" class="page">
                        <div class="page-header">
                            <h1>Edit Order</h1>
                            <div class="header-actions">
                                <a href="order.aspx" class="btn-secondary"><i class="fas fa-arrow-left"></i>Back to Orders</a>
                            </div>
                        </div>

                        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="table-container" Style="margin-bottom: 15px; background-color: #fee; border-left: 4px solid #f00; padding: 15px;">
                            <div style="color: #c00;">
                                <i class="fas fa-exclamation-circle"></i>
                                <asp:Literal ID="litError" runat="server"></asp:Literal>
                            </div>
                        </asp:Panel>

                        <div class="table-container">
                            <div class="form-group">
                                <label>Customer *</label>
                                <asp:DropDownList ID="ddlCustomer" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                    <asp:ListItem Text="Select Customer" Value="" />
                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label>Order Date *</label>
                                <asp:TextBox ID="txtDate" runat="server" TextMode="DateTimeLocal" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Total Amount *</label>
                                <asp:TextBox ID="txtTotal" runat="server" TextMode="Number" step="0.01" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Payment Status *</label>
                                <asp:DropDownList ID="ddlPayment" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="pending">Pending</asp:ListItem>
                                    <asp:ListItem Value="paid">Paid</asp:ListItem>
                                    <asp:ListItem Value="failed">Failed</asp:ListItem>
                                    <asp:ListItem Value="refunded">Refunded</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label>Order Status *</label>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="pending">Pending</asp:ListItem>
                                    <asp:ListItem Value="processing">Processing</asp:ListItem>
                                    <asp:ListItem Value="shipped">Shipped</asp:ListItem>
                                    <asp:ListItem Value="delivered">Delivered</asp:ListItem>
                                    <asp:ListItem Value="cancelled">Cancelled</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="modal-actions">
                                <a href="orders.aspx" class="btn-secondary">Cancel</a>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update Order" CssClass="btn-primary" OnClick="btnUpdate_Click" />
                            </div>
                        </div>
                    </section>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
