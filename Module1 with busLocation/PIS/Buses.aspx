<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Buses.aspx.cs" Inherits="BusArriaval.Buses" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Menu.ascx" TagPrefix="uc1" TagName="Menu" %>

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
                        <%--<asp:LinkButton ID="lnkLogut" runat="server" OnClick="lnkLogut_Click" CausesValidation="false">Logout</asp:LinkButton>--%>

                        <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="btnLogout_Click" />
                    </li>
                </ul>
                <!-- end user -->
                

                <uc1:Menu runat="server" id="Menu" />


            </div>

            <!-- content -->
            <div id="content">
                <div class="box">
					<!-- box / title -->
					<div class="title">
						<h5>All Buses</h5>
					</div>
					<!-- end box / title -->
                
                    <div class="form">
                        
                        <div class="fields">
                            
                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
                            </telerik:RadAjaxLoadingPanel>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="lnkAddBus" runat="server" OnClick="lnkAddBus_Click">Add bus</asp:LinkButton>
                                        <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        <div id="divFrm" visible="false" runat="server"  style="text-align:center">
                                           
                                            <div class="field  field-first">
                                                <div class="label">
                                                    <label for="input-small">Bus Number:</label>
                                                </div>
                                                <div class="input">
                                                    <asp:TextBox ID="txtBusNumber" runat="server"></asp:TextBox>
                                                </div>
                                                <div class="label">
                                                    <label for="input-medium">Name:</label>
                                                </div>
                                                <div class="input">
                                                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="field">
                                                 <div class="label">
                                                    <label for="input-medium">Imei:</label>
                                                </div>
                                                <div class="input">
                                                    <asp:TextBox ID="txtImei" runat="server"></asp:TextBox>
                                                </div>
                                                <div class="label">
                                                    <label for="input-medium">Route:</label>
                                                </div>
                                                <div class="input">
                                                    <telerik:RadComboBox RenderMode="Lightweight" ID="ddlRoutes" runat="server" Height="200" Width="305"
                                                        DropDownWidth="310" EmptyMessage="Choose a Route" HighlightTemplatedItems="true"
                                                        EnableLoadOnDemand="true" Filter="Contains">
                                                    </telerik:RadComboBox>
                                                </div>

                                               
                                            </div>
                                             <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"  />
                                        </div>

                                        <asp:GridView ID="GridBuses" runat="server" DataKeyNames="Id" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField DataField="BusNumber" HeaderStyle-HorizontalAlign="Left" HeaderText="Bus Number"
                                                    ItemStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Name"
                                                    ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                                <asp:BoundField DataField="CurrentBusStop" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="Current Stop" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                                <asp:BoundField DataField="PreviousBusStop" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="Previous Stop" ItemStyle-HorizontalAlign="Left"></asp:BoundField>

                                                <asp:BoundField DataField="NextBusStop" HeaderStyle-HorizontalAlign="Right" HeaderText="Next Stop"
                                                    ItemStyle-HorizontalAlign="Left"></asp:BoundField>

                                                <asp:BoundField DataField="DistanceToNextStop" HeaderStyle-HorizontalAlign="Left" HeaderText="Distance To Next Stop(mtrs)"
                                                    ItemStyle-HorizontalAlign="Right"></asp:BoundField>

                                                <asp:BoundField DataField="TimeToNextStop" HeaderStyle-HorizontalAlign="Left" HeaderText="Time To Next Stop(mins)"
                                                    ItemStyle-HorizontalAlign="Right"></asp:BoundField>

                                                <asp:BoundField DataField="Route" HeaderStyle-HorizontalAlign="Left" HeaderText="Route"
                                                    ItemStyle-HorizontalAlign="Right"></asp:BoundField>

                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <HeaderTemplate>
                                                        Locations
                                                    </HeaderTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <a href='<%# "TrackBus.aspx?Id=" + Eval("Id")%>' target="_blank">See Location</a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                 <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <HeaderTemplate>
                                                        
                                                    </HeaderTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkDelete" CommandArgument='<%# Eval("Id")%>' OnClick="lnkDelete_Click" runat="server">Delete</asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </telerik:RadAjaxPanel>
                       


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
			<p>Copyright &copy;  PIS. All Rights Reserved.</p>
		</div>
		<!-- end footert -->
	</body>
</html>

