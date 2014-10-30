<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MyAccount.aspx.cs" Inherits="GroupProject.MyAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("UserPicture")%>' Width="254px" Height="208px" ImageAlign="Left" />
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
                    <td>First Name:</td>
                    <td>
                        <asp:Label ID="lblFirstname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td>Last Name:</td>
                    <td>
                        <asp:Label ID="lblLastname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td>Class ID:</td>
                    <td>
                        <asp:Label ID="lblClassid" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
              </table>
          <br />
          <table>
                <tr>
                    <td>Email Address:</td>
                    <td>
                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
  </asp:Panel>
</asp:Content>
<%--      <asp:Panel ID="Panel1" runat="server" Height="216px" Width="278px">--%>
           <%-- <table>
                <tr>
                    <td>User ID</td>
                    <td class="auto-style1">
                       <asp:TextBox ID="TextBox1" runat="server" ForeColor="Black" Width="161px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>First Name</td>
                    <td class="auto-style1">
                        <asp:TextBox ID="TextBox2" runat="server" ForeColor="Black" Width="161px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Last Name</td>
                    <td class="auto-style1">
                        <asp:TextBox ID="TextBox3" runat="server" ForeColor="Black" Width="161px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="TextBox4" runat="server" TextMode="Password" Width="161px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Class Name</td>
                    <td class="auto-style1">
                        <asp:TextBox ID="TextBox5" runat="server" ForeColor="Black" Width="161px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Email Address</td>
                    <td class="auto-style1">
                        <asp:TextBox ID="TextBox6" runat="server" Width="161px"></asp:TextBox>
                    </td>
                </tr>
            </table>
                  <asp:Button ID="Button1" runat="server" Text="Save" />
                  <asp:Button ID="Button2" runat="server" Text="Cancel" />
  </asp:Panel>--%>
