using System;
using System.Web.UI;

namespace CartProWebApp
{
    public partial class ViewProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            // Add profile update logic here
            Response.Write("<script>alert('Profile updated successfully!');</script>");
        }
    }
}
