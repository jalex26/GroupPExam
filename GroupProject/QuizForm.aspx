<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizForm.aspx.cs" Inherits="GroupProject.QuizForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<<<<<<< HEAD
<asp:DataList ID="DataList1" runat="server" DataKeyField="NationalityID"
            DataSourceID="SqlDataSource1" onitemdatabound="DataList1_ItemDataBound" Width="313px">
            <ItemTemplate>
                <asp:Label ID="lblnum" runat="server" Text=""></asp:Label>
                <asp:Label ID="Question" runat="server"
                    Text='<%# Eval("Question") %>' />
                <br />
                <br />

                <asp:Label ID="Label1" runat="server" Text="a."></asp:Label><asp:RadioButton ID="Choice1" runat="server" /><%# Eval("Choice1") %><br />
                <asp:Label ID="Label2" runat="server" Text="b."></asp:Label><asp:RadioButton ID="Choice2" runat="server" /><%# Eval("Choice2") %><br />
                <asp:Label ID="Label3" runat="server" Text="c."></asp:Label><asp:RadioButton ID="Choice3" runat="server" /><%# Eval("Choice3") %><br />
                <asp:Label ID="Label4" runat="server" Text="d."></asp:Label><asp:RadioButton ID="Choice4" runat="server" /><%# Eval("Choice4") %><br />
                <br />
                </ItemTemplate>
        </asp:DataList>
      
        </div>
     </form>
=======
        
    </div>
    </form>
>>>>>>> origin/master
</body>
</html>
