<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GroupProject.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        <asp:Panel ID="pnlRegister" HorizontalAlign="Center" style="margin-left:300px;" runat="server">
        <table>
            <tr>
                <td>FirstName</td>
                <td>
                    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator
                        ID="rfvFirstName"
                        runat="server"
                        ErrorMessage="FirstName is required!"
                        ControlToValidate="txtFirstName"
                        EnableClientScript="False"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>LastName</td>
                <td>
                    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator
                        ID="rfvLastName"
                        runat="server"
                        ErrorMessage="LastName is required!"
                        ControlToValidate="txtLastName"
                        EnableClientScript="False"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>Email</td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox> &nbsp;
                    @robertsoncollege.net
                       <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" 
                        ErrorMessage="Please Enter Email!"
                        ForeColor="Red"                   
                        Display="Dynamic" EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                   <%-- <asp:RegularExpressionValidator 
                        ID="revEmail" 
                        runat="server" 
                        EnableClientScript="False"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Invalid Email Address" 
                         ForeColor="Red"  
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                    </asp:RegularExpressionValidator>--%>
                </td>
            </tr>

            <tr>
                <td>Password</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator
                        ID="rfvPassword"
                        runat="server"
                        ErrorMessage="Please enter Password!"
                        ControlToValidate="txtPassword"
                        EnableClientScript="False"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Re-type Password</td>
                <td>
                    <asp:TextBox ID="txtRePassword" runat="server"></asp:TextBox>
                    <asp:CompareValidator ID="CMPPass" runat="server" ErrorMessage="*Password do not match" ControlToValidate="txtRePassword" ControlToCompare="txtPassword" ValidationGroup="ValGroupRegister"></asp:CompareValidator>

                </td>
            </tr>

            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
            </asp:Panel>
        <br />
        <br />

        <asp:Label ID="lblRegisterMessage" runat="server" Text=""></asp:Label>

    </div>

</asp:Content>
