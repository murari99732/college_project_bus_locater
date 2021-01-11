<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="BusArriaval.Menu" %>
<div id="header-inner">
    <div id="home">
        <a href="AdminHome.aspx"></a>
    </div>
    <!-- quick -->
    <ul id="quick">
        <li>
            <a href="AdminHome.aspx" title="Products"><span class="normal">Home</span></a>

        </li>
        <li>
            <a href="Buses.aspx" ><span class="icon">
                <img src="resources\images\icons\application_double.png"></span><span>Buses</span>
            </a>
        </li>
        <li>
            <a href="BreakDown.aspx" ><span class="icon">
                <img src="resources\images\icons\application_double.png"></span><span>Breakdown Buses</span>
            </a>
        </li>
        <li>
            <a href="AddStops.aspx" title="Products"><span class="icon">
                <img src="resources\images\icons\application_double.png"></span><span>Add Stops</span></a>
            <ul>
                <li><a href="AllStops.aspx">All Stops</a></li>
                <li><a href="AddStops.aspx">Add Stops</a></li>
            </ul>
        </li>
        <li>
            <a href="AddRoutes.aspx" title="Events"><span class="icon">
                <img src="resources\images\icons\calendar.png"></span><span>Add Routes</span></a>
            <ul>
                <li><a href="AllRoutes.aspx">All Routes</a></li>
                <li><a href="AddRoutes.aspx">Add Routes</a></li>
            </ul>
        </li>
    </ul>
    <!-- end quick -->
    <div class="corner tl"></div>
    <div class="corner tr"></div>
</div>
