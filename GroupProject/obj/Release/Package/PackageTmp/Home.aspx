<%@ Page Title="Robertson Online Quiz" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="GroupProject.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"> 

    <!-- JS testing javascript carousal for pictures -->
    <script src="js/jquery-1.4.1.min.js"></script>
    <script src="js/jquery.jcarousel.pack.js"></script>
    <script src="js/jquery-func.js"></script>
    <!-- End JS -->
 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      
  <div class="sliderpanelmargin">
            <!-- Content Slider -->
			<div id="slider" class="box">
				<div id="slider-holder">
					<ul>
					    <li><a href="#"><img src="Pictures/students4.jpg" alt="" style="height: 320px; width: 652px; border:medium;" /></a></li>
					    <li><a href="#"><img src="Pictures/s2.jpg" alt="" style="height: 320px; width: 652px; border:medium;" /></a></li>
					    <li><a href="#"><img src="Pictures/1.jpg" alt="" style="height: 320px; width: 652px; border:medium;" /></a></li>
					    <li><a href="#"><img src="Pictures/students3.jpg" alt="" style="height: 320px; width: 652px; border:medium;" /></a></li>
                         <li><a href="#"><img src="Pictures/2.jpg" alt="" style="height: 320px; width: 652px; border:medium;" /></a></li>
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

            <br />
            <br />

    <div class="collegeInfo">
    <img src="Pictures/top-business-school.png" style="width:200px; height:200px;"  />
    <img src="Pictures/student-oriented.png" style="width:220px; height:200px;"   />
    <img src="Pictures/program-variety.png" style="width:220px; height:200px;"  />
    <img src="Pictures/career-focused.png" style="width:220px; height:200px;"  />
    </div>

    <div id="content">

        <asp:Panel ID="Panel1" HorizontalAlign="Center" style="margin-left:100px;" runat="server">
           
             <div class="colHeader">  
        <h3>Be Employment Ready In 1 Year Or Less</h3>
        <h4>The college that sticks with you for life.</h4>

                  </div>
        Robertson College will have you career ready in 12 months or less through one of our diploma programs in business, technology or healthcare. 
        Throughout your program, we work with you to find your first job in your new career.
        We will be here to help you not only now, but 25 years down your career path!

            </asp:Panel> 

    </div>

</asp:Content>
