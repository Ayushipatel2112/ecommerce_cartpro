using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Xml.Linq;

namespace CartProWebApp
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
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

                        // ✔ Show JavaScript alert + redirect
                        string script =
                            "alert('Registration Successful!'); window.location='Login.aspx';";

                        ScriptManager.RegisterStartupScript(
                            this,
                            this.GetType(),
                            "successMessage",
                            script,
                            true
                        );
                    }
                    catch (Exception ex)
                    {
                        string script =
                            "alert('Error: " + ex.Message.Replace("'", "") + "');";

                        ScriptManager.RegisterStartupScript(
                            this,
                            this.GetType(),
                            "errorMessage",
                            script,
                            true
                        );
                    }
                }
            }
        }

    }

}




