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



    <%-- Main content panel starts here--%>

    <div id="content">
    

            <asp:Panel ID="pnlbuttons" runat="server">

                <asp:Button CssClass="ButtonsOnMentorPage" ID="btnViewQuiz" runat="server" Text="View Quiz" OnClick="btnViewQuiz_Click" Width="98px" />

                <asp:Button CssClass="ButtonsOnMentorPage" ID="btnIssueQuiz" runat="server" Text="Issue Quiz" OnClick="btnIssueQuiz_Click" Width="98px" />

                <asp:Button CssClass="ButtonsOnMentorPage" ID="btnCreateQuiz" runat="server" Text="Create Quiz" Width="98px" OnClick="btnCreateQuiz_Click" />

                <asp:Button CssClass="ButtonsOnMentorPage" ID="btnUploadQuiz" runat="server" Text="Upload Quiz" OnClick="btnUploadQuiz_Click" Width="98px" />

                <asp:Button CssClass="ButtonsOnMentorPage" ID="btnStartQuiz" runat="server" Text="Start Quiz" OnClick="btnStartQuiz_Click" Width="98px" />

            </asp:Panel>
        
        <br />
        <br />
        <br />

        <div class="messagepop pop">

            <asp:CheckBoxList ID="cblStudents" runat="server" RepeatColumns="3"></asp:CheckBoxList>
            <a class="close" href="/">Close</a>
        </div>
        <asp:Panel ID="pnlStartQuiz" runat="server">
            <asp:GridView ID="gvQuizes" runat="server" AutoGenerateColumns="false" DataKeyNames="IssuedQuizId" OnRowCommand="gvQuizes_RowCommand">
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
                                <asp:Button ID="btnSubmit" runat="server" Text="Issue Quiz" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlUploadQuiz" runat="server" Visible="false">
            <asp:Label ID="lblFileUpload" runat="server" Text="Browse and select a file to upload quiz:"></asp:Label>
            <br />
            <br />
            <table>

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
      
        <asp:GridView ID="gvViewQuiz" 
            runat="server" 
            AutoGenerateColumns="false"
            HorizontalAlign="Center"
            DataKeyNames="Versionid"
            Visible="false" Height="200px">
              <HeaderStyle BackColor="#ADADAD"></HeaderStyle>
            <AlternatingRowStyle BackColor="#CCCCCC" />
               <Columns>
                 <asp:TemplateField HeaderText="View Quiz">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbViewQuiz" Text="View Quiz"   
                            OnClick="lbViewQuiz_Click"                      
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


        <asp:Panel ID="pnlViewExam" ScrollBars="Auto" BorderColor="White" runat="server" CssClass="ModalPopUp">
            <div>
                <%--<asp:Repeater ID="rpt1" runat="server">
                <ItemTemplate>
                    Question Id: <%#XPath("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/@ID", ns) %><br />
                    <b>Question:</b> <%#XPath("/ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question/ns:Questi", ns) %><br />
                  
                </ItemTemplate>
            </asp:Repeater>--%>
                <asp:DataList ID="DLExamDemo" Width="450px" runat="server">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Repeater ID="rptMultiple" runat="server" DataSource='<%# XPathSelect("//ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns) %>'>
                            <ItemTemplate>
                                <h4>QuestionID: <%# XPath("@ID") %><br />
                                    <%-- Question: <%# XPath("Questi",ns) %> --%>
                                Question: <%#XPath("*[local-name()='Questi' and namespace-uri()='urn:Question-Schema']")%>

                                    <%--<asp:DataList ID="DLOptions" runat="server" DataSource='<%# XPathSelect("//ns:Options//ns:Option",ns) %>'>
                                <ItemTemplate>
                                    a: <%#XPath("*[local-name()='Option' and namespace-uri()='urn:Question-Schema']")%>
                                </ItemTemplate>
                            </asp:DataList>--%>
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
                                        <%--<%#XPath("*[local-name()='.' and namespace-uri()='urn:Question-Schema']")%>--%>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <br />

                            </ItemTemplate>
                            <SeparatorTemplate>
                                <hr style="border: solid 2px #c0c0c0" />
                            </SeparatorTemplate>
                        </asp:Repeater>


                        <%-- <asp:Repeater ID="repeat1" runat="server" DataSource='<%# DataBinder.Eval(((System.Xml.XmlNode)(Container.DataItem)).SelectNodes("/ns:Quiz/ns:Questions/ns:MultipleChoice", ns),null) %>'>
                        <ItemTemplate>
                            <h4>
                                Question no <%# XPath("//ns:Question[@id]",ns) %> :
                                <%# XPath("//ns:Questi",ns) %>
                            </h4>

                        </ItemTemplate>--%>

                        <%-- Question ID. <%#((XmlNode)Container.DataItem).SelectSingleNode("//ns:Questions//ns:MultipleChoice//ns:Question//ns:Questi", ns).InnerText%><br />--%>

                        <%--</asp:Repeater>--%>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <asp:Button ID="btnPopUpClose" Text="Close" runat="server" OnClick="btnPopUpClose_Click" />
        </asp:Panel>

        <div class="JavascriptButtons">
            <asp:Button ID="Button1" runat="server" Text="Button" Visible="true" />
            <asp:Button ID="Button2" runat="server" Text="Button" Visible="true" />
        </div>
        <asp:Panel ID="pnlQuizAction" ScrollBars="Auto" BorderColor="White" runat="server" CssClass="ModalPopUp">
            
            <table>
                <tr>
                    <td>ID:</td>
                    <td>
                        <asp:Label ID="lblIssuedQuizId" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Title:</td>
                    <td><asp:Label ID="lblTitle" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Time to take:</td>
                    <td><asp:Label ID="lblTime" runat="server" ></asp:Label></td>
                </tr>
                <tr>
                    <td>Class:</td>
                    <td><asp:Label ID="lblClass" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td>Status:</td>
                    <td>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label></td>
                </tr>
            </table>
            <asp:Button ID="btnStart" runat="server" Text="Start Quiz" OnClick="btnStart_Click" />
            <asp:Button ID="btnEnd" runat="server" Text="End Quiz" />
            <asp:Button ID="btnDelete" runat="server" Text="Cancel Quiz" /><br />
            <asp:Button ID="btnClosePopUp" Text="Close" runat="server" OnClick="btnClosePopUp_Click" />
        </asp:Panel>

        <asp:ModalPopupExtender ID="MPE1" TargetControlID="Button1" PopupControlID="pnlViewExam" BackgroundCssClass="ModalBackground" runat="server"></asp:ModalPopupExtender>
        <asp:ModalPopupExtender ID="MPEQuizAction" TargetControlID="Button2" PopupControlID="pnlQuizAction" BackgroundCssClass="ModalBackground" runat="server"></asp:ModalPopupExtender>

    </div>
    <%-- main content panel ends here--%>
</asp:Content>
