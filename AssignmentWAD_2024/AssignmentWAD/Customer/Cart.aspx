<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="AssignmentWAD.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .gridview-container {
            margin-top: 20px;
            text-align: center;
            min-height: 500px;
        }

        .custom-gridview {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }

        .custom-gridview th,
            .custom-gridview td{
               border: 2px solid black;
                padding: 10px;
                text-align: center;
            }

            .custom-gridview th {
                background-color: rgb(61, 52, 53);
                font-weight: bold;
                 color: rgb(178, 146, 94);
            }


        .auto-style1 {
            width: 50%;
            text-align: right;
        }

        .auto-style2 {
            width: 200px;
            text-align: left;
        }

        .auto-style3 {
            width: 25px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="gridview-container">
        <div class="row">
            <div class="col-md-12">
                <h2 class="ml-3" style="text-align: left;padding-left:10%">Cart</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <asp:GridView ID="GridView1" DataKeyNames="CustomerID,ProductID" runat="server" CssClass="custom-gridview" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AutoPostBack="true">
                    <Columns>
                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                                <asp:Image runat="server" ImageUrl='<%# Eval("ProductImage") %>' Width="38px" Height="50px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductName" HeaderText="Item" SortExpression="ProductName" />

                        <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" SortExpression="UnitPrice" />

                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:Button ID="btnDecrease" runat="server" CommandName="DecreaseQuantity" Text="-" CssClass="btn btn-success" OnClick="DecreaseQuantity_Click" />
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                                <asp:Button ID="btnIncrease" runat="server" CommandName="IncreaseQuantity" Text="+" CssClass="btn btn-success" OnClick="IncreaseQuantity_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />

                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" OnClick="BtnDelete_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM Cart WHERE CustomerID = @CustomerID AND ProductID = @ProductID"
            SelectCommand="SELECT Product.ProductImage, Product.ProductName, Product.UnitPrice, Cart.Quantity, Cart.ProductID, Cart.CustomerID, (Cart.Quantity * Product.UnitPrice) As Total FROM [Cart] INNER JOIN [Product] ON Cart.ProductID = Product.ProductID WHERE Cart.CustomerID = @CustomerID"
            UpdateCommand="UPDATE Cart SET Quantity = @Quantity WHERE CustomerID = @CustomerID AND ProductID = @ProductID">
            <SelectParameters>
                <asp:SessionParameter Name="CustomerID" SessionField="CustomerID" Type="String" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="CustomerID" Type="String" />
                <asp:Parameter Name="ProductID" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Quantity" Type="Int32" />
                <asp:Parameter Name="CustomerID" Type="String" />
                <asp:Parameter Name="ProductID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <div class="row">
            <div class="col-md-4 offset-md-8">

                <table id="tblCartDetails" runat="server" class="auto-style1">
                    <tr>
                        <td class="auto-style2">Subtotal</td>
                        <td class="auto-style3">:</td>
                        <td class="auto-style4">
                            <asp:Label ID="lblSubtotal" runat="server" Text="29.60"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Delivery Fee</td>
                        <td class="auto-style3">:</td>
                        <td>
                            <asp:Label ID="lblDelivery" runat="server" Text="5.00"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Total</td>
                        <td class="auto-style3">:</td>
                        <td>
                            <asp:Label ID="lblTotal" runat="server" Text="34.60"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style3">&nbsp;</td>
                        <td>
                            <asp:Button ID="btnCheckOut" runat="server" CssClass="btn btn-success" Text="Check Out" OnClick="BtnCheckOut_Click"/>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:Label ID="lblEmptyCartMessage" runat="server" Text="Your cart is empty." style="margin: 200px auto;" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>
