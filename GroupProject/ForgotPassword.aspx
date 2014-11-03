<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="GroupProject.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:Panel ID="pnlForgot" CssClass="ForgotTextbox" runat="server">
    <div id="RetrievePass" runat="server">
        <a>Forgotten Password</a>
        <br />
        <table>
            <tr>
                <td>Enter Your Email</td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" Width="149px"></asp:TextBox>
                </td>
            </tr>
        </table>
        <asp:Button ID="btnRecoverPassword" CssClass="button" runat="server" Text="Recover Password" OnClick="btnRecoverPassword_Click" />
</div>
        
    <div id="CheckMail" runat="server" visible="false">
            <strong>Account Retrieval Successful. Please Check Your Current Valid Email Account.
                     </strong>
        </div>
        <div id="CheckMailInvalid" runat="server" visible="false" >

            <strong>You entered an Invalid Email or not existed on our database.</strong>
        </div>
        <div id="InvalidToken" runat="server" visible="false">
            Invalid Link.
        </div>
                </asp:Panel>
        <asp:Panel ID="pnlChangePassword" CssClass="ForgotTextbox" runat="server">
        <div id="ChangePass" runat="server" visible="false">
            <table>
                <tr>
                    <td>New Password:</td>
                    <td>
                        <asp:TextBox ID="txtPass" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVPass" runat="server" ErrorMessage="*Required" ControlToValidate="txtPass"
                            EnableClientScript="False" EnableViewState="False" ValidationGroup="Pass"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Retype Password:</td>
                    <td>
                        <asp:TextBox ID="txtPass2" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:CompareValidator ID="RFVPass2" runat="server" ErrorMessage="*Password does not match" ControlToValidate="txtPass" ControlToCompare="txtPass2" EnableClientScript="false" EnableViewState="false" ValidationGroup="Pass"></asp:CompareValidator>
                    </td>
                </tr>
            </table>
            <asp:Button ID="btnChange" CssClass="button" runat="server" Text="Change Password" OnClick="btnChange_Click" />
        </div>
        <div id="ChangeSuccess" runat="server" visible="false">
           Change Password Successful. Please LogIn.</div>
        <div id="ChangeFailed" runat="server" visible="false">
            <span class="auto-style2"><strong>Password Failed. </strong></span>
        </div>
            </asp:Panel>
    </div>
</asp:Content>
