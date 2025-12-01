using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CartProWebApp
{
    public partial class Wishlist : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindWishlist();
            }
        }

        // --- 1. Wishlist Products Fetch Karna ---
        private void BindWishlist()
        {
            DataTable dtWishlist = (DataTable)Session["Wishlist"];

            // Agar wishlist session null hai ya khali hai
            if (dtWishlist == null || dtWishlist.Rows.Count == 0)
            {
                lblEmpty.Visible = true;
                rptWishlist.Visible = false;
                return;
            }

            // Wishlist ke saare Product IDs comma separated string mein convert karein
            // Example: "1,5,8"
            List<string> ids = new List<string>();
            foreach (DataRow row in dtWishlist.Rows)
            {
                ids.Add(row["id"].ToString());
            }
            string idList = string.Join(",", ids);

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Query: Sirf wahi products laaye jo IDs list mein hain
                string query = $"SELECT * FROM products WHERE id IN ({idList})";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dtProducts = new DataTable();
                        sda.Fill(dtProducts);

                        if (dtProducts.Rows.Count > 0)
                        {
                            rptWishlist.DataSource = dtProducts;
                            rptWishlist.DataBind();
                            rptWishlist.Visible = true;
                            lblEmpty.Visible = false;
                        }
                        else
                        {
                            lblEmpty.Visible = true;
                            rptWishlist.Visible = false;
                        }
                    }
                }
            }
        }

        // --- 2. Remove & Add to Cart Actions ---
        protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string productId = e.CommandArgument.ToString();

            if (e.CommandName == "Remove")
            {
                // Remove from Session
                DataTable dtWishlist = (DataTable)Session["Wishlist"];
                if (dtWishlist != null)
                {
                    // Row find karke delete karein
                    for (int i = dtWishlist.Rows.Count - 1; i >= 0; i--)
                    {
                        DataRow dr = dtWishlist.Rows[i];
                        if (dr["id"].ToString() == productId)
                        {
                            dr.Delete();
                        }
                    }
                    dtWishlist.AcceptChanges();
                    Session["Wishlist"] = dtWishlist;
                }

                // Refresh Page Logic
                BindWishlist();
            }
            else if (e.CommandName == "AddToCart")
            {
                // Cart Logic (Same as Shop Page)
                AddToCartLogic(productId);
            }
        }

        // --- 3. Add to Cart Helper ---
        private void AddToCartLogic(string productId)
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
                existingRows[0]["quantity"] = currentQty + 1;
            }
            else
            {
                DataRow dr = dtCart.NewRow();
                dr["id"] = productId;
                dr["quantity"] = 1;
                dtCart.Rows.Add(dr);
            }

            Session["Cart"] = dtCart;

            // Update Master Badge
            if (this.Master is SiteMaster)
            {
                ((SiteMaster)this.Master).UpdateCartCount();
            }

            // JavaScript Alert
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Item moved to Cart!');", true);
        }

        // --- Helper: Image Path ---
        protected string GetImageUrl(object imageName)
        {
            if (imageName == null || imageName == DBNull.Value || string.IsNullOrEmpty(imageName.ToString()))
                return ResolveUrl("~/admin/images/no-image.png");

            string dbValue = imageName.ToString();
            if (dbValue.ToLower().Contains("admin/"))
                return ResolveUrl("~/" + dbValue);

            return ResolveUrl("~/admin/" + dbValue);
        }
    }
}