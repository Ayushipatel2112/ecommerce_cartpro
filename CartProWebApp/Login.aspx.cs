using System;
using System.Web.UI;
using System.Configuration;
using System.Data.SqlClient;
namespace CartProWebApp
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["msg"] == "registered")
            {
                lblMessage.Text = "Registration successfully. Please login.";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(1) FROM [user] WHERE email = @Email AND password = @Password";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    con.Open();
                    int count = (int)cmd.ExecuteScalar();

                    if (count == 1)
                    {
                        Response.Redirect("Cart.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid email or password.";
                    }
                }
            }
        }
    }
}
