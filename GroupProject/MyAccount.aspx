<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="GroupProject.MyAccount" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 92px;
        }
        .auto-style2 {
            width: 97px;
        }
        .auto-style3 {
            width: 99px;
        }
        .auto-style4 {
            width: 139px;
        }
        .StudentPNL {
            margin-top: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div id="content">

         <br />
          Welcome to My Account page. Here you can view your account details and Quiz Report of all the quizes you have taken online.
         <br />
         <br />

         <h4><i><u>Account Details:</u></i></h4>

    <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("UserPicture")%>' Width="177px" Height="193px" ImageAlign="Left" />
     
         
          <asp:Panel ID="pnlStudentInfo" HorizontalAlign="Center" runat="server" CssClass="StudentPNL" Height="207px" Width="447px">
            <table>
                <tr>
                    <td class="auto-style1">User ID:</td>
                    <td>
                        <asp:Label ID="lblUserid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
             </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style2" >First Name:</td>
                    <td>
                        <asp:Label ID="lblFirstname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style3" >Last Name:</td>
                    <td>
                        <asp:Label ID="lblLastname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style3" >Class ID:</td>
                    <td>
                        <asp:Label ID="lblClassid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style2" >Email:</td>
                    <td class="auto-style4">
                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
  </asp:Panel>

         <br />
         

         <asp:Panel ID="pnlStudentQuizReport" runat="server">

             <hr />
         <br />

             <h4><i><u>Your Quiz Report:</u></i></h4>

         <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

         <rsweb:ReportViewer ID="ReportViewer1" 
                AsyncRendering="false" SizeToReportContent="true" Width="545px"
             runat="server"></rsweb:ReportViewer>


         </asp:Panel>
  
         </div>
</asp:Content>


