<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Quizes.aspx.cs" Inherits="GroupProject.Quizes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="XMLBINDINGTEST" runat="server" Text="XML Binding Test" OnClick="XMLBINDINGTEST_Click" />   
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="QuizFormTEST" />
</asp:Content>
