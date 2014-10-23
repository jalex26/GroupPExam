<%@ Import Namespace="System.Data" %>

<script  runat="server">
sub Page_Load
if Not Page.IsPostBack then
   dim mycdcatalog=New DataSet
   mycdcatalog.ReadXml(MapPath("App_Data/XMLFileTEST.xml"))
   cdcatalog.DataSource=mycdcatalog
   cdcatalog.DataBind()
end if
end sub
</script>

<!DOCTYPE html>
<html>
<body>

<form runat="server">
<asp:DataList id="cdcatalog"
runat="server"
cellpadding="2"
cellspacing="2"
borderstyle="inset"
backcolor="#e8e8e8"
width="100%"
headerstyle-font-name="Verdana"
headerstyle-font-size="12pt"
headerstyle-horizontalalign="center"
headerstyle-font-bold="True"
itemstyle-backcolor="#778899"
itemstyle-forecolor="#ffffff"
footerstyle-font-size="9pt"
footerstyle-font-italic="True">

<HeaderTemplate>
My CD Catalog
</HeaderTemplate>

<ItemTemplate>
<%--Details: <%#Container.DataItem("Details")%>
Title: "<%#Container.DataItem("Title")%>" <br /> 
Subject: <%#Container.DataItem("Subject")%> <br />
Course:  <%#Container.DataItem("Course")%> <br />
Time: <%#Container.DataItem("Time")%> <br />--%>
Difficulty: <%#Container.DataItem("Title")%>
</ItemTemplate>

<FooterTemplate>
© Hege Refsnes
</FooterTemplate>

</asp:DataList>
</form>

</body>
</html>

