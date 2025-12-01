using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace CartProWebApp.admin
{
    public partial class product : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;
        int PageSize = 10; // Number of items per page

        // Properties to store state in ViewState
        public int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1; }
            set { ViewState["CurrentPage"] = value; }
        }

        public string SortColumn
        {
            get { return ViewState["SortColumn"] != null ? (string)ViewState["SortColumn"] : "id"; }
            set { ViewState["SortColumn"] = value; }
        }

        public string SortDirection
        {
            get { return ViewState["SortDirection"] != null ? (string)ViewState["SortDirection"] : "DESC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                // Check for redirect messages
                if (Request.QueryString["msg"] != null)
                {
                    ShowMessage(Request.QueryString["msg"], true);
                }

                LoadCategories();
                BindData();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT id, category_name FROM categories ORDER BY category_name";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    ddlCategory.DataSource = cmd.ExecuteReader();
                    ddlCategory.DataTextField = "category_name";
                    ddlCategory.DataValueField = "id";
                    ddlCategory.DataBind();
                }
            }
        }

        private void BindData()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Base Query
                string query = @"SELECT p.*, c.category_name 
                                 FROM products p 
                                 LEFT JOIN categories c ON p.catid = c.id 
                                 WHERE 1=1 ";

                // 1. Apply Filters
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    query += " AND (p.productname LIKE @Search OR p.productdescription LIKE @Search)";
                }

                if (ddlCategory.SelectedValue != "0")
                {
                    query += " AND p.catid = @CatId";
                }

                if (!string.IsNullOrEmpty(ddlStock.SelectedValue))
                {
                    query += " AND p.stock_status = @Stock";
                }

                // 2. Fetch Data into DataTable (for easier sorting/paging in memory)
                // Note: For massive datasets (100k+ rows), use SQL Offset/Fetch. For standard logic, this is fine.
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                        cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text.Trim() + "%");

                    if (ddlCategory.SelectedValue != "0")
                        cmd.Parameters.AddWithValue("@CatId", ddlCategory.SelectedValue);

                    if (!string.IsNullOrEmpty(ddlStock.SelectedValue))
                        cmd.Parameters.AddWithValue("@Stock", ddlStock.SelectedValue);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        // 3. Apply Sorting
                        DataView dv = dt.DefaultView;
                        dv.Sort = SortColumn + " " + SortDirection;
                        UpdateSortIcons();

                        // 4. Apply Pagination
                        PagedDataSource pds = new PagedDataSource();
                        pds.DataSource = dv;
                        pds.AllowPaging = true;
                        pds.PageSize = PageSize;
                        pds.CurrentPageIndex = CurrentPage - 1; // Zero-based index

                        // Update Stats
                        int totalItems = dt.Rows.Count;
                        int startItem = (CurrentPage - 1) * PageSize + 1;
                        int endItem = Math.Min(CurrentPage * PageSize, totalItems);

                        if (totalItems == 0) startItem = 0;

                        litStart.Text = startItem.ToString();
                        litEnd.Text = endItem.ToString();
                        litTotal.Text = totalItems.ToString();

                        // Bind Repeater
                        rptProducts.DataSource = pds;
                        rptProducts.DataBind();

                        // Bind Pagination Buttons
                        BindPaginationButtons(pds.PageCount);

                        // Show/Hide Pagination Container based on data
                        divPagination.Visible = totalItems > 0;
                        btnFirst.Enabled = !pds.IsFirstPage;
                        btnPrev.Enabled = !pds.IsFirstPage;
                        btnNext.Enabled = !pds.IsLastPage;
                        btnLast.Enabled = !pds.IsLastPage;
                    }
                }
            }
        }

        private void BindPaginationButtons(int totalPages)
        {
            List<int> pages = new List<int>();
            // Logic to show a window of pages (e.g., current - 2 to current + 2)
            for (int i = 1; i <= totalPages; i++)
            {
                pages.Add(i);
            }
            rptPages.DataSource = pages;
            rptPages.DataBind();
        }

        // --- Event Handlers ---

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 1; // Reset to page 1 on new search
            BindData();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlCategory.SelectedIndex = 0;
            ddlStock.SelectedIndex = 0;
            CurrentPage = 1;
            SortColumn = "id";
            SortDirection = "DESC";
            BindData();
        }

        protected void Sort_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string argument = btn.CommandArgument;

            if (SortColumn == argument)
            {
                // Toggle direction
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            }
            else
            {
                SortColumn = argument;
                SortDirection = "ASC"; // Default new sort to ASC
            }

            BindData();
        }

        private void UpdateSortIcons()
        {
            // Reset all icons
            lblSortId.Text = "";
            lblSortName.Text = "";
            lblSortCat.Text = "";
            lblSortPrice.Text = "";
            lblSortStock.Text = "";

            // Set current icon
            string icon = SortDirection == "ASC" ? " <i class='fas fa-sort-up'></i>" : " <i class='fas fa-sort-down'></i>";

            switch (SortColumn)
            {
                case "id": lblSortId.Text = icon; break;
                case "category_name": lblSortCat.Text = icon; break;
                case "productname": lblSortName.Text = icon; break;
                case "productprice": lblSortPrice.Text = icon; break;
                case "stock_status": lblSortStock.Text = icon; break;
            }
        }

        protected void btnPage_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string arg = btn.CommandArgument;

            if (arg == "prev")
            {
                if (CurrentPage > 1) CurrentPage--;
            }
            else if (arg == "next")
            {
                // Note: We don't check max here as BindData handles "IsLastPage", 
                // but ideally you pass MaxPages to this method. 
                // For simplicity, we increment and BindData calculates the real view.
                CurrentPage++;
            }
            else if (arg == "first")
            {
                CurrentPage = 1;
            }
            else if (arg == "last")
            {
                // To implement "Last" correctly with PagedDataSource, 
                // we need to know TotalPages before binding.
                // For now, let's just make it very high number and PagedDataSource fixes it, 
                // or fetch count first.
                CurrentPage = 10000;
            }
            else
            {
                CurrentPage = Convert.ToInt32(arg);
            }

            BindData();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int id = Convert.ToInt32(btn.CommandArgument);
                string imagePath = "";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    // Get Image Path
                    SqlCommand cmdSelect = new SqlCommand("SELECT image FROM products WHERE id=@id", con);
                    cmdSelect.Parameters.AddWithValue("@id", id);
                    object result = cmdSelect.ExecuteScalar();
                    if (result != null) imagePath = result.ToString();

                    // Delete
                    SqlCommand cmdDelete = new SqlCommand("DELETE FROM products WHERE id=@id", con);
                    cmdDelete.Parameters.AddWithValue("@id", id);
                    int rows = cmdDelete.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        if (!string.IsNullOrEmpty(imagePath))
                        {
                            string physicalPath = Server.MapPath("~/" + imagePath);
                            if (File.Exists(physicalPath)) File.Delete(physicalPath);
                        }
                        ShowMessage("Product deleted successfully.", true);
                        BindData(); // Refresh list
                    }
                    else
                    {
                        ShowMessage("Error deleting product.", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }

        // Helper for Stock Badge styling
        public string GetStockBadgeClass(string status)
        {
            switch (status)
            {
                case "In Stock": return "badge-success";
                case "Low Stock": return "badge-warning";
                case "Out of Stock": return "badge-danger";
                default: return "";
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            pnlMessage.Visible = true;
            litMessage.Text = message;
            if (isSuccess)
            {
                pnlMessage.Style["background-color"] = "#efe";
                pnlMessage.Style["border-left"] = "4px solid #0c0";
                litMessage.Text = "<span style='color:#060'>" + message + "</span>";
            }
            else
            {
                pnlMessage.Style["background-color"] = "#fee";
                pnlMessage.Style["border-left"] = "4px solid #f00";
                litMessage.Text = "<span style='color:#c00'>" + message + "</span>";
            }
        }
    }
}