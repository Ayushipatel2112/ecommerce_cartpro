using System;
using System.Data;
using System.Web.UI;

namespace CartProWebApp
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateCartCount();
            }
        }

        // Ye function Public hai taki Shop page isse call kar sake
        public void UpdateCartCount()
        {
            if (Session["Cart"] != null)
            {
                DataTable dt = (DataTable)Session["Cart"];
                int totalItems = 0;

                // Total Quantity count karein
                foreach (DataRow row in dt.Rows)
                {
                    totalItems += Convert.ToInt32(row["quantity"]);
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
    }
}