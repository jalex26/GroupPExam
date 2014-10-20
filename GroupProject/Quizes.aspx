<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Quizes.aspx.cs" Inherits="GroupProject.Quizes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="Panel1" runat="server">
    <div>
    <asp:Button ID="btnViewQuizResult" runat="server" Text="View Quiz Result" OnClick="btnViewQuizResult_Click" /><br/>
    <asp:Button ID="btnPendingQuiz" runat="server" Text="Pending Quiz" OnClick="btnPendingQuiz_Click" /><br />
    
    </div>
        
        <asp:GridView ID="gvViewResults" runat="server" Visible="false"></asp:GridView>
        <%--<asp:GridView ID="gvPendingQuiz" runat="server" Visible="false"></asp:GridView>--%>


        <asp:GridView ID="gvPendingQuiz" runat="server" AutoGenerateColumns="False" Visible="false" DataKeyNames="xmlQuizid" Height="20px" Width="20px" AllowPaging="True" ShowFooter="true" PageSize="5" BackColor="#CCCCCC" OnRowCommand="gvPendingQuiz_RowCommand" >
        <Columns>
            <%--<asp:ButtonField CommandName="Del" Text="Delete" ButtonType="Button" />--%>
            <asp:ButtonField CommandName="StartQuiz" Text="Start Quiz" ButtonType="Button" />
            <asp:BoundField DataField="QuizTitle" HeaderText="Title" />
            <asp:BoundField DataField="QuizSubject" HeaderText="Subject" />
            <asp:BoundField DataField="Difficultyname" HeaderText="Difficulty" />
            <asp:BoundField DataField="TimetoTake" HeaderText="Time Limit" />
            <asp:BoundField DataField="DateAndTime" HeaderText="Date&Time" /> 
            <asp:BoundField DataField="Version" HeaderText="Version"/>           
        </Columns>
    </asp:GridView> 
        <div>
        </div>

    </asp:Panel>
</asp:Content>
