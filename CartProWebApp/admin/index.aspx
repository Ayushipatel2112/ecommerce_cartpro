<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="CartProWebApp.admin.index" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-commerce Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="light-mode">
    <div class="container">
        <!-- Sidebar -->
        <% Server.Execute("include/sidebar.aspx"); %>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->

            <% Server.Execute("include/header.aspx"); %>
            <!-- Page Content -->
            <div id="page-content">
                <!-- Dashboard Page -->
                <section id="index" class="page">
                    <div class="page-title">
                        <h1>Dashboard Overview</h1>
                        <div class="date-range">
                            <i class="fas fa-calendar-alt"></i>
                            <span id="currentDate">Today</span>
                        </div>
                    </div>

                    <!-- Today's Stats -->
                    <div class="stats-grid">
                        <div class="stat-card primary">
                            <div class="stat-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stat-details">
                                <span class="stat-label">Today's Sales</span>
                                <h2 class="stat-value" id="todaySales">$0</h2>
                                <span class="stat-change positive"><i class="fas fa-arrow-up"></i>12.5%</span>
                            </div>
                        </div>
                        <div class="stat-card success">
                            <div class="stat-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div class="stat-details">
                                <span class="stat-label">Today's Orders</span>
                                <h2 class="stat-value" id="todayOrders">0</h2>
                                <span class="stat-change positive"><i class="fas fa-arrow-up"></i>8.2%</span>
                            </div>
                        </div>
                        <div class="stat-card warning">
                            <div class="stat-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div class="stat-details">
                                <span class="stat-label">Total Revenue</span>
                                <h2 class="stat-value" id="totalRevenue">$0</h2>
                                <span class="stat-change positive"><i class="fas fa-arrow-up"></i>15.3%</span>
                            </div>
                        </div>
                        <div class="stat-card info">
                            <div class="stat-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="stat-details">
                                <span class="stat-label">New Customers</span>
                                <h2 class="stat-value" id="newCustomers">0</h2>
                                <span class="stat-change positive"><i class="fas fa-arrow-up"></i>5.7%</span>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Stats -->
                    <div class="quick-stats-grid">
                        <div class="quick-stat-card">
                            <i class="fas fa-clock"></i>
                            <div>
                                <h3 id="pendingOrders">0</h3>
                                <span>Pending Orders</span>
                            </div>
                        </div>
                        <div class="quick-stat-card">
                            <i class="fas fa-box"></i>
                            <div>
                                <h3 id="outOfStock">0</h3>
                                <span>Out of Stock</span>
                            </div>
                        </div>
                        <div class="quick-stat-card">
                            <i class="fas fa-eye"></i>
                            <div>
                                <h3 id="siteVisitors">0</h3>
                                <span>Site Visitors</span>
                            </div>
                        </div>
                        <div class="quick-stat-card">
                            <i class="fas fa-undo"></i>
                            <div>
                                <h3 id="returns">0</h3>
                                <span>Returns</span>
                            </div>
                        </div>
                    </div>

                    <!-- Charts and Activity -->
                    <div class="dashboard-grid">
                        <div class="chart-card large">
                            <div class="card-header">
                                <h3>Sales Overview</h3>
                                <select id="salesPeriod" class="period-selector">
                                    <option value="7">Last 7 Days</option>
                                    <option value="30" selected>Last 30 Days</option>
                                    <option value="90">Last 90 Days</option>
                                </select>
                            </div>
                            <canvas id="salesChart"></canvas>
                        </div>

                        <div class="activity-card">
                            <div class="card-header">
                                <h3>Live Activity</h3>
                                <button class="refresh-btn"><i class="fas fa-sync-alt"></i></button>
                            </div>
                            <div class="activity-list" id="activityList">
                                <div class="activity-item">
                                    <div class="activity-icon order">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p><strong>New Order #1234</strong></p>
                                        <span>John Doe placed an order</span>
                                        <small>2 min ago</small>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon customer">
                                        <i class="fas fa-user-check"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p><strong>New Customer</strong></p>
                                        <span>Sarah Smith registered</span>
                                        <small>15 min ago</small>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon payment">
                                        <i class="fas fa-credit-card"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p><strong>Payment Received</strong></p>
                                        <span>Order #1230 - $125.00</span>
                                        <small>1 hour ago</small>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon shipped">
                                        <i class="fas fa-shipping-fast"></i>
                                    </div>
                                    <div class="activity-details">
                                        <p><strong>Order Shipped</strong></p>
                                        <span>Order #1228 shipped</span>
                                        <small>3 hours ago</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Revenue and Top Products -->
                    <div class="dashboard-grid-2">
                        <div class="chart-card">
                            <div class="card-header">
                                <h3>Revenue by Category</h3>
                            </div>
                            <canvas id="revenueChart"></canvas>
                        </div>

                        <div class="chart-card">
                            <div class="card-header">
                                <h3>Top Selling Products</h3>
                            </div>
                            <div class="top-products-list" id="topProductsList">
                                <!-- Will be populated by JS -->
                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </main>
    </div>

    <!-- Product Modal -->
    <div id="productModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" data-modal="productModal">&times;</span>
            <h2 id="productModalTitle">Add New Product</h2>
            <form id="productForm" novalidate>
                <input type="hidden" id="productId">
                <div class="form-group">
                    <label for="productName">Product Name *</label>
                    <input type="text" id="productName" required>
                    <div class="error"></div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="productSKU">SKU *</label>
                        <input type="text" id="productSKU" required>
                        <div class="error"></div>
                    </div>
                    <div class="form-group">
                        <label for="productCategory">Category *</label>
                        <input type="text" id="productCategory" required>
                        <div class="error"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="productPrice">Price *</label>
                        <input type="number" id="productPrice" required min="0.01" step="0.01">
                        <div class="error"></div>
                    </div>
                    <div class="form-group">
                        <label for="productStock">Stock *</label>
                        <input type="number" id="productStock" required min="0">
                        <div class="error"></div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="productDescription">Description</label>
                    <textarea id="productDescription" rows="3"></textarea>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-secondary" data-close="productModal">Cancel</button>
                    <button type="submit" class="btn-primary">Save Product</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Order Details Modal -->
    <div id="orderModal" class="modal">
        <div class="modal-content large">
            <span class="close-btn" data-modal="orderModal">&times;</span>
            <h2>Order Details</h2>
            <div id="orderDetailsContent">
                <!-- Populated by JS -->
            </div>
        </div>
    </div>

    <!-- Coupon Modal -->
    <div id="couponModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" data-modal="couponModal">&times;</span>
            <h2>Create Coupon</h2>
            <form id="couponForm" novalidate>
                <div class="form-group">
                    <label for="couponCode">Coupon Code *</label>
                    <input type="text" id="couponCode" required>
                    <div class="error"></div>
                </div>
                <div class="form-group">
                    <label for="couponDiscount">Discount (%) *</label>
                    <input type="number" id="couponDiscount" required min="1" max="100">
                    <div class="error"></div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="couponStart">Start Date</label>
                        <input type="date" id="couponStart">
                    </div>
                    <div class="form-group">
                        <label for="couponEnd">End Date</label>
                        <input type="date" id="couponEnd">
                    </div>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-secondary" data-close="couponModal">Cancel</button>
                    <button type="submit" class="btn-primary">Create Coupon</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="js/main.js"></script>
</body>

</html>
