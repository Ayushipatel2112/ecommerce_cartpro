using System;
using System.Web.UI;

namespace CartProWebApp
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThankYou.aspx");
        }
    }
}
