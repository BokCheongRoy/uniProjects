<%@ Page Title="" Language="C#" MasterPageFile="~/LoginEmployee.Master" AutoEventWireup="true" CodeBehind="ViewUserList.aspx.cs" Inherits="AssignmentWAD.ViewUserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 29px;
        }
        .auto-style2 {
            height: 29px;
            width: 844px;
        }
        .auto-style3 {
            width: 844px;
        }
        .auto-style4 {
            height: 29px;
            width: 491px;
        }
        .auto-style5 {
            width: 491px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>User List</h1>
    <p>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Button" />
    </p>
    <p>
        <table class="w-100">
            <tr>
                <td class="auto-style2">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="CustomerID" DataSourceID="SqlDataSource1">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" ReadOnly="True" SortExpression="CustomerID" />
                            <asp:BoundField DataField="CustomerName" HeaderText="CustomerName" SortExpression="CustomerName" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                            <asp:BoundField DataField="CustomerPhoneNum" HeaderText="CustomerPhoneNum" SortExpression="CustomerPhoneNum" />
                            <asp:BoundField DataField="CustomerEmail" HeaderText="CustomerEmail" SortExpression="CustomerEmail" />
                            <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Customer] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [Customer] ([CustomerID], [CustomerName], [Gender], [CustomerPhoneNum], [CustomerEmail], [Password]) VALUES (@CustomerID, @CustomerName, @Gender, @CustomerPhoneNum, @CustomerEmail, @Password)" SelectCommand="SELECT * FROM [Customer]" UpdateCommand="UPDATE [Customer] SET [CustomerName] = @CustomerName, [Gender] = @Gender, [CustomerPhoneNum] = @CustomerPhoneNum, [CustomerEmail] = @CustomerEmail, [Password] = @Password WHERE [CustomerID] = @CustomerID">
                        <DeleteParameters>
                            <asp:Parameter Name="CustomerID" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="CustomerID" Type="String" />
                            <asp:Parameter Name="CustomerName" Type="String" />
                            <asp:Parameter Name="Gender" Type="String" />
                            <asp:Parameter Name="CustomerPhoneNum" Type="String" />
                            <asp:Parameter Name="CustomerEmail" Type="String" />
                            <asp:Parameter Name="Password" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="CustomerName" Type="String" />
                            <asp:Parameter Name="Gender" Type="String" />
                            <asp:Parameter Name="CustomerPhoneNum" Type="String" />
                            <asp:Parameter Name="CustomerEmail" Type="String" />
                            <asp:Parameter Name="Password" Type="String" />
                            <asp:Parameter Name="CustomerID" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="auto-style4">
                    <asp:DataList ID="DataList1" runat="server">
                    </asp:DataList>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>
&nbsp;</td>
                <td class="auto-style1"></td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style5">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style5">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </p>
</asp:Content>
