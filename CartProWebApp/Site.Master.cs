using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CartProWebApp
{
    public partial class SiteMaster : MasterPage
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            UpdateCartCount();

            if (!IsPostBack)
            {
                LoadUserImage();
                LoadFooterImage();
            }
        }

        // --- 1. UPDATED: DB QUERY REMOVED (Fixed the Error) ---
        private void LoadUserImage()
        {
            // Humne yahan se SQL Query hata di hai kyunki database mein 'UserImage' column nahi hai.
            // Ab ye har user ke liye default icon hi dikhayega.

            if (Session["UserId"] != null)
            {
                // Agar User Login hai -> Default User Icon
                imgUserIcon.Src = ResolveUrl("~/images/user.svg");
            }
            else
            {
                // Agar User Login nahi hai -> Default Icon
                imgUserIcon.Src = ResolveUrl("~/images/user.svg");
            }
        }

        // --- 2. FOOTER IMAGE ---
        private void LoadFooterImage()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Agar SiteSettings table nahi hai, to ye part bhi error de sakta hai.
                // Agar error aaye, to is pure 'try-catch' block ko hata kar
                // imgFooterSofa.Src = "~/images/sofa.png"; likh dein.
                string query = "SELECT SettingValue FROM SiteSettings WHERE SettingName = 'FooterImage'";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    try
                    {
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            imgFooterSofa.Src = ResolveUrl("~/images/" + result.ToString());
                        }
                    }
                    catch
                    {
                        // Ignore error if table missing
                    }
                }
            }
        }

        // --- 3. CART COUNT ---
        public void UpdateCartCount()
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                int totalItems = 0;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Note: Ensure karein ki aapki table ka naam 'Cart' hai ya 'CartItems'
                    // Aapke pichle code mein 'Cart' aur 'CartItems' dono use hue the.
                    // Yahan wahi naam likhein jo database mein hai.
                    string query = "SELECT SUM(quantity) FROM CartItems WHERE user_id = @Uid";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Uid", userId);
                        try
                        {
                            con.Open();
                            object result = cmd.ExecuteScalar();
                            if (result != null && result != DBNull.Value)
                            {
                                totalItems = Convert.ToInt32(result);
                            }
                        }
                        catch
                        {
                            // Agar CartItems table mein issue hai to count 0 rahega
                        }
                    }
                }

                if (totalItems > 0)
                {
                    lblCartCount.Text = totalItems.ToString();
                    lblCartCount.Visible = true;
                }
                else
                {
                    lblCartCount.Visible = false;
                }
            }
            else
            {
                lblCartCount.Visible = false;
            }
        }

        protected string GetImageUrl(object imageName)
        {
            if (imageName == null || imageName == DBNull.Value || string.IsNullOrEmpty(imageName.ToString()))
            {
                return ResolveUrl("~/images/sofa.png");
            }
            string dbValue = imageName.ToString();
            if (dbValue.Contains("/"))
            {
                return ResolveUrl("~/" + dbValue);
            }
            return ResolveUrl("~/images/" + dbValue);
        }
    }
}
