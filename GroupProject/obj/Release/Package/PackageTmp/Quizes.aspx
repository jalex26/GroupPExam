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

        <asp:DataList ID="dlPendingQuiz" RepeatColumns="3"  runat="server" DataKeyField="QuizStudentid" OnItemCommand="dlPendingQuiz_ItemCommand" CellSpacing="20" CellPadding="-1">
            <ItemTemplate>
                <div>
                    <asp:Panel ID="Panel1" runat="server">
                        
                    <asp:Image ID="imgTakeQuiz" runat="server" ImageUrl="~/Pictures/takeQuiz.jpg" />
                    <br />
                    <br />
                    <asp:Label ID="lblTitle" runat="server" Text='<%#Eval("Title") %>'></asp:Label>
                    <asp:Label ID="lblSubject" runat="server" Text='<%#Eval("Subject") %>'></asp:Label>
                    <asp:Label ID="lblTime" runat="server" Text='<%#Eval("Time") %>'></asp:Label>
                        <br />
                        <br />
                    <asp:Button ID="btnStartQuiz" CommandName="Start" CommandArgument='<%#Eval("QuizStudentid") %>' runat="server" Text="Start Quiz" />
               </asp:Panel>
                         </div>
            </ItemTemplate>
        </asp:DataList> 
    </div>
</asp:Content>
