<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizForm.aspx.cs" Inherits="GroupProject.QuizForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

<asp:DataList ID="dlMultipleChoice" runat="server" Width="313px">
            <ItemTemplate>
                <asp:Label ID="lblnum" runat="server" Text=""></asp:Label>
                <asp:Label ID="Question" runat="server"
                    Text='<%# Eval("Question") %>' />
                <br />
                <br />

                <asp:RadioButton ID="Choice1" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice1" runat="server" Text="A."></asp:Label><%# Eval("Choice1") %><br />
                <asp:RadioButton ID="Choice2" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice2" runat="server" Text="B."></asp:Label><%# Eval("Choice2") %><br />
                <asp:RadioButton ID="Choice3" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice3" runat="server" Text="C."></asp:Label><%# Eval("Choice3") %><br />
                <asp:RadioButton ID="Choice4" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice4" runat="server" Text="D."></asp:Label><%# Eval("Choice4") %><br />
                <br />
                </ItemTemplate>
        </asp:DataList>
      
        </div>
     </form>

</body>
</html>
