using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using Notifier;

namespace BusArriaval
{
    /// <summary>
    /// Summary description for API
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class API : System.Web.Services.WebService
    {
        SqlConnection Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ToString());
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public object checkEmailId(string EmailId)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            try
            {
                SqlCommand cmd = new SqlCommand("checkEmailId", Connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@EmailId", SqlDbType.VarChar).Value = EmailId;
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dap.Fill(dt);
                if (dt.Rows.Count <= 0)
                {
                    row.Add("Status", "Success");
                    return serializer.Serialize(row);
                }
                else
                {
                    row.Add("Status", "Failure");
                }
            }
            catch (Exception e)
            {
                row.Add("Status", "Faliure");
                row.Add("Message", e.Message);
            }
            //  row.Add("Status", "Success");
            return serializer.Serialize(row);
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public object registerUser(string emailId, string password, string name, string phone, string address)   //loginFlag==Facebook means facebook login and LinkedIn means  linkedIn
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                SqlCommand cmd = new SqlCommand("registerUser", Connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@emailid", SqlDbType.VarChar).Value = emailId;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
                cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = phone;
                cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = address;
                

                Connection.Open();
                int id = int.Parse(cmd.ExecuteScalar().ToString());
                if (id == -1)
                {
                    row.Add("Status", "Failure");
                    row.Add("Message", "Email Id already registerd");
                }
                else
                {
                    row.Add("Status", "Success");
                    row.Add("id", id);
                }
            }
            catch (Exception e)
            {
                row = new Dictionary<string, object>();
                row.Add("Status", "Failure");
                row.Add("Message", e.Message);
            }
            return serializer.Serialize(row);
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public object login(string EmailId, string Password)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            try
            {
                SqlCommand cmd = new SqlCommand("login", Connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@emailId", SqlDbType.NVarChar).Value = EmailId;
                cmd.Parameters.Add("@password", SqlDbType.NVarChar).Value = Password;                
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dap.Fill(dt);
                if (dt.Rows.Count <= 0)
                {
                    row.Add("Status", "Failure");
                    row.Add("id", null);
                    return serializer.Serialize(row);
                }
                else
                {
                    foreach (DataRow dr in dt.Rows)
                    {

                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                    }
                    row.Add("Status", "Success");
                }
            }
            catch (Exception e)
            {
                row.Add("Status", "Faliure");
                row.Add("Message", e.Message);
            }            
            return serializer.Serialize(row);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getAllBuses()
        {
            SqlCommand cmd = new SqlCommand("getBuses1", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds);

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            Dictionary<string, object> row = new Dictionary<string, object>(); ;
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in ds.Tables[0].Rows)// for result list
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public object UpdateBusLocation(int BusId,float Lat,float Lng)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                SqlCommand cmd = new SqlCommand("updateBusLocation", Connection);                
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@BusId", SqlDbType.Int).Value = BusId;
                cmd.Parameters.Add("@lat", SqlDbType.Float).Value = Lat;
                cmd.Parameters.Add("@lng", SqlDbType.Float).Value = Lng;
                cmd.Parameters.Add("@tripId", SqlDbType.NVarChar).Value = 1;
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                dap.Fill(ds);

                //table0    --locations
                //table1    --routestops
                //table2    --bus details

                //DataTable Locations = ds.Tables[0];
                //DataTable RouteStops = ds.Tables[1];
                //DataTable BusDetails=ds.Tables[2];

                //string CurrentBusStopId=null;
                
                //string NextBusStop=null;
                //string PreviousBusStop=null;
                //string CurrentBusStop = null;
                //string DistanceToNextStop = null;
                //string TimeToNextStop = null;
                //string DistanceToDestination = null;
                //string TimeToDestination = null;
                //string CounterId;

                //int index=FindBusStop(Lat, Lng, RouteStops);

                //int distance = 0;
                //int time = 0;
                //if (index != -1)
                //{
                //    CurrentBusStopId = RouteStops.Rows[index]["StopFId"].ToString();
                //    CurrentBusStop = RouteStops.Rows[index]["Stop"].ToString();
                //    if (index != RouteStops.Rows.Count)
                //    {
                //        NextBusStop = RouteStops.Rows[index + 1]["Stop"].ToString();
                //        TimeToNextStop = RouteStops.Rows[index]["TimeToNextStop"].ToString();
                //        DistanceToNextStop = RouteStops.Rows[index]["DistanceToNextStop"].ToString();
                //    }
                //    if (index != 0)
                //    {
                //        PreviousBusStop = RouteStops.Rows[index - 1]["Stop"].ToString();
                //    }
                //    for (int i = index; i < RouteStops.Rows.Count - 1; i++)
                //    {
                //        distance += int.Parse(RouteStops.Rows[i]["DistanceToNextStop"].ToString());
                //    }
                //    for (int i = index; i < RouteStops.Rows.Count - 1; i++)
                //    {
                //        time += int.Parse(RouteStops.Rows[i]["TimeToNextStop"].ToString());
                //    }
                //    DistanceToDestination = distance.ToString();
                //    TimeToDestination = time.ToString();

                //    cmd = new SqlCommand("updateBusParams", Connection);
                //    cmd.CommandType = CommandType.StoredProcedure;
                //    CounterId = Locations.Rows[Locations.Rows.Count - 1]["Id"].ToString();
                //    cmd.Parameters.Add("@CurrentBusStopId", SqlDbType.NVarChar).Value = CurrentBusStopId;
                //    cmd.Parameters.Add("@NextBusStop", SqlDbType.NVarChar).Value = NextBusStop;
                //    cmd.Parameters.Add("@PreviousBusStop", SqlDbType.NVarChar).Value = PreviousBusStop;
                //    cmd.Parameters.Add("@CurrentBusStop", SqlDbType.NVarChar).Value = CurrentBusStop;
                //    cmd.Parameters.Add("@DistanceToNextStop", SqlDbType.NVarChar).Value = DistanceToNextStop;
                //    cmd.Parameters.Add("@TimeToNextStop", SqlDbType.NVarChar).Value = TimeToNextStop;
                //    cmd.Parameters.Add("@DistanceToDestination", SqlDbType.NVarChar).Value = DistanceToDestination;
                //    cmd.Parameters.Add("@TimeToDestination", SqlDbType.NVarChar).Value = TimeToDestination;
                //    cmd.Parameters.Add("@busId", SqlDbType.NVarChar).Value = BusId;
                //    cmd.Parameters.Add("@CounterId", SqlDbType.NVarChar).Value = CounterId;

                //    Connection.Open();
                //    cmd.ExecuteNonQuery();
                //    Connection.Close();
                //}
                //else {
                //    DataTable temp = Locations.Select("Id>=" + BusDetails.Rows[0]["CounterId"].ToString()).CopyToDataTable();
                //    double DiscreateDistance = 0;
                //    for (int i = 1; i < temp.Rows.Count; i++)
                //    {
                //        DiscreateDistance += (CalcDistanceBetween(double.Parse(temp.Rows[i - 1]["Lat"].ToString()), double.Parse(temp.Rows[i - 1]["Lng"].ToString()), double.Parse(temp.Rows[i]["Lat"].ToString()), double.Parse(temp.Rows[i]["Lng"].ToString()))*1000);
                //    }
                //    cmd = new SqlCommand("updateBusParams", Connection);
                //    cmd.CommandType = CommandType.StoredProcedure;
                //    CounterId = Locations.Rows[Locations.Rows.Count - 1]["Id"].ToString();
                //    cmd.Parameters.Add("@PreviousBusStop", SqlDbType.NVarChar).Value = BusDetails.Rows[0]["CurrentBusStop"];
                //    cmd.Parameters.Add("@CurrentBusStop", SqlDbType.NVarChar).Value = "";

                //    DistanceToNextStop = (double.Parse(BusDetails.Rows[0]["DistanceToNextStop"].ToString()) - DiscreateDistance).ToString();
                //    DistanceToDestination = (double.Parse(BusDetails.Rows[0]["DistanceToDestination"].ToString()) - DiscreateDistance).ToString();

                //    TimeToNextStop = ((double.Parse(DistanceToNextStop) / double.Parse(RouteStops.Select("StopFId=" + BusDetails.Rows[0]["CurrentBusStopId"])[0]["DistanceToNextStop"].ToString())) * double.Parse(RouteStops.Select("StopFId=" + BusDetails.Rows[0]["CurrentBusStopId"])[0]["TimeToNextStop"].ToString())).ToString();
                    
                //    cmd.Parameters.Add("@DistanceToNextStop", SqlDbType.NVarChar).Value = DistanceToNextStop;
                //    cmd.Parameters.Add("@DistanceToDestination", SqlDbType.NVarChar).Value = DistanceToDestination;

                //    cmd.Parameters.Add("@TimeToNextStop", SqlDbType.NVarChar).Value = TimeToNextStop;
                //    cmd.Parameters.Add("@TimeToDestination", SqlDbType.NVarChar).Value = double.Parse(BusDetails.Rows[0]["TimeToDestination"].ToString()) - (double.Parse(RouteStops.Select("StopFId=" + BusDetails.Rows[0]["CurrentBusStopId"])[0]["TimeToNextStop"].ToString()) - double.Parse(TimeToNextStop));
                //    cmd.Parameters.Add("@CounterId", SqlDbType.NVarChar).Value = CounterId;
                //    cmd.Parameters.Add("@busId", SqlDbType.NVarChar).Value = BusId;
                //    cmd.Parameters.Add("@CurrentBusStopId", SqlDbType.NVarChar).Value = BusDetails.Rows[0]["CurrentBusStopId"];
                //    cmd.Parameters.Add("@NextBusStop", SqlDbType.NVarChar).Value = BusDetails.Rows[0]["NextBusStop"]; 
                //    Connection.Open();
                //    cmd.ExecuteNonQuery();
                //    Connection.Close();

                //}
                row.Add("Status", "Success");               
            }
            catch (Exception e)
            {
                row.Add("Status", "Faliure");
                row.Add("Message", e.Message);
            }
            return serializer.Serialize(row);
        }

