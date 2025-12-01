<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="CartProWebApp.admin.product" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management | E-commerce Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .sort-link {
            color: inherit;
            text-decoration: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
        }

            .sort-link:hover {
                text-decoration: underline;
            }

        .pagination-container {
            display: flex;
            gap: 5px;
        }

        .badge-success {
            background-color: #d4edda;
            color: #155724;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85em;
        }

        .badge-warning {
            background-color: #fff3cd;
            color: #856404;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85em;
        }

        .badge-danger {
            background-color: #f8d7da;
            color: #721c24;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85em;
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
                    <section id="product" class="page">

                        <div class="page-header">
                            <h1>Product Management</h1>
                            <div class="header-actions">
                                <a href="product_add.aspx" class="btn-primary"><i class="fas fa-plus"></i>Add Product</a>
                            </div>
                        </div>

                        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="table-container" Style="margin-bottom: 15px; background-color: #efe; border-left: 4px solid #0c0; padding: 15px;">
                            <div style="color: #060;">
                                <i class="fas fa-check-circle"></i>
                                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                            </div>
                        </asp:Panel>

                        <div class="table-container" style="margin-bottom: 15px;">
                            <div style="display: flex; gap: 10px; flex-wrap: wrap; align-items: end;">

                                <div class="form-group" style="flex: 1; min-width: 200px; margin: 0;">
                                    <label>Search</label>
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search products..." Style="width: 100%;"></asp:TextBox>
                                </div>

                                <div class="form-group" style="flex: 0 0 150px; margin: 0;">
                                    <label>Category</label>
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AppendDataBoundItems="true" Style="width: 100%;">
                                        <asp:ListItem Text="All Categories" Value="0" />
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group" style="flex: 0 0 150px; margin: 0;">
                                    <label>Stock Status</label>
                                    <asp:DropDownList ID="ddlStock" runat="server" CssClass="form-control" Style="width: 100%;">
                                        <asp:ListItem Text="All Status" Value="" />
                                        <asp:ListItem Text="In Stock" Value="In Stock" />
                                        <asp:ListItem Text="Low Stock" Value="Low Stock" />
                                        <asp:ListItem Text="Out of Stock" Value="Out of Stock" />
                                    </asp:DropDownList>
                                </div>

                                <div style="display: flex; gap: 5px;">
                                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-primary" OnClick="btnSearch_Click" Style="white-space: nowrap;">
                                        <i class="fas fa-search"></i> Search
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnReset" runat="server" CssClass="btn-secondary" OnClick="btnReset_Click" Style="white-space: nowrap;">
                                        <i class="fas fa-redo"></i> Reset
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <div class="table-container">
                            <table width="100%">
                                <thead>
                                    <tr>
                                        <th>
                                            <asp:LinkButton ID="lnkSortId" runat="server" CssClass="sort-link" OnClick="Sort_Click" CommandArgument="id">
                                                ID
                                                <asp:Label ID="lblSortId" runat="server"></asp:Label>
                                            </asp:LinkButton></th>
                                        <th>
                                            <asp:LinkButton ID="lnkSortCat" runat="server" CssClass="sort-link" OnClick="Sort_Click" CommandArgument="category_name">
                                                Category
                                                <asp:Label ID="lblSortCat" runat="server"></asp:Label>
                                            </asp:LinkButton></th>
                                        <th>
                                            <asp:LinkButton ID="lnkSortName" runat="server" CssClass="sort-link" OnClick="Sort_Click" CommandArgument="productname">
                                                Name
                                                <asp:Label ID="lblSortName" runat="server"></asp:Label>
                                            </asp:LinkButton></th>
                                        <th>Description</th>
                                        <th>
                                            <asp:LinkButton ID="lnkSortPrice" runat="server" CssClass="sort-link" OnClick="Sort_Click" CommandArgument="productprice">
                                                Price
                                                <asp:Label ID="lblSortPrice" runat="server"></asp:Label>
                                            </asp:LinkButton></th>
                                        <th>Image</th>
                                        <th>
                                            <asp:LinkButton ID="lnkSortStock" runat="server" CssClass="sort-link" OnClick="Sort_Click" CommandArgument="stock_status">
                                                Stock
                                                <asp:Label ID="lblSortStock" runat="server"></asp:Label>
                                            </asp:LinkButton></th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptProducts" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id") %></td>
                                                <td><%# Eval("category_name") %></td>
                                                <td><%# Eval("productname") %></td>
                                                <td>
                                                    <%# (!string.IsNullOrEmpty(Eval("productdescription").ToString()) && Eval("productdescription").ToString().Length > 50) 
                                                        ? Eval("productdescription").ToString().Substring(0, 50) + "..." 
                                                        : Eval("productdescription") %>
                                                </td>
                                                <td>₹<%# Eval("productprice", "{0:N2}") %></td>
                                                <td>
                                                    <img src='<%# string.IsNullOrEmpty(Eval("image").ToString()) ? "" : Eval("image") %>'
                                                        style="width: 50px; height: 50px; object-fit: cover; border-radius: 6px;"
                                                        onerror="this.style.display='none'"
                                                        alt="Product" />
                                                </td>
                                                <td>
                                                    <span class='<%# GetStockBadgeClass(Eval("stock_status").ToString()) %>'>
                                                        <%# Eval("stock_status") %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="product_edit.aspx?id=<%# Eval("id") %>" class="action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-btn" CommandArgument='<%# Eval("id") %>' OnClick="btnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this product?');" title="Delete">
                                                        <i class="fas fa-trash"></i>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <tr runat="server" visible='<%# rptProducts.Items.Count == 0 %>'>
                                                <td colspan="8" style="text-align: center; padding: 30px;">
                                                    <i class="fas fa-box-open" style="font-size: 48px; color: #ccc; display: block; margin-bottom: 10px;"></i>
                                                    <strong>No products found.</strong>
                                                </td>
                                            </tr>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>

                        <div class="table-container" style="margin-top: 15px;" runat="server" id="divPagination">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div>
                                    Showing
                                    <asp:Literal ID="litStart" runat="server"></asp:Literal>
                                    to
                                    <asp:Literal ID="litEnd" runat="server"></asp:Literal>
                                    of
                                    <asp:Literal ID="litTotal" runat="server"></asp:Literal>
                                    products
                                </div>
                                <div class="pagination-container">
                                    <asp:Button ID="btnFirst" runat="server" Text="First" CssClass="btn-secondary" OnClick="btnPage_Click" CommandArgument="1" />
                                    <asp:Button ID="btnPrev" runat="server" Text="Prev" CssClass="btn-secondary" OnClick="btnPage_Click" CommandArgument="prev" />

                                    <asp:Repeater ID="rptPages" runat="server">
                                        <ItemTemplate>
                                            <asp:Button ID="btnPageNum" runat="server"
                                                Text='<%# Container.DataItem %>'
                                                CssClass='<%# Convert.ToInt32(Container.DataItem) == CurrentPage ? "btn-primary" : "btn-secondary" %>'
                                                OnClick="btnPage_Click"
                                                CommandArgument='<%# Container.DataItem %>' />
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn-secondary" OnClick="btnPage_Click" CommandArgument="next" />
                                    <asp:Button ID="btnLast" runat="server" Text="Last" CssClass="btn-secondary" OnClick="btnPage_Click" CommandArgument="last" />
                                </div>
                            </div>
                        </div>

                    </section>
                </div>
            </main>
        </div>
    </form>
    <script src="js/main.js"></script>
</body>
</html>
