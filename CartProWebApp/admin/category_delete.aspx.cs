using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace CartProWebApp.admin
{
    public partial class category_delete : System.Web.UI.Page
    {
        // Get connection string from Web.config
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Check Authentication (Matches your category.aspx logic)
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // 2. Get ID from Query String
            int id = 0;
            if (int.TryParse(Request.QueryString["id"], out id) && id > 0)
            {
                DeleteCategory(id);
            }
            else
            {
                RedirectWithMsg("Category not found or invalid ID.");
            }
        }

        private void DeleteCategory(int id)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                try
                {
                    conn.Open();

                    // A. Fetch the image path first so we can delete the file later
                    string imagePath = null;
                    string sqlSelect = "SELECT image FROM categories WHERE id = @id";

                    using (SqlCommand cmdSelect = new SqlCommand(sqlSelect, conn))
                    {
                        cmdSelect.Parameters.AddWithValue("@id", id);
                        object result = cmdSelect.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            imagePath = result.ToString();
                        }
                        else
                        {
                            // ID does not exist in database
                            RedirectWithMsg("Category not found.");
                            return;
                        }
                    }

                    // B. Delete the record from database
                    string sqlDelete = "DELETE FROM categories WHERE id = @id";
                    using (SqlCommand cmdDelete = new SqlCommand(sqlDelete, conn))
                    {
                        cmdDelete.Parameters.AddWithValue("@id", id);
                        int rowsAffected = cmdDelete.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // C. Delete the physical image file if it exists
                            if (!string.IsNullOrEmpty(imagePath))
                            {
                                // Converts virtual path (e.g., "~/images/cat1.jpg") to physical path
                                string physicalPath = Server.MapPath("~/" + imagePath);

                                if (File.Exists(physicalPath))
                                {
                                    try
                                    {
                                        File.Delete(physicalPath);
                                    }
                                    catch (Exception)
                                    {
                                        // If file is locked or cannot be deleted, we ignore it 
                                        // so the database delete still counts as success.
                                    }
                                }
                            }

                            RedirectWithMsg("Category deleted successfully.");
                        }
                        else
                        {
                            RedirectWithMsg("Error deleting category.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // In a real app, you might log this error to a text file or table
                    RedirectWithMsg("An error occurred: " + ex.Message);
                }
            }
        }

        private void RedirectWithMsg(string message)
        {
            // Redirects back to the list page with the message
            Response.Redirect("category.aspx?msg=" + HttpUtility.UrlEncode(message));
        }
    }
}