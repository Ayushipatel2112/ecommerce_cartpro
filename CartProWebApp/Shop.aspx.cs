using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CartProWebApp
{
    public partial class Shop : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProducts();
            }
        }

        private void BindProducts()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT p.*, 
                           ISNULL(r.avg_rating, 0) as avg_rating,
                           ISNULL(r.total_ratings, 0) as total_ratings,
                           c.category_name
                    FROM products p
                    LEFT JOIN categories c ON p.catid = c.id
                    LEFT JOIN (
                        SELECT product_id, AVG(CAST(rating AS FLOAT)) as avg_rating, COUNT(id) as total_ratings
                        FROM product_ratings GROUP BY product_id
                    ) r ON p.id = r.product_id
                    ORDER BY p.id DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            rptProducts.DataSource = dt;
                            rptProducts.DataBind();
                            rptProducts.Visible = true;
                            lblNoProducts.Visible = false;
                        }
                        else
                        {
                            rptProducts.Visible = false;
                            lblNoProducts.Visible = true;
                            lblNoProducts.Text = "<h3>No products found.</h3>";
                        }
                    }
                }
            }
        }

        // --- HANDLERS ---
        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string productId = e.CommandArgument.ToString();

            if (e.CommandName == "ViewDetails")
            {
                ShowProductPopup(productId);
            }
            else if (e.CommandName == "AddToCart")
            {
                AddToCartLogic(productId, 1);
            }
        }

        // --- SHOW POPUP ---
        private void ShowProductPopup(string productId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT p.*, c.category_name 
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
                        lblPopupName.Text = rdr["productname"].ToString();
                        lblPopupPrice.Text = "₹" + rdr["productprice"].ToString();
                        lblPopupDesc.Text = rdr["productdescription"].ToString();
                        lblPopupCategory.Text = rdr["category_name"].ToString();
                        lblPopupStatus.Text = rdr["stock_status"].ToString();

                        imgPopup.ImageUrl = GetImageUrl(rdr["image"]);
                        hfPopupProductId.Value = rdr["id"].ToString();
                        txtPopupQty.Text = "1";

                        // Call the JS function we created in Shop.aspx
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openProductModal();", true);
                    }
                }
            }
        }

        // --- POPUP BUTTONS ---
        protected void btnPopupAddToCart_Click(object sender, EventArgs e)
        {
            string productId = hfPopupProductId.Value;
            int qty = 1;
            int.TryParse(txtPopupQty.Text, out qty);
            if (qty < 1) qty = 1;

            AddToCartLogic(productId, qty);

            // Close Modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePop", "closeProductModal();", true);
        }

        protected void btnPopupWishlist_Click(object sender, EventArgs e)
        {
            string productId = hfPopupProductId.Value; // Popup se hidden ID lena
            AddToWishlistLogic(productId); // Logic call karna

            // Popup ko band karna
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePop", "closeProductModal();", true);
        }

        // --- CART LOGIC ---
        private void AddToCartLogic(string productId, int quantity)
        {
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

            DataRow[] existingRows = dtCart.Select("id=" + productId);
            if (existingRows.Length > 0)
            {
                int currentQty = Convert.ToInt32(existingRows[0]["quantity"]);
                existingRows[0]["quantity"] = currentQty + quantity;
            }
            else
            {
                DataRow dr = dtCart.NewRow();
                dr["id"] = productId;
                dr["quantity"] = quantity;
                dtCart.Rows.Add(dr);
            }

            Session["Cart"] = dtCart;

            if (this.Master is SiteMaster)
            {
                ((SiteMaster)this.Master).UpdateCartCount();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Added to Cart Successfully!');", true);
        }

        // --- WISHLIST LOGIC ---
        private void AddToWishlistLogic(string productId)
        {
            DataTable dtWishlist;

            // Step A: Check karein session pehle se hai ya nahi
            if (Session["Wishlist"] == null)
            {
                dtWishlist = new DataTable();
                dtWishlist.Columns.Add("id", typeof(int));
            }
            else
            {
                dtWishlist = (DataTable)Session["Wishlist"];
            }

            // Step B: Check karein item pehle se wishlist mein hai kya?
            DataRow[] existingRows = dtWishlist.Select("id=" + productId);

            if (existingRows.Length == 0)
            {
                // Agar nahi hai, to add karein
                DataRow dr = dtWishlist.NewRow();
                dr["id"] = productId;
                dtWishlist.Rows.Add(dr);

                // Session update karein
                Session["Wishlist"] = dtWishlist;

                // Success Alert
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertWish", "alert('Item Added to Wishlist ❤️');", true);
            }
            else
            {
                // Duplicate Alert
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertWish", "alert('Item is already in your Wishlist!');", true);
            }
        }

        // --- Helpers ---
        protected string GetImageUrl(object imageName)
        {
            if (imageName == null || imageName == DBNull.Value || string.IsNullOrEmpty(imageName.ToString()))
                return ResolveUrl("~/admin/images/no-image.png");

            string dbValue = imageName.ToString();
            if (dbValue.ToLower().Contains("admin/"))
                return ResolveUrl("~/" + dbValue);

            return ResolveUrl("~/admin/" + dbValue);
        }

        protected string GetStarRating(object productId, object avgRating, object totalRatings)
        {
            double rating = (avgRating != DBNull.Value) ? Convert.ToDouble(avgRating) : 0;
            int total = (totalRatings != DBNull.Value) ? Convert.ToInt32(totalRatings) : 0;

            string stars = "";
            int fullStars = (int)Math.Floor(rating);
            bool hasHalfStar = (rating - fullStars) >= 0.5;

            for (int i = 0; i < fullStars; i++) stars += "<i class='fas fa-star'></i>";
            if (hasHalfStar && fullStars < 5) { stars += "<i class='fas fa-star-half-alt'></i>"; fullStars++; }
            for (int i = fullStars; i < 5; i++) stars += "<i class='far fa-star'></i>";

            return $"<div class='stars'>{stars}</div><span class='rating-text'>({total})</span>";
        }
    }
}
