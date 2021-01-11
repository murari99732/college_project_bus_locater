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
    public partial class Buses : System.Web.UI.Page
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
                BindDdl();
            }
        }
        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());


        void BindDdl()
        {
            SqlCommand cmd = new SqlCommand("getAllRoutes", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable userDt = (DataTable)Session["UserId"];
            cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userDt.Rows[0][0];
            DataTable dt = new DataTable();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dt);
            ddlRoutes.DataSource = dt;
            ddlRoutes.DataTextField = "Name";
            ddlRoutes.DataValueField = "Id";
            ddlRoutes.DataBind();
        }

        void BindGrid()
        {
            SqlCommand cmd = new SqlCommand("getAllBuses", Connection);
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("addBus", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BusNumber", SqlDbType.NVarChar).Value = txtBusNumber.Text;
            cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
            cmd.Parameters.Add("@Imei", SqlDbType.NVarChar).Value = txtImei.Text;
            cmd.Parameters.Add("@RouteId", SqlDbType.NVarChar).Value = ddlRoutes.SelectedValue;
           
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();
            lblStatus.Text = "Bus Added Successfully";
            divFrm.Visible = false;
            BindGrid();
            clearAll();
        }

        void clearAll()
        {
            txtBusNumber.Text = "";
            txtName.Text = "";
            txtImei.Text = "";
            ddlRoutes.SelectedIndex = 0;
        }


        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            int id = int.Parse(lnk.CommandArgument.ToString() );
           
            SqlCommand cmd = new SqlCommand("DeleteBus", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.NVarChar).Value = id;            
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();
            lblStatus.Text = "Bus Delete Successfully";
            divFrm.Visible = false;
            BindGrid();

        }

        protected void lnkAddBus_Click(object sender, EventArgs e)
        {
            divFrm.Visible = true;
            lblStatus.Text = "";
        }
    }
}