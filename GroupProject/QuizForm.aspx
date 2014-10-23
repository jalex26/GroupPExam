<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizForm.aspx.cs" Inherits="GroupProject.QuizForm" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
     <form id="form1" runat="server">



         <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/Bookstore.xml"></asp:XmlDataSource>       
         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="XmlDataSource1">
             <Columns>
                 <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                 <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
                 <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" />
             </Columns>
         </asp:GridView>
         <%--<asp:XmlDataSource ID="XmlDataSource2" runat="server" DataFile="~/App_Data/XMLFileTEST.xml"></asp:XmlDataSource>
         <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="XmlDataSource2">
             <Columns>
                 <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                 <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" />
                 <asp:BoundField DataField="Course" HeaderText="Course" SortExpression="Course" />
             </Columns>
         </asp:GridView>--%>


     </form>
</body>
</html>
