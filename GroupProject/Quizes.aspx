<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Quizes.aspx.cs" Inherits="GroupProject.Quizes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <script src="js/jquery-2.1.1.js"></script>--%>
    <div id="content">

        <asp:Panel ID="Panel2" HorizontalAlign="Center" runat="server">

            <img src="Pictures/online-testing-assessments2.jpg" />

        </asp:Panel>
        <br />
        <br />

        <h3>Your Available Quizes:</h3>
        <br />
        <br />

        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>


        <asp:DataList ID="dlPendingQuiz" RepeatColumns="1" runat="server" DataKeyField="QuizStudentid" OnItemCommand="dlPendingQuiz_ItemCommand" CellSpacing="20" CellPadding="-1" OnSelectedIndexChanged="dlPendingQuiz_SelectedIndexChanged">
            <ItemTemplate>
                <div id="Quizes" style="border:solid; border-color:maroon; border-width:thin">
                    
                    <div class="ImgQuiz">
                        <asp:Image ID="imgTakeQuiz" Width="100%" Height="100%" runat="server" ImageUrl="~/Pictures/takeQuiz.jpg" />
                    </div>
                    <div id="QuizInfo">
                        <table>
                            <tr>
                                <td>Title:</td>
                                <td><asp:Label ID="lblTitle" runat="server" Text='<%#Eval("Title") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Subject:</td>
                                <td><asp:Label ID="lblSubject" runat="server" Text='<%#Eval("Subject") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Estimated Time to take:</td>
                                <td><asp:Label ID="lblTime" runat="server" Text='<%#Eval("Time") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td><asp:Button ID="btnStartQuiz" CommandName="Start" CommandArgument='<%#Eval("QuizStudentid") %>' runat="server" Text="Start Quiz" /></td>
                            </tr>
                        </table>
                        
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>
