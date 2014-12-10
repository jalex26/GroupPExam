<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MentorPage.aspx.cs" Inherits="GroupProject.MentorPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.ComponentModel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="js/jquery-2.1.1.js"></script>
    <link href="styles/QuizActionStylePoP.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tabs-menu a").click(function (event) {
                event.preventDefault();
                $(this).parent().addClass("current");
                $(this).parent().siblings().removeClass("current");
                var tab = $(this).attr("href");
                $(".tab-content").not(tab).css("display", "none");
                $(tab).fadeIn();
            });
        });

        function PopOnShown() {
            var background = $find("MPE1")._backgroundElement;
            background.onclick = function () { $find("MPE1").hide(); }
        }

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

        function ConfirmIssueQuiz() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Issue this new Quiz?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function ConfirmChangeQuizStudentStatus() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Update Student quiz status?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function HideMPE() {
            $find("mpeView").hide();
            $find("mpeAction").hide();
            return false;
        }

        function ConfirmQuizUpload() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Upload Quiz?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function ConfirmAllocateStudents() {
            var confirm_value = document.createElement("INPUT");
            var ClassToAdd = $('#ContentPlaceHolder1_ddlAssignClass option:selected').text()
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Add selected students to class '" + ClassToAdd + "'?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        $.fn.slideFadeToggle = function (easing, callback) {
            return this.animate({
                opacity: 'toggle',
                height: 'toggle'
            }, 'slow', easing, callback);
        };
        deselect($('#aGetStudents'));

        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to delete this Quiz?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        $(function () {
            $("#tabs").tabs();
        });
    </script>
    <!--[if IE 6]>
	<script type="text/javascript" src="js/jquery.nyroModal-ie6.min.js"></script>
<![endif]-->



    <%-- Main content panel starts here--%>

    <div id="content">


        <asp:Panel ID="pnlbuttons" runat="server" Height="126px">
            &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:Image ID="imgView" runat="server" Width="69px" Height="61px" ImageUrl="~/Pictures/ViewQuiz.jpg" Style="margin-top: 0px; margin-left: 0px;" />

            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
            <asp:Image ID="imgIssue" runat="server" Width="67px" Height="56px" ImageUrl="~/Pictures/checklist.png" Style="margin-left: 0px" />
            <asp:Image ID="imgCreate" runat="server" Width="75px" Height="67px" ImageUrl="~/Pictures/download.jpg" Style="margin-left: 49px" />
            <asp:Image ID="imgAllocate" runat="server" Width="70px" Height="51px" ImageUrl="~/Pictures/allocate.png" Style="margin-left: 37px; margin-top: 29px" />
            <asp:Image ID="imgUploadQuiz" runat="server" Height="67px" ImageUrl="~/Pictures/Upload.png" Style="margin-left: 16px" Width="86px" />
            <asp:Image ID="imgStart" runat="server" Height="58px" ImageUrl="~/Pictures/StartEnd.png" Style="margin-left: 16px" Width="61px" />
            <asp:Image ID="imgViewReports" runat="server" Height="61px" ImageUrl="~/Pictures/Reports2.png" Style="margin-left: 22px" Width="68px" />
            <br />
            <asp:Button ID="btnViewQuiz" runat="server" CssClass="ButtonsOnMentorPage" Height="16px" OnClick="btnViewQuiz_Click" Text="View &amp; Download Quiz" Width="127px" />
            <asp:Button ID="btnIssueQuiz" runat="server" CssClass="ButtonsOnMentorPage" Height="16px" OnClick="btnIssueQuiz_Click" Text="Issue/ Assign Quiz" Width="105px" />
            <asp:Button ID="btnCreateQuiz" runat="server" CssClass="ButtonsOnMentorPage" Height="16px" OnClick="btnCreateQuiz_Click" Text="Download ExamMaker" Width="128px" />
            <asp:Button ID="btnAllocateStudents" runat="server" CssClass="ButtonsOnMentorPage" Height="16px" OnClick="btnAllocateStudents_Click" Text="Allocate Students" Width="103px" />
            <asp:Button ID="btnUploadQuiz" runat="server" CssClass="ButtonsOnMentorPage" Height="16px" OnClick="btnUploadQuiz_Click" Text="Upload Quiz" Width="71px" />
            <asp:Button ID="btnStartQuiz" runat="server" CssClass="ButtonsOnMentorPage" Height="17px" OnClick="btnStartQuiz_Click" Text="Start/End Quiz" Width="84px" />
            <asp:Button ID="btnReports" runat="server" CssClass="ButtonsOnMentorPage" Height="16px" OnClick="btnReports_Click" Text="View Reports" Width="81px" />
            <br />
            <br />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                <br />
            <br />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />
        </asp:Panel>

        <br />
        <br />
        <br />

        <%--<div class="messagepop pop">

            <asp:CheckBoxList ID="cblStudents" runat="server" RepeatColumns="3"></asp:CheckBoxList>
            <a class="close" href="/">Close</a>
        </div>--%>
        <asp:Panel ID="pnlStartQuiz" HorizontalAlign="Center" Visible="false" runat="server">

            <h3>Start or End Quiz</h3>

            <asp:GridView ID="gvQuizes"
                runat="server"
                GridLines="None"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AutoGenerateColumns="false"
                DataKeyNames="IssuedQuizId"
                OnRowCommand="gvQuizes_RowCommand" Height="100px">
                <Columns>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Classname" HeaderText="Class" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="QuizId" HeaderText="Quiz ID" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Title" HeaderText="Title" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Subject" HeaderText="Subject" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Coursename" HeaderText="Course" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Version" HeaderText="Version" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Time" HeaderText="Time (minutes)" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="StatusName" HeaderText="Status" />
                    <asp:ButtonField ButtonType="Link" CommandName="Action" Text="Actions" />

                </Columns>
            </asp:GridView>
        </asp:Panel>

        <asp:Panel ID="pnlIssueQuiz" runat="server" Visible="false">

            <h3>Issue / Assign Quiz to Students</h3>

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
                                <%--<asp:ToolkitScriptManager ID="TSM1" runat="server"></asp:ToolkitScriptManager>--%>
                                <ajaxToolkit:ToolkitScriptManager ID="TSM1" runat="server" CombineScripts="false" ScriptMode="Release">
                                    <ControlBundles>
                                        <%-- <ajaxToolkit:ControlBundle Name="PopUp" />--%>
                                    </ControlBundles>
                                </ajaxToolkit:ToolkitScriptManager>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblVersion" runat="server" Text="Version"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVersion" runat="server" OnSelectedIndexChanged="ddlVersion_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                <asp:Button ID="btnViewDemoQuiz" runat="server" OnClick="btnViewDemoQuiz_Click" Text="View Quiz" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbStudents" runat="server" Text="Students"></asp:Label>
                            </td>
                            <td>
                                <a href="/" id="aGetStudents">Select Students</a>
                                <div class="messagepop pop">

                                    <asp:CheckBoxList ID="cblStudents" runat="server" RepeatColumns="3"></asp:CheckBoxList>
                                    <a class="close" href="/">Close</a>
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td>Quiz Duration:</td>
                            <td>
                                <asp:Label ID="lblQuizDuration" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" Text="Issue Quiz" OnClick="btnSubmit_Click" OnClientClick="ConfirmIssueQuiz()" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlUploadQuiz" runat="server" Visible="false">

            <h3>Upload Quiz to Database</h3>

            <asp:Label ID="lblFileUpload" runat="server" Text="Browse and select a file to upload quiz:"></asp:Label>
            <br />
            <br />
            <table>

                <tr>
                    <td></td>
                    <td>

                        <asp:FileUpload ID="fuploadQuiz" runat="server" />
                        <asp:Button ID="btnUploadFile" runat="server" Text="Upload" OnClick="btnUploadFile_Click" OnClientClick="ConfirmQuizUpload()" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pnlViewQuiz" Visible="false" runat="server">

            <h3>View and Download Available Quizes</h3>

            <asp:GridView ID="gvViewQuiz"
                runat="server"
                HorizontalAlign="Center"
                DataKeyNames="Versionid"
                GridLines="None"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AutoGenerateColumns="false"
                Height="200px">
                <Columns>
                    <asp:TemplateField HeaderText="View Quiz">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbViewQuiz" Text="View Quiz"
                                OnClick="lbViewQuiz_Click"
                                runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Download">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbDownloadQuiz" Text="Download"
                                OnClick="lbDownloadQuiz_Click"
                                runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="XMLQuizID" HeaderText="Quiz ID" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Title" HeaderText="Quiz Title" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Subject" HeaderText="Subject" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Version" HeaderText="Version" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Difficultyname" HeaderText="Difficulty Level" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Time" HeaderText="Time (in minutes)" />
                </Columns>
            </asp:GridView>
        </asp:Panel>


        <asp:Panel ID="pnlDownload" runat="server" Visible="false">

            <h3>Download Robertson ExamMaker Application </h3>

            <a href="Download/QuizMaker_Install.msi">Download MSI Installer</a>
            <br />
            <a href="Download/setup.exe">Download EXE Installer</a>
            <br />
        </asp:Panel>

        <asp:Panel ID="pnlAllocateStudents" runat="server" Visible="false">

            <h3>Allocate New Students to a Class</h3>

            <asp:GridView ID="gvAllocateStudents"
                runat="server"
                HorizontalAlign="Center"
                DataKeyNames="Userid"
                GridLines="None"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AutoGenerateColumns="false"
                Height="200px">
                <Columns>
                    <asp:TemplateField HeaderText="Add">
                        <ItemTemplate>
                            <asp:CheckBox ID="CBUser" runat="server" AutoPostBack="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Userid" HeaderText="User ID" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Name" HeaderText="Name" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Email" HeaderText="Email" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
            <hr />
            <asp:Panel ID="pnlAddToClass" runat="server" Visible="false">
                Assign to Class: &nbsp 
            <asp:DropDownList ID="ddlAssignClass" runat="server" AutoPostBack="true"></asp:DropDownList>
            <asp:Button ID="btnAccept" runat="server" Text="Submit" OnClick="btnAccept_Click" OnClientClick="ConfirmAllocateStudents()" />
            </asp:Panel>
            
        </asp:Panel>

        <asp:Panel ID="pnlViewExam" ScrollBars="Auto" BorderColor="White" runat="server" CssClass="ModalPopUp">
            <div>

                <hr />
                Part I: Multiple Choice
                <hr />
                <asp:DataList ID="DLExamDemo" Width="100%" runat="server">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Repeater ID="rptMultiple" runat="server" DataSource='<%# XPathSelect("//ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns) %>'>
                            <ItemTemplate>
                                <h4>QuestionID: <%# XPath("@ID") %><br />
                                    <%-- Question: <%# XPath("Questi",ns) %> --%>
                                Question: <%#XPath("*[local-name()='Questi' and namespace-uri()='urn:Question-Schema']")%>
                                </h4>
                                <asp:Repeater ID="rpt2" runat="server" DataSource='<%# XPathSelect("ns:Options/ns:Option",ns) %>'>
                                    <ItemTemplate>
                                        Option: <%# XPath(".") %>
                                        <br />
                                    </ItemTemplate>
                                </asp:Repeater>

                                <asp:Repeater ID="rpt3" runat="server" DataSource='<%# XPathSelect("ns:Options/ns:Option/@Correct",ns) %>'>
                                    <ItemTemplate>
                                        Correct Answer: <%# XPath("..") %>
                                        <br />
                                    </ItemTemplate>
                                </asp:Repeater>

                                <br />

                            </ItemTemplate>
                            <SeparatorTemplate>
                                <hr style="border: solid 2px #c0c0c0" />
                            </SeparatorTemplate>
                        </asp:Repeater>
                    </ItemTemplate>
                </asp:DataList>

                <hr />
                Part II: Fill in the blanks
                <hr />

                <asp:DataList ID="DLExamDemoFillBlanks" Width="100%" runat="server">
                    <HeaderTemplate />
                    <ItemTemplate>
                        <asp:Repeater ID="rptFillBlanks" runat="server" DataSource='<%# XPathSelect("//ns:Quiz/ns:Questions/ns:FillBlanks/ns:Question", ns) %>'>
                            <ItemTemplate>
                                <h4>QuestionID: <%# XPath("@ID") %><br />
                                    Question: <%#XPath("*[local-name()='Questi' and namespace-uri()='urn:Question-Schema']")%>
                                </h4>
                                <asp:Repeater ID="rpt2" runat="server" DataSource='<%# XPathSelect("ns:Options/ns:Option",ns) %>'>
                                    <ItemTemplate>
                                        Option: <%# XPath(".") %>
                                        <br />
                                    </ItemTemplate>
                                </asp:Repeater>
                                Correct Answer(s): 
                                <asp:Repeater ID="rpt3" runat="server" DataSource='<%# XPathSelect("ns:Options/ns:Option/@Correct",ns) %>'>
                                    <ItemTemplate>
                                        <%# XPath("..") %>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <br />
                            </ItemTemplate>
                            <SeparatorTemplate>
                                <hr style="border: solid 2px #c0c0c0" />
                            </SeparatorTemplate>
                        </asp:Repeater>
                    </ItemTemplate>
                </asp:DataList>


                <hr />
                Part III: True or False
                <hr />

                <asp:DataList ID="DLExamDemoTrueFalse" Width="100%" runat="server">
                    <HeaderTemplate />
                    <ItemTemplate>
                        <asp:Repeater ID="rptTrueFalse" runat="server" DataSource='<%# XPathSelect("//ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question", ns) %>'>
                            <ItemTemplate>
                                <h4>QuestionID: <%# XPath("@ID") %><br />
                                    Question: <%#XPath("*[local-name()='Questi' and namespace-uri()='urn:Question-Schema']")%>
                                </h4>

                                <h4>Answer: <%#XPath("*[local-name()='Answer' and namespace-uri()='urn:Question-Schema']")%>
                                </h4>
                                <br />
                            </ItemTemplate>
                            <SeparatorTemplate>
                                <hr style="border: solid 2px #c0c0c0" />
                            </SeparatorTemplate>
                        </asp:Repeater>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <asp:Button ID="btnPopUpClose" Text="Close" runat="server" OnClientClick="return HideMPE()" OnClick="btnPopUpClose_Click" />
        </asp:Panel>

        <div class="JavascriptButtons">
            <asp:Button ID="Button1" runat="server" Text="Button" Visible="true" />
            <asp:Button ID="Button2" runat="server" Text="Button" Visible="true" />
        </div>

        <asp:Panel ID="pnlQuizActionOuter"
            Style="display: none; background-color: whitesmoke;"
            HorizontalAlign="Center"
            Width="400" Height="400"
            runat="server">

            <asp:Panel ID="pnlQuizAction" ScrollBars="Auto"
                BorderColor="White" runat="server"
                Style="cursor: move; font-family: Tahoma; box-shadow: 10px 10px 5px #424242; padding: 10px; align-content: center"
                HorizontalAlign="Center" BackColor="#E3170D"
                ForeColor="White" Height="30" Width="375"
                CssClass="ModalPopUp">
                <%--ModalPopUp--%>

                <b>Start or End Quiz</b>

            </asp:Panel>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div id="tabs-container">
                        <ul class="tabs-menu">
                            <li class="current"><a href="#tab-1">Quiz</a></li>
                            <li><a href="#tab-2">Student</a></li>
                        </ul>
                        <div class="tab">
                            <div id="tab-1" class="tab-content">
                                <br />
                                <br />

                                <table align="center">
                                    <tr>
                                        <td>ID:</td>
                                        <td>
                                            <asp:Label ID="lblIssuedQuizId" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Title:</td>
                                        <td>
                                            <asp:Label ID="lblTitle" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Time to take:</td>
                                        <td>
                                            <asp:Label ID="lblTime" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Class:</td>
                                        <td>
                                            <asp:Label ID="lblClass" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Status:</td>
                                        <td>
                                            <asp:Label ID="lblStatus" runat="server"></asp:Label></td>
                                    </tr>
                                </table>

                                <asp:Button ID="btnStart" CssClass="ButtonsOnMentorPage" runat="server" Text="Start Quiz" OnClick="btnStart_Click" />
                                &nbsp;
            <asp:Button ID="btnEnd" CssClass="ButtonsOnMentorPage" runat="server" Text="End Quiz" OnClick="btnEnd_Click" />
                                &nbsp;              
            <asp:Button ID="btnDelete" CssClass="ButtonsOnMentorPage" runat="server" Text="Delete Quiz" OnClick="btnDelete_Click" OnClientClick="Confirm()" /><br />

                                <asp:Button ID="btnClosePopUp" CssClass="ButtonsOnMentorPage" Text="Close" runat="server" OnClick="btnClosePopUp_Click" OnClientClick="return HideMPE()" />


                            </div>
                            <div id="tab-2" class="tab-content">
                                <table>
                                    <tr>
                                        <td>Select Student </td>
                                        <td>
                                            <asp:DropDownList ID="ddlActionQuizStudent" runat="server"></asp:DropDownList></td> <%--im forced to disable Postback--%>
                                    </tr>
                                    <tr>
                                        <td>Change User Quiz Status to: </td>
                                        <td>
                                            <asp:DropDownList ID="ddlQuizStudentStatus" runat="server"></asp:DropDownList></td>
                                    </tr>
                                    <tr><td></td></tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <asp:Button ID="btnAcceptChanges" runat="server" Text="Accept Changes" OnClick="btnAcceptChanges_Click" OnClientClick="ConfirmChangeQuizStudentStatus()"/>&nbsp
                                            <asp:Button ID="btnCancelChanges" runat="server" Text="Cancel" OnClick="btnCancelChanges_Click" /></td>
                                        
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>


        <asp:ModalPopupExtender ID="MPE1" TargetControlID="Button1" PopupControlID="pnlViewExam" BackgroundCssClass="ModalBackground" BehaviorID="mpeView" runat="server"></asp:ModalPopupExtender>
        <asp:ModalPopupExtender ID="MPEQuizAction" BehaviorID="mpeAction" TargetControlID="Button2" PopupControlID="pnlQuizActionOuter" BackgroundCssClass="ModalBackground" runat="server"></asp:ModalPopupExtender>

    </div>
    <%-- main content panel ends here--%>
</asp:Content>
