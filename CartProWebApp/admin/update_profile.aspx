<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="update_profile.aspx.cs" Inherits="CartProWebApp.admin.update_profile" %>

<!DOCTYPE html>
<html lang="en">

<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <script type="text/javascript">
        function showPopup(msg, isError) {
            const popup = document.getElementById('popup');
            if (popup) {
                popup.textContent = msg;

                // Error ya Success color set karein
                if (isError) {
                    popup.classList.add('error');
                    popup.style.backgroundColor = "#dc3545"; // Red
                } else {
                    popup.classList.remove('error');
                    popup.style.backgroundColor = "#28a745"; // Green
                }

                // Show Animation
                popup.style.display = "block"; // Force display
                setTimeout(() => {
                    popup.style.opacity = "1";
                    popup.style.transform = "translateY(0)";
                }, 10);

                // Hide after 3 seconds
                setTimeout(() => {
                    popup.style.opacity = "0";
                    popup.style.transform = "translateY(-20px)";
                    setTimeout(() => { popup.style.display = "none"; }, 300);
                }, 3000);
            } else {
                alert(msg); // Fallback agar popup div nahi mila
            }
        }
    </script>

    <style>
        .popup {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #3b5d50; /* var(--secondary-color) fallback */
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            z-index: 9999;
            opacity: 0;
            transition: all 0.3s ease;
            transform: translateY(-20px);
        }

        .popup {
            /* ... baki styles ... */
            z-index: 99999 !important; /* Ensure ye sabse upar ho */
            display: none; /* Shuru mein chipa rahe */
        }

            .popup.show {
                display: block;
                opacity: 1;
                transform: translateY(0);
            }

            .popup.error {
                background-color: #dc3545; /* var(--danger-color) fallback */
            }

        /* Styles for ASP.NET Controls to match your design */
        .form-control-custom {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 5px;
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
                    <div class="modal-content" style="max-width: 600px; margin: auto;">
                        <h2>Update Profile Information</h2>

                        <div class="form-group">
                            <label for="txtUsername">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control-custom" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtEmail">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-custom" TextMode="Email" required="required"></asp:TextBox>
                        </div>

                        <div class="modal-actions">
                            <a href="myprofile.aspx" class="btn-secondary" style="text-decoration: none; padding: 10px 20px; background-color: #6c757d; color: white; border-radius: 4px;">Cancel</a>
                            <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn-primary" OnClick="btnUpdate_Click" Style="border: none; cursor: pointer; padding: 10px 20px;" />
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </form>

    <div id="popup" class="popup"></div>

    <script src="js/main.js"></script>
    <script>
        // JavaScript function to show popup (Called from C#)
        function showPopup(msg, isError = false) {
            const popup = document.getElementById('popup');
            if (popup) {
                popup.textContent = msg;
                if (isError) {
                    popup.classList.add('error');
                } else {
                    popup.classList.remove('error');
                }
                popup.classList.add('show');
                setTimeout(() => {
                    popup.classList.remove('show');
                }, 3000);
            }
        }
    </script>
</body>
</html>
