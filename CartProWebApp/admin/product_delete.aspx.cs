using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace CartProWebApp.admin
{
    public partial class product_delete : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Session Check
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // 2. Get Product ID from URL
            int id = 0;
            if (int.TryParse(Request.QueryString["id"], out id) && id > 0)
            {
                ProcessDelete(id);
            }
            else
            {
                Response.Redirect("product.aspx?msg=" + Server.UrlEncode("Invalid product ID."));
            }
        }

        private void ProcessDelete(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Start a Database Transaction
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    string imagePath = "";
                    string productName = "";

                    // Step A: Fetch Product Details (to get image path & name)
                    string selectQuery = "SELECT productname, image FROM products WHERE id = @id";
                    using (SqlCommand cmdSelect = new SqlCommand(selectQuery, con, transaction))
                    {
                        cmdSelect.Parameters.AddWithValue("@id", id);

                        using (SqlDataReader reader = cmdSelect.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                productName = reader["productname"].ToString();
                                imagePath = reader["image"].ToString();
                            }
                            else
                            {
                                // Product not found
                                reader.Close();
                                transaction.Rollback();
                                Response.Redirect("product.aspx?msg=" + Server.UrlEncode("Product not found."));
                                return;
                            }
                        }
                    }

                    // Step B: Delete from Database
                    string deleteQuery = "DELETE FROM products WHERE id = @id";
                    using (SqlCommand cmdDelete = new SqlCommand(deleteQuery, con, transaction))
                    {
                        cmdDelete.Parameters.AddWithValue("@id", id);
                        cmdDelete.ExecuteNonQuery();
                    }

                    // Step C: Commit Transaction (DB delete successful)
                    transaction.Commit();

                    // Step D: Delete Image File from Server
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        string physicalPath = Server.MapPath("~/" + imagePath);
                        if (File.Exists(physicalPath))
                        {
                            try
                            {
                                File.Delete(physicalPath);
                            }
                            catch
                            {
                                // Optional: Log error, but don't fail the request since DB is already updated
                            }
                        }
                    }

                    // Step E: Redirect Success
                    Response.Redirect("product.aspx?msg=" + Server.UrlEncode("Product \"" + productName + "\" deleted successfully."));
                }
                catch (Exception ex)
                {
                    // Rollback DB changes if anything went wrong
                    transaction.Rollback();
                    Response.Redirect("product.aspx?msg=" + Server.UrlEncode("Error deleting product: " + ex.Message));
                }
            }
        }
    }
}