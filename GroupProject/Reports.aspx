<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="GroupProject.Reports" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.ComponentModel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">

        function HideMPE() {
            $find("mpeView").hide();
            $find("mpeAction").hide();
            return false;
        }

    </script>
    <div id="content">

        <asp:Panel ID="Panel1" runat="server">
            Select a Report to View Details:
            &nbsp; &nbsp;
            <asp:DropDownList ID="ddlReports" AutoPostBack="true" OnSelectedIndexChanged="ddlReports_SelectedIndexChanged" runat="server">
                <asp:ListItem Value="0" Text="Issued Quizes"></asp:ListItem>
                <asp:ListItem Value="1" Text="Offline Quizes"></asp:ListItem>
                <asp:ListItem Value="2" Text="Online Quizes"></asp:ListItem>
                <asp:ListItem Value="3" Text="Completed Quizes"></asp:ListItem>
                <asp:ListItem Value="4" Text="Studentwise Quiz Response Report"></asp:ListItem>
                <asp:ListItem Value="5" Text="Quiz Analysis"></asp:ListItem>
                <asp:ListItem Value="6" Text="View Student Responses"></asp:ListItem>

            </asp:DropDownList>

            <br />
            <br />

            <asp:Panel ID="pnlAdditionalDetails" Visible="false" runat="server">
                Select Course:
                <asp:DropDownList ID="ddlCourse" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged" AutoPostBack="true" runat="server">
                </asp:DropDownList>

                <asp:Label ID="lblClass" runat="server" Text="Select Class:"></asp:Label>
                <asp:DropDownList ID="ddlClass" AutoPostBack="true" runat="server">
                </asp:DropDownList>

                <br />
                <br />
                Select Quiz:
            <asp:DropDownList ID="ddlQuiz" OnSelectedIndexChanged="ddlQuiz_SelectedIndexChanged" AutoPostBack="true" runat="server">
            </asp:DropDownList>

                Select Version:
                   <asp:DropDownList ID="ddlVersion" runat="server">
                   </asp:DropDownList>
            </asp:Panel>
            <br />
            <br />
            Click the View Report Button to Get Data:
               <asp:Button ID="btnViewReport" runat="server" Text="View Report" OnClick="btnViewReport_Click" />

        </asp:Panel>

        <br />
        <br />
        <br />
        <asp:Panel ID="Panel2" HorizontalAlign="Center" Font-Size="Medium" Font-Italic="true" runat="server">
            <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
        </asp:Panel>
        <br />
        <br />

        <asp:Panel ID="pnlIssuedQuizes" runat="server">
            <asp:GridView ID="gvIssuedQuizes"
                DataKeyNames="Versionid"
                HorizontalAlign="Center"
                GridLines="None"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AutoGenerateColumns="false"
                Visible="false"
                runat="server">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center"
                        ItemStyle-HorizontalAlign="Center" HeaderText="View Quiz">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbViewQuiz" Text="View Quiz"
                                OnClick="lbViewQuiz_Click"
                                runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="IssuedQuizId" HeaderText="Quiz ID" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Versionid" HeaderText="Version" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Classname" HeaderText="Class" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="DateIssued" HeaderText="Date Issued" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Mentor" HeaderText="Issued by (Mentor)" />
                </Columns>
            </asp:GridView>
        </asp:Panel>

        <asp:GridView ID="gvViewStudentResponse" runat="server"
            DataKeyNames="QuizStudentid" HorizontalAlign="Center"
            GridLines="None"
            CssClass="mGrid"
            PagerStyle-CssClass="pgr"
            AutoGenerateColumns="false"
            Visible="false">
            <Columns>
                <asp:TemplateField HeaderStyle-HorizontalAlign="Center"
                    ItemStyle-HorizontalAlign="Center" HeaderText="View Response Report">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbViewStudentResponse" Text="View"
                            OnClick="lbViewStudentResponse_Click"
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="QuizStudentid" HeaderText="QuizStudent ID" />
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="IssuedQuizId" HeaderText="Issued Quiz ID" />
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Userid" HeaderText="User ID/ Student ID" />
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="StudentName" HeaderText="Student Name" />
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="StatusName" HeaderText="Quiz Status" />
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Points" HeaderText="Points Scored" />
            </Columns>
        </asp:GridView>

        <ajaxToolkit:ToolkitScriptManager ID="TSM1" runat="server"
            CombineScripts="false" ScriptMode="Release">
        </ajaxToolkit:ToolkitScriptManager>

        <rsweb:ReportViewer ID="ReportViewer1" runat="server"
            AsyncRendering="false" SizeToReportContent="true" Width="700px">
        </rsweb:ReportViewer>


        <asp:GridView ID="gvTest" runat="server"></asp:GridView>


        <%--    Pop View Quiz Repeater Starts Here--%>

        <asp:Panel ID="pnlViewQuiz" ScrollBars="Auto" BorderColor="White" runat="server" CssClass="ModalPopUp">
            <asp:DataList ID="DLExamDemo" Width="100%" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Repeater ID="rptMultiple" runat="server" DataSource='<%# XPathSelect("//ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns) %>'>
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
            <asp:Button ID="btnPopUpClose" Text="Close" runat="server" OnClientClick="return HideMPE()" OnClick="btnPopUpClose_Click" />
        </asp:Panel>

        <%-- another datalist to show student repsonse report--%>

        <asp:Panel ID="pnlViewResponseReport" ScrollBars="Auto" BorderColor="White" runat="server" CssClass="ModalPopUp">
            <div>
                <hr />
                Part I: Multiple Choice
                <hr />
                <asp:DataList ID="DLViewResponseReport" Width="100%" runat="server" Style="margin-bottom: 0px">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Repeater ID="rptMultiple" runat="server" DataSource='<%# XPathSelect("//ns:Quiz/ns:Questions/ns:MultipleChoice/ns:Question", ns) %>' OnItemDataBound="rptMultiple_ItemDataBound">
                            <ItemTemplate>
                                <div id="Question" runat="server">
                                    <h4>QuestionID: <%# XPath("@ID") %><br />

                                        Question: <%#XPath("*[local-name()='Questi' and namespace-uri()='urn:Question-Schema']")%>

                                    </h4>
                                    <asp:Repeater ID="rpt2" runat="server" DataSource='<%# XPathSelect("ns:Options/ns:Option",ns) %>'>
                                        <ItemTemplate>
                                            Option: <%# XPath(".") %>
                                            <br />
                                        </ItemTemplate>
                                    </asp:Repeater>

                                   
                                    <asp:Repeater ID="rpt3" runat="server" DataSource='<%# XPathSelect("ns:Options/ns:Option/@Correct",ns) %>' OnItemDataBound="rpt3_ItemDataBound">
                                        <ItemTemplate>
                                            Correct Answer: 
                                            <asp:Label ID="lblAnswer" runat="server" Text='<%# XPath("..") %>'></asp:Label>
                                            <br /></ItemTemplate></asp:Repeater>

                                    <h4>Student Answer: 
                          <%# XPath("*[local-name()='UserAnswer' and namespace-uri()='urn:Question-Schema']")%> </h4>
                                    <%--<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# XPath("*[local-name()='UserAnswer' and namespace-uri()=urn:Question-Schema]")%>' />--%>

                                   <%-- <input type="hidden" id="lblStuAnswer"
               value="<%# XPath("*[local-name()='UserAnswer' and namespace-uri()='urn:Question-Schema']")%>" />--%>
                                            <%--<asp:Label ID="lblStuAnswer" runat="server" Text='<%# XPath("*[local-name()='UserAnswer' and namespace-uri()='urn:Question-Schema']")%> '></asp:Label>--%>
                                </div>
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
                <asp:DataList ID="DLViewResponseReportFillin" Width="100%" runat="server">
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
                                <h4>Student Answer: <%#XPath("*[local-name()='UserAnswer' and namespace-uri()='urn:Question-Schema']")%></h4>

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

                <asp:DataList ID="DLViewResponseReportTrueFalse" Width="100%" runat="server">
                    <HeaderTemplate />
                    <ItemTemplate>
                        <asp:Repeater ID="rptTrueFalse" runat="server" DataSource='<%# XPathSelect("//ns:Quiz/ns:Questions/ns:TrueFalse/ns:Question", ns) %>'>
                            <ItemTemplate>
                                <h4>QuestionID: <%# XPath("@ID") %><br />
                                    Question: <%#XPath("*[local-name()='Questi' and namespace-uri()='urn:Question-Schema']")%>
                                </h4>

                                Answer: <%#XPath("*[local-name()='Answer' and namespace-uri()='urn:Question-Schema']")%>
                                <h4>Student Answer: <%#XPath("*[local-name()='UserAnswer' and namespace-uri()='urn:Question-Schema']")%></h4>

                                <br />
                            </ItemTemplate>
                            <SeparatorTemplate>
                                <hr style="border: solid 2px #c0c0c0" />
                            </SeparatorTemplate>
                        </asp:Repeater>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <asp:Button ID="btnClose2" Text="Close" OnClick="btnClose2_Click" OnClientClick="return HideMPE()" runat="server" />

        </asp:Panel>


        <div class="JavascriptButtons">
            <asp:Button ID="Button1" runat="server" Text="Button" Visible="true" />
            <asp:Button ID="Button2" runat="server" Text="Button" Visible="true" />
        </div>

        <asp:ModalPopupExtender ID="MPE1" BehaviorID="mpeView" TargetControlID="Button1" PopupControlID="pnlViewQuiz" BackgroundCssClass="ModalBackground" runat="server"></asp:ModalPopupExtender>

        <asp:ModalPopupExtender ID="MPE2" BehaviorID="mpeAction" TargetControlID="Button2" PopupControlID="pnlViewResponseReport" BackgroundCssClass="ModalBackground" runat="server"></asp:ModalPopupExtender>


    </div>

</asp:Content>
