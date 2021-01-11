<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BusEnquiry.aspx.cs" Inherits="BusArriaval.BusEnquiry" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>PIS</title>
		
		<!-- stylesheets -->
		<link rel="stylesheet" type="text/css" href="resources\css\reset.css">
		<link rel="stylesheet" type="text/css" href="resources\css\style.css" media="screen">
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
                          <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="btnLogout_Click" />
                    </li>
                </ul>
                <!-- end user -->
                <div id="header-inner">
                    <div id="home">
                        <a href="" title="Home"></a>
                    </div>
         
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
							<div class="field  field-first">
								<div class="label">
									<label for="input-small">Source:</label>
								</div>
								<div class="input">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="ddlSource" runat="server" Height="200" Width="305"
                                        DropDownWidth="310" EmptyMessage="Choose a Source" HighlightTemplatedItems="true"
                                        EnableLoadOnDemand="true" Filter="StartsWith" >
                                    </telerik:RadComboBox>									
                                </div>
							</div>
							<div class="field">
								<div class="label">
									<label for="input-medium">Destination:</label>
								</div>
								<div class="input">
                                     <telerik:RadComboBox RenderMode="Lightweight" ID="ddlDest" runat="server" Height="200" Width="305"
                                        DropDownWidth="310" EmptyMessage="Choose a Destination" HighlightTemplatedItems="true"
                                        EnableLoadOnDemand="true" Filter="StartsWith"  >
                                    </telerik:RadComboBox>
								</div>
							</div>   
							<div class="buttons">
                                <asp:Button ID="btnSubmit" runat="server" Text="Find Buses" OnClick="btnSubmit_Click" />
							</div>

                            <telerik:RadGrid ID="radGrid" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="false" PageSize="15" Width="100%"
                                AllowFilteringByColumn="true">
                                <GroupingSettings CaseSensitive="false" />
                                <MasterTableView DataKeyNames="Id">
                                    <Columns>
                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" Width="10px" />
                                            <HeaderTemplate>
                                                Sr.No.
                                            </HeaderTemplate>
                                            <ItemStyle HorizontalAlign="Right" />
                                            <ItemTemplate>
                                                <%#Container.DataSetIndex+1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="BusNumber" HeaderStyle-HorizontalAlign="Left" HeaderText="Bus Number"
                                            ItemStyle-HorizontalAlign="Left" ShowFilterIcon="true" UniqueName="BusNumber" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Name"
                                            ItemStyle-HorizontalAlign="Left" ShowFilterIcon="true" UniqueName="Name" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CurrentBusStop" HeaderStyle-HorizontalAlign="Left"
                                            HeaderText="Current Stop" ItemStyle-HorizontalAlign="Left" ShowFilterIcon="true"
                                            UniqueName="CurrentBusStop" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="PreviousBusStop" HeaderStyle-HorizontalAlign="Left"
                                            HeaderText="Previous Stop" ItemStyle-HorizontalAlign="Left" ShowFilterIcon="true"
                                            UniqueName="PreviousBusStop" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="NextBusStop" HeaderStyle-HorizontalAlign="Right" HeaderText="Next Stop"
                                            ItemStyle-HorizontalAlign="Left" ShowFilterIcon="true" UniqueName="NextBusStop" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="DistanceToNextStop" HeaderStyle-HorizontalAlign="Left" HeaderText="Distance To Next Stop(mtrs)"
                                            ItemStyle-HorizontalAlign="Right" ShowFilterIcon="true" UniqueName="DistanceToNextStop" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="TimeToNextStop" HeaderStyle-HorizontalAlign="Left" HeaderText="Time To Next Stop(mins)"
                                            ItemStyle-HorizontalAlign="Right" ShowFilterIcon="true" UniqueName="TimeToNextStop" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <HeaderTemplate>
                                                Locations
                                            </HeaderTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <a href='<%# "TrackBus.aspx?Id=" + Eval("Id")%>'>See Location</a>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <PagerStyle AlwaysVisible="true" />
                                </MasterTableView>
                            </telerik:RadGrid>
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


