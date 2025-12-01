using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; // Database ke liye zaroori
using System.Configuration;  // Connection String ke liye zaroori

namespace CartProWebApp.admin
{
    public partial class myprofile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Check karein user logged in hai ya nahi
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            // 2. Agar page pehli baar load ho raha hai toh data layein
            if (!IsPostBack)
            {
                FetchProfileData();
            }
        }

        private void FetchProfileData()
        {
            string adminEmail = Session["AdminEmail"].ToString();

            // Connection String fetch karein Web.config se
            string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Query: Email match karke Name aur Email layein
                // [admin] table use kar rahe hain
                string query = "SELECT name, email FROM [user] WHERE email = @Email OR name = @Email";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", adminEmail);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // Database se data nikal kar Labels me set karein
                            lblUsername.Text = reader["name"].ToString();
                            lblEmail.Text = reader["email"].ToString();
                        }
                        else
                        {
                            lblMessage.Text = "User details not found.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error fetching profile: " + ex.Message;
                    }
                }
            }
        }
    }
}