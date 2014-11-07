<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Quizes.aspx.cs" Inherits="GroupProject.Quizes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <script src="js/jquery-2.1.1.js"></script>--%>

    <asp:Button ID="btnLoadQuiz" runat="server" Text="LoadYourQuiz tem Button" OnClick="btnLoadQuiz_Click" />
    <div>
        <asp:Panel ID="pnlMultipleQuestion" runat="server" Visible="false">
            <asp:Label ID="lblQuestionId" Text="Question #" runat="server" />
            <br />
            <asp:Label ID="lblQuestion" runat="server" />
            <br />
            <asp:RadioButton ID="rdoOption1" runat="server" /><br />
            <asp:RadioButton ID="rdoOption2" runat="server" /><br />
            <asp:RadioButton ID="rdoOption3" runat="server" /><br />
            <asp:RadioButton ID="rdoOption4" runat="server" />
            <p contenteditable="true" spellcheck="true">heres</p>
            <input type="text" spellcheck="true" name="name"  />
        </asp:Panel>
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/TestXSL.aspx">LinkButton</asp:LinkButton>

    </div>
    <div>
        <asp:DataList ID="dlPendingQuiz" RepeatColumns="1" runat="server" DataKeyField="XMLQuizID" OnItemCommand="dlPendingQuiz_ItemCommand">
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
