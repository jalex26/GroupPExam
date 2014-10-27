<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MentorPage.aspx.cs" Inherits="GroupProject.MentorPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.ComponentModel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="js/jquery-2.1.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            
        });
        function deselect(e) {
            $('.pop').slideFadeToggle(function () {
                //$("#aGetStudents").removeClass('selected');
                e.removeClass('selected');
            });
        }

        $(function () {
            $('#aGetStudents').on('click', function () {
                if ($(this).hasClass('selected')) {
                    deselect($(this));
                } else {
                    $(this).addClass('selected');
                    $('.pop').slideFadeToggle();
                }
                return false;
            });

            $('.close').on('click', function () {
                deselect($('#aGetStudents'));
                return false;
            });
        });

        $.fn.slideFadeToggle = function (easing, callback) {
            return this.animate({
                opacity: 'toggle',
                height: 'toggle'
            }, 'slow', easing, callback);
        };
        deselect($('#aGetStudents'));


    </script>
    <!--[if IE 6]>
	<script type="text/javascript" src="js/jquery.nyroModal-ie6.min.js"></script>
<![endif]-->

    <div>
        <asp:Button ID="btnViewQuiz" runat="server" Text="View Quiz" OnClick="btnViewQuiz_Click" />
        <asp:Button ID="btnIssueQuiz" runat="server" Text="Issue Quiz" OnClick="btnIssueQuiz_Click" />
        <asp:Button ID="btnCreateQuiz" runat="server" Text="Create Quiz" />
        <asp:Button ID="btnUploadQuiz" runat="server" Text="Upload Quiz" OnClick="btnUploadQuiz_Click" />
    </div>
    <div class="messagepop pop">

        <asp:CheckBoxList ID="cblStudents" runat="server" RepeatColumns="3"></asp:CheckBoxList>
        <a class="close" href="/">Close</a>
    </div>
    <asp:Panel ID="pnlIssueQuiz" runat="server" Visible="false">
        <div style="text-align: center;">
            <div style="width: 50%; margin: 0 auto; text-align: left;">
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <asp:Label ID="lbId" runat="server" Visible="true"></asp:Label>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Course:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlCourse" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lbClass" runat="server" Text="Class"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSelectQuiz" runat="server" Text="Select a Quiz"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbCourseid" runat="server" Text="" Visible="false"></asp:Label>
                            <asp:DropDownList ID="ddlSelectQuiz" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlSelectQuiz_SelectedIndexChanged"></asp:DropDownList>
                            <asp:ToolkitScriptManager ID="TSM1" runat="server"></asp:ToolkitScriptManager>
                            <asp:Button ID="btnViewDemoQuiz" runat="server" Text="View Quiz" OnClick="btnViewDemoQuiz_Click"></asp:Button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblVersion" runat="server" Text="Version"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlVersion" runat="server" OnSelectedIndexChanged="ddlVersion_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbStudents" runat="server" Text="Students"></asp:Label>
                        </td>
                        <td>
                            <a href="/" id="aGetStudents">Select Students</a>


                        </td>
                    </tr>
                    <tr>
                        <td>Quiz Duration:</td>
                        <td>
                            <asp:Label ID="lblQuizDuration" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" Text="Issue Quiz" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlUploadQuiz" runat="server" Visible="false">
        <table>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="lblFileUpload" runat="server" Text="Upload a Quiz"></asp:Label></td>
            </tr>
            <tr>
                <td></td>
                <td>

                    <asp:FileUpload ID="fuploadQuiz" runat="server" />
                    <asp:Button ID="btnUploadFile" runat="server" Text="Upload" OnClick="btnUploadFile_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlViewQuiz" runat="server">
        <asp:GridView ID="gvViewQuiz" runat="server" Visible="false"></asp:GridView>
    </asp:Panel>

    <asp:Panel ID="pnlViewExam" BorderColor="Red" runat="server" CssClass="ModalPopUp">

        <div>
            <asp:DataList ID="DLExamDemo" RepeatColumns="1" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                    <div>
                        Question ID. <%#((XmlNode)Container.DataItem).SelectSingleNode("//ns:Quiz//ns:Questions//ns:MultipleChoice//ns:Question//ns:Questi", ns).InnerText%><br />
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </asp:Panel>
    <asp:ModalPopupExtender ID="MPE1" TargetControlID="btnViewDemoQuiz" PopupControlID="pnlViewExam" BackgroundCssClass="ModalBackground" runat="server"></asp:ModalPopupExtender>

</asp:Content>
