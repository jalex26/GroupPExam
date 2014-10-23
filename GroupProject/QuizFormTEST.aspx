<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizFormTEST.aspx.cs" Inherits="GroupProject.QuizFormTEST" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:DataList ID="dlXML" runat="server">
            <HeaderTemplate>
                My CD Catalog
            </HeaderTemplate>

            <ItemTemplate>
                <strong>PostedXml: </strong>
                <asp:Label ID="PostedXmlLabel" runat="server" Text='<%# System.Web.HttpUtility.HtmlEncode((string)Eval("XmlFile")) %>' />      
            </ItemTemplate>

            <FooterTemplate>
                © Hege Refsnes
            </FooterTemplate>
        </asp:DataList>
    </div>
    </form>
</body>
</html>
