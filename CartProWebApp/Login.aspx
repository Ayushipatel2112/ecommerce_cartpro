<%@ Page Title="Login - CartPro" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CartProWebApp.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="shortcut icon" href="favicon.png" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>Login - CartPro</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header text-center h4 text-white" style="background-color: #3b5d50;">Login</div>
                        <div class="card-body">
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-center d-block mb-3"></asp:Label>
                            <div class="mb-3">
                                <label for="txtUsername" class="form-label">Username</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtPassword" class="form-label">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required="required"></asp:TextBox>
                            </div>
                            <div class="text-center">
                                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="btnLogin_Click" />
                            </div>
                        </div>
                        <div class="card-footer text-center">
                            Don't have an account? <a href="Registration.aspx">Register</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
