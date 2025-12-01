using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO; // Required for File Handling

namespace CartProWebApp.admin
{
    public partial class category_add : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string description = txtDescription.Text.Trim();
            string imagePath = ""; // Default empty

            if (string.IsNullOrEmpty(name))
            {
                ShowError("Category Name is required.");
                return;
            }

            // --- 1. Handle Image Upload ---
            if (fuImage.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(fuImage.PostedFile.FileName);
                    string fileExtension = Path.GetExtension(fileName).ToLower();

                    // Validate Extension
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                    if (!allowedExtensions.Contains(fileExtension))
                    {
                        ShowError("Invalid file type. Only JPG, PNG, and GIF allowed.");
                        return;
                    }

                    // Create unique filename to prevent overwriting
                    string uniqueFileName = Guid.NewGuid().ToString() + fileExtension;

                    // Define upload folder path (Ensure this folder exists in your project!)
                    string uploadFolder = Server.MapPath("~/admin/images/categories/");

                    // Create directory if it doesn't exist
                    if (!Directory.Exists(uploadFolder))
                    {
                        Directory.CreateDirectory(uploadFolder);
                    }

                    // Save file
                    string savePath = Path.Combine(uploadFolder, uniqueFileName);
                    fuImage.SaveAs(savePath);

                    // Store relative path in database
                    imagePath = "images/categories/" + uniqueFileName;
                }
                catch (Exception ex)
                {
                    ShowError("Image upload failed: " + ex.Message);
                    return;
                }
            }

            // --- 2. Insert into Database ---
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Using GETDATE() for created_at
                string query = "INSERT INTO categories (category_name, category_description, image, created_at) VALUES (@Name, @Desc, @Img, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Desc", description);
                    cmd.Parameters.AddWithValue("@Img", imagePath); // Can be empty string if no image

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();

                        // Redirect with Success Message
                        Response.Redirect("category.aspx?msg=Category added successfully!");
                    }
                    catch (Exception ex)
                    {
                        ShowError("Database Error: " + ex.Message);
                    }
                }
            }
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            litError.Text = message;
        }
    }
}