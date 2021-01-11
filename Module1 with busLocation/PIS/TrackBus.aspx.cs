using Newtonsoft.Json;
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
    public partial class TrackBus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
              
            }
        }

        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());

        void PlotBusNdStops(int Id)
        {
            SqlCommand cmd = new SqlCommand("getStopsNdLocation", Connection);
            cmd.Parameters.Add("@Id", SqlDbType.Float).Value = Id;
            
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds);
           
            DataTable dt = ds.Tables[2];
            lblCurrentStop.Text = dt.Rows[0]["CurrentBusStop"].ToString();
            lblDistanceStop.Text = double.Parse(dt.Rows[0]["DistanceToNextStop"].ToString())/1000 +"Km";
            lblNextBusStop.Text = dt.Rows[0]["NextBusStop"].ToString();
            lblPreviousStop.Text = dt.Rows[0]["PreviousBusStop"].ToString();
            string answer = "";
            if(dt.Rows[0]["TimeToDestination"]!=null)
            {
                TimeSpan t = TimeSpan.FromSeconds(double.Parse(dt.Rows[0]["TimeToDestination"].ToString()));

                 answer = string.Format("{0:D2}h:{1:D2}m:{2:D2}s:{3:D3}ms",
                            t.Hours,
                            t.Minutes,
                            t.Seconds,
                            t.Milliseconds);
            }
            
            lblTimeToDest.Text = answer;
            lblDistanceToDest.Text = double.Parse(dt.Rows[0]["DistanceToDestination"].ToString()) / 1000 + "Km";
            answer = "";
            if (dt.Rows[0]["TimeToNextStop"] != null)
            {
                TimeSpan t = TimeSpan.FromSeconds(double.Parse(dt.Rows[0]["TimeToNextStop"].ToString()));

                answer = string.Format("{0:D2}h:{1:D2}m:{2:D2}s:{3:D3}ms",
                           t.Hours,
                           t.Minutes,
                           t.Seconds,
                           t.Milliseconds);
            }

            lblTimeToStop.Text = answer;


            string DataString = JsonConvert.SerializeObject(ds);
           // System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "init", "initialize();", true);     
           System.Web.UI.ScriptManager.RegisterClientScriptBlock(UpdatePanel1, UpdatePanel1.GetType(), "PlotStopsNdBus", "PlotLocationAndStops(" + DataString + ");", true);     
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            int id = int.Parse(Request.QueryString["Id"].ToString());
            PlotBusNdStops(id);
            Timer1.Interval = 10000;
        }
    }
}