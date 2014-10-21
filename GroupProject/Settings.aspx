<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="GroupProject.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:GridView ID="gvSettings" runat="server" OnRowCommand="gvSettings_RowCommand">
        <Columns>
           <%--<asp:ButtonField CommandName="Del" Text="Delete" ButtonType="Button" />--%>
           <asp:ButtonField CommandName="Upd" Text="Update" ButtonType="Button" />
            <asp:BoundField DataField="Userid" HeaderText="Userid" />
            <asp:BoundField DataField="Firstname" HeaderText="Firstname" />
            <asp:BoundField DataField="Lastname" HeaderText="Lastname" />
            <asp:BoundField DataField="Username" HeaderText="Username" />
            <asp:BoundField DataField="Password" HeaderText="Password" />
            <asp:BoundField DataField="Classid" HeaderText="Classid" /> 
            <asp:BoundField DataField="SecurityLevel" HeaderText="SecurityLevel"/>           
        </Columns>
   </asp:GridView>

        <asp:Panel ID="pn1Upd" runat="server" Visible="false" ScrollBars="Horizontal" BackColor="#CCCCCC" Height="308px" Width="376px">
          
           Userid
           <asp:TextBox ID="txtUserid" runat="server" ForeColor="Black"></asp:TextBox>
            <br />
           Firstname
           <asp:TextBox ID="txtFirstname" runat="server" ForeColor="Black"></asp:TextBox>
           <br />
           Lastname
           <asp:TextBox ID="txtLastname" runat="server" ForeColor="Black"></asp:TextBox>
           <br />
           Username
           <asp:TextBox ID="txtUsername" runat="server" ForeColor="Black"></asp:TextBox>
           <br />
           Password
           <asp:TextBox ID="txtPassword" runat="server" ForeColor="Black"></asp:TextBox>
             <br />
           Classid
           <asp:TextBox ID="txtClassid" runat="server" ForeColor="Black"></asp:TextBox>
             <br />
           Security
           <asp:TextBox ID="txtSecurityLevel" runat="server" ForeColor="Black"></asp:TextBox>
           <br />
           
           <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
           <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
           </asp:Panel> 
</asp:Content>

