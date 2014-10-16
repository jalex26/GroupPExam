﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestForm.aspx.cs" Inherits="GroupProject.TestForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.js"></script>
</head>
<body>
    <div data-role="page">
  <div data-role="header">
    <h1>Welcome To My Homepage</h1>
  </div>

  <div data-role="main" class="ui-content">
    <a href="#myPopup" data-rel="popup" class="ui-btn ui-btn-inline ui-corner-all">Show Popup</a>

    <div data-role="popup" id="myPopup" class="ui-content" data-dismissible="false" style="max-width:400px;">
      <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
      <p>I am an undismissible button (data-dismissible="false). The only way to close me is by clicking on the close button, which is positioned at the top right corner. You cannot close me by clicking outside of me.</p>
    </div>
  </div>

  <div data-role="footer">
    <h1>Footer Text</h1>
  </div>
</div> 
</body>
</html>
