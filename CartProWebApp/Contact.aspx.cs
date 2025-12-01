using System;
using System.Web.UI;

namespace CartProWebApp
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            // Add email sending logic here
            Response.Write("<script>alert('Message sent successfully!');</script>");
        }
    }
}
