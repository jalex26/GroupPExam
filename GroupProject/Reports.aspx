<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="GroupProject.Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div id="content">

        <asp:Panel ID="Panel1" runat="server">
            Select a Report to View Details:
            &nbsp; &nbsp;
            <asp:DropDownList ID="ddlReports" runat="server">
                <asp:ListItem Value="0" Text="Issued Quizes"></asp:ListItem>
                <asp:ListItem Value="1" Text="Active Quizes"></asp:ListItem>
                <asp:ListItem Value="2" Text="Pending Quizes"></asp:ListItem>
                <asp:ListItem Value="3" Text="Completed Quizes"></asp:ListItem>
                <asp:ListItem Value="4" Text="Student Response Report"></asp:ListItem>
                <asp:ListItem Value="5" Text="Graphical Interpretation of Student Response Report"></asp:ListItem>
                <asp:ListItem Value="6" Text="Graphical Analysis of Quiz Questions/ Test Data"></asp:ListItem>
            </asp:DropDownList>
              &nbsp; &nbsp;
            <asp:Button ID="btnViewReport" runat="server" Text="View Report" />
        </asp:Panel>

        <asp:Repeater ID="repIssuedQuizes" runat="server">

              <HeaderTemplate>
                    <table style="max-width: 900px; font-size: small; align-content: center; text-align: center; border: 1px solid #C0C0C0; background-color: #D8D8D8">
                        <tr>
                            <th style="width: 90px; height: 30px; background-color: #E3170D">Issued Quiz ID </th>

                            <th style="width: 90px; height: 30px; background-color: #E3170D">Version ID</th>

                            <th style="width: 90px; height: 30px; background-color: #E3170D">Class ID</th>

                            <th style="width: 90px; height: 30px; background-color: #E3170D">Date Issued</th>        

                            <th style="width: 90px; height: 30px; background-color: #E3170D">Issued By (Mentor)</th>

                            <th style="width: 90px; height: 30px; background-color: #E3170D">View Details</th>
                        </tr>
                </HeaderTemplate>
              
                 <ItemTemplate>
                                    
                    <td><%# DataBinder.Eval(Container.DataItem, "IssuedQuizId") %></td>

                    <td><%# DataBinder.Eval(Container.DataItem, "Versionid") %></td>

                    <td><%# DataBinder.Eval(Container.DataItem, "ClassId") %></td>

                    <td><%# DataBinder.Eval(Container.DataItem, "DateIssued") %></td>

                    <td><%# DataBinder.Eval(Container.DataItem, "Mentor") %></td>

                      <td>
                        <asp:Button ID="btnViewDetails"
                            runat="server"
                            CommandName="View"
                            CommandArgument='<%# Eval ("Versionid") %>'
                            ToolTip="Click Here to View Quiz Details"
                            Width="60px"
                            Font-Size="Small"
                            Text="View" />
                    </td>

                       </tr>

                    <tr>
                        <td colspan="6" style="height: 6px;"></td>
                    </tr>

                </ItemTemplate>

                <SeparatorTemplate>
                    <tr>
                        <td colspan="6">
                            <hr>
                            <br />
                        </td>
                    </tr>
                </SeparatorTemplate>
            <FooterTemplate></FooterTemplate>

        </asp:Repeater>



    </div>

</asp:Content>
