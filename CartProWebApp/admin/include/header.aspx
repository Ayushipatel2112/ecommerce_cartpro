<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="header.aspx.cs" Inherits="CartProWebApp.admin.include.header" %>


<header class="header">
    <div class="header-left">
        <button class="icon-btn" id="sidebarToggle" style="margin-right: 15px;">
            <i class="fas fa-bars"></i>
        </button>
        <div class="search-wrapper">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search products, orders, customers...">
        </div>
    </div>
    <div class="header-right">
        <div class="notification-wrapper">
            <button class="icon-btn" id="notificationBtn">
                <i class="fas fa-bell"></i>
                <span class="badge">5</span>
            </button>
            <div class="notification-dropdown" id="notificationDropdown">
            </div>
        </div>

        <div class="user-profile" id="userProfile">
            <img src="https://ui-avatars.com/api/?name=Admin+User&background=3498db&color=fff" alt="Admin">
            <div class="user-info">
                <span class="user-name">Admin User</span>
                <span class="user-role">Administrator</span>
            </div>
            <i class="fas fa-chevron-down"></i>
            <div class="profile-dropdown" id="profileDropdown">
                <a href="myprofile.aspx"><i class="fas fa-user"></i>My Profile</a>
                <a href="logout.aspx"><i class="fas fa-sign-out-alt"></i>Logout</a>
            </div>
        </div>
    </div>
</header>

