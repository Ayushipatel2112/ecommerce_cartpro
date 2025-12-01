using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CartProWebApp.admin
{
    public partial class order_delete : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null) Response.Redirect("Login.aspx");

            if (Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                DeleteOrder(id);
            }
            else
            {
                Response.Redirect("order.aspx");
            }
        }

        private void DeleteOrder(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM orders WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", id);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("order.aspx?msg=Order deleted successfully");
                }
                catch
                {
                    Response.Redirect("order.aspx?msg=Error deleting order");
                }
            }
        }
    }
}