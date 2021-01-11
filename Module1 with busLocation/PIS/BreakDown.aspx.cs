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
    public partial class BreakDown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                BindGrid();
              
            }
        }
        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());


        void BindGrid()
        {
            SqlCommand cmd = new SqlCommand("getAllNotifications", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable userDt = (DataTable)Session["UserId"];
            cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userDt.Rows[0][0];
            DataTable dt = new DataTable();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dt);
            GridBuses.DataSource = dt;
            GridBuses.DataBind();
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

       

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            int id = int.Parse(lnk.CommandArgument.ToString() );
           
            SqlCommand cmd = new SqlCommand("DeleteBreakDown", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.NVarChar).Value = id;            
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();
            lblStatus.Text = "Bus Marked as Repaired Successfully";
         
            BindGrid();

        }

       
    }
}