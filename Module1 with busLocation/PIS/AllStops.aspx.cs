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
    public partial class AllStops : System.Web.UI.Page
    {
        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());

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

        void BindGrid()
        {
            SqlCommand cmd = new SqlCommand("getAllStops", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable userDt = (DataTable)Session["UserId"];
            cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userDt.Rows[0][0];
            DataTable dt = new DataTable();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dt);
            GridStops.DataSource = dt;
            GridStops.DataBind();
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            int id = int.Parse(lnk.CommandArgument.ToString());

            SqlCommand cmd = new SqlCommand("DeleteStops", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.NVarChar).Value = id;
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();
            lblStatus.Text = "Stop Delete Successfully";           
            BindGrid();
        }
    }
}