<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddStops.aspx.cs" Inherits="BusArriaval.AddStops" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>PIS</title>
		
		<!-- stylesheets -->
		<link rel="stylesheet" type="text/css" href="resources\css\reset.css">
		<link rel="stylesheet" type="text/css" href="resources\css\styleCopy.css" media="screen">
		<link rel="stylesheet" type="text/css" href="resources\css\style_fixed_full.css">
		<link id="color" rel="stylesheet" type="text/css" href="resources\css\colors\blue.css">
		<!-- scripts (jquery) -->
		<script src="resources\scripts\jquery-1.6.4.min.js" type="text/javascript"></script>
		<!--[if IE]><script language="javascript" type="text/javascript" src="resources/scripts/excanvas.min.js"></script><![endif]-->
		<script src="resources\scripts\jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
		<script src="resources\scripts\jquery.ui.selectmenu.js" type="text/javascript"></script>
		<script src="resources\scripts\jquery.flot.min.js" type="text/javascript"></script>
		<script src="resources\scripts\tiny_mce\jquery.tinymce.js" type="text/javascript"></script>
		<!-- scripts (custom) -->
		<script src="resources\scripts\smooth.js" type="text/javascript"></script>
		<script src="resources\scripts\smooth.menu.js" type="text/javascript"></script>
		<script src="resources\scripts\smooth.chart.js" type="text/javascript"></script>
		<script src="resources\scripts\smooth.table.js" type="text/javascript"></script>
		<script src="resources\scripts\smooth.form.js" type="text/javascript"></script>
		<script src="resources\scripts\smooth.dialog.js" type="text/javascript"></script>
		<script src="resources\scripts\smooth.autocomplete.js" type="text/javascript"></script>
		
    <script src="http://maps.google.com/maps?file=api&v=3&key="
      type="text/javascript">
    </script>
    
   <script type="text/javascript">
       /* Developed by: Abhinay Rathore [web3o.blogspot.com] */
       //Global variables 
       var map;
       var bounds = new GLatLngBounds; //Circle Bounds 
      // var map_center = new GLatLng(38.903843, -94.680096);

       var Circle; //Circle object 
       var CirclePoints = []; //Circle drawing points 
       var CircleCenterMarker, CircleResizeMarker;
       var mymarker;
       var circle_moving = false; //To track Circle moving 
       var circle_resizing = false; //To track Circle resizing 
       var radius = 1; //1 km 
       var min_radius = 0.1; //0.5km 
       var max_radius = 15; //5km 

       //Circle Marker/Node icons 
       var redpin = new GIcon(); //Red Pushpin Icon 
       redpin.image = 'icons/icon1.png'; //"http://maps.google.com/mapfiles/ms/icons/red-pushpin.png";
       redpin.iconSize = new GSize(32, 32);
       redpin.iconAnchor = new GPoint(10, 32);
       var bluepin = new GIcon(); //Blue Pushpin Icon 
       bluepin.image = 'icons/icon1.png'; // "http://maps.google.com/mapfiles/ms/icons/blue-pushpin.png";
       bluepin.iconSize = new GSize(32, 32);
       bluepin.iconAnchor = new GPoint(10, 32);

       var imageUrl = new GIcon(); //Blue Pushpin Icon 
       imageUrl.image = 'icons/icon1.png'; // "http://maps.google.com/mapfiles/ms/icons/blue-pushpin.png";
  
       imageUrl.iconAnchor = new GPoint(10, 32);

       var cu_lat, cu_long;
       window.onload = function () {
           initialize(18.500407, 73.939104, 0.1);
       };
       function initialize(latitude, longitude, radius) { //Initialize Google Map 
           if (GBrowserIsCompatible()) {

               cu_lat = latitude;
               cu_long = longitude;            

              
             
               var map_center = new GLatLng(latitude, longitude);
               map = new GMap2(document.getElementById("map_canvas")); //New GMap object 
               map.setCenter(map_center);

               var ui = new GMapUIOptions(); //Map UI options 
               ui.maptypes = { normal: true, satellite: true, hybrid: true, physical: false }
               ui.zoom = { scrollwheel: true, doubleclick: true };
               ui.controls = { largemapcontrol3d: true, maptypecontrol: true, scalecontrol: true };
               map.setUI(ui); //Set Map UI options 


               var map_center_new = new GLatLng(cu_lat, cu_long);
              

               addCircleCenterMarker(map_center);
               addCircleResizeMarker(map_center);
               drawCircle(map_center, radius);
               addmarker(map_center_new);
              
           }
       }

       function addmarker(point) {
         
           var markerOptions1 = { icon: imageUrl, draggable: true };
          
          // mymarker = new GMarker(point, markerOptions1);
          
           
          // map.addOverlay(mymarker); //Add marker on the map
         
       }

       // Adds Circle Center marker 
       function addCircleCenterMarker(point) {
         
          var markerOptions = { icon: bluepin, draggable: true };
           CircleCenterMarker = new GMarker(point, markerOptions);

           map.addOverlay(CircleCenterMarker); //Add marker on the map 
      

           GEvent.addListener(CircleCenterMarker, 'dragstart', function () { //Add drag start event 
               circle_moving = true;
           });
           GEvent.addListener(CircleCenterMarker, 'drag', function (point) { //Add drag event 
               drawCircle(point, radius);
           });
           GEvent.addListener(CircleCenterMarker, 'dragend', function (point) { //Add drag end event 
               circle_moving = false;
               drawCircle(point, radius);
           });
       }

       // Adds Circle Resize marker 
       function addCircleResizeMarker(point) {
         
           var resize_icon = new GIcon(redpin);
           resize_icon.maxHeight = 0;
           var markerOptions = { icon: resize_icon, draggable: true };
           CircleResizeMarker = new GMarker(point, markerOptions);
           map.addOverlay(CircleResizeMarker); //Add marker on the map 
        
           GEvent.addListener(CircleResizeMarker, 'dragstart', function () { //Add drag start event 
               circle_resizing = true;
           });
           GEvent.addListener(CircleResizeMarker, 'drag', function (point) { //Add drag event 
               var new_point = new GLatLng(map_center.lat(), point.lng()); //to keep resize marker on horizontal line 
               var new_radius = new_point.distanceFrom(map_center) / 1000; //calculate new radius 
               if (new_radius < min_radius) new_radius = min_radius;
               if (new_radius > max_radius) new_radius = max_radius;
               drawCircle(map_center, new_radius);
           });
           GEvent.addListener(CircleResizeMarker, 'dragend', function (point) { //Add drag end event 
               circle_resizing = false;
               var new_point = new GLatLng(map_center.lat(), point.lng()); //to keep resize marker on horizontal line 
               var new_radius = new_point.distanceFrom(map_center) / 1000; //calculate new radius 
               if (new_radius < min_radius) new_radius = min_radius;
               if (new_radius > max_radius) new_radius = max_radius;
               drawCircle(map_center, new_radius);
           });
       }

       //Draw Circle with given radius and center 
       function drawCircle(center, new_radius) {
           //Circle Drawing Algorithm from: http://koti.mbnet.fi/ojalesa/googlepages/circle.htm 

           //Number of nodes to form the circle 
           var nodes = new_radius * 40;
           if (new_radius < 1) nodes = 40;

           //calculating km/degree 
           var latConv = center.distanceFrom(new GLatLng(center.lat() + 0.1, center.lng())) / 100;
           var lngConv = center.distanceFrom(new GLatLng(center.lat(), center.lng() + 0.1)) / 100;

           CirclePoints = [];
           var step = parseInt(360 / nodes) || 10;
           var counter = 0;

           var lat = new Array(360); // regular array (add an optional integer
           var lng = new Array(360);
           var latdemo = 0;
           var longdemo = 0;

           for (var i = 0; i <= 360; i += step) {
               var cLat = center.lat() + (new_radius / latConv * Math.cos(i * Math.PI / 180));
               var cLng = center.lng() + (new_radius / lngConv * Math.sin(i * Math.PI / 180));

               lat[i] = cLat;
               lng[i] = cLng;
               latdemo = latdemo + ',' + cLat;
               longdemo = longdemo + ',' + cLng;
               var point = new GLatLng(cLat, cLng);
               CirclePoints.push(point);
               counter++;
           }

           for (var i = 0; i <= 1; i ++) {
               document.getElementById('<%=txtLat.ClientID %>').value = lat[0];
               document.getElementById('<%=txtLng.ClientID %>').value = lng[0];
           }

           CircleResizeMarker.setLatLng(CirclePoints[Math.floor(counter / 4)]); //place circle resize marker 
           CirclePoints.push(CirclePoints[0]); //close the circle polygon 
           if (Circle) { map.removeOverlay(Circle); } //Remove existing Circle from Map 
           var fillColor = (circle_resizing || circle_moving) ? 'black' : 'black'; //Set Circle Fill Color
           Circle = new GPolygon(CirclePoints, '#000000', 2, 1, fillColor, 0.2); //New GPolygon object for Circle 
           map.addOverlay(Circle); //Add Circle Overlay on the Map 
           radius = new_radius; //Set global radius 
           map_center = center; //Set global map_center 
           if (!circle_resizing && !circle_moving) { //Fit the circle if it is nor moving or resizing 
               fitCircle();
               //Circle drawing complete trigger function goes here
           }

           document.getElementById('<%=txtRadius.ClientID %>').value = radius;
           
       }

       //Fits the Map to Circle bounds 
       function fitCircle() {
           bounds = Circle.getBounds();
           map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds));
           
       } 
   </script>

	</head>
	<body>
        <form runat="server" id="Form1">
            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <!-- end dialogs -->
            <!-- header -->
            <div id="header">
                <!-- logo -->
                <div id="logo">
                    <h1><a href="" title="Net Banking">PIS</a></h1>
                </div>
                <!-- end logo -->
                <!-- user -->
                <ul id="user">

                    <li>
                        <%--<asp:LinkButton ID="lnkLogut" runat="server" OnClick="lnkLogut_Click" CausesValidation="false">Logout</asp:LinkButton>--%>

                        <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="btnLogout_Click" />
                    </li>
                </ul>
                <!-- end user -->
                <div id="header-inner">
                    <div id="home">
                        <a href="" title="Home"></a>
                    </div>
                    <!-- quick -->
                 <%--   <ul id="quick">
                        <li>
                            <a href="#" title="Products"><span class="normal">Accounts</span></a>

                        </li>
                        <li>
                            <a href="FundTransfer.aspx" title="Products"><span class="icon">
                                <img src="resources\images\icons\application_double.png" alt="Products"></span><span>Fund Transfers</span></a>

                        </li>
                        <li>
                            <a href="BillPay.aspx" title="Events"><span class="icon">
                                <img src="resources\images\icons\calendar.png" alt="Events"></span><span>Bill Pay & Recharge</span></a>

                        </li>

                    </ul>--%>
                    <!-- end quick -->
                    <div class="corner tl"></div>
                    <div class="corner tr"></div>
                </div>
            </div>

            <!-- content -->
            <div id="content">
                <div class="box">
					<!-- box / title -->
					<div class="title">
						<h5>Bus Enquiry</h5>
					</div>
					<!-- end box / title -->
                
                    <div class="form">
                        
                        <div class="fields">
                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
                            </telerik:RadAjaxLoadingPanel>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        <div class="field  field-first">
                                            <div class="label">
                                                <label for="input-small">Stop Name:</label>
                                            </div>
                                            <div class="input">
                                                <asp:TextBox ID="txtStopName" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="label">
                                                <label for="input-medium">Radius:</label>
                                            </div>
                                            <div class="input">
                                                <asp:TextBox ID="txtRadius" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="field">

                                            <div class="label">
                                                <label for="input-medium">Lat:</label>
                                            </div>
                                            <div class="input">
                                                <asp:TextBox ID="txtLat" runat="server"></asp:TextBox>

                                            </div>

                                            <div class="label">
                                                <label for="input-medium">Lng:</label>
                                            </div>
                                            <div class="input">
                                                <asp:TextBox ID="txtLng" runat="server"></asp:TextBox>

                                            </div>
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </telerik:RadAjaxPanel>
                            <div id="map_canvas" style="width: 100%; height: 600px"></div>


                            <div class="buttons">

                                <%--<input type="submit" name="submit" value="Submit">
								<input type="reset" name="reset" value="Reset">
								<div class="highlight">
									<input type="submit" name="submit.highlight" value="Submit Empathized">
								</div>--%>
                            </div>




                        </div>
                    </div>
                     
				</div>
            </div>
            <!-- end content -->

        </form>
		<!-- footer -->
		<div id="footer">
			<p>Copyright &copy; 2015-2016 PIS. All Rights Reserved.</p>
		</div>
		<!-- end footert -->
	</body>
</html>


