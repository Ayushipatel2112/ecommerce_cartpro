using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace CartProWebApp.admin
{
    public partial class category : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CartProConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Check Authentication
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                // 2. Check for Message in URL (like category.aspx?msg=Success)
                if (Request.QueryString["msg"] != null)
                {
                    pnlMessage.Visible = true;
                    litMessage.Text = Request.QueryString["msg"];
                }

                // 3. Load Data
                BindCategories();
            }
        }

        private void BindCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Assuming table name is 'categories'
                string query = "SELECT id, category_name, category_description, image, created_at FROM categories ORDER BY id DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            // Data found, bind to repeater
                            rptCategories.DataSource = dt;
                            rptCategories.DataBind();
                            pnlNoData.Visible = false;
                        }
                        else
                        {
                            // No data, show empty message
                            rptCategories.DataSource = null;
                            rptCategories.DataBind();
                            pnlNoData.Visible = true;
                        }
                    }
                }
            }
        }
    }
}