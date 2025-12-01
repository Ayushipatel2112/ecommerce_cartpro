<%@ Page Title="Profile - CartPro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewProfile.aspx.cs" Inherits="CartProWebApp.ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Profile - CartPro
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header text-center h4 text-white" style="background-color: #3b5d50;">
                        User Profile
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="txtUsername" class="form-label">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtEmail" class="form-label">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtPhone" class="form-label">Phone</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtAddress" class="form-label">Address</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <div class="text-center">
                            <asp:Button ID="btnUpdateProfile" runat="server" CssClass="btn btn-primary" Text="Update Profile" OnClick="btnUpdateProfile_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
