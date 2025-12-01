<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myprofile.aspx.cs" Inherits="CartProWebApp.admin.myprofile" %>



<!DOCTYPE html>
<html lang="en">

<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .profile-container {
            background: #fff; /* var(--white-color) fallback */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 700px;
            margin: 0 auto;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .profile-info {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 15px;
            background: #f8f9fa; /* var(--background-color) fallback */
            border-radius: 8px;
            margin-bottom: 20px;
        }

            .profile-info i {
                font-size: 1.5rem;
                color: #3b5d50; /* var(--primary-color) fallback */
            }

            .profile-info .details p {
                margin: 0;
                color: #6c757d;
            }

            .profile-info .details strong {
                font-size: 1rem;
                color: #000;
            }

        .profile-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }

        /* Buttons specific styles if not in global css */
        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
        }

        .btn-primary {
            background: #3b5d50;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
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
                    <div class="profile-container">
                        <div class="profile-header">
                            <h1>My Profile</h1>
                        </div>

                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

                        <div class="profile-info">
                            <i class="fas fa-user-circle"></i>
                            <div class="details">
                                <p>Username / Name</p>
                                <strong>
                                    <asp:Label ID="lblUsername" runat="server" Text="Loading..."></asp:Label></strong>
                            </div>
                        </div>
                        <div class="profile-info">
                            <i class="fas fa-envelope"></i>
                            <div class="details">
                                <p>Email Address</p>
                                <strong>
                                    <asp:Label ID="lblEmail" runat="server" Text="Loading..."></asp:Label></strong>
                            </div>
                        </div>
                        <div class="profile-info">
                            <i class="fas fa-key"></i>
                            <div class="details">
                                <p>Password</p>
                                <strong>••••••••••</strong>
                            </div>
                        </div>

                        <div class="profile-actions">
                            <a href="forgot_password.aspx" class="btn-secondary">Forgot Password</a>
                            <a href="update_profile.aspx" class="btn-primary">Update Profile</a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </form>
    <script src="js/main.js"></script>
</body>
</html>
