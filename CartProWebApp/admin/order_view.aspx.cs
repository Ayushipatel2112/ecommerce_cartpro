using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CartProWebApp.admin
{
    public partial class order_view : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null) Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    LoadDetails(Request.QueryString["id"]);
                    lnkEdit.NavigateUrl = "order_edit.aspx?id=" + Request.QueryString["id"];
                }
                else
                {
                    Response.Redirect("orders.aspx");
                }
            }
        }

        private void LoadDetails(string id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // FIX: I removed "u.phone" from this query.
                // It now only selects name and email.
                string query = @"SELECT o.*, 
                                 ISNULL(u.name, 'N/A') as cust_name, 
                                 ISNULL(u.email, 'N/A') as cust_email
                                 FROM orders o 
                                 LEFT JOIN [user] u ON o.user_id = u.id 
                                 WHERE o.id = @id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    lblHeaderId.Text = rdr["id"].ToString();
                    lblOrderId.Text = rdr["id"].ToString();
                    lblDate.Text = Convert.ToDateTime(rdr["date"]).ToString("MMM dd, yyyy HH:mm");
                    lblTotal.Text = Convert.ToDecimal(rdr["total_amount"]).ToString("N2");

                    lblPayment.Text = UppercaseFirst(rdr["payment"].ToString());
                    lblStatus.Text = UppercaseFirst(rdr["status"].ToString());

                    lblCustName.Text = rdr["cust_name"].ToString();
                    lblCustEmail.Text = rdr["cust_email"].ToString();

                    // FIX: Since there is no phone column, we just show "N/A" (Not Available)
                    lblCustPhone.Text = "N/A";
                }
                else
                {
                    Response.Redirect("orders.aspx?msg=Order not found");
                }
            }
        }

        protected string UppercaseFirst(string s)
        {
            if (string.IsNullOrEmpty(s)) return string.Empty;
            return char.ToUpper(s[0]) + s.Substring(1);
        }
    }
}