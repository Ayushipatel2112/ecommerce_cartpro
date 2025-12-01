using System;
using System.Web;
using System.Web.UI;

namespace CartProWebApp.admin
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}