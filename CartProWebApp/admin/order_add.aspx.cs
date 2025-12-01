using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace CartProWebApp.admin
{
    public partial class order_add : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null) Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                BindCustomers();
                // Set default date to now formatted for HTML5 datetime-local input
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-ddTHH:mm");
            }
        }

        private void BindCustomers()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // NOTE: Using [user] singular
                SqlCommand cmd = new SqlCommand("SELECT id, email FROM [user] ORDER BY email", con);
                con.Open();
                ddlCustomer.DataSource = cmd.ExecuteReader();
                ddlCustomer.DataTextField = "email";
                ddlCustomer.DataValueField = "id";
                ddlCustomer.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlCustomer.SelectedValue == "" || string.IsNullOrEmpty(txtDate.Text) || string.IsNullOrEmpty(txtTotal.Text))
            {
                pnlError.Visible = true;
                litError.Text = "Please fill all required fields.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "INSERT INTO orders (user_id, date, total_amount, payment, status) VALUES (@uid, @date, @total, @pay, @stat)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@uid", ddlCustomer.SelectedValue);
                cmd.Parameters.AddWithValue("@date", DateTime.Parse(txtDate.Text));
                cmd.Parameters.AddWithValue("@total", txtTotal.Text);
                cmd.Parameters.AddWithValue("@pay", ddlPayment.SelectedValue);
                cmd.Parameters.AddWithValue("@stat", ddlStatus.SelectedValue);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("orders.aspx?msg=Order added successfully");
                }
                catch (Exception ex)
                {
                    pnlError.Visible = true;
                    litError.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}