<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ViewUserList.aspx.cs" Inherits="AssignmentWAD.ViewUserList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .gridview-style {
            width: 100%;
            border: 2px solid black;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 20px;
        }

            .gridview-style th,
            .gridview-style td {
                border: 2px solid black;
                padding: 10px;
                text-align: center;
            }

            .gridview-style th {
                background-color: rgb(61, 52, 53);
                color: white;
            }

                .gridview-style th a {
                    color: white;
                    text-decoration: none;
                }

            .gridview-style td a {
                color: black;
            }

            .gridview-style tr {
                border: 2px solid black;
            }

        .auto-style1 {
            width: 298px;
        }
        .auto-style2 {
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <h1>User List</h1>
           <p>
     <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
     &nbsp;
     <asp:Button ID="Button1" runat="server" Text="Search" CssClass="btn-success" PostBackUrl="~/Employee/ViewUserList.aspx" OnClick="Button1_Click" />
     <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>

 </p>
            <p>
                <strong>
                    <asp:GridView ID="GridViewUser" runat="server" CssClass="gridview-style" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="CustomerID" DataSourceID="SqlDataSource1" AllowSorting="True" >
                        <Columns>
                            <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="CustomerID" HeaderText="Customer ID" ReadOnly="True" SortExpression="CustomerID" />
                            <asp:TemplateField HeaderText="Name" SortExpression="CustomerName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustomerName") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" EnableViewState="False" ErrorMessage="Please Enter Name!" ForeColor="Red"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CustomerName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email" SortExpression="CustomerEmail">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CustomerEmail") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Please Fill In Email!" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Invalid Email Format!" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("CustomerEmail") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phone Number" SortExpression="CustomerPhoneNum">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CustomerPhoneNum") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Please Fill In Phone Number!" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Invalid phone number format(Eg.010-2049999)" ForeColor="Red" ValidationExpression="^\d{3}-\d{7,8}$"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CustomerPhoneNum") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </strong>

            </p>

            <table style="width: 100%;">
                <tr>
                    <th class="auto-style1">
                        <strong>
                            <asp:GridView ID="GridView1" runat="server" CssClass="gridview-style" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                                    <asp:BoundField DataField="OrderID" HeaderText="OrderID" SortExpression="OrderID" ReadOnly="True" />
                                    <asp:BoundField DataField="RecipientName" HeaderText="RecipientName" SortExpression="RecipientName" />
                                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                </Columns>
                            </asp:GridView>
                        </strong>
                    </th>
                    <td class="text-center">
                        <strong>
                        <asp:Label ID="lblDataList" runat="server" CssClass="auto-style2"></asp:Label>
                        </strong>
                        <br />
                        <asp:GridView ID="GridView2" CssClass="gridview-style" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
                            <Columns>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                                <asp:TemplateField HeaderText="ProductImage" SortExpression="ProductImage">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ProductImage") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("ProductImage") %>' Width="150px" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT od.Quantity, p.ProductImage, p.ProductName
FROM OrderDetails od
JOIN Product p ON od.ProductID = p.ProductID
WHERE od.OrderID = @OrderID;
">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="OrderID" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [OrderDate], [OrderID], [RecipientName], [Address], [Status] FROM [Order] WHERE ([CustomerID] = @CustomerID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewUser" Name="CustomerID" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Customer] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [Customer] ([CustomerID], [CustomerName], [CustomerEmail], [CustomerPhoneNum]) VALUES (@CustomerID, @CustomerName, @CustomerEmail, @CustomerPhoneNum)" SelectCommand="SELECT * FROM [Customer] ORDER BY [CustomerID]" UpdateCommand="UPDATE [Customer] SET [CustomerName] = @CustomerName, [CustomerEmail] = @CustomerEmail, [CustomerPhoneNum] = @CustomerPhoneNum WHERE [CustomerID] = @CustomerID">
                <DeleteParameters>
                    <asp:Parameter Name="CustomerID" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CustomerID" Type="String" />
                    <asp:Parameter Name="CustomerName" Type="String" />
                    <asp:Parameter Name="CustomerEmail" Type="String" />
                    <asp:Parameter Name="CustomerPhoneNum" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CustomerName" Type="String" />
                    <asp:Parameter Name="CustomerEmail" Type="String" />
                    <asp:Parameter Name="CustomerPhoneNum" Type="String" />
                    <asp:Parameter Name="CustomerID" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </div>
    </div>
</asp:Content>