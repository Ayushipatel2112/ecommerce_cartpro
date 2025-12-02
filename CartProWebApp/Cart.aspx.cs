using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CartProWebApp
{
    public partial class Cart : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                // If not logged in, redirect to login
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                BindCart();
            }
        }

        private void BindCart()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Join CartItems with Products to get Image, Name, and Price
                // We alias c.id as 'id' so the Repeaters CommandArgument works for Deleting/Updating the specific cart row
                string query = @"
                    SELECT 
                        c.id, 
                        c.product_id, 
                        c.quantity, 
                        p.productname, 
                        p.productprice, 
                        p.image, 
                        (p.productprice * c.quantity) AS total_price 
                    FROM CartItems c
                    INNER JOIN products p ON c.product_id = p.id
                    WHERE c.user_id = @Uid";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                // Bind Data
                rptCart.DataSource = dt;
                rptCart.DataBind();

                // Calculate Totals
                decimal subtotal = 0;
                foreach (DataRow row in dt.Rows)
                {
                    subtotal += Convert.ToDecimal(row["total_price"]);
                }

                lblSubtotal.Text = subtotal.ToString("C"); // Currency Format
                lblTotal.Text = subtotal.ToString("C");

                // Toggle Views
                divCartItems.Visible = true;
                divCartTotals.Visible = true;
                divEmptyCart.Visible = false;
            }
            else
            {
                // Empty Cart UI
                divCartItems.Visible = false;
                divCartTotals.Visible = false;
                divEmptyCart.Visible = true;
            }
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // The CommandArgument here is the ID of the row in the CartItems table (not the product ID)
            int cartId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Remove")
            {
                RemoveItem(cartId);
            }
            else if (e.CommandName == "Increase")
            {
                UpdateQuantity(cartId, 1);
            }
            else if (e.CommandName == "Decrease")
            {
                UpdateQuantity(cartId, -1);
            }

            // Refresh the cart list
            BindCart();

            // Update Master Page Badge
            if (this.Master is SiteMaster)
            {
                ((SiteMaster)this.Master).UpdateCartCount();
            }
        }

        private void UpdateQuantity(int cartId, int change)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // First get current quantity
                string getQtyQuery = "SELECT quantity FROM CartItems WHERE id = @Id";
                int currentQty = 0;

                using (SqlCommand cmd = new SqlCommand(getQtyQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Id", cartId);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null) currentQty = Convert.ToInt32(result);
                }

                int newQty = currentQty + change;

                if (newQty <= 0)
                {
                    // If quantity becomes 0, remove the item
                    RemoveItem(cartId);
                }
                else
                {
                    // Otherwise update it
                    string updateQuery = "UPDATE CartItems SET quantity = @Qty WHERE id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Qty", newQty);
                        cmd.Parameters.AddWithValue("@Id", cartId);
                        if (con.State == ConnectionState.Closed) con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        private void RemoveItem(int cartId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM CartItems WHERE id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", cartId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // Just refreshes the cart (useful if users manually type in a box, but we are using buttons)
        protected void btnUpdateCart_Click(object sender, EventArgs e)
        {
            BindCart();
        }

        // Helper for Images (Same as in your Shop page)
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
