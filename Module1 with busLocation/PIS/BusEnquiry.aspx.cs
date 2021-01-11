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
    public partial class BusEnquiry : System.Web.UI.Page
    {

        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindAllDdls();
            }
        }

        void BindAllDdls()
        {
            SqlCommand cmd = new SqlCommand("getAllStops1", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
     
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dap.Fill(dt);

            ddlDest.DataSource = dt;
            ddlDest.DataTextField = "Stop";
            ddlDest.DataValueField = "Id";
            ddlDest.DataBind();

            ddlSource.DataSource = dt;
            ddlSource.DataTextField = "Stop";
            ddlSource.DataValueField = "Id";
            ddlSource.DataBind();
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("GetBusBySourceNdDest", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@sourceId", SqlDbType.NVarChar).Value = ddlSource.SelectedValue;
            cmd.Parameters.Add("@destId", SqlDbType.NVarChar).Value = ddlDest.SelectedValue;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dap.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                radGrid.DataSource = dt;
                radGrid.DataBind();
            }
        }
    }
}