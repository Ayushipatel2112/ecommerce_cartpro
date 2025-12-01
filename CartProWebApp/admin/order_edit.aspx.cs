using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace CartProWebApp.admin
{
    // Make sure class name is exactly 'order_edit'
    public partial class order_edit : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null) Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                BindCustomers();

                if (Request.QueryString["id"] != null)
                {
                    LoadOrderData(Request.QueryString["id"]);
                }
                else
                {
                    Response.Redirect("order.aspx");
                }
            }
        }

        private void BindCustomers()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Using [user] singular
                SqlCommand cmd = new SqlCommand("SELECT id, email FROM [user] ORDER BY email", con);
                con.Open();
                ddlCustomer.DataSource = cmd.ExecuteReader();
                ddlCustomer.DataTextField = "email";
                ddlCustomer.DataValueField = "id";
                ddlCustomer.DataBind();
            }
        }

        private void LoadOrderData(string id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM orders WHERE id = @id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    if (ddlCustomer.Items.FindByValue(rdr["user_id"].ToString()) != null)
                        ddlCustomer.SelectedValue = rdr["user_id"].ToString();

                    txtDate.Text = Convert.ToDateTime(rdr["date"]).ToString("yyyy-MM-ddTHH:mm");
                    txtTotal.Text = rdr["total_amount"].ToString();
                    ddlPayment.SelectedValue = rdr["payment"].ToString();
                    ddlStatus.SelectedValue = rdr["status"].ToString();
                }
                else
                {
                    Response.Redirect("order.aspx?msg=Order not found");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE orders SET user_id=@uid, date=@date, total_amount=@total, payment=@pay, status=@stat WHERE id=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@uid", ddlCustomer.SelectedValue);
                cmd.Parameters.AddWithValue("@date", DateTime.Parse(txtDate.Text));
                cmd.Parameters.AddWithValue("@total", txtTotal.Text);
                cmd.Parameters.AddWithValue("@pay", ddlPayment.SelectedValue);
                cmd.Parameters.AddWithValue("@stat", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("order.aspx?msg=Order updated successfully");
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