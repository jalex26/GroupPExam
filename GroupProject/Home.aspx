<%@ Page Title="Robertson Online Quiz" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="GroupProject.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     
    <!-- JS testing javascript carousal for pictures -->
<%--    <script src="js/jquery-2.1.1.js"></script>
    <script src="js/jquery.jcarousel.pack.js"></script>
    <script src="js/jquery-func.js"></script>--%>
    <!-- End JS -->

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

 <div class="sliderpanelmargin">
            <!-- Content Slider -->
			<div id="slider" class="box">
				<div id="slider-holder">
					<ul>
					    <li><a href="#"><img src="Pictures/students4.jpg" alt="" style="height: 320px; width: 652px" /></a></li>
					    <li><a href="#"><img src="Pictures/s2.jpg" alt="" style="height: 320px; width: 652px" /></a></li>
					    <li><a href="#"><img src="Pictures/1.jpg" alt="" style="height: 320px; width: 652px" /></a></li>
					    <li><a href="#"><img src="Pictures/students3.jpg" alt="" style="height: 320px; width: 652px" /></a></li>
                         <li><a href="#"><img src="Pictures/2.jpg" alt="" style="height: 320px; width: 652px" /></a></li>
					</ul>
				</div>
				<div id="slider-nav">
					<a href="#" class="active">1</a>
					<a href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
                    <a href="#">5</a>
                    
				</div>
			</div>
			<!-- End Content Slider -->
            </div>

</asp:Content>
