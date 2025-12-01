using System;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Data.SqlClient;

namespace CartProWebApp.admin
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // If already logged in, redirect to Dashboard
                if (Session["AdminEmail"] != null)
                {
                    Response.Redirect("index.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // --- Database Check ---
            string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                // FIX: Changed table from [admin] to [user]
                // We check if the input matches either 'name' OR 'email'
                string query = "SELECT COUNT(1) FROM [user] WHERE (name = @User OR email = @User) AND password = @Pass";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@User", username);
                    cmd.Parameters.AddWithValue("@Pass", password);

                    try
                    {
                        con.Open();
                        int count = (int)cmd.ExecuteScalar();

                        if (count >= 1)
                        {
                            // Login Successful
                            Session["AdminEmail"] = username;

                            // Redirect to Dashboard (index.aspx)
                            Response.Redirect("index.aspx");
                        }
                        else
                        {
                            // Login Failed
                            lblMessage.Text = "Invalid Username or Password.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Database Error: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}