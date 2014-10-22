<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="GroupProject.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:GridView ID="gvSettings" runat="server" OnRowCommand="gvSettings_RowCommand" AutoGenerateColumns="False">
        <Columns>
            <%--<asp:ButtonField CommandName="Del" Text="Delete" ButtonType="Button" />--%>
            <asp:ButtonField CommandName="Upd" Text="Update" ButtonType="Button" />
            <asp:BoundField DataField="Userid" HeaderText="User ID" />
            <asp:BoundField DataField="Firstname" HeaderText="First Name" />
            <asp:BoundField DataField="Lastname" HeaderText="Last Name" />
            <asp:BoundField DataField="Username" HeaderText="User Name" />
            <asp:BoundField DataField="Password" HeaderText="Password" />
            <asp:BoundField DataField="Classname" HeaderText="Class Name" />
        </Columns>
    </asp:GridView>

    <asp:Panel ID="pn1Upd" runat="server" Visible="false" ScrollBars="Horizontal" Height="308px" Width="376px">
        <table>
            <tr>
                <td>Userid</td>
                <td>
                    <asp:TextBox ID="txtUserid" runat="server" ForeColor="Black"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Firstname</td>
                <td>
                    <asp:TextBox ID="txtFirstname" runat="server" ForeColor="Black"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Lastname</td>
                <td>
                    <asp:TextBox ID="txtLastname" runat="server" ForeColor="Black"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Username</td>
                <td>
                    <asp:TextBox ID="txtUsername" runat="server" ForeColor="Black"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Password</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" ForeColor="Black"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Classname</td>
                <td>
                    <asp:TextBox ID="txtClassname" runat="server" ForeColor="Black"></asp:TextBox>
                </td>
            </tr>
        </table>

        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
    </asp:Panel>
</asp:Content>

