<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddRoutes.aspx.cs" Inherits="BusArriaval.AddRoutes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Menu.ascx" TagPrefix="uc1" TagName="Menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>PIS</title>
		
		<!-- stylesheets -->
		<link rel="stylesheet" type="text/css" href="resources\css\reset.css"/>
		<link rel="stylesheet" type="text/css" href="resources\css\styleCopy.css" media="screen"/>
		<link rel="stylesheet" type="text/css" href="resources\css\style_fixed_full.css"/>
		<link id="color" rel="stylesheet" type="text/css" href="resources\css\colors\blue.css"/>
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
                <uc1:Menu runat="server" ID="Menu" />
            </div>

            <!-- content -->
            <div id="content">
                <div class="box">
					<!-- box / title -->
					<div class="title">
						<h5>Add Route</h5>
					</div>
					<!-- end box / title -->
                  <%--  <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
                    </telerik:RadAjaxLoadingPanel>
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>--%>
                                <div class="form">
                                    <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    <div class="fields">
                                        <div class="field">
                                            <table style="border: groove">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label8" runat="server"
                                                            Style="top: 150px; left: 316px; height: 19px; width: 123px"
                                                            Text="Route Number"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtNumber" runat="server"
                                                            Style="top: 150px; left: 470px; height: 18px; width: 200px"></asp:TextBox>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label7" runat="server"
                                                            Style="top: 255px; left: 316px; height: 19px; width: 34px"
                                                            Text="Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtName" runat="server"
                                                            Style="top: 255px; left: 470px; height: 18px; width: 200px;"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server"
                                                            Style="top: 185px; left: 316px; height: 19px; width: 82px"
                                                            Text="Source:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSource" runat="server"
                                                            Style="top: 185px; left: 470px; height: 18px; width: 200px;"></asp:TextBox>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label2" runat="server"
                                                            Style="top: 220px; left: 316px; height: 19px; width: 82px"
                                                            Text="Destination:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDestination" runat="server"
                                                            Style="top: 220px; left: 470px; height: 18px; width: 200px;"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>

                                            <table style="border: groove">
                                                <tr>
                                                    <td colspan="4">
                                                        <table>
                                                            <tr>
                                                                <th>Stops</th>
                                                                <th></th>
                                                                <th>Route Stops</th>
                                                                <th></th>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:ListBox ID="lstStops" runat="server" SelectionMode="Multiple" Height="200px"
                                                                        BorderStyle="Outset"></asp:ListBox>
                                                                </td>
                                                                <td style="vertical-align: top">
                                                                    <asp:Button ID="btnaddall" runat="server" Text=">>" OnClick="btnaddall_Click" class="ui-button ui-widget ui-state-default ui-corner-all"></asp:Button><br />
                                                                    <asp:Button ID="btnadditem" runat="server" Text=">" OnClick="btnadditem_Click"></asp:Button><br />
                                                                    <asp:Button ID="btnremoveitem" runat="server" Text="<" OnClick="btnremoveitem_Click"></asp:Button><br />
                                                                    <asp:Button ID="btnremoveall" runat="server" Text="<<" OnClick="btnremoveall_Click"></asp:Button>
                                                                </td>
                                                                <td>
                                                                    <asp:ListBox ID="lstRouteStops" runat="server" Height="200px"
                                                                        SelectionMode="Multiple">
                                                                       

                                                                    </asp:ListBox>
                                                                </td>
                                                                <td style="vertical-align: top">
                                                                    <asp:Button ID="btnColmoveup" runat="server" Text="^" Font-Size="13" OnClick="btnColmoveup_Click"></asp:Button><br>
                                                                    <asp:Button ID="btnColmovedwn" runat="server" Text="v" Font-Size="13" OnClick="btnColmovedwn_Click"></asp:Button>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td>
                                                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="ui-button ui-widget ui-state-default ui-corner-all" OnClick="btnSubmit_Click" />
                                                                </td>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <%--<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />						--%>
                                        </div>

                                        <div class="buttons">

                                            <%--<input type="submit" name="submit" value="Submit">
								<input type="reset" name="reset" value="Reset">
								<div class="highlight">
									<input type="submit" name="submit.highlight" value="Submit Empathized">
								</div>--%>
                                        </div>

                                    </div>
                                </div>
                         <%--   </ContentTemplate>
                        </asp:UpdatePanel>
                    </telerik:RadAjaxPanel>--%>
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