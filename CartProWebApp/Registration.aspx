<%@ Page Title="Registration - CartPro" Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="CartProWebApp.Registration" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="shortcut icon" href="favicon.png" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>Registration - CartPro</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header text-center h4 text-white" style="background-color: #3b5d50;">Register</div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="txtUsername" class="form-label">Username</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required="required"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtPassword" class="form-label">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required="required"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" required="required"></asp:TextBox>
                            </div>
                            <div class="text-center">
                                <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary" Text="Register" OnClick="btnRegister_Click" />
                            </div>
                        </div>
                        <div class="card-footer text-center">
                            <a href="Login.aspx">Already have an account? Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
