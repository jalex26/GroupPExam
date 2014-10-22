<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="GroupProject.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<<<<<<< HEAD
    <asp:GridView ID="gvSettings" runat="server" OnRowCommand="gvSettings_RowCommand" AutoGenerateColumns="False" DataKeyNames="Userid">
=======
    <asp:GridView ID="gvSettings" runat="server" OnRowCommand="gvSettings_RowCommand" AutoGenerateColumns="False">
>>>>>>> origin/master
        <Columns>
            <%--<asp:ButtonField CommandName="Del" Text="Delete" ButtonType="Button" />--%>
            <asp:ButtonField CommandName="Upd" Text="Update" ButtonType="Button" />
            <asp:BoundField DataField="Userid" HeaderText="User ID" />
            <asp:BoundField DataField="Firstname" HeaderText="First Name" />
            <asp:BoundField DataField="Lastname" HeaderText="Last Name" />
            <asp:BoundField DataField="Username" HeaderText="User Name" />
            <asp:BoundField DataField="Password" HeaderText="Password" />
<<<<<<< HEAD
            <asp:BoundField DataField="Classname" HeaderText="Classname" /> 
            <asp:BoundField DataField="Email" HeaderText="Email"/>           
=======
            <asp:BoundField DataField="Classname" HeaderText="Class Name" />
>>>>>>> origin/master
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

<<<<<<< HEAD
        <asp:Panel ID="pn1Upd" runat="server" Visible="false" ScrollBars="Horizontal" BackColor="#CCCCCC" Height="308px" Width="376px">
          
            <asp:Label ID="lblUserid" runat="server" Text="Userid"></asp:Label>
           <asp:TextBox ID="txtUserid" runat="server" ForeColor="Black"></asp:TextBox>
            <br />
            <asp:Label ID="lblFirstname" runat="server" Text="Firstname"></asp:Label>    
           <asp:TextBox ID="txtFirstname" runat="server" ForeColor="Black"></asp:TextBox>
           <br />
            <asp:Label ID="lblLastname" runat="server" Text="Lastname"></asp:Label>  
           <asp:TextBox ID="txtLastname" runat="server" ForeColor="Black"></asp:TextBox>
           <br />
            <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>   
           <asp:TextBox ID="txtUsername" runat="server" ForeColor="Black"></asp:TextBox>
           <br />
            <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>         
           <asp:TextBox ID="txtPassword" runat="server" ForeColor="Black"></asp:TextBox>
             <br />
            <asp:Label ID="lblClass" runat="server" Text="Class"></asp:Label> 
           <asp:TextBox ID="txtClassname" runat="server" ForeColor="Black"></asp:TextBox>
             <br />
            <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label><asp:TextBox ID="txtEmail" runat="server"></asp:TextBox> 
           <br />
           <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
           <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
           </asp:Panel> 
=======
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
    </asp:Panel>
>>>>>>> origin/master
</asp:Content>

