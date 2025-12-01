using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CartProWebApp
{
    public partial class product_details : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;
        int productId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // URL se ID lena (e.g. product_details.aspx?id=5)
            if (Request.QueryString["id"] != null)
            {
                productId = Convert.ToInt32(Request.QueryString["id"]);
            }
            else
            {
                Response.Redirect("Shop.aspx"); // Agar ID nahi hai to wapis shop pe bhejo
            }

            if (!IsPostBack)
            {
                BindProductDetails();
                BindReviews();
            }
        }

        // --- 1. Product Details Fetch Karna ---
        private void BindProductDetails()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Join Product with Category and Ratings (Average)
                string query = @"
                    SELECT p.*, c.category_name,
                           ISNULL((SELECT AVG(CAST(rating AS FLOAT)) FROM product_ratings WHERE product_id = p.id), 0) as avg_rating,
                           ISNULL((SELECT COUNT(*) FROM product_ratings WHERE product_id = p.id), 0) as total_ratings
                    FROM products p
                    LEFT JOIN categories c ON p.catid = c.id
                    WHERE p.id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", productId);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        lblProductName.Text = rdr["productname"].ToString();
                        lblPrice.Text = "₹" + rdr["productprice"].ToString();
                        lblDescription.Text = rdr["productdescription"].ToString();
                        lblCategory.Text = rdr["category_name"].ToString();
                        lblStockStatus.Text = rdr["stock_status"].ToString();

                        // Image Handling
                        string imgPath = rdr["image"].ToString();
                        if (string.IsNullOrEmpty(imgPath)) imgPath = "admin/images/no-image.png";
                        else if (!imgPath.ToLower().Contains("admin/")) imgPath = "admin/" + imgPath;

                        imgProduct.ImageUrl = imgPath;

                        // Star Ratings Show Karna
                        double avgRating = Convert.ToDouble(rdr["avg_rating"]);
                        int totalReviews = Convert.ToInt32(rdr["total_ratings"]);
                        litStars.Text = GenerateStars(avgRating) + $" <small>({totalReviews} Reviews)</small>";
                    }
                    else
                    {
                        Response.Redirect("Shop.aspx"); // Product not found
                    }
                }
            }
        }

        // --- 2. Reviews Fetch Karna ---
        private void BindReviews()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM product_ratings WHERE product_id = @Id ORDER BY created_at DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", productId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptReviews.DataSource = dt;
                            rptReviews.DataBind();
                        }
                        else
                        {
                            lblNoReviews.Visible = true;
                        }
                    }
                }
            }
        }

        // --- 3. Add to Cart Logic (With Quantity) ---
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int quantity = 1;
            int.TryParse(txtQuantity.Text, out quantity);
            if (quantity < 1) quantity = 1;

            DataTable dtCart;
            if (Session["Cart"] == null)
            {
                dtCart = new DataTable();
                dtCart.Columns.Add("id", typeof(int));
                dtCart.Columns.Add("quantity", typeof(int));
            }
            else
            {
                dtCart = (DataTable)Session["Cart"];
            }

            // Check if product exists
            DataRow[] existingRows = dtCart.Select("id=" + productId);
            if (existingRows.Length > 0)
            {
                // Increase quantity
                int currentQty = Convert.ToInt32(existingRows[0]["quantity"]);
                existingRows[0]["quantity"] = currentQty + quantity;
            }
            else
            {
                // Add new row
                DataRow dr = dtCart.NewRow();
                dr["id"] = productId;
                dr["quantity"] = quantity;
                dtCart.Rows.Add(dr);
            }

            Session["Cart"] = dtCart;

            // Update Master Badge
            if (this.Master is SiteMaster)
            {
                ((SiteMaster)this.Master).UpdateCartCount();
            }

            lblMessage.Visible = true;
            lblMessage.Text = "Added to cart successfully!";
        }

        // --- Helper: Generate Main Stars ---
        private string GenerateStars(double rating)
        {
            string stars = "";
            int fullStars = (int)Math.Floor(rating);
            bool hasHalfStar = (rating - fullStars) >= 0.5;

            for (int i = 0; i < fullStars; i++) stars += "<i class='fas fa-star text-warning'></i>";
            if (hasHalfStar && fullStars < 5) { stars += "<i class='fas fa-star-half-alt text-warning'></i>"; fullStars++; }
            for (int i = fullStars; i < 5; i++) stars += "<i class='far fa-star text-warning'></i>";

            return stars;
        }

        // --- Helper: Generate Review Stars (For Repeater) ---
        public string GetReviewStars(object ratingObj)
        {
            int rating = Convert.ToInt32(ratingObj);
            string stars = "";
            for (int i = 0; i < rating; i++) stars += "<i class='fas fa-star'></i>";
            for (int i = rating; i < 5; i++) stars += "<i class='far fa-star'></i>";
            return stars;
        }
    }
}