<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="GroupProject.Reports" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.ComponentModel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">

        <asp:Panel ID="Panel1" runat="server">
            Select a Report to View Details:
            &nbsp; &nbsp;
            <asp:DropDownList ID="ddlReports" runat="server">
                <asp:ListItem Value="0" Text="Issued Quizes"></asp:ListItem>
                <asp:ListItem Value="1" Text="Offline Quizes"></asp:ListItem>
                <asp:ListItem Value="2" Text="Online Quizes"></asp:ListItem>
                <asp:ListItem Value="3" Text="Completed Quizes"></asp:ListItem>
                <asp:ListItem Value="4" Text="Student Response Report"></asp:ListItem>
                <asp:ListItem Value="5" Text="Graphical Interpretation of Student Response Report"></asp:ListItem>
                <asp:ListItem Value="6" Text="Graphical Analysis of Quiz Questions/ Test Data"></asp:ListItem>
            </asp:DropDownList>
            &nbsp; &nbsp;
            <asp:Button ID="btnViewReport" runat="server" Text="View Report" OnClick="btnViewReport_Click" />
        </asp:Panel>

        <br />
        <br />
        <br />
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

        <asp:Panel ID="pnlIssuedQuizes" runat="server">

            <asp:GridView ID="gvIssuedQuizes" 
                          DataKeyNames="Versionid"
                          HorizontalAlign="Center"
                          RowStyle-Height="30px" 
                          RowStyle-Width="120px"
                          AutoGenerateColumns="false" runat="server"
                          BorderStyle="None" GridLines="None">
                 <HeaderStyle ForeColor="White" Height="30px" BackColor="#E3170D" ></HeaderStyle>
                <AlternatingRowStyle BackColor="#CCCCCC" />
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

         <ajaxToolkit:ToolkitScriptManager ID="TSM1" runat="server"
                CombineScripts="false" ScriptMode="Release">
            </ajaxToolkit:ToolkitScriptManager>

        <%--    Pop View Quiz Repeater Starts Here--%>

        <asp:Panel ID="pnlViewQuiz" ScrollBars="Auto" BorderColor="White" runat="server" CssClass="ModalPopUp">
                <asp:DataList ID="DLExamDemo" Width="450px" runat="server">
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
               <asp:Button ID="btnPopUpClose" Text="Close" runat="server" OnClick="btnPopUpClose_Click" />
        </asp:Panel>

     

         <div class="JavascriptButtons">
        <asp:Button ID="Button1" runat="server" Text="Button" Visible="true" />
              </div>

        <asp:ModalPopupExtender ID="MPE1" TargetControlID="Button1" PopupControlID="pnlViewQuiz" BackgroundCssClass="ModalBackground" runat="server"></asp:ModalPopupExtender>


    </div>

</asp:Content>
