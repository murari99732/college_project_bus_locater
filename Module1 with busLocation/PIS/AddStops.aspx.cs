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
    public partial class AddStops : System.Web.UI.Page
    {

        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("addStop", Connection);
            cmd.Parameters.Add("@Lat", SqlDbType.Float).Value = txtLat.Text;
            cmd.Parameters.Add("@Lng", SqlDbType.Float).Value = txtLng.Text;
            cmd.Parameters.Add("@Radius", SqlDbType.Float).Value = txtRadius.Text;
            cmd.Parameters.Add("@StopName", SqlDbType.NVarChar).Value = txtStopName.Text;
          
            cmd.CommandType = CommandType.StoredProcedure;
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();
            lblStatus.Text = "Stop Added successfully";
            clearAll();
        }

        void clearAll()
        {
            txtStopName.Text = "";
        }
    }
}