<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TrippleSecurity.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>PIS</title>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<!-- stylesheets -->
		<link rel="stylesheet" type="text/css" href="resources\css\reset-1.css">
		<link rel="stylesheet" type="text/css" href="resources\css\style-1.css" media="screen">
		<link id="color" rel="stylesheet" type="text/css" href="resources\css\colors\blue-1.css">
		<!-- scripts (jquery) -->
		<script src="resources\scripts\jquery-1.6.4.min-1.js" type="text/javascript"></script>
		<script src="resources\scripts\jquery-ui-1.8.16.custom.min-1.js" type="text/javascript"></script>
		<script src="resources\scripts\smooth-1.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function () {
				style_path = "resources/css/colors";

				$("input.focus").focus(function () {
					if (this.value == this.defaultValue) {
						this.value = "";
					}
					else {
						this.select();
					}
				});

				$("input.focus").blur(function () {
					if ($.trim(this.value) == "") {
						this.value = (this.defaultValue ? this.defaultValue : "");
					}
				});

				$("input:submit, input:reset").button();
			});
		</script>
	</head>
	<body>
		<div id="login">
			<!-- login -->
			<div class="title">
				<h5>Sign In to PIS</h5>
				<div class="corner tl"></div>
				<div class="corner tr"></div>
			</div>
			<div class="messages" id="Messages" runat="server" visible="false">
				<div id="message-error" class="message message-error">
					<div class="image">
						<img src="resources\images\icons\error-1.png" alt="Error" height="32">
					</div>
					<div class="text">
						<h6>Error Message</h6>
						<span>Wrong credentials. Login failed!!!!</span>
					</div>
					<div class="dismiss">
						<a href="#message-error"></a>
					</div>
				</div>
			</div>
			<div class="inner">
				<form  runat="server">
				<div class="form">
					<!-- fields -->
					<div class="fields">
						<div class="field">
							<div class="label">
								<label for="username">Email Id:</label>
							</div>
							<div class="input">
                                
                                <asp:TextBox ID="txtUserName" runat="server" text="" class="focus"></asp:TextBox>
								<%--<input type="text" id="username" name="username" size="40" value="admin" >--%>
							</div>
						</div>
						<div class="field">
							<div class="label">
								<label for="password">Password:</label>
							</div>
							<div class="input">
								<%--<input type="password" id="password" name="password" size="40" value="password" class="focus">--%>
                                <asp:TextBox ID="txtPassword" TextMode="Password" Text="" runat="server" class="focus"></asp:TextBox>
							</div>
						</div>
						<%--<div class="field">
							<div class="checkbox">
								<input type="checkbox" id="remember" name="remember">
								<label for="remember">Remember me</label>
							</div>
						</div>--%>
						<div class="buttons">
                            <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" />
							<%--<input type="submit" value="Sign In">--%>
						</div>
					</div>
					<!-- end fields -->
					<!-- links -->
					<div class="links">
						<a href="Register.aspx">Signup</a>
					</div>
					<!-- end links -->
				</div>
				</form>
			</div>
			
		</div>
	</body>
</html>