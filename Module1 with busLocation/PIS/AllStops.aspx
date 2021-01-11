<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllStops.aspx.cs" Inherits="BusArriaval.AllStops" %>


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
						<h5>All Stops</h5>
					</div>
					<!-- end box / title -->
                
                    <div class="form">
                        
                        <div class="fields">
                            
                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
                            </telerik:RadAjaxLoadingPanel>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <a href="AddStops.aspx">Add Stops</a>
                                        <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red"></asp:Label>   
                                        <asp:GridView ID="GridStops" runat="server" DataKeyNames="Id" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField DataField="Stop" HeaderStyle-HorizontalAlign="Left" HeaderText="Stop Name"
                                                    ItemStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Lat" HeaderStyle-HorizontalAlign="Left" HeaderText="Lat"
                                                    ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                                <asp:BoundField DataField="Lng" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="Lng" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                                <asp:BoundField DataField="Radius" HeaderStyle-HorizontalAlign="Left"
                                                    HeaderText="Radius" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                                                                                                                                
                                                 <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <HeaderTemplate>
                                                        Delete
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

