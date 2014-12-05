<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="GroupProject.ManageProfiles" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function ConfirmDelete() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to delete this Course?")) {
                if (confirm("All datas associated with this course will also be deleted including Quiz Results and Students. Continue?")) {
                    confirm_value.value = "Yes";
                }
                else {
                    confirm_value.value = "No";
                }
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
        function ConfirmUpdate() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to update this Course?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
        function ConfirmCreateCourse() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Save this new Course?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function ConfirmCreateUpdateClass() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Update/Add Class?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function ConfirmDeleteClass() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to delete this Class?")) {
                if (confirm("All datas associated with this Class will also be deleted including Quiz Results and Students. Continue?")) {
                    confirm_value.value = "Yes";
                }
                else {
                    confirm_value.value = "No";
                }
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    <%--  style for pop up ajax control, it will grey out background during pop up--%>
    <style type="text/css">
        .modalBackground {
            background-color: silver;
            opacity: 0.7;
        }
    </style>
    <%-- style ends here--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        Welcome to Manage Profiles page. This page shows all the users in database. 
        Here you can update and delete selected users from the record. Please click
        on the appropriate link button in grid to make changes.
           
        <br />
        <br />
        <asp:LinkButton ID="lbUsers" runat="server" OnClick="lbUsers_Click">Manage Users</asp:LinkButton>
        &nbsp
        &nbsp
        &nbsp
        <asp:LinkButton ID="lbCourse" runat="server" OnClick="lbCourse_Click">Manage Course</asp:LinkButton>
        &nbsp
        &nbsp
        &nbsp
        <asp:LinkButton ID="lbClass" runat="server" OnClick="lbClass_Click">Manage Class</asp:LinkButton>
        &nbsp
        &nbsp
        &nbsp
        <asp:LinkButton ID="lbStudentLogHistory" runat="server" OnClick="lbStudentLogHistory_Click">Student Log History</asp:LinkButton>
        <br />
        <br />
        <asp:Panel ID="pnlManageCourse" runat="server" Visible="false">
            <br />
            <asp:DropDownList ID="ddlCourses" runat="server" Height="16px" Width="227px" AutoPostBack="true" OnSelectedIndexChanged="ddlCourses_SelectedIndexChanged" />
            <asp:Button ID="btnCreateCourse" ToolTip="Click Here To Make A New Course" runat="server" OnClick="btnCreateCourse_Click" Text="New Course" Width="84px" />
            &nbsp
            <asp:Button ID="btnEdit" ToolTip="Click Here To Delete A Course" runat="server" Text="Edit" OnClick="btnedit_Click" />
            &nbsp
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="ConfirmDelete()" OnClick="btnDelete_Click" />
            <%--New Course Panel--%>
            <asp:Panel ID="pnlNewCourse" runat="server" Height="65px" Visible="false" Width="210px">
                <asp:Label ID="lblNewCourse" runat="server" Text="New Course:"></asp:Label>
                &nbsp
        <asp:TextBox ID="txtNewCourse" ToolTip="Enter A New Course Title" runat="server"></asp:TextBox>
                <br />
                <asp:Button ID="btnSaveCourse" runat="server" Text="Save new course" OnClick="btnSaveCourse_Click" OnClientClick="ConfirmCreateCourse()" />
            </asp:Panel>
            <%--End Of Course Panel--%>
            <%--Start Of Course Panel--%>
            <asp:Panel ID="pnlCourse" runat="server" Visible="false" Height="68px" Width="326px">
                <br />
                Change Course name to: 
                <asp:TextBox ID="txtCourse" runat="server" Height="16px" Width="259px"></asp:TextBox>
                <br />
                <asp:Button ID="btnCourseUpdate" runat="server" Text="Save" OnClientClick="ConfirmUpdate()" OnClick="btnCourseUpdate_Click" />
                &nbsp
                <asp:Button ID="btnCancelUpdate" runat="server" Text="Cancel" OnClick="btnCancelUpdate_Click" />
            </asp:Panel>
            <%--End Of Course Panel--%>
        </asp:Panel>

        <asp:Panel ID="pnlManageClass" runat="server" Visible="false">
            <asp:Label ID="lblSelectCourse" runat="server" Text="Select a Course: "></asp:Label><asp:DropDownList ID="ddlCourseforClass" runat="server" OnSelectedIndexChanged="ddlCourseforClass_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
            <br />
            <asp:Panel ID="pnlMainManageClass" runat="server" Visible="false">
                <asp:Label ID="lblSelectClass" runat="server" Text="Select Class:"></asp:Label>
                &nbsp
            <asp:DropDownList ID="ddlClassname" runat="server" OnSelectedIndexChanged="ddlClassname_SelectedIndexChanged" Width="172px"></asp:DropDownList>
                &nbsp
            <asp:Button ID="btnAddClass" runat="server" Text="New Class" OnClick="btnAddClass_Click" Height="28px" />&nbsp
            <asp:Button ID="btnUpdateClass" runat="server" Text="Update Class" Width="104px" OnClick="btnUpdateClass_Click" />&nbsp
            <asp:Button ID="btnDeleteClass" runat="server" Text="Remove Class" OnClientClick="ConfirmDeleteClass()" OnClick="btnDeleteClass_Click" />

                <asp:Panel ID="pnlAddUpdateClass" runat="server" Visible="false">
                    <table>
                        <tr>
                            <td>Class name:</td>
                            <td>
                                <asp:TextBox ID="txtNewClass" runat="server" Width="262px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Associated Course: </td>
                            <td>
                                <asp:DropDownList ID="ddlClassCourse" runat="server" Width="265px"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="button" name="btnSaveClas" value="test" id="btnSaveClas" onclick="btnSaveClass_Click" />
                                <asp:Button ID="btnSaveClass" runat="server" OnClick="btnSaveClass_Click" OnClientClick="ConfirmCreateUpdateClass()" /></td>
                        </tr>
                    </table>
                </asp:Panel>
            </asp:Panel>
        </asp:Panel>
        <br />
        <asp:Panel ID="pnlManageUsers" runat="server" Visible="false">
            <asp:GridView ID="gvSettings"
                runat="server" AllowSorting="True"
                AllowPaging="true" PageSize="9"
                OnSorting="gvSettings_Sorting"
                OnPageIndexChanging="gvSettings_PageIndexChanging"
                DataKeyNames="Userid"
                HorizontalAlign="Center"
                GridLines="None"
                CssClass="mGrid"
                PagerStyle-CssClass="pgr"
                AlternatingRowStyle-CssClass="alt"
                AutoGenerateColumns="False">

                <Columns>
                    <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbUpdate" Text="Update"
                                OnClick="lbUpdate_Click" CommandName="Upd"
                                runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbDelete" Text="Delete"
                                OnClick="lbDelete_Click"
                                runat="server"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Userid" HeaderText="User ID" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Firstname" HeaderText="First Name" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Lastname" HeaderText="Last Name" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Email" HeaderText="Email Address" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Password" HeaderText="User Password" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Classname" HeaderText="Class Name" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Coursename" HeaderText="Course/ Program" />
                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="SecurityLevel" HeaderText="Security Level" />
                </Columns>
            </asp:GridView>
            <br />
            <br />

            <!--Panel to update selected record-->
            <ajaxToolkit:ToolkitScriptManager ID="TSM2" runat="server">
            </ajaxToolkit:ToolkitScriptManager>

            <div class="JavascriptButtons">
                <asp:Button ID="btnDummyUpdate" runat="server" Text="Dummy Update" Visible="true" />
            </div>

            <ajaxToolkit:ModalPopupExtender ID="mpeUpdate" runat="server"
                TargetControlID="btnDummyUpdate" PopupControlID="panelUpdate"
                RepositionMode="RepositionOnWindowResizeAndScroll" DropShadow="true"
                PopupDragHandleControlID="panelUpdateTitle"
                BackgroundCssClass="modalBackground">
            </ajaxToolkit:ModalPopupExtender>
        </asp:Panel>


        <asp:Panel ID="panelUpdate" runat="server"
            Style="display: none; background-color: whitesmoke;"
            HorizontalAlign="Center"
            Width="400" Height="500">

            <asp:Panel ID="panelUpdateTitle" runat="server"
                Style="cursor: move; font-family: Tahoma; box-shadow: 10px 10px 5px #424242; padding: 10px; align-content: center"
                HorizontalAlign="Center" BackColor="#E3170D"
                ForeColor="White" Height="30">
                <b>Update Record</b>
            </asp:Panel>
            <table style="padding: 60px">
                <tr>
                    <td colspan="10">
                        <asp:Label ID="lblStatus1" ForeColor="Black" runat="server">
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><b>User ID</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:Label ID="lblUserID" runat="server" Text=""></asp:Label></td>
                </tr>

                <tr>
                    <td><b>First Name</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:TextBox ID="txtFirstName" runat="server">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                            ErrorMessage="Enter First Name" Display="None"
                            ControlToValidate="txtFirstName" ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceFirstName"
                            TargetControlID="rfvFirstName" runat="server">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Last Name</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:TextBox ID="txtLastName" runat="server">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                            ErrorMessage="Enter Last Name" Display="None"
                            ControlToValidate="txtLastName" ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceLastName"
                            runat="server" TargetControlID="rfvLastName">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Email</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ErrorMessage="Enter Email" Display="None"
                            ControlToValidate="txtEmail" ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceEmail"
                            runat="server" TargetControlID="rfvEmail">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Password</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                            ErrorMessage="Enter Password" Display="None"
                            ControlToValidate="txtPassword" ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vcePassword"
                            runat="server" TargetControlID="rfvPassword">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Security Level</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:DropDownList ID="ddlSecurity" runat="server">
                            <asp:ListItem Text="Student" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Mentor" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvSecurityLevel" runat="server"
                            ErrorMessage="Select Security Level" Display="None"
                            ControlToValidate="ddlSecurity" ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceSecurityLevel"
                            runat="server" TargetControlID="rfvSecurityLevel">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Select Course</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:DropDownList ID="ddlCourse" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCourse" runat="server"
                            ErrorMessage="Select Course"
                            Display="None" ControlToValidate="ddlCourse"
                            ValidationGroup="add"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender runat="server"
                            ID="vceCourse" TargetControlID="rfvCourse">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Select Class</b></td>
                    <td><b>:</b></td>
                    <td>
                        <asp:DropDownList ID="ddlClass" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvClass" runat="server"
                            ErrorMessage="Select Class"
                            Display="None" ControlToValidate="ddlClass"
                            ValidationGroup="add"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender runat="server"
                            ID="vceClass" TargetControlID="rfvClass">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            </table>
            <br />

            <div>
                <asp:Button ID="btnUpdate" runat="server"
                    Width="70" Text="Update"
                    OnClick="btnUpdate_Click" ValidationGroup="add" />
                &nbsp;
                <asp:Button ID="btnCancel" runat="server"
                    Width="70" Text="Cancel"
                    CausesValidation="false" OnClick="btnCancel_Click1"
                    ValidationGroup="add" />
            </div>
        </asp:Panel>

        <div class="JavascriptButtons">
            <asp:Button ID="btnDummyDelete" runat="server" Text="Dummy Delete" Visible="true" />
        </div>

        <!--Panel to Edit record-->

        <!--Panel to DELETE record-->

        <ajaxToolkit:ModalPopupExtender ID="mpeDelete" runat="server"
            TargetControlID="btnDummyDelete" PopupControlID="panelDelete"
            RepositionMode="RepositionOnWindowResizeAndScroll" DropShadow="true"
            PopupDragHandleControlID="panelDeleteTitle"
            BackgroundCssClass="modalBackground">
        </ajaxToolkit:ModalPopupExtender>

        <asp:Panel ID="panelDelete" runat="server"
            Style="display: none; box-shadow: 10px 10px 5px #424242; background-color: whitesmoke;"
            HorizontalAlign="Center"
            Width="300" Height="350">

            <asp:Panel ID="panelDeleteTitle" runat="server"
                Style="cursor: move; font-family: Tahoma; padding: 10px; align-content: center"
                HorizontalAlign="Center" BackColor="#E3170D"
                ForeColor="White" Height="30">
                <b>Confirm Delete</b>
            </asp:Panel>
            <table style="padding: 60px">
                <tr>
                    <td colspan="10">
                        <asp:Label ID="lblStatus2" ForeColor="Black" runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:Label ID="lblDelete" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblSelectedUserid" runat="server" Visible="false" Text=""></asp:Label>
                    </td>
                </tr>
            </table>

            <div>
                <asp:Button ID="btnConfirmDelete" OnClick="btnConfirmDelete_Click" runat="server" Text="Yes" />
                &nbsp;
                    <asp:Button ID="btnCancelDelete" runat="server" Text="Cancel" />
            </div>
        </asp:Panel>


    </div>
</asp:Content>

