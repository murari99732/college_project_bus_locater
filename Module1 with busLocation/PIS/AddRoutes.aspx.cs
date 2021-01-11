using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Xml.Linq;
using Newtonsoft.Json;

namespace BusArriaval
{
    public partial class AddRoutes : System.Web.UI.Page
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
                loadlist();
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        public void loadlist()
        {
            SqlCommand cmd = new SqlCommand("getAllStops", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable userDt = (DataTable)Session["UserId"];
            cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userDt.Rows[0][0];
            DataTable dt = new DataTable();
            dap.Fill(dt);
            lstStops.DataTextField = "Stop";
            lstStops.DataValueField = "Id";
            lstStops.DataSource = dt;
            lstStops.DataBind();
            Session["dt"] = dt;
        }


        private void MoveUp(ListBox lstBox)
        {
            int iIndex, iCount, iOffset, iInsertAt, iIndexSelectedMarker = -1;
            string lItemData, lItemval;
            try
            {

                // Get the count of items in the list control
                iCount = lstBox.Items.Count;

                // Set the base loop index and the increment/decrement value based on the direction the item are being moved (up or down).
                iIndex = 0;
                iOffset = -1;

                // Loop through all of the items in the list.
                while (iIndex < iCount)
                {
                    // Check if this item is selected.
                    if (lstBox.SelectedIndex > 0)
                    {
                        // Get the item data for this item
                        lItemval = lstBox.SelectedItem.Value.ToString();
                        lItemData = lstBox.SelectedItem.Text.ToString();
                        iIndexSelectedMarker = lstBox.SelectedIndex;

                        // Don't move selected items past other selected items
                        if (-1 != iIndexSelectedMarker)
                        {
                            for (int iIndex2 = 0; iIndex2 < iCount; ++iIndex2)
                            {
                                // Find the index of this item in enabled list
                                if (lItemval == lstBox.Items[iIndex2].Value.ToString())
                                {
                                    // Remove the item from its current position
                                    lstBox.Items.RemoveAt(iIndex2);

                                    // Reinsert the item in the array one space higher than its previous position
                                    iInsertAt = (iIndex2 + iOffset) < 0 ? 0 : iIndex2 + iOffset;
                                    ListItem li = new ListItem(lItemData, lItemval);
                                    lstBox.Items.Insert(iInsertAt, li);
                                    break;
                                }
                            }
                        }
                    }
                    // If this item wasn't selected save the index so we can check it later so we don't move past the any selected items.
                    else if (-1 == iIndexSelectedMarker)
                    {
                        iIndexSelectedMarker = iIndex;
                        break;

                    }

                    iIndex = iIndex + 1;
                }

                if (iIndexSelectedMarker == 0)
                    lstBox.SelectedIndex = iIndexSelectedMarker;
                else
                    lstBox.SelectedIndex = iIndexSelectedMarker - 1;
            }
            catch (Exception expException)
            {
                Response.Write(expException.Message);
            }

        }

        private void MoveDown(ListBox lstBox)
        {
            try
            {
                int iIndex, iCount, iOffset, iInsertAt, iIndexSelectedMarker = -1;
                string lItemData;
                string lItemval;


                // Get the count of items in the list control
                iCount = lstBox.Items.Count;

                // Set the base loop index and the increment/decrement value based on the direction the item are being moved (up or down).
                iIndex = iCount - 1;
                iOffset = 1;

                // Loop through all of the items in the list.
                while (iIndex >= 0)
                {
                    // Check if this item is selected.
                    if (lstBox.SelectedIndex >= 0)
                    {
                        // Get the item data for this item
                        lItemData = lstBox.SelectedItem.Text.ToString();
                        lItemval = lstBox.SelectedItem.Value.ToString();
                        iIndexSelectedMarker = lstBox.SelectedIndex;

                        // Don't move selected items past other selected items
                        if (-1 != iIndexSelectedMarker)
                        {
                            for (int iIndex2 = 0; iIndex2 < iCount - 1; ++iIndex2)
                            {
                                // Find the index of this item in enabled list
                                if (lItemval == lstBox.Items[iIndex2].Value.ToString())
                                {
                                    // Remove the item from its current position

                                    lstBox.Items.RemoveAt(iIndex2);

                                    // Reinsert the item in the array one space higher than its previous position
                                    iInsertAt = (iIndex2 + iOffset) < 0 ? 0 : iIndex2 + iOffset;
                                    ListItem li = new ListItem(lItemData, lItemval);
                                    lstBox.Items.Insert(iInsertAt, li);
                                    break;

                                }
                            }
                        }
                    }
                    iIndex = iIndex - 1;
                }
                if (iIndexSelectedMarker == lstBox.Items.Count - 1)
                    lstBox.SelectedIndex = iIndexSelectedMarker;
                else
                    lstBox.SelectedIndex = iIndexSelectedMarker + 1;
            }
            catch (Exception expException)
            {
                Response.Write(expException.Message);
            }
        }

        private void AddRemoveAll(ListBox aSource, ListBox aTarget)
        {
            try
            {
                foreach (ListItem item in aSource.Items)
                {
                    aTarget.Items.Add(item);
                }
                aSource.Items.Clear();
            }
            catch (Exception expException)
            {
                Response.Write(expException.Message);
            }

        }

        private void AddRemoveItem(ListBox aSource, ListBox aTarget)
        {
            ListItemCollection licCollection;

            try
            {

                licCollection = new ListItemCollection();
                for (int intCount = 0; intCount < aSource.Items.Count; intCount++)
                {
                    if (aSource.Items[intCount].Selected == true)
                        licCollection.Add(aSource.Items[intCount]);
                }

                for (int intCount = 0; intCount < licCollection.Count; intCount++)
                {
                    aSource.Items.Remove(licCollection[intCount]);
                    aTarget.Items.Add(licCollection[intCount]);
                }

            }
            catch (Exception expException)
            {
                Response.Write(expException.Message);
            }
            finally
            {
                licCollection = null;
            }

        }

        protected void btnaddall_Click(object sender, EventArgs e)
        {
            AddRemoveAll(lstStops, lstRouteStops);
        }
      
        protected void btnadditem_Click(object sender, EventArgs e)
        {
            AddRemoveItem(lstStops, lstRouteStops);
        }

        protected void btnremoveitem_Click(object sender, EventArgs e)
        {
            AddRemoveItem(lstRouteStops, lstStops);
        }

        protected void btnremoveall_Click(object sender, EventArgs e)
        {
            AddRemoveAll(lstRouteStops, lstStops);
        }

        protected void btnColmoveup_Click(object sender, EventArgs e)
        {
            MoveUp(lstRouteStops);
        }

        protected void btnColmovedwn_Click(object sender, EventArgs e)
        {
            MoveDown(lstRouteStops);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("addRoute", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Number", SqlDbType.NVarChar).Value = txtNumber.Text;
            cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Text;
            cmd.Parameters.Add("@Source", SqlDbType.NVarChar).Value = txtSource.Text;
            cmd.Parameters.Add("@Destination", SqlDbType.NVarChar).Value = txtDestination.Text;
          
            DataTable dt = ListToTable(lstRouteStops.Items);
            cmd.Parameters.Add("@RouteStops", dt);
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();
            lblStatus.Text = "Route Added Successfully";
            clearAll();
        }
        void clearAll()
        {
            txtNumber.Text = "";
            txtName.Text = "";
            txtSource.Text = "";
            txtDestination.Text = "";
        }

        protected DataTable ListToTable(ListItemCollection listBoxData)
        {
            //Create a DataTable
            DataTable DT = new DataTable();
            //Add columns
            DT.Columns.Add("Id");
            DT.Columns.Add("Sequence"); 
            DT.Columns.Add("Lat"); 
            DT.Columns.Add("Lng"); 
            DT.Columns.Add("TimeToNextStop");
            DT.Columns.Add("DistanceToNextStop");
 
            DataTable stopsDt= (DataTable)Session["dt"];
            //Loop through ListItemCollection
            for (int i = 0; i < listBoxData.Count;i++ )
            {
                DataRow dr = DT.NewRow();
                dr["Id"] = listBoxData[i].Value;
                dr["Sequence"] = i + 1;

                dr["Lat"] = stopsDt.Select("Id=" + listBoxData[i].Value)[0]["Lat"].ToString();
                dr["Lng"] = stopsDt.Select("Id=" + listBoxData[i].Value)[0]["Lng"].ToString();
                  
               

                if (i > 0)
                {
                    HttpWebRequest request =
                   (HttpWebRequest)WebRequest.Create("http://maps.googleapis.com/maps/api/distancematrix/json?origins="
                   + DT.Rows[i-1]["Lat"] + "," + DT.Rows[i-1]["Lng"] + "&destinations=" + dr["Lat"] + "," + dr["Lng"]
                   + "&mode=Car&language=us-en&sensor=false");

                    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                    using (var streamReader = new StreamReader(response.GetResponseStream()))
                    {
                        var result = streamReader.ReadToEnd();

                        if (!string.IsNullOrEmpty(result))
                        {
                            Parent t = JsonConvert.DeserializeObject<Parent>(result);
                            try {
                                DT.Rows[i - 1]["DistanceToNextStop"] = t.rows[0].elements[0].distance.value;
                                DT.Rows[i - 1]["TimeToNextStop"] = t.rows[0].elements[0].duration.value;
                            
                            }
                            catch { }
                          
                        }
                    }
                }
                DT.Rows.Add(dr);
                
                //WebClient client = new WebClient();
                //Stream stream = client.OpenRead("http://maps.googleapis.com/maps/api/distancematrix/xml?origins=Vancouver+BC|Seattle&destinations=San+Francisco|Vancouver+BC&mode=bicycling&language=fr-FR&sensor=false");
                //XDocument doc = XDocument.Load(stream);
            }
            return DT;
        }
        public class Distance
        {
            public string text { get; set; }
            public int value { get; set; }
        }

        public class Duration
        {
            public string text { get; set; }
            public int value { get; set; }
        }

        public class Element
        {
            public Distance distance { get; set; }
            public Duration duration { get; set; }
            public string status { get; set; }
        }

        public class Row
        {
            public Element[] elements { get; set; }
        }

        public class Parent
        {
            public string[] destination_addresses { get; set; }
            public string[] origin_addresses { get; set; }
            public Row[] rows { get; set; }
            public string status { get; set; }
        }
    }
}