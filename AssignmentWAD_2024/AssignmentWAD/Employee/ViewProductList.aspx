<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ViewProductList.aspx.cs" Inherits="AssignmentWAD.ViewProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .content-container {
            padding: 20px;
        }

        .gridview-style {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            .gridview-style th,
            .gridview-style td {
                border: 2px solid black;
                padding: 15px;
                text-align: center;
            }

            .gridview-style th {
                background-color: rgb(61, 52, 53);
                color: white;
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

        .btn-container {
            text-align: right;
            margin-top: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row justify-content-center">
        <div class="col-lg-9 content-container">
            <table class="w-100">
                <tr>
                    <td class="auto-style1">
                        <h1 class="auto-style2">Product List</h1>
                    </td>
                    <td class="text-end btn-container">
                        <asp:Button ID="Button2" CssClass="btn btn-success btn-lg" runat="server" Text="Add" Width="90px" PostBackUrl="~/Employee/AddProduct.aspx" UseSubmitBehavior="False" />
                        <asp:Button ID="Button3" CssClass="btn btn-success btn-lg" runat="server" Enabled="False" Text="List" Width="90px" OnClientClick="disableRequired();" />
                    </td>
                </tr>
            </table>

            <p>
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                &nbsp;
     <asp:Button ID="Button1" runat="server" Text="Search" CssClass="btn-success" PostBackUrl="~/Employee/ViewProductList.aspx" OnClick="Button1_Click" />
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                
            </p><asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label>
            <p>
                <asp:GridView ID="GridView1" runat="server" OnRowDeleting="GridView1_RowDeleting"  OnRowUpdating="GridView1_RowUpdating" CssClass="gridview-style" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ProductID" DataSourceID="SqlDataSource1" AllowSorting="True">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                        <asp:TemplateField HeaderText="ProductID" SortExpression="ProductID">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ProductID") %>'></asp:Label>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <a href="javascript:__doPostBack('GridView1','Sort$Ingredient')">Ingredient</a>
                            </FooterTemplate>
                            <HeaderTemplate>
                                <a href="javascript:__doPostBack('GridView1','Sort$CategoryID')">ProductID</a>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ProductID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ProductName" SortExpression="ProductName">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProductName" runat="server" Text='<%# Bind("ProductName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorProductName" runat="server"
                                    ControlToValidate="txtProductName" ErrorMessage="ProductName is required." Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LabelProductName" runat="server" Text='<%# Bind("ProductName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category" SortExpression="CategoryID">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="CategoryName" DataValueField="CategoryID" SelectedValue='<%# Bind("CategoryID") %>'>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategoryID" runat="server"
                                    ControlToValidate="DropDownList1" InitialValue="" ErrorMessage="CategoryID is required." Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%--<asp:Label ID="Label2" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>--%>
                                <asp:Label ID="LabelCategoryName" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("CategoryID") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ingredient" SortExpression="Ingredient">
                            <EditItemTemplate>
                                <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                                    <asp:ListItem>Gluten</asp:ListItem>
                                    <asp:ListItem>Milk</asp:ListItem>
                                    <asp:ListItem>Eggs</asp:ListItem>
                                    <asp:ListItem>Chicken Sausage</asp:ListItem>
                                    <asp:ListItem>Dairy</asp:ListItem>
                                    <asp:ListItem>Gelatin(Fish)</asp:ListItem>
                                </asp:CheckBoxList>
                                
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LabelIngredient" runat="server" Text='<%# Bind("Ingredient") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="UnitPrice" SortExpression="UnitPrice">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Unit Price is required!" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Please fill in a number between 0 and 1000." ForeColor="Red" MaximumValue="1000" MinimumValue="0" SetFocusOnError="True" Type="Double"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LabelUnitPrice" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Size" SortExpression="Size">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Size") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Size is required!" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Size") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="ProductImage" SortExpression="ProductImage">
                            <EditItemTemplate>
                                <asp:FileUpload ID="fileUploadImage" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                
                                <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("ProductImage") %>' Width="150px" />
                                
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <%--DeleteCommand="DELETE FROM [Product] WHERE [ProductID] = @ProductID"--%>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="Select * FROM [Product] WHERE [ProductID] = @ProductID" InsertCommand="INSERT INTO [Product] ([ProductID], [ProductName], [CategoryID], [UnitPrice], [Size], [Ingredient], [Image]) VALUES (@ProductID, @ProductName, @CategoryID, @UnitPrice, @Size, @Ingredient, @Image)" SelectCommand="SELECT 
    P.ProductID,
    P.ProductName,
    P.CategoryID,
    P.UnitPrice,
    P.Size,
    P.Ingredient,
    P.ProductImage,
    C.CategoryName
FROM 
    Product P
LEFT JOIN 
    Category C ON P.CategoryID = C.CategoryID;" UpdateCommand="UPDATE [Product] SET [ProductName] = @ProductName, [CategoryID] = @CategoryID, [UnitPrice] = @UnitPrice, [Size] = @Size WHERE [ProductID] = @ProductID">
                    <DeleteParameters>
                        <asp:Parameter Name="ProductID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ProductID" Type="String" />
                        <asp:Parameter Name="ProductName" Type="String" />
                        <asp:Parameter Name="CategoryID" Type="Int32" />
                        <asp:Parameter Name="UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="Size" Type="String" />
                        <asp:Parameter Name="Ingredient" Type="String" />
                        <asp:Parameter Name="Image" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ProductName" Type="String" />
                        <asp:Parameter Name="CategoryID" Type="Int32" />
                        <asp:Parameter Name="UnitPrice" Type="Decimal" />
                        <asp:Parameter Name="Size" Type="String" />
                        <asp:Parameter Name="Ingredient" Type="String" />
                        <asp:Parameter Name="ProductID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </p>
            <p>
                &nbsp;
            </p>
        </div>
    </div>
</asp:Content>