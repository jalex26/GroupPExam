<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GroupProject.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content">
        <asp:Panel ID="pnlRegister" HorizontalAlign="Center" style="margin-left:300px;" runat="server">
        <table>
            <tr>
                <td>FirstName:</td>
                <td>
                    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator
                        ID="rfvFirstName"
                        runat="server"
                        ErrorMessage="FirstName is required!"
                        ControlToValidate="txtFirstName"
                        EnableClientScript="False"
                        ForeColor="Red" ValidationGroup="ValGroupRegister"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>LastName:</td>
                <td>
                    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox> 
                </td>
                <td>
                    <asp:RequiredFieldValidator
                        ID="rfvLastName"
                        runat="server"
                        ErrorMessage="LastName is required!"
                        ControlToValidate="txtLastName"
                        EnableClientScript="False"
                        ForeColor="Red" ValidationGroup="ValGroupRegister"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>Email:</td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                    
                       
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
                <td>
                    @robertsoncollege.net <br />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail" 
                        ErrorMessage="Please Enter Email!"
                        ForeColor="Red"                   
                        Display="Dynamic" EnableClientScript="False" ValidationGroup="ValGroupRegister">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>Password:</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox> 
                </td>
                <td>
                    <asp:RequiredFieldValidator
                        ID="rfvPassword"
                        runat="server"
                        ErrorMessage="Please enter Password!"
                        ControlToValidate="txtPassword"
                        EnableClientScript="False"
                        ForeColor="Red" ValidationGroup="ValGroupRegister"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Re-type Password:</td>
                <td>
                    <asp:TextBox ID="txtRePassword" runat="server" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                    <asp:CompareValidator ID="CMPPass" runat="server" ErrorMessage="*Password do not match" ControlToValidate="txtRePassword" ControlToCompare="txtPassword" ValidationGroup="ValGroupRegister" ForeColor="Red"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="rfvRePass" runat="server" ErrorMessage="*Required" ControlToValidate="txtRePassword" EnableClientScript="False"
                        ForeColor="Red" ValidationGroup="ValGroupRegister"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="myButton"/>
                </td>
            </tr>
        </table>
            </asp:Panel>
        <br />
        <br />

        <asp:Label ID="lblRegisterMessage" runat="server" ForeColor="Red" Text=""></asp:Label>

    </div>

</asp:Content>
