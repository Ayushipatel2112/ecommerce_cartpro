<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="order_view.aspx.cs" Inherits="CartProWebApp.admin.order_view" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Order Details | Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .order-details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .detail-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #4CAF50;
        }

            .detail-card h3 {
                margin: 0 0 10px 0;
                color: #666;
                font-size: 14px;
                text-transform: uppercase;
            }

            .detail-card p {
                margin: 0;
                font-size: 18px;
                font-weight: 600;
                color: #333;
            }
    </style>
</head>
<body class="light-mode">
    <form id="form1" runat="server">
        <div class="container">
            <% Server.Execute("include/sidebar.aspx"); %>
            <main class="main-content">
                <% Server.Execute("include/header.aspx"); %>

                <div id="page-content">
                    <section id="order-view" class="page">
                        <div class="page-header">
                            <h1>Order Details #<asp:Label ID="lblHeaderId" runat="server"></asp:Label></h1>
                            <div class="header-actions">
                                <a href="order.aspx" class="btn-secondary"><i class="fas fa-arrow-left"></i>Back</a>
                                <asp:HyperLink ID="lnkEdit" runat="server" CssClass="btn-primary"><i class="fas fa-edit"></i> Edit</asp:HyperLink>
                            </div>
                        </div>

                        <div class="table-container">
                            <h2 style="margin-bottom: 20px;">Order Information</h2>
                            <div class="order-details-grid">
                                <div class="detail-card">
                                    <h3>Order ID</h3>
                                    <p>#<asp:Label ID="lblOrderId" runat="server"></asp:Label></p>
                                </div>
                                <div class="detail-card">
                                    <h3>Order Date</h3>
                                    <p>
                                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div class="detail-card">
                                    <h3>Total Amount</h3>
                                    <p>₹<asp:Label ID="lblTotal" runat="server"></asp:Label></p>
                                </div>
                                <div class="detail-card">
                                    <h3>Payment Status</h3>
                                    <p>
                                        <asp:Label ID="lblPayment" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div class="detail-card">
                                    <h3>Order Status</h3>
                                    <p>
                                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                    </p>
                                </div>
                            </div>

                            <h2 style="margin: 30px 0 20px 0;">Customer Information</h2>
                            <div class="order-details-grid">
                                <div class="detail-card">
                                    <h3>Name</h3>
                                    <p>
                                        <asp:Label ID="lblCustName" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div class="detail-card">
                                    <h3>Email</h3>
                                    <p>
                                        <asp:Label ID="lblCustEmail" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div class="detail-card">
                                    <h3>Phone</h3>
                                    <p>
                                        <asp:Label ID="lblCustPhone" runat="server"></asp:Label>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
