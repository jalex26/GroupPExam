<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="GroupProject.MyAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("UserPicture")%>' Width="254px" Height="208px" ImageAlign="Left" />
      <asp:Panel ID="pnlStudentInfo" runat="server" CssClass="StudentPNL" Height="216px" Width="278px">
            <table>
                <tr>
                    <td class="auto-style2">User ID:</td>
                    <td>
                        <asp:Label ID="lblUserid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
             </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style2">First Name:</td>
                    <td>
                        <asp:Label ID="lblFirstname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style2">Last Name:</td>
                    <td>
                        <asp:Label ID="lblLastname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style2">Class ID:</td>
                    <td>
                        <asp:Label ID="lblClassid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td class="auto-style2">Email Address:</td>
                    <td>
                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
  </asp:Panel>
    <a>Would You Like To Change Your Password Click Here ---></a>
    <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="button2" OnClick="btnChangePassword_Click" />
</asp:Content>
<%--      <asp:Panel ID="Panel1" runat="server" Height="216px" Width="278px">--%>
           <%-- <table>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="TextBox4" runat="server" TextMode="Password" Width="161px"></asp:TextBox>
                    </td>
                </tr>
            </table>
                  <asp:Button ID="Button1" runat="server" Text="Save" />
                  <asp:Button ID="Button2" runat="server" Text="Cancel" />
  </asp:Panel>--%>
