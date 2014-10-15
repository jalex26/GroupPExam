<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MentorPage.aspx.cs" Inherits="GroupProject.MentorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div>
        <asp:Button ID="btnViewQuiz" runat="server" Text="View Quiz" OnClick="btnViewQuiz_Click" />
        <asp:Button ID="btnIssueQuiz" runat="server" Text="Issue Quiz" OnClick="btnIssueQuiz_Click"/>
        <asp:Button ID="btnCreateQuiz" runat="server" Text="Create Quiz" />
        <asp:Button ID="btnUploadQuiz" runat="server" Text="Upload Quiz" OnClick="btnUploadQuiz_Click" />
    </div>
    
    <asp:Panel ID="pnlIssueQuiz" runat="server" Visible="false">
        <table>
        
        <tr>
            <td>
                <asp:Label ID="lbId" runat="server" Visible="true"></asp:Label>
            </td>
            <td></td>
        </tr>
            
        <tr>
            <td>
                <asp:Label ID="lbClass" runat="server" Text="Class"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlClass" runat="server" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList> 
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblSelectQuiz" runat="server" Text="Select a Quiz"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lbCourseid" runat="server" Text="" Visible="false"></asp:Label>
                <asp:DropDownList ID="ddlSelectQuiz" runat="server"></asp:DropDownList> 
             
                <%--<input type="button" value="New Window!" onclick="window.open('http://localhost:49966/ViewQuestions.aspx', 'mywindow', 'width=400,height=200')" />--%>
                

               
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.js"></script>


<%--<div data-role="page">--%>
  

  <div data-role="main" class="ui-content">
    <a href="#myPopup" data-rel="popup" class="ui-btn ui-btn-inline ui-corner-all">View Questions</a>

    <div data-role="popup" id="myPopup" class="ui-content" data-dismissible="false" style="max-width:400px;">
      <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
      <p>I am an undismissible button (data-dismissible="false). The only way to close me is by clicking on the close button, which is positioned at the top right corner. You cannot close me by clicking outside of me.</p>
    </div>
  </div>

  
<%--</div>--%> 










            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblVersion" runat="server" Text="Version"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlVersion" runat="server"></asp:DropDownList>    
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbStudents" runat="server" Text="Students"></asp:Label>
            </td>
            <td>
                <asp:CheckBoxList ID="cblStudents" runat="server"></asp:CheckBoxList>    
            </td>
        </tr> 
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Issue Quiz"/>
                <asp:Button ID="btnCancel" runat="server" Text="Cancel"/>
            </td>
        </tr>
    </table>
    </asp:Panel>  

    <asp:Panel ID="pnlUploadQuiz" runat="server" Visible="false">
        <table>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="lblFileUpload" runat="server" Text="Upload a Quiz"></asp:Label></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:FileUpload ID="fuploadQuiz" runat="server" />
                </td>
            </tr>
        
        </table>


    </asp:Panel>
    <asp:Panel ID="pnlViewQuiz" runat="server">
        <asp:GridView ID="gvViewQuiz" runat="server" Visible="false"></asp:GridView>
    </asp:Panel>

</asp:Content>
