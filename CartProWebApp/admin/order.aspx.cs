using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text; // Required for StringBuilder (Export)

namespace CartProWebApp.admin
{
    public partial class orders : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["msg"] != null)
                {
                    pnlMessage.Visible = true;
                    litMessage.Text = Request.QueryString["msg"];
                }
                BindOrders();
            }
        }

        private void BindOrders()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // FIX: Changed 'users' to '[user]' to match your database table name
                string query = @"SELECT 
                                    o.id,
                                    o.user_id,
                                    o.date,
                                    o.total_amount,
                                    o.payment,
                                    o.status,
                                    ISNULL(u.name, 'N/A') as customer_name,
                                    ISNULL(u.email, '') as customer_email
                                  FROM orders o
                                  LEFT JOIN [user] u ON o.user_id = u.id
                                  WHERE 1=1";

                List<SqlParameter> parameters = new List<SqlParameter>();

                // --- Apply Status Filter ---
                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                {
                    query += " AND o.status = @status";
                    parameters.Add(new SqlParameter("@status", ddlStatus.SelectedValue));
                    btnClear.Visible = true;
                }

                // --- Apply Date Filter ---
                if (!string.IsNullOrEmpty(txtDate.Text))
                {
                    query += " AND CAST(o.date AS DATE) = @date";
                    parameters.Add(new SqlParameter("@date", txtDate.Text));
                    btnClear.Visible = true;
                }

                query += " ORDER BY o.id DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters.Count > 0)
                    {
                        cmd.Parameters.AddRange(parameters.ToArray());
                    }

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt); // The error was happening here

                        if (dt.Rows.Count > 0)
                        {
                            rptOrders.DataSource = dt;
                            rptOrders.DataBind();
                            pnlNoData.Visible = false;

                            // Store for Export
                            ViewState["OrdersTable"] = dt;
                        }
                        else
                        {
                            rptOrders.DataSource = null;
                            rptOrders.DataBind();
                            pnlNoData.Visible = true;
                            ViewState["OrdersTable"] = null;
                        }
                    }
                }
            }
        }

        // --- Filter Events ---
        protected void Filter_Changed(object sender, EventArgs e)
        {
            BindOrders();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            txtDate.Text = string.Empty;
            btnClear.Visible = false;
            BindOrders();
        }

        // --- Delete Event ---
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int orderId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM orders WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", orderId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            BindOrders();
        }

        // --- Export to CSV Event ---
        protected void btnExport_Click(object sender, EventArgs e)
        {
            DataTable dt = ViewState["OrdersTable"] as DataTable;
            if (dt != null && dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("Order ID,Customer,Email,Date,Total,Payment,Status");

                foreach (DataRow row in dt.Rows)
                {
                    string dateStr = Convert.ToDateTime(row["date"]).ToString("MMM dd yyyy");
                    string line = String.Format("{0},\"{1}\",\"{2}\",{3},{4},{5},{6}",
                        row["id"],
                        row["customer_name"],
                        row["customer_email"],
                        dateStr,
                        row["total_amount"],
                        row["payment"],
                        row["status"]);
                    sb.AppendLine(line);
                }

                Response.Clear();
                Response.ContentType = "text/csv";
                Response.AddHeader("Content-Disposition", "attachment;filename=orders_" + DateTime.Now.Ticks + ".csv");
                Response.Write(sb.ToString());
                Response.End();
            }
        }

        // --- Helper Methods ---
        protected string UppercaseFirst(string s)
        {
            if (string.IsNullOrEmpty(s)) return string.Empty;
            return char.ToUpper(s[0]) + s.Substring(1);
        }

        protected string GetStatusBadgeClass(string status)
        {
            switch (status.ToLower())
            {
                case "delivered": return "success";
                case "cancelled": return "danger";
                case "shipped": return "info";
                case "processing": return "primary";
                case "pending": return "warning";
                default: return "warning";
            }
        }
    }
}