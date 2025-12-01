using System;
using System.Web;
using System.Web.UI;

namespace CartProWebApp
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            Session.Abandon();
            
            // Redirect to home page
            Response.Redirect("Default.aspx");
        }
    }
}
