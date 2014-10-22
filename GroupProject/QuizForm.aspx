<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizForm.aspx.cs" Inherits="GroupProject.QuizForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <br />
<asp:Label ID="lblMultipleChoice" runat="server" Text="MULTIPLE CHOICE:"></asp:Label><asp:Button ID="btnPrev" runat="server" Text="Prev" /><asp:Button ID="btnNext" runat="server" Text="Next" />
                <br />
                <br />
<asp:DataList ID="dlMultipleChoice" runat="server" Width="313px" >
            <ItemTemplate>
                <asp:Label ID="lblnum" runat="server" Text=""></asp:Label>
                <asp:Label ID="Question" runat="server"
                    Text='<%# Eval("Question") %>' />
                <br />
                <br />
                <asp:RadioButton ID="Choice1" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice1" runat="server" Text="A. "></asp:Label><%# Eval("Choice1") %><br />
                <asp:RadioButton ID="Choice2" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice2" runat="server" Text="B. "></asp:Label><%# Eval("Choice2") %><br />
                <asp:RadioButton ID="Choice3" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice3" runat="server" Text="C. "></asp:Label><%# Eval("Choice3") %><br />
                <asp:RadioButton ID="Choice4" runat="server" GroupName="Choices"/><asp:Label ID="lblChoice4" runat="server" Text="D. "></asp:Label><%# Eval("Choice4") %><br />
                <br />
                </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
<asp:Label ID="lblMatchingType" runat="server" Text="MATCHING TYPE:"></asp:Label>
                <br />
                <br />
<asp:DataList ID="dlMatching" runat="server" Width="313px">
            <ItemTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblnum" runat="server" Text=""></asp:Label>
                <asp:DropDownList ID="ddlMatching" runat="server"></asp:DropDownList>      
                <asp:Label ID="Question" runat="server"
                    Text='<%# Eval("Question") %>' /></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><%# Eval("Choices") %></td>
                    </tr>
                </table>
                </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
<asp:Label ID="lblTrueOrFalse" runat="server" Text="TRUE OR FALSE:"></asp:Label>
                <br />
                <br />
<asp:DataList ID="dlTrueOrFalse" runat="server" Width="313px">
            <ItemTemplate>
                <asp:Label ID="lblnum" runat="server" Text=""></asp:Label>
                <asp:Label ID="Question" runat="server"
                    Text='<%# Eval("Question") %>' />
                <br />
                <br />
                <asp:RadioButton ID="True" runat="server" GroupName="Choices"/><asp:Label ID="lblTrue" runat="server" Text="A. "></asp:Label><%# Eval("True") %><br />
                <asp:RadioButton ID="False" runat="server" GroupName="Choices"/><asp:Label ID="lblFalse" runat="server" Text="B. "></asp:Label><%# Eval("False") %><br />
                <br />
                </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
<asp:Label ID="lblFInBlanks" runat="server" Text="Fill in the Blanks:"></asp:Label>
                <br />
                <br />
<asp:DataList ID="dlFInBlanks" runat="server" Width="313px">
            <ItemTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblnum" runat="server" Text=""></asp:Label>
                <asp:Label ID="Question" runat="server"
                    Text='<%# Eval("Question") %>' /></td>
                    </tr>
                    <%--<br />
                    <br />
                        <asp:Label ID="lblPossibleAnswers" runat="server" Text="Possible Answers:"></asp:Label>
                    <br />
                    <br />
                    <tr>
                        <%# Eval("Answers") %>
                    </tr>--%>
                </table>
                </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
<asp:Label ID="lblLongAnswers" runat="server" Text="LONG ANSWERS:"></asp:Label>
                <br />
                <br />
<asp:DataList ID="dlLongAnswers" runat="server" Width="313px">
            <ItemTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblnum" runat="server" Text=""></asp:Label>
                     
                <asp:Label ID="Question" runat="server"
                    Text='<%# Eval("Question") %>' /></td>
                    </tr>
                </table>
                </ItemTemplate>
        </asp:DataList>
        </div>
     </form>
</body>
</html>
