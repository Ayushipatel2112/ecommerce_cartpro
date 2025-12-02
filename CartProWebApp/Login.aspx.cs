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
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                // 1. CHANGE QUERY: Don't just Count, actually SELECT the ID and Email
                string query = "SELECT id, email FROM [user] WHERE email = @Email AND password = @Password";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    con.Open();

                    // 2. Use ExecuteReader to get the data
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            // --- CRITICAL FIX START ---
                            // Store the User ID in Session so Shop.aspx knows who is adding to cart
                            Session["UserId"] = rdr["id"].ToString();
                            Session["User"] = rdr["email"].ToString();
                            // --- CRITICAL FIX END ---

                            // 3. Redirect back to Shop or Cart
                            Response.Redirect("cart.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid email or password.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
        }
    }
}
