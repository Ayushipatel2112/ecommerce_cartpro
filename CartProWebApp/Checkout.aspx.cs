using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI; // Required for the Validation fix

namespace CartProWebApp
{
    public partial class Checkout : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // --- FIX FOR "ScriptResourceMapping" ERROR ---
            // This line disables the requirement for jQuery validation, 
            // so you don't need to touch Web.config.
            this.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            // 1. Check Login
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return; // Stop execution
            }

            if (!IsPostBack)
            {
                BindOrderSummary();
                LoadUserInfo();
            }
        }

        // --- DISPLAY CART ITEMS ---
        private void BindOrderSummary()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Join CartItems with Products to get names and calculated totals
                string query = @"SELECT p.productname, c.quantity, (p.productprice * c.quantity) as total_price 
                                 FROM CartItems c 
                                 JOIN Products p ON c.product_id = p.id 
                                 WHERE c.user_id = @Uid";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            // If cart is empty, send them back to shop
                            Response.Redirect("Shop.aspx");
                        }

                        // Bind the Repeater
                        rptOrderSummary.DataSource = dt;
                        rptOrderSummary.DataBind();

                        // Calculate Total Price
                        decimal total = 0;
                        foreach (DataRow row in dt.Rows)
                        {
                            total += Convert.ToDecimal(row["total_price"]);
                        }

                        // Display Totals
                        lblSubtotal.Text = total.ToString("C"); // Currency format
                        lblTotal.Text = total.ToString("C");
                    }
                }
            }
        }

        private void LoadUserInfo()
        {
            // Optional: Pre-fill email if available in Session
            if (Session["User"] != null)
            {
                txtEmail.Text = Session["User"].ToString();
            }
        }

        // --- PLACE ORDER LOGIC ---
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // 1. DETERMINE PAYMENT METHOD
            string paymentMethod = "Unknown";
            string orderStatus = "Pending";

            if (rbBankTransfer.Checked)
            {
                paymentMethod = "Direct Bank Transfer";
                orderStatus = "Pending (Unpaid)";
            }
            else if (rbCOD.Checked)
            {
                paymentMethod = "Cash on Delivery";
                orderStatus = "Processing";
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            decimal totalAmount = 0;
            string totalText = lblTotal.Text.Replace("$", "").Replace("₹", "").Replace(",", "").Trim();
            decimal.TryParse(totalText, out totalAmount);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // 2. INSERT ORDER WITH SELECTED PAYMENT METHOD
                    string orderQuery = @"INSERT INTO Orders 
                                (UserId, TotalAmount, FullName, Email, Phone, FullAddress, Country, State, ZipCode, OrderNotes, PaymentMethod, OrderStatus) 
                                VALUES 
                                (@UserId, @Total, @Name, @Email, @Phone, @Address, @Country, @State, @Zip, @Notes, @PaymentMethod, @Status); 
                                SELECT SCOPE_IDENTITY();";

                    int newOrderId = 0;

                    using (SqlCommand cmdOrder = new SqlCommand(orderQuery, con, transaction))
                    {
                        // ... (Existing parameters for Name, Address, etc remain the same) ...
                        string fullName = txtFirstName.Text.Trim() + " " + txtLastName.Text.Trim();
                        string fullAddr = txtAddress.Text.Trim() + " " + txtAddress2.Text.Trim();

                        cmdOrder.Parameters.AddWithValue("@UserId", userId);
                        cmdOrder.Parameters.AddWithValue("@Total", totalAmount);
                        cmdOrder.Parameters.AddWithValue("@Name", fullName);
                        cmdOrder.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmdOrder.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmdOrder.Parameters.AddWithValue("@Address", fullAddr);
                        cmdOrder.Parameters.AddWithValue("@Country", ddlCountry.SelectedItem.Text);
                        cmdOrder.Parameters.AddWithValue("@State", txtState.Text.Trim());
                        cmdOrder.Parameters.AddWithValue("@Zip", txtZip.Text.Trim());
                        cmdOrder.Parameters.AddWithValue("@Notes", txtOrderNotes.Text.Trim());

                        // NEW DYNAMIC PARAMETERS
                        cmdOrder.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                        cmdOrder.Parameters.AddWithValue("@Status", orderStatus);

                        newOrderId = Convert.ToInt32(cmdOrder.ExecuteScalar());
                    }

                    // 3. MOVE ITEMS TO ORDER DETAILS (Same as before)
                    string moveItemsQuery = @"INSERT INTO OrderDetails (OrderId, ProductId, ProductName, Quantity, Price)
                                      SELECT @OrderId, c.product_id, p.productname, c.quantity, p.productprice
                                      FROM CartItems c
                                      JOIN Products p ON c.product_id = p.id
                                      WHERE c.user_id = @UserId";

                    using (SqlCommand cmdDetails = new SqlCommand(moveItemsQuery, con, transaction))
                    {
                        cmdDetails.Parameters.AddWithValue("@OrderId", newOrderId);
                        cmdDetails.Parameters.AddWithValue("@UserId", userId);
                        cmdDetails.ExecuteNonQuery();
                    }

                    // 4. EMPTY CART (Same as before)
                    string emptyCartQuery = "DELETE FROM CartItems WHERE user_id = @UserId";
                    using (SqlCommand cmdDelete = new SqlCommand(emptyCartQuery, con, transaction))
                    {
                        cmdDelete.Parameters.AddWithValue("@UserId", userId);
                        cmdDelete.ExecuteNonQuery();
                    }

                    transaction.Commit();

                    // 5. REDIRECT TO CONFIRMATION
                    Response.Redirect("OrderConfirmation.aspx?id=" + newOrderId);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    string cleanMsg = ex.Message.Replace("'", "");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "alert('Error: " + cleanMsg + "');", true);
                }
            }
        }
    }
}
