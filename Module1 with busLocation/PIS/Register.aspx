<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BusArriaval.Register" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>PIS</title>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
		<!-- stylesheets -->
		<link rel="stylesheet" type="text/css" href="resources\css\reset-1.css"/>
		<link rel="stylesheet" type="text/css" href="resources\css\style-1.css" media="screen"/>
		<link id="color" rel="stylesheet" type="text/css" href="resources\css\colors\blue-1.css"/>
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
				<h5>Register to PIS</h5>
				<div class="corner tl"></div>
				<div class="corner tr"></div>
			</div>
			<div class="messages" id="Messages" runat="server" visible="false">
				<div id="message-error" class="message message-success">
					<div class="image">
						<img src="resources\images\icons\success-1.png" alt="Success" height="32">
					</div>
					<div class="text">
						<h6>Message</h6>
						<span>Registration Success!!!</span>
					</div>
					<div class="dismiss">
						<a href="#message-error"></a>
					</div>
				</div>
			</div>
			<div class="inner">
				<form  runat="server">
				<div class="form">
                     <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please fix the following errors to proceed"
                                ForeColor="Red" />
					<!-- fields -->
					<div class="fields">
                        <div class="field">
							<div class="label">
								<label for="username">Name:</label>
							</div>
							<div class="input">
                                <asp:TextBox ID="txtName" runat="server" class="focus"></asp:TextBox>
                                <br />
								 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtName"
                                                    ErrorMessage="Enter Name" ForeColor="Red">*</asp:RequiredFieldValidator>
							</div>
						</div>
						<div class="field">
							<div class="label">
								<label for="username">Email Id:</label>
							</div>
							<div class="input">
                                <asp:TextBox ID="txtUserName" runat="server" text="" class="focus"></asp:TextBox>
                                  <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtUserName"
                                ErrorMessage="Enter Valid Email Address" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
								<%--<input type="text" id="username" name="username" size="40" value="admin" >--%>
							</div>
						</div>
						<div class="field">
							<div class="label">
								<label for="password">Password:</label>
                                 
							</div>
							<div class="input">								
                                <asp:TextBox ID="txtPassword" TextMode="Password" Text="" runat="server" class="focus"></asp:TextBox>
                                   <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPassword"
                                                    ErrorMessage="Enter Password." ForeColor="Red">*</asp:RequiredFieldValidator>
							</div>
						</div>
                        <div class="field">
							<div class="label">
								<label for="password">Confirm Password:</label>
							</div>
							<div class="input">								
                                <asp:TextBox ID="txtconPass" TextMode="Password" Text="" runat="server" class="focus"></asp:TextBox>
                                   <br />
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match." ControlToValidate="txtconPass" ControlToCompare="txtPassword"></asp:CompareValidator>
							</div>
						</div>
                        <div class="field">
							<div class="label">
								<label for="password">Address:</label>
							</div>
							<div class="input">								
                                <asp:TextBox ID="txtAddress" Text="" runat="server" class="focus"></asp:TextBox>
							</div>
						</div>
                        <div class="field">
							<div class="label">
								<label for="password">Phone:</label>
							</div>
							<div class="input">								
                                <asp:TextBox ID="txtPhone"  Text="" runat="server" class="focus"></asp:TextBox>
                                   <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtPhone"
                                ErrorMessage="Mobile number must be 10 Characters long and Must Not contain any alphabets or special characters."
                                ForeColor="Red" ValidationExpression="[0-9]{10,10}">*</asp:RegularExpressionValidator>
							</div>
						</div>
                       
						<%--<div class="field">
							<div class="checkbox">
								<input type="checkbox" id="remember" name="remember">
								<label for="remember">Remember me</label>
							</div>
						</div>--%>
						<div class="buttons">
                            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click"  />
							<%--<input type="submit" value="Sign In">--%>
						</div>
					</div>
					<!-- end fields -->
					<!-- links -->
				<%--	<div class="links">
						<a href="index-1.html">Forgot your password?</a>
					</div>--%>
					<!-- end links -->
				</div>
				</form>
			</div>
			
		</div>
	</body>
</html>