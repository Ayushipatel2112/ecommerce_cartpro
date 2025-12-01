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
    public partial class update_profile : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Check Login
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            // 2. Load Data only on first page load (Not on button click)
            if (!IsPostBack)
            {
                LoadCurrentProfile();
            }
        }

        private void LoadCurrentProfile()
        {
            string currentEmail = Session["AdminEmail"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Fetching data from [admin] table
                string query = "SELECT name, email FROM [user] WHERE email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", currentEmail);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtUsername.Text = reader["name"].ToString();
                        txtEmail.Text = reader["email"].ToString();
                    }
                    con.Close();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string newName = txtUsername.Text.Trim();
            string newEmail = txtEmail.Text.Trim();
            string oldEmail = Session["AdminEmail"].ToString(); // Need this to identify WHICH user to update

            if (string.IsNullOrEmpty(newName) || string.IsNullOrEmpty(newEmail))
            {
                TriggerPopup("Please fill all fields.", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Update Query
                string query = "UPDATE [user] SET name = @NewName, email = @NewEmail WHERE email = @OldEmail";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@NewName", newName);
                    cmd.Parameters.AddWithValue("@NewEmail", newEmail);
                    cmd.Parameters.AddWithValue("@OldEmail", oldEmail);

                    try
                    {
                        con.Open();
                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            // Important: If email changed, update the Session
                            Session["AdminEmail"] = newEmail;

                            TriggerPopup("Profile updated successfully!", false);
                        }
                        else
                        {
                            TriggerPopup("Update failed. User not found.", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        TriggerPopup("Error: " + ex.Message.Replace("'", ""), true);
                    }
                }
            }
        }

        // Helper function to call JavaScript from C#
        private void TriggerPopup(string message, bool isError)
        {
            string jsBool = isError ? "true" : "false";

            // CHANGE: Hum script ko 'window.onload' ke andar daal rahe hain
            // Isse script tabhi chalega jab pura page load ho chuka hoga
            string script = $@"
        window.onload = function() {{
            showPopup('{message}', {jsBool});
        }};";

            ClientScript.RegisterStartupScript(this.GetType(), "PopupScript", script, true);
        }
    }
}