using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BusArriaval
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("Register", Connection);
            cmd.Parameters.Add("@EmailId", SqlDbType.NVarChar).Value = txtUserName.Text;
            cmd.Parameters.Add("@Password", SqlDbType.NVarChar).Value = txtPassword.Text;
            cmd.Parameters.Add("@Address", SqlDbType.NVarChar).Value = txtAddress.Text;
            cmd.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = txtPhone.Text;
            cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;

            cmd.CommandType = CommandType.StoredProcedure;
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();
            Messages.Visible = true;
            
        }






    }
}