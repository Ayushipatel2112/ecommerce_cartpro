using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace CartProWebApp.admin
{
    public partial class product_edit : System.Web.UI.Page
    {
        // Connection string from Web.config
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Session Check (Redirect to login if not logged in)
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCategories();
                LoadProductData();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT id, category_name FROM categories ORDER BY category_name";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlCategory.DataSource = reader;
                        ddlCategory.DataBind();
                    }
                }
            }
            // Insert default option
            ddlCategory.Items.Insert(0, new ListItem("Select Category", ""));
        }

        private void LoadProductData()
        {
            int id = 0;
            // Get ID from URL
            if (int.TryParse(Request.QueryString["id"], out id) && id > 0)
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT * FROM products WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate TextFields
                                txtName.Text = reader["productname"].ToString();
                                txtPrice.Text = reader["productprice"].ToString();
                                txtDescription.Text = reader["productdescription"].ToString();

                                // Set Dropdowns
                                string catId = reader["catid"].ToString();
                                if (ddlCategory.Items.FindByValue(catId) != null)
                                    ddlCategory.SelectedValue = catId;

                                string stockStatus = reader["stock_status"].ToString();
                                if (ddlStockStatus.Items.FindByValue(stockStatus) != null)
                                    ddlStockStatus.SelectedValue = stockStatus;

                                // Handle Image Preview
                                string imgPath = reader["image"].ToString();
                                if (!string.IsNullOrEmpty(imgPath))
                                {
                                    divCurrentImage.Visible = true;
                                    imgCurrent.ImageUrl = "~/" + imgPath;
                                    hfCurrentImagePath.Value = imgPath; // Store DB path in hidden field
                                }
                            }
                            else
                            {
                                // Product ID not found in DB
                                Response.Redirect("product.aspx?msg=" + Server.UrlEncode("Product not found."));
                            }
                        }
                    }
                }
            }
            else
            {
                // Invalid or missing ID
                Response.Redirect("product.aspx?msg=" + Server.UrlEncode("Invalid product ID."));
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Reset messages
            pnlError.Visible = false;
            pnlSuccess.Visible = false;

            int id = 0;
            if (!int.TryParse(Request.QueryString["id"], out id) || id <= 0)
            {
                ShowError("Invalid Product ID.");
                return;
            }

            // Get Inputs
            string name = txtName.Text.Trim();
            string catId = ddlCategory.SelectedValue;
            string priceStr = txtPrice.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string stockStatus = ddlStockStatus.SelectedValue;

            // Validation
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(catId) || string.IsNullOrEmpty(priceStr))
            {
                ShowError("All required fields must be filled.");
                return;
            }

            decimal price;
            if (!decimal.TryParse(priceStr, out price) || price <= 0)
            {
                ShowError("Price must be a valid positive number.");
                return;
            }

            // --- Image Upload Logic ---
            string finalImagePath = hfCurrentImagePath.Value; // Default to existing image
            bool isNewImageUploaded = false;

            if (fuImage.HasFile)
            {
                string fileExt = Path.GetExtension(fuImage.FileName).ToLower();
                string[] allowedExts = { ".jpg", ".jpeg", ".png", ".gif", ".webp", ".avif", ".svg" };

                // Size Check (5MB = 5 * 1024 * 1024)
                if (fuImage.PostedFile.ContentLength > 5242880)
                {
                    ShowError("Image file size must be less than 5MB.");
                    return;
                }

                if (Array.Exists(allowedExts, element => element == fileExt))
                {
                    try
                    {
                        // Save path: matches your 'product_add' logic
                        string folderPath = Server.MapPath("images/products/");

                        // Create directory if it doesn't exist
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        // Generate unique filename
                        string newFileName = "prod_" + DateTime.Now.Ticks + "_" + Guid.NewGuid().ToString().Substring(0, 4) + fileExt;
                        string savePath = Path.Combine(folderPath, newFileName);

                        // Upload
                        fuImage.SaveAs(savePath);

                        // Set new DB path
                        finalImagePath = "images/products/" + newFileName;
                        isNewImageUploaded = true;
                    }
                    catch (Exception ex)
                    {
                        ShowError("Failed to upload image: " + ex.Message);
                        return;
                    }
                }
                else
                {
                    ShowError("Invalid image type. Allowed: JPG, JPEG, PNG, GIF, WEBP.");
                    return;
                }
            }

            // --- Database Update ---
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE products 
                                     SET catid = @catid, 
                                         productname = @name, 
                                         productdescription = @desc, 
                                         productprice = @price, 
                                         image = @image, 
                                         stock_status = @stock 
                                     WHERE id = @id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@catid", catId);
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@desc", desc);
                        cmd.Parameters.AddWithValue("@price", price);
                        cmd.Parameters.AddWithValue("@image", finalImagePath);
                        cmd.Parameters.AddWithValue("@stock", stockStatus);
                        cmd.Parameters.AddWithValue("@id", id);

                        con.Open();
                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            // Delete old image only if a new one was uploaded AND an old one existed
                            if (isNewImageUploaded && !string.IsNullOrEmpty(hfCurrentImagePath.Value))
                            {
                                string oldPhysicalPath = Server.MapPath("~/" + hfCurrentImagePath.Value);
                                if (File.Exists(oldPhysicalPath))
                                {
                                    try { File.Delete(oldPhysicalPath); } catch { }
                                }
                            }

                            // Redirect on success
                            Response.Redirect("product.aspx?msg=" + Server.UrlEncode("Product updated successfully!"));
                        }
                        else
                        {
                            ShowError("Error: Product could not be updated.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Database Error: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            lblError.Text = message;
        }
    }
}