<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="GroupProject.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GVUsers" runat="server"
         CssClass="mGrid">
    <Columns>
        <asp:BoundField DataField="Userid" HeaderText="User ID" />
        <asp:BoundField DataField="Firstname" HeaderText="First Name" />
        <asp:BoundField DataField="Lastname" HeaderText="Last Name" />
        <asp:BoundField DataField="Username" HeaderText="UserName" />
        <asp:BoundField DataField="Password" HeaderText="Password" />
        <asp:BoundField DataField="Email" HeaderText="Email" />
        <asp:BoundField DataField="Classid" HeaderText="Class ID" />
        <asp:BoundField DataField="SecurityLevel" HeaderText="Security Level" />
    </Columns>
    </asp:GridView>
</asp:Content>
