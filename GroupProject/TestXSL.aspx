<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestXSL.aspx.cs" Inherits="GroupProject.TestXSL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <%-- <script>
        $(document).ready(function () {
            // The DOM (document object model) is constructed
            // We will initialize and run our plugin here
            var tmp = [
            '<Question>',
            '<Questi>Richard</Questi>',
            '<Options>Richard</Options>',
            '</Question>'].join('');

            //var xmlDoc = $.parseXML(tmp);
            var xmlDoc = $(tmp);
            var QuestionElement = xmlDoc.filter('Question');

            $(QuestionElement).attr('type', 'MultipleChoice');

            // would like to append <age>28</age> to personElement
            $(QuestionElement).append('<answer></answer>');

            $('body').append(xmlDoc);
        });

    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Xml ID="Xml1" runat="server"></asp:Xml>
    </div>
    


    </form>
</body>
</html>
