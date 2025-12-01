using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace CartProWebApp.admin
{
    public partial class category_edit : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Auth Check (matches category.aspx)
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id;
                    if (int.TryParse(Request.QueryString["id"], out id))
                    {
                        // 2. Store ID in ViewState to persist across button clicks
                        ViewState["SelectedCatId"] = id;
                        LoadCategoryData(id);
                    }
                    else
                    {
                        Response.Redirect("category.aspx?msg=Invalid ID");
                    }
                }
                else
                {
                    Response.Redirect("category.aspx?msg=No ID Provided");
                }
            }
        }

        private void LoadCategoryData(int id)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "SELECT category_name, category_description, image FROM categories WHERE id = @id";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtName.Text = reader["category_name"].ToString();
                    txtDescription.Text = reader["category_description"].ToString();

                    string imgPath = reader["image"].ToString();

                    // Store the current path so we can use it if the user DOESN'T upload a new one
                    if (hfOldImagePath != null) hfOldImagePath.Value = imgPath;

                    if (!string.IsNullOrEmpty(imgPath))
                    {
                        imgPreview.ImageUrl = "~/" + imgPath;
                        divCurrentImage.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("category.aspx?msg=Category not found");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // 3. Get ID from ViewState
            if (ViewState["SelectedCatId"] == null)
            {
                Response.Redirect("category.aspx?msg=Session Expired");
                return;
            }

            int id = Convert.ToInt32(ViewState["SelectedCatId"]);
            string name = txtName.Text.Trim();
            string description = txtDescription.Text.Trim();
            string imagePath = hfOldImagePath.Value; // Default to old image

            if (string.IsNullOrEmpty(name))
            {
                lblError.Text = "Category name is required.";
                pnlError.Visible = true;
                return;
            }

            // --- IMAGE SAVING LOGIC ---
            if (fileImage.HasFile)
            {
                string fileExt = Path.GetExtension(fileImage.FileName).ToLower();
                string[] allowed = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
                bool isValid = false;
                foreach (string ext in allowed) { if (fileExt == ext) isValid = true; }

                if (isValid)
                {
                    // MapPath finds the physical folder on your hard drive (e.g., C:\Projects\CartPro\images\categories\)
                    string uploadFolder = Server.MapPath("images/categories/");

                    // Safety: Create folder if it doesn't exist
                    if (!Directory.Exists(uploadFolder))
                    {
                        Directory.CreateDirectory(uploadFolder);
                    }

                    // Optional: Delete the OLD image to save space
                    if (!string.IsNullOrEmpty(hfOldImagePath.Value))
                    {
                        try
                        {
                            string oldPhysicalPath = Server.MapPath("~/" + hfOldImagePath.Value);
                            if (File.Exists(oldPhysicalPath)) File.Delete(oldPhysicalPath);
                        }
                        catch { /* Ignore errors if file is already gone */ }
                    }

                    // Create unique name
                    string newFileName = "cat_" + DateTime.Now.Ticks + fileExt;
                    string fullSavePath = Path.Combine(uploadFolder, newFileName);

                    // SAVE THE FILE
                    try
                    {
                        fileImage.SaveAs(fullSavePath);
                        // Update the path string for the database
                        imagePath = "images/categories/" + newFileName;
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = "Error saving file: " + ex.Message;
                        pnlError.Visible = true;
                        return;
                    }
                }
                else
                {
                    lblError.Text = "Invalid image type. Only JPG, PNG, GIF allowed.";
                    pnlError.Visible = true;
                    return;
                }
            }

            // --- DATABASE UPDATE ---
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "UPDATE categories SET category_name=@name, category_description=@desc, image=@img WHERE id=@id";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@desc", string.IsNullOrEmpty(description) ? (object)DBNull.Value : description);
                cmd.Parameters.AddWithValue("@img", imagePath); // Will be new path OR old path
                cmd.Parameters.AddWithValue("@id", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("category.aspx?msg=Updated Successfully");
        }
    }
}