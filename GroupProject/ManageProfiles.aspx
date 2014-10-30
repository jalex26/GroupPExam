<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ManageProfiles.aspx.cs" Inherits="GroupProject.ManageProfiles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style7 {
            width: 234px;
            height: 40px;
        }
        .auto-style9 {
            width: 596px;
            height: 40px;
        }
        .auto-style10 {
            width: 448px;
            height: 40px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div id="content">
    <asp:GridView ID="gvSettings" runat="server"
         OnRowCommand="gvSettings_RowCommand"
        DataKeyNames="Userid"
         HorizontalAlign="Center"
         Height="200px"       
         AutoGenerateColumns="False">
        <HeaderStyle BackColor="#ADADAD"></HeaderStyle>
            <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <%--<asp:ButtonField CommandName="Del" Text="Delete" ButtonType="Button" />--%>
            <asp:ButtonField CommandName="Upd" Text="Update" ButtonType="Button" />
            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Userid" HeaderText="User ID" />
            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Firstname" HeaderText="First Name" />
            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Lastname" HeaderText="Last Name" />
            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Email" HeaderText="Email Address" />
            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Password" HeaderText="User Password" />
            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Classname" HeaderText="Class Name" />
            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Coursename" HeaderText="Course/ Program" />
        </Columns>
    </asp:GridView>
         <br />
         <br />

    <asp:Panel margin-left="300px" ID="pn1Upd" runat="server" Visible="false" HorizontalAlign="Center" Height="237px" Width="285px">
        <table>
            <tr>
                <td class="auto-style7">
                    <asp:Label ID="lblUserid" runat="server" Text="Userid"></asp:Label>
                </td>
                <td class="auto-style10">
                    <asp:TextBox ID="txtUserid" runat="server" ForeColor="Black"></asp:TextBox>
                </td>
            </tr>
        
       <tr>
           <td class="auto-style7">
               <asp:Label ID="lblFirstname" runat="server" Text="Firstname"></asp:Label>
           </td>
           <td class="auto-style10">
               <asp:TextBox ID="txtFirstname" runat="server" ForeColor="Black"></asp:TextBox>
           </td>
       </tr>
        
        <tr>
            <td class="auto-style7">
                <asp:Label ID="lblLastname" runat="server" Text="Lastname"></asp:Label>
            </td>
            <td class="auto-style10">
                 <asp:TextBox ID="txtLastname" runat="server" ForeColor="Black"></asp:TextBox>
            </td>
        </tr>
        
     <tr>
         <td class="auto-style7">
                <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
         </td>
         <td class="auto-style10">
             <asp:TextBox ID="txtPassword" runat="server" ForeColor="Black"></asp:TextBox>
         </td>
     </tr>
     
       <tr>
           <td class="auto-style7">
                <asp:Label ID="lblClass" runat="server" Text="Class"></asp:Label>
           </td>
           <td class="auto-style10">
                <asp:TextBox ID="txtClassname" runat="server" ForeColor="Black"></asp:TextBox>
           </td>
       </tr>
       
       <tr>
           <td class="auto-style7">
                <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
           </td>
           <td class="auto-style10">
               <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
           </td>
       </tr>
       
       <tr>
           <td class="auto-style7"></td>
           <td class="auto-style10">
               <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="70px" />
               &nbsp;
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" Width="70px" />
           </td>
           
       </tr>       
            </table>
    </asp:Panel>
         
     </div>
</asp:Content>

