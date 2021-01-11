using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TrippleSecurity
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("login", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@emailId", SqlDbType.NVarChar).Value = txtUserName.Text;
            cmd.Parameters.Add("@password", SqlDbType.NVarChar).Value = txtPassword.Text;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dap.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Session["UserId"] = dt;
                if (dt.Rows[0]["Role"].ToString() == "1")
                {
                    Response.Redirect("adminhome.aspx");
                }
                else
                {
                    Response.Redirect("busEnquiry.aspx");
                }                
            }
            else
            {
                Messages.Visible = true;
            }
        }
    }
}