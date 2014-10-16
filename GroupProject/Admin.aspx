<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="GroupProject.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--    <asp:GridView ID="GVUsers" runat="server"
         CssClass="Grid"
          AutoGenerateColumns="False">
    <Columns>
        <asp:TemplateField>
            <HeaderStyle Width="25px" />
            <ItemStyle Width="15px" BackColor="White" />
            <HeaderTemplate>
                <asp:Image ID="imgTab" onClick="javascript:Toggle(this);"
                     runat="server" ImageUrl="~/Pictures/GreenDown.png" Width="20" Height="20" ToolTip="Collapse" />
                  </HeaderTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Firstname" HeaderText="First Name"  />
        <asp:BoundField DataField="Lastname" HeaderText="Last Name" />
    </Columns>        
    </asp:GridView>--%>
<%--    <asp:Image ID="imgTab" onclick="javascript:Toggle(this);" runat="server" 
           ImageUrl="~Pictures/GreenDown.png" ToolTip="Collapse" />--%>

<%--    <script type="text/javascript">
        var Grid = null;
        var UpperBound = 0;
        var LowerBound = 1;
        var CollapseImage = '~/Pictures/GreenDown.png';
        var ExpandImage = '~/Pictures/Green Up.png';
        var IsExpanded = true;
        var Rows = null;
        var n = 1;
        var TimeSpan = 25;

        window.onload = function () {
            Grid = document.getElementById('<%= this.GVUsers.ClientID %>');
     UpperBound = parseInt('<%= this.GVUsers.Rows.Count %>');
     Rows = Grid.getElementsByTagName('tr');
 }

 function Toggle(Image) {
     ToggleImage(Image);
     ToggleRows();
 }

 function ToggleImage(Image) {
     if (IsExpanded) {
         Image.src = ExpandImage;
         Image.title = 'Expand';
         Grid.rules = 'none';
         n = LowerBound;

         IsExpanded = false;
     }
     else {
         Image.src = CollapseImage;
         Image.title = 'Collapse';
         Grid.rules = 'cols';
         n = UpperBound;

         IsExpanded = true;
     }
 }

 function ToggleRows() {
     if (n < LowerBound || n > UpperBound) return;

     Rows[n].style.display = Rows[n].style.display == '' ? 'none' : '';
     if (IsExpanded) n--; else n++;
     setTimeout("ToggleRows()", TimeSpan);
 }
</script>--%>

    <script language="javascript" type="text/javascript">
        function expandcollapse(obj, row) {
            var div = document.getElementById(obj);
            var img = document.getElementById('img' + obj);

            if (div.style.display == "none") {
                div.style.display = "block";
                if (row == 'alt') {
                    img.innerText = "collapse";
                }
                else {
                    img.innerText = "collapse";
                }
                img.alt = "Close to view other Customers";
            }
            else {
                div.style.display = "none";
                if (row == 'alt') {
                    img.innerText = "Expand";
                }
                else {
                    img.innerText = "Expand";
                }

            }
        }
    </script>


    <asp:GridView ID="GVUsers" runat="server" AutoGenerateColumns="False">
        
            <Columns>
             <asp:TemplateField>
                    <ItemTemplate>
                        <a href="javascript:expandcollapse('div<%# Eval("Userid") %>', 'one');">
                        <span  id="imgdiv<%# Eval("Userid") %>">Expand</span>
                           
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
        <asp:BoundField DataField="Firstname" HeaderText="First Name"  />
        <asp:BoundField DataField="Lastname" HeaderText="Last Name" />
                <asp:TemplateField >
                    <ItemTemplate>
                      
                        <tr>
                            <td colspan="100%">
                                <div id="div<%# Eval("Userid") %>" style="display: none; position: relative; left: 15px;
                                    overflow: auto; width: 97%">
                                    <asp:GridView ID="GVInfo" runat="server" AutoGenerateColumns="False" >
                                        <Columns>
                                            <asp:BoundField DataField="Userid" HeaderText="User ID"  />
                                            <asp:BoundField DataField="Lastname" HeaderText="Last Name" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
</asp:Content>
