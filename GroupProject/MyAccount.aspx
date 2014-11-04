<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="GroupProject.MyAccount" %>
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
  
         </div>
</asp:Content>


