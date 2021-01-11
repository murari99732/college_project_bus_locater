<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrackBus.aspx.cs" Inherits="BusArriaval.TrackBus" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>PIS</title>

    <script src="resources/jq/jquery-1.8.2.intellisense.js"></script>
    <script src="resources/jq/jquery-1.8.2.js"></script>
    <script src="resources/jq/jquery-1.8.2.min.js"></script>
    <script src="resources/jq/jquery-ui-1.8.24.js"></script>
    <script src="resources/jq/jquery-ui-1.8.24.min.js"></script>
		
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
    

     <script
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBWkiKblrRk1pG2oBEdZEonqYD0wuMWbGU&callback=initMap">
    </script>

   <script type="text/javascript">       
       var map;
       var geocoder;
       window.onload= function() {
           initialize();
       }
        
       function initialize() {
           //try {
           geocoder = new google.maps.Geocoder();
           var mapOptions =
                    {
                        mapTypeControlOptions: {
                            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
                            position: google.maps.ControlPosition.RIGHT_CENTER
                        },
                        zoom: 5,
                        zoomControlOptions: {
                            style: google.maps.ZoomControlStyle.SMALL,
                            position: google.maps.ControlPosition.RIGHT_CENTER
                        },
                        panControl: false,
                        center: new google.maps.LatLng(23, 78),
                        mapTypeControl: true,
                        mapTypeId: google.maps.MapTypeId.ROADMAP

                    }
           var canvasName = "map_canvas";


           map = new google.maps.Map(document.getElementById(canvasName), mapOptions);
           return map;
           //}
           //catch (err) {
           //    alert("Script Error(2).. " + err.Message)
           //}
       }
       
       function PlotLocationAndStops(data)
       {
           plotStops(data.Table1);
           PlotBusLocation(data.Table);
       }
       var circles = new Array();
       function plotStops(Stops)
       {
          
            if (circles.length > 0) {
                for (var i = 0; i < circles.length; i++) {
                    circles[i].setMap(null);
                }
            }
          
           //var bounds = new google.maps.LatLngBounds();
           for (var i = 0; i < Stops.length; i++)
           {
               var latLng = new google.maps.LatLng(Stops[i].Lat, Stops[i].Lng)
               circles[circles.length] = new google.maps.Circle({
                   strokeColor: '#FF0000',
                   strokeOpacity: 0.8,
                   strokeWeight: 2,
                   fillColor: '#FF0000',
                   fillOpacity: 0.35,
                   map: map,
                   center: latLng,
                   radius: Stops[i].Radius*1000
               });
              // bounds.extend(latLng);
               //map.fitBounds(bounds);
           }
           
       }
       var marker;
       function PlotBusLocation(bus)
       {
           var myLatlng = new google.maps.LatLng(bus[0].Lat, bus[0].Lng);          
           var sizex = 34, sizey = 52;
           var image = new google.maps.MarkerImage("icons/bus-marker-icon.png", new google.maps.Size(sizex, sizey),
                                new google.maps.Point(0, 0),
                                new google.maps.Point(sizex / 2, sizey)
                                );

           if (marker != null)
           {
               marker.setMap(null);
           }
           marker = new google.maps.Marker({
               position: myLatlng,
               map: map,
               icon: image,
               title: bus[0].BusNumber
           });

           map.setZoom(17);
           map.setCenter(marker.getPosition());
       }

    </script>
    <style>
        .labels {
            color: red;
            background-color: white;
            font-family: "Lucida Grande", "Arial", sans-serif;
            font-size: 11px;
            font-weight: bold;
            text-align: center;
            width: auto;
            border: 1px solid black;
            white-space: nowrap;
            z-index: 99999;
            margin-top: 20px !important;
            padding: 2px;
        }

        #infoWindow {
            position: fixed;
            height: 160px;
            width: 350px;
            background-color: #eee;
            border-radius: 100px;
            text-align: center;
            z-index: 99999;
            opacity: 0.8;
        }
    </style>

	</head>
	<body>
        <form runat="server" id="Form1">

            <asp:ScriptManager runat="server"></asp:ScriptManager>
            
            <!-- end dialogs -->
            <!-- header -->
            

            <!-- content -->
            <div id="content">
                <div class="box">
					<!-- box / title -->
					<div class="title">
						<h5>Track Bus</h5>
					</div>
					<!-- end box / title -->
                    <div class="row">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>
                                    <div style="width: 20%; float: left">
                                        <h6>Next Stop</h6>
                                       &nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblNextBusStop" runat="server" Text=""></asp:Label>
                                        <br /><br />
                                        <h6>Previous Stop</h6>
                                        &nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblPreviousStop" runat="server" Text=""></asp:Label>
                                        <br /><br />
                                        <h6>Current Stop</h6>
                                        &nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblCurrentStop" runat="server" Text=""></asp:Label>
                                        <br /><br />
                                        <h6>Distance To Next Stop</h6>
                                      &nbsp;&nbsp;&nbsp;&nbsp;   <asp:Label ID="lblDistanceStop" runat="server" Text=""></asp:Label>
                                        <br /><br />
                                        <h6>Time To Next Stop</h6>
                                       &nbsp;&nbsp;&nbsp;&nbsp;  <asp:Label ID="lblTimeToStop" runat="server" Text=""></asp:Label>
                                        <br /><br />
                                        <h6>Distance To Destination</h6>
                                        &nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblDistanceToDest" runat="server" Text=""></asp:Label>
                                        <br /><br />
                                        <h6>Time To Destination</h6>
                                       &nbsp;&nbsp;&nbsp;&nbsp;  <asp:Label ID="lblTimeToDest" runat="server" Text=""></asp:Label>

                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </telerik:RadAjaxPanel>

                        <div style="width: 80%; float: left">
                            <div id="map_canvas" style="width: 100%; height: 600px"></div>
                        </div>
                    </div>


                  
				</div>
            </div>
            <!-- end content -->

        </form>
		<!-- footer -->
		<div id="footer">
			<p>Copyright &copy;  PIS. All Rights Reserved.</p>
		</div>
		<!-- end footert -->
	</body>
</html>



