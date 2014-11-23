<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Quizes.aspx.cs" Inherits="GroupProject.Quizes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <script src="js/jquery-2.1.1.js"></script>--%>
    <div>
        <asp:DataList ID="dlPendingQuiz" RepeatColumns="1" runat="server" DataKeyField="QuizStudentid" OnItemCommand="dlPendingQuiz_ItemCommand">
            <ItemTemplate>
                <div>
                    <asp:Image ID="imgTakeQuiz" runat="server" ImageUrl="~/Pictures/takeQuiz.jpg" />
                    <asp:Label ID="lblTitle" runat="server" Text='<%#Eval("Title") %>'></asp:Label>
                    <asp:Label ID="lblSubject" runat="server" Text='<%#Eval("Subject") %>'></asp:Label>
                    <asp:Label ID="lblTime" runat="server" Text='<%#Eval("Time") %>'></asp:Label>
                    <asp:Button ID="btnStartQuiz" CommandName="Start" CommandArgument='<%#Eval("QuizStudentid") %>' runat="server" Text="Start Quiz" />
                </div>
            </ItemTemplate>
        </asp:DataList> 
    </div>
</asp:Content>
