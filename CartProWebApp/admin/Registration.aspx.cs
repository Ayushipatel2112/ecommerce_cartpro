using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace CartProWebApp.admin
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Ensure your HTML TextBoxes are ID="txtUsername", ID="txtEmail", ID="txtPassword"
            string name = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                // FIX 3: Changed table from [user] to [admin]
                // Also kept [create at] and GETDATE() to prevent date errors
                string query = "INSERT INTO [user] (name, email, password, [create at]) VALUES (@name, @email, @password, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@password", password);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();

                        // FIX 4: Used ClientScript for reliable alert and redirect
                        string script = "alert('Admin Registration Successful!'); window.location='Login.aspx';";
                        ClientScript.RegisterStartupScript(this.GetType(), "successMessage", script, true);
                    }
                    catch (Exception ex)
                    {
                        // Instead of ClientScript, show it on the label
                        lblMessage.Text = "Error: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}