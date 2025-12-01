using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace CartProWebApp.admin
{
    public partial class forgot_password : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // === STEP 1: CHECK IF EMAIL EXISTS ===
        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            using (SqlConnection con = new SqlConnection(cs))
            {
                // FIX: Table name changed to [user]
                string query = "SELECT COUNT(1) FROM [user] WHERE email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);

                    try
                    {
                        con.Open();
                        int count = (int)cmd.ExecuteScalar();

                        if (count > 0)
                        {
                            ViewState["ResetEmail"] = email;
                            pnlVerifyEmail.Visible = false;
                            pnlResetPass.Visible = true;
                            lblMessage.Text = "Email verified! Please enter a new password.";
                            lblMessage.ForeColor = Color.Green;
                        }
                        else
                        {
                            lblMessage.Text = "Email address not found in our system.";
                            lblMessage.ForeColor = Color.Red;
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                }
            }
        }

        // === STEP 2: UPDATE PASSWORD ===
        protected void btnReset_Click(object sender, EventArgs e)
        {
            string newPass = txtNewPass.Text.Trim();
            string confirmPass = txtConfirmPass.Text.Trim();
            string email = ViewState["ResetEmail"] as string;

            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("forgot_password.aspx");
                return;
            }

            if (newPass != confirmPass)
            {
                lblMessage.Text = "New passwords do not match.";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                // FIX: Table name changed to [user]
                string query = "UPDATE [user] SET password = @Password WHERE email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Password", newPass);
                    cmd.Parameters.AddWithValue("@Email", email);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();

                        string script = "alert('Password reset successfully! Login with new password.'); window.location='Login.aspx';";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessScript", script, true);
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error updating password: " + ex.Message;
                        lblMessage.ForeColor = Color.Red;
                    }
                }
            }
        }
    }
}