<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="GroupProject.MyAccount" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div id="content">

    <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("UserPicture")%>' Width="177px" Height="193px" ImageAlign="Left" />
      <asp:Panel ID="pnlStudentInfo" runat="server" CssClass="StudentPNL" Height="216px" Width="278px">
            <table>
                <tr>
                    <td>User ID:</td>
                    <td>
                        <asp:Label ID="lblUserid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
             </table>
          <br />
          <table>
                <tr>
                    <td >First Name:</td>
                    <td>
                        <asp:Label ID="lblFirstname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td >Last Name:</td>
                    <td>
                        <asp:Label ID="lblLastname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td >Class ID:</td>
                    <td>
                        <asp:Label ID="lblClassid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td >Email:</td>
                    <td>
                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
  </asp:Panel>

         <br />
         <br />

         <asp:Panel ID="pnlStudentQuizReport" runat="server">

         <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

         <rsweb:ReportViewer ID="ReportViewer1" 
                AsyncRendering="false" SizeToReportContent="true" Width="700px"
             runat="server"></rsweb:ReportViewer>


         </asp:Panel>
  
         </div>
</asp:Content>


