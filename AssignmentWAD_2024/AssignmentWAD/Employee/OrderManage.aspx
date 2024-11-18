<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="OrderManage.aspx.cs" Inherits="AssignmentWAD.OrderManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .gridview-style {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-top: 30px;
        }

            .gridview-style tr {
                border-bottom: 2px solid black;
            }

            .gridview-style th,
            .gridview-style td {
                border: 2px solid black;
                padding: 15px;
                text-align: center;
            }

            .gridview-style th {
                background-color: rgb(61, 52, 53);
                color: rgb(178, 146, 94);
            }

                .gridview-style th a {
                    text-decoration: none;
                    color: white;
                }

            .gridview-style tr {
                border: 2px solid black;
            }

            .gridview-style td a {
                color: black;
            }

        .auto-style1 {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

            .auto-style1 strong {
                margin-left: 10px;
            }

            .auto-style1 .btn {
                text-align: center;
                width: 90px;
            }

        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row justify-content-center">
        <div class="col-lg-9 mt-5">
            <h1>Order</h1>
            <div class="auto-style1">
                <strong>
                    <asp:Button ID="Button1" CssClass="btn btn-success btn-lg" runat="server" Text="All" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button1_Click" />
                </strong>
                <strong>
                    <asp:Button ID="Button2" CssClass="btn btn-success btn-lg" runat="server" Text="Pending" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button2_Click" />
                    <asp:Button ID="Button3" CssClass="btn btn-success btn-lg" runat="server" Text="Preparing" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button3_Click" />

                    <asp:Button ID="Button4" CssClass="btn btn-success btn-lg" runat="server" Text="Delivered" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button4_Click" />
                    <asp:Button ID="Button6" CssClass="btn btn-success btn-lg" runat="server" Text="Rated" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button6_Click" />
                </strong>
            </div>
            <p>
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                &nbsp;
                <asp:Button ID="Button5" runat="server" Text="Search" CssClass="btn-success" PostBackUrl="~/Employee/OrderManage.aspx" OnClick="Button5_Click" />
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>

            </p>
            <p>
                <strong>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="SqlDataSource1" CssClass="gridview-style">
                        <Columns>
                            <asp:CommandField ShowEditButton="True" />
                            <asp:TemplateField HeaderText="OrderID" SortExpression="OrderID">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrderID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("OrderID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="OrderDate" SortExpression="OrderDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True" Text='<%# Bind("OrderDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("OrderDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CustomerID" SortExpression="CustomerID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True" Text='<%# Bind("CustomerID") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CustomerID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RecipientName" SortExpression="RecipientName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" ReadOnly="True" Text='<%# Bind("RecipientName") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("RecipientName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" ReadOnly="True" Text='<%# Bind("Address") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ContactNumber" SortExpression="ContactNumber">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox5" runat="server" ReadOnly="True" Text='<%# Bind("ContactNumber") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("ContactNumber") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("Status") %>'>
                                        <asp:ListItem>Pending</asp:ListItem>
                                        <asp:ListItem>Preparing</asp:ListItem>
                                        <asp:ListItem>Delivered</asp:ListItem>
                                        <asp:ListItem Value="Rated"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </strong>
            </p>
            <p>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [OrderID], [OrderDate], [CustomerID], [RecipientName], [Address], [Status], [ContactNumber] FROM [Order]" DeleteCommand="DELETE FROM [Order] WHERE [OrderID] = @OrderID" InsertCommand="INSERT INTO [Order] ([OrderID], [OrderDate], [CustomerID], [RecipientName], [Address], [Status], [ContactNumber]) VALUES (@OrderID, @OrderDate, @CustomerID, @RecipientName, @Address, @Status, @ContactNumber)" UpdateCommand="UPDATE [Order] SET [OrderDate] = @OrderDate, [CustomerID] = @CustomerID, [RecipientName] = @RecipientName, [Address] = @Address, [Status] = @Status, [ContactNumber] = @ContactNumber WHERE [OrderID] = @OrderID">
                    <DeleteParameters>
                        <asp:Parameter Name="OrderID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="OrderID" Type="String" />
                        <asp:Parameter DbType="Date" Name="OrderDate" />
                        <asp:Parameter Name="CustomerID" Type="String" />
                        <asp:Parameter Name="RecipientName" Type="String" />
                        <asp:Parameter Name="Address" Type="String" />
                        <asp:Parameter Name="Status" Type="String" />
                        <asp:Parameter Name="ContactNumber" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter DbType="Date" Name="OrderDate" />
                        <asp:Parameter Name="CustomerID" Type="String" />
                        <asp:Parameter Name="RecipientName" Type="String" />
                        <asp:Parameter Name="Address" Type="String" />
                        <asp:Parameter Name="Status" Type="String" />
                        <asp:Parameter Name="ContactNumber" Type="String" />
                        <asp:Parameter Name="OrderID" Type="String" />
                    </UpdateParameters>

                </asp:SqlDataSource>
            </p>
        </div>
    </div>
</asp:Content>
