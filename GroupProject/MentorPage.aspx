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
                
              
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
<script>
    $(document).ready(function () {
        $("#hello").dialog({ autoOpen: false });
        $("#say_it").click(function () {
            $("#hello").dialog("open");
        });
    });
</script>
            <button id="say_it">Say "Hello!"</button>
                <div id="hello" title="Hello  World!"><p><font face="Georgia" size="4">
Hey, world, I just said "Hello!"</font></p></div>
               <%-- <div id="hello" title="ohter page"><iframe width="100%" height="300px" src="demo_iframe.htm" name="hello"></iframe></div>--%>
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
