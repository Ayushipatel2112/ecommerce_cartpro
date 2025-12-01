<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sidebar.aspx.cs" Inherits="CartProWebApp.admin.include.sidebar" %>

<html xmlns="http://www.w3.org/1999/xhtml">

<body>


    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-store"></i>ShopAdmin</h3>
        </div>

        <ul class="sidebar-menu">
            <li><a href="index.aspx" class="menu-item active"><i class="fas fa-home"></i><span>Dashboard</span></a></li>

            <li class="menu-section"><span>E-COMMERCE</span></li>
            <li><a href="category.aspx" class="menu-item"><i class="fas fa-tags"></i><span>Categories</span></a></li>
            <li><a href="product.aspx" class="menu-item"><i class="fas fa-box-open"></i><span>Products</span></a></li>
            <li><a href="order.aspx" class="menu-item"><i class="fas fa-shopping-cart"></i><span>Orders</span></a></li>
            <li><a href="inventory_management.aspx" class="menu-item"><i class="fas fa-warehouse"></i><span>Inventory</span></a></li>

            <li class="menu-section"><span>CUSTOMERS</span></li>
            <li><a href="customer_management.aspx" class="menu-item"><i class="fas fa-users"></i><span>All Customers</span></a></li>
        </ul>
    </aside>
</body>

</html>
