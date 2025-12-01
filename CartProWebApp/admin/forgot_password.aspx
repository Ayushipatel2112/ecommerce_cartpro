<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgot_password.aspx.cs" Inherits="CartProWebApp.admin.forgot_password" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password | CartPro Admin</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Centering the form like a Login Page */
        body {
            background-color: #eff2f1;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-card {
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            width: 100%;
            max-width: 450px;
        }

        .auth-header {
            text-align: center;
            margin-bottom: 30px;
        }

            .auth-header h2 {
                color: #3b5d50;
                margin-bottom: 10px;
            }

        .form-control-custom {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .btn-primary-custom {
            width: 100%;
            padding: 12px;
            background-color: #3b5d50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
        }

            .btn-primary-custom:hover {
                background-color: #2f4d42;
            }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #6c757d;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-card">
            <div class="auth-header">
                <h2>Forgot Password?</h2>
                <p>Don't worry! Enter your email to reset it.</p>
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Style="display: block; text-align: center; margin-bottom: 15px; font-weight: bold;"></asp:Label>

            <asp:Panel ID="pnlVerifyEmail" runat="server">
                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-custom" placeholder="admin@example.com" required="required"></asp:TextBox>
                </div>
                <asp:Button ID="btnVerify" runat="server" Text="Verify Email" CssClass="btn-primary-custom" OnClick="btnVerify_Click" />
            </asp:Panel>

            <asp:Panel ID="pnlResetPass" runat="server" Visible="false">
                <div class="form-group">
                    <label>New Password</label>
                    <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="New Password" required="required"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPass" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Confirm Password" required="required"></asp:TextBox>
                </div>
                <asp:Button ID="btnReset" runat="server" Text="Reset Password" CssClass="btn-primary-custom" OnClick="btnReset_Click" />
            </asp:Panel>

            <a href="Login.aspx" class="back-link">Back to Login</a>
        </div>
    </form>
</body>
</html>
