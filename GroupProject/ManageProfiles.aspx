<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ManageProfiles.aspx.cs" Inherits="GroupProject.ManageProfiles" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
        

        <asp:GridView ID="gvSettings" runat="server" AllowSorting="True" AllowPaging="true" PageSize="9" OnSorting="gvSettings_Sorting" OnPageIndexChanging="gvSettings_PageIndexChanging"
            DataKeyNames="Userid"
            HorizontalAlign="Center"
            Width="800px"                  
            AutoGenerateColumns="False" GridLines="Horizontal">
            <HeaderStyle BackColor="#ADADAD"></HeaderStyle>
            <AlternatingRowStyle BackColor="#CCCCCC" />
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

        <asp:Panel ID="panelUpdate" runat="server"
            Style="display: none; background-color: #CCCCCC;"
            ForeColor="Black"
            HorizontalAlign="Center"
            Width="400" Height="400">
  
         <asp:Panel ID="panelUpdateTitle" runat="server" 
            style="cursor:move;font-family:Tahoma;padding:10px; align-content:center" 
            HorizontalAlign="Center" BackColor="DarkGray" 
            ForeColor="White" Height="30" ><b>Update Record</b>
                </asp:Panel>
            <table style="padding:60px">
                <tr>
                <td colspan="10">
                    <asp:Label ID="lblStatus1" ForeColor="Black" runat="server">
                    </asp:Label>
                </td>
                </tr>
                <tr>
                    <td><b>User ID</b></td>
                    <td><b>:</b></td>
                    <td><asp:Label ID="lblUserID" runat="server" Text=""></asp:Label></td>
                </tr>

                <tr>
                    <td><b>First Name</b></td>
                    <td><b>:</b></td>
                    <td><asp:TextBox ID="txtFirstName" runat="server">
                    </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                        ErrorMessage="Enter First Name" Display="None"  
                        ControlToValidate="txtFirstName"  ValidationGroup="add">
                        </asp:RequiredFieldValidator>             
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceFirstName" 
                        TargetControlID="rfvFirstName" runat="server">
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Last Name</b></td>
                    <td><b>:</b></td>
                    <td><asp:TextBox ID="txtLastName" runat="server">
                    </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                        ErrorMessage="Enter Last Name"  Display="None" 
                        ControlToValidate="txtLastName"  ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceLastName" 
                        runat="server" TargetControlID="rfvLastName" >
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Email</b></td>
                    <td><b>:</b></td>
                    <td><asp:TextBox ID="txtEmail" runat="server">
                    </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                        ErrorMessage="Enter Email"  Display="None" 
                        ControlToValidate="txtEmail"  ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceEmail" 
                        runat="server" TargetControlID="rfvEmail" >
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                   <tr>
                    <td><b>Password</b></td>
                    <td><b>:</b></td>
                    <td><asp:TextBox ID="txtPassword" runat="server">
                    </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                        ErrorMessage="Enter Password"  Display="None" 
                        ControlToValidate="txtPassword"  ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vcePassword" 
                        runat="server" TargetControlID="rfvPassword" >
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                 <tr>
                    <td><b>Security Level</b></td>
                    <td><b>:</b></td>
                    <td><asp:DropDownList ID="ddlSecurity" runat="server">
                        <asp:ListItem Text="Student" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Mentor" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Admin" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvSecurityLevel" runat="server" 
                        ErrorMessage="Select Security Level"  Display="None" 
                        ControlToValidate="ddlSecurity"  ValidationGroup="add">
                        </asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="vceSecurityLevel" 
                        runat="server" TargetControlID="rfvSecurityLevel" >
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>

                <tr>
                    <td><b>Select Class</b></td>
                    <td><b>:</b></td>
                    <td><asp:DropDownList ID="ddlClass" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvClass" runat="server" 
                         ErrorMessage="Select Class" 
                        Display="None" ControlToValidate="ddlCLass"  
                        ValidationGroup="add"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender runat="server" 
                        ID="vceClass" TargetControlID="rfvClass" >
                        </ajaxToolkit:ValidatorCalloutExtender>
                    </td>
                </tr>
            </table>
        <br />

         <div>
                <asp:Button ID="btnUpdate" runat="server" 
                Width="70" Text="Update" 
                OnClick="btnUpdate_Click"  ValidationGroup="add"/>
                &nbsp;
                <asp:Button ID="btnCancel" runat="server" 
                Width="70" Text="Cancel" 
                CausesValidation="false" OnClick="btnCancel_Click1" 
                ValidationGroup="add"/>
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
            Style="display: none; background-color: #CCCCCC;"
            ForeColor="Black"
            HorizontalAlign="Center"
            Width="300" Height="350">
  
         <asp:Panel ID="panelDeleteTitle" runat="server" 
            style="cursor:move;font-family:Tahoma;padding:10px; align-content:center" 
            HorizontalAlign="Center" BackColor="DarkGray" 
            ForeColor="White" Height="30" ><b>Confirm Delete</b>
                </asp:Panel>
            <table style="padding:60px">
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