        int FindBusStop(float lat,float lng,DataTable stops)
        {
            for (int i = 0; i < stops.Rows.Count; i++)
            {
                if (CalcDistanceBetween(lat, lng, double.Parse(stops.Rows[i]["Lat"].ToString()), double.Parse(stops.Rows[i]["Lng"].ToString())) <= double.Parse(stops.Rows[i]["Radius"].ToString()))
                {
                    return i;
                }
            }
            return -1;
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getAllStops()
        {
            SqlCommand cmd = new SqlCommand("getAllStops1", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds);

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            Dictionary<string, object> row = new Dictionary<string, object>(); ;
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in ds.Tables[0].Rows)// for result list
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getBusesBySourceDestination(int SourceStopId,int DestinationStopId)
        {
            SqlCommand cmd = new SqlCommand("GetBusBySourceNdDest", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@sourceId", SqlDbType.NVarChar).Value = SourceStopId;
            cmd.Parameters.Add("@destId", SqlDbType.NVarChar).Value = DestinationStopId;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            
            DataTable dt = new DataTable();
            dap.Fill(dt);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            Dictionary<string, object> row = new Dictionary<string, object>(); ;
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in dt.Rows)// for result list
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getBusesByCurrentLocDestination(float Lat,float Lng, int DestinationStopId)
        {
            SqlCommand cmd = new SqlCommand("getBusesByCurrentLocDestination", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Lat", SqlDbType.Float).Value = Lat;
            cmd.Parameters.Add("@Lng", SqlDbType.Float).Value = Lng;
            cmd.Parameters.Add("@destId", SqlDbType.NVarChar).Value = DestinationStopId;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dap.Fill(dt);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            Dictionary<string, object> row = new Dictionary<string, object>(); ;
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in dt.Rows)// for result list
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }
        
        protected double CalcDistanceBetween(double lat1, double lon1, double lat2, double lon2)
        {

            //Radius of the earth in:  1.609344 miles,  6371 km  | var R = (6371 / 1.609344);
            double R = 6371; // Radius in Kilometers default
            double dLat = toRad(lat2 - lat1);
            double dLon = toRad(lon2 - lon1);
            double a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                Math.Cos(toRad(lat1)) * Math.Cos(toRad(lat2)) *
                Math.Sin(dLon / 2) * Math.Sin(dLon / 2);
            var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
            var d = R * c;

            return d;
        }
        protected double toRad(double Value)
        {
            /** Converts numeric degrees to radians */
            return Value * Math.PI / 180;
        }
        public double ConvertToRadians(double angle)
        {
            return (Math.PI / 180) * angle;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public object BusBreakDown(int BusId)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            try
            {
                SqlCommand cmd = new SqlCommand("NotifyBusBreakDown", Connection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@BusId", SqlDbType.Int).Value = BusId;              

                Connection.Open();
                int code = int.Parse(cmd.ExecuteScalar().ToString());
                Connection.Close();

                if (code == -1)
                {
                    row.Add("Status", "Failure");
                    row.Add("Message", "Update Failed.");

                    return serializer.Serialize(row);
                }
                else
                {
                    row.Add("Status", "Success");
                }
            }
            catch (Exception e)
            {
                row.Add("Status", "Faliure");
                row.Add("Message", e.Message);
            }
            return serializer.Serialize(row);
        }
        

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public object RegisterGCM(int userId, string GCMId)
        {
            SqlCommand cmd = new SqlCommand("updateGCMId", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = userId;
            cmd.Parameters.Add("@GCMId", SqlDbType.NVarChar).Value = GCMId;
            
            Connection.Open();
            cmd.ExecuteNonQuery();
            Connection.Close();

            Dictionary<string, object> row = new Dictionary<string, object>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            row.Add("Status", "Success");
            return serializer.Serialize(row);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getBusLocation(int BusId)
        {
            SqlCommand cmd = new SqlCommand("getBusLocation", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BusId", SqlDbType.Int).Value = BusId;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds);

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            Dictionary<string, object> row = new Dictionary<string, object>();
            List<Dictionary<string, object>> rows;
            Dictionary<string, object> JsonObj = new Dictionary<string, object>(); 
                                   
            
            row = new Dictionary<string, object>();
            foreach (DataColumn col in ds.Tables[0].Columns)
            {
                row.Add(col.ColumnName, ds.Tables[0].Rows[0][col]);
            }                        
            JsonObj.Add("BusDetails", row);
            
            rows = new List<Dictionary<string, object>>();
            foreach (DataRow dr in ds.Tables[1].Rows)// for result list
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[1].Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            JsonObj.Add("Stops", rows);

            row = new Dictionary<string, object>();
            foreach (DataColumn col in ds.Tables[2].Columns)
            {
                row.Add(col.ColumnName, ds.Tables[2].Rows[0][col]);
            }            
            JsonObj.Add("RouteDetails", row);
            return serializer.Serialize(JsonObj);
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string notifyUser(int userId, int busId, string geofenceName,float lat,float lng)
        {
            SqlCommand cmd = new SqlCommand("getDetails", Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
            cmd.Parameters.Add("@busId", SqlDbType.Int).Value = busId;
          
            DataSet ds = new DataSet();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(ds);

            string tickerText = "messageNotification";
            string busNumber = ds.Tables[1].Rows[0]["BusNumber"].ToString();
            string GCMId = ds.Tables[0].Rows[0]["GCMId"].ToString();
           
            string contentTitle = string.Format("bus number {0} has entered {1} Please be ready", busNumber, geofenceName);
          
            MessageResponse response = new MessageResponse
            {
                data = new MessageData { json = new MessageJSONData { tickerText = tickerText, contentTitle = contentTitle, lat = lat, lng = lng } },
                registration_ids = new List<string> { GCMId }
            };

            Dictionary<string, object> row = new Dictionary<string, object>();
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            string json = serializer.Serialize(response);

            return showMessage(GCM.SendGCMNotification("AIzaSyDn3-IIK9V8hn-gb7RnDoviKwqzhsFqvgM", json));       //PROJECT iD=1064837045532
        }

        public string showMessage(string Message)
        {
            return "{\"Result\":" + Message + "}";
        }
        public class MessageResponse
        {
            public MessageData data { get; set; }
            public IList<string> registration_ids { get; set; }
        }
        public class MessageData
        {
            public MessageJSONData json { get; set; }
        }

        public class MessageJSONData
        {
            public string tickerText { get; set; }
            public string contentTitle { get; set; }
            public float lat { get; set; }
            public float lng { get; set; }
        }
        
    }
}
