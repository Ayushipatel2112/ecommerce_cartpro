using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace CartProWebApp.admin
{
    public partial class product_add : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                BindCategories();
            }
        }

        private void BindCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT id, category_name FROM categories", con);
                ddlCategory.DataSource = cmd.ExecuteReader();
                ddlCategory.DataTextField = "category_name";
                ddlCategory.DataValueField = "id";
                ddlCategory.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Handle Image Upload
                string imagePath = "";
                if (fileImage.HasFile)
                {
                    // Create unique filename
                    string fileName = DateTime.Now.Ticks + "_" + fileImage.FileName;

                    // CHANGE: Path updated to 'images/products'
                    string folderPath = Server.MapPath("images/products/");

                    // Create folder if it doesn't exist
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    // Save file
                    fileImage.SaveAs(folderPath + fileName);

                    // CHANGE: Database path updated
                    imagePath = "images/products/" + fileName;
                }

                // 2. Insert into Database
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "INSERT INTO products (catid, productname, productdescription, productprice, image, stock_status) VALUES (@cat, @name, @desc, @price, @img, @stock)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@cat", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@name", txtName.Text);
                    cmd.Parameters.AddWithValue("@desc", txtDescription.Text);
                    cmd.Parameters.AddWithValue("@price", txtPrice.Text);
                    cmd.Parameters.AddWithValue("@img", imagePath);
                    cmd.Parameters.AddWithValue("@stock", ddlStockStatus.SelectedValue);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // 3. Redirect
                Response.Redirect("product.aspx?msg=Product Added Successfully");
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}