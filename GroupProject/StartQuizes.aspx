<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StartQuizes.aspx.cs" Inherits="GroupProject.StartQuizes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:DataList ID="dlSelectedQuiz" runat="server" RepeatColumns="4" OnSelectedIndexChanged="dlSelectedQuiz_SelectedIndexChanged">
            <ItemTemplate>
                  <div >
                    <table>
                    <tr>
                    <td>
                    
                    <%#Eval("QuizTitle") %>
                    <br />
                    <br />
                    <%#Eval("QuizSubject") %>
                    <br />
                    <br />
                    <%#Eval("TimetoTake") %>
                    <br />
                    <br />
                    <%#Eval("Difficultyname") %>
                    <br />
                    <br />
                    <asp:Button ID="btnBegintheQuiz" runat="server" Text="Begin the Quiz" CommandArgument='<%#Eval("Quizid") %>' CommandName="StartQuiz"/>
                    </td>
                    <td></td>                   
                    </tr>
                </table>
            </div>
        </ItemTemplate>
        </asp:DataList>

    
    </div>
    </form>
</body>
</html>
