using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CartProWebApp.admin
{
    // CLASS NAME MATCHES FILE NAME
    public partial class inventory_management : System.Web.UI.Page
    {
        protected int lowStockCount = 0;
        protected int outOfStockCount = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                LoadInventoryData();
            }
        }

        private void LoadInventoryData()
        {
            string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Matches your DB columns
                string query = "SELECT id, productname, productprice, image, stock_status FROM products";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        CalculateStockCounts(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptInventory.DataSource = dt;
                            rptInventory.DataBind();
                        }
                        else
                        {
                            lblNoData.Visible = true;
                        }
                    }
                }
            }
        }

        private void CalculateStockCounts(DataTable dt)
        {
            lowStockCount = 0;
            outOfStockCount = 0;

            foreach (DataRow row in dt.Rows)
            {
                // Safely convert to string before checking
                string status = Convert.ToString(row["stock_status"]).Trim();

                if (status.Equals("Out of Stock", StringComparison.OrdinalIgnoreCase))
                {
                    outOfStockCount++;
                }
                else if (status.Equals("Low Stock", StringComparison.OrdinalIgnoreCase))
                {
                    lowStockCount++;
                }
            }

            lblLowStockCount.Text = lowStockCount.ToString();
            lblOutOfStockCount.Text = outOfStockCount.ToString();
        }

        // Helper Method: Must be protected or public to be seen by ASPX
        protected string GetStatusBadge(string status)
        {
            if (string.IsNullOrEmpty(status))
                return "<span class='badge badge-secondary'>Unknown</span>";

            status = status.Trim();

            if (status.Equals("Out of Stock", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='badge badge-danger'>Out of Stock</span>";
            }
            else if (status.Equals("Low Stock", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='badge badge-warning'>Low Stock</span>";
            }
            else
            {
                return "<span class='badge badge-success'>In Stock</span>";
            }
        }
    }
}