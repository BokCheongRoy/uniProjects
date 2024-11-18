<%@ Page Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ViewOrderHistory.aspx.cs" Inherits="AssignmentWAD.Customer.ViewOrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .gridview-container {
            margin-top: 20px;
            text-align: center;
            min-height: 500px;
        }

            .gridview-container #lblEmptyOrder {
                margin: 200px auto;
                padding-top: 100px;
            }

        .custom-gridview {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }

            .custom-gridview th,
            .custom-gridview td {
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
            display: flex;
            justify-content: center;
            margin: 10px auto;
        }

            .auto-style1 strong {
                margin-left: 10px;
            }

            .auto-style1 .btn {
                text-align: center;
                width: 100px; 
                margin-right: 10px; 
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="gridview-container">
        <div class="row">
            <div class="col-md-12">
                <h2 class="ml-3" style="text-align: left; padding-left: 10%">Order History</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="auto-style1">
                    <strong>
                        <asp:Button ID="BtnPending" CssClass="btn btn-success btn-lg" runat="server" Text="New Order"  Style="padding-left: 5px; padding-right: 5px;" OnClick="BtnPending_Click" />
                        <asp:Button ID="BtnPreparing" CssClass="btn btn-success btn-lg" runat="server" Text="To Receive" Style="padding-left: 5px; padding-right: 5px;" OnClick="BtnPreparing_Click" />
                        <asp:Button ID="BtnDelivered" CssClass="btn btn-success btn-lg" runat="server" Text="To Rate"  Style="padding-left: 5px; padding-right: 5px;" OnClick="BtnDelivered_Click" />
                        <asp:Button ID="BtnRated" CssClass="btn btn-success btn-lg" runat="server" Text="Rated" Style="padding-left: 5px; padding-right: 5px;" OnClick="BtnRated_Click" />
                    </strong>
                </div>
            </div>
            <div class="col-md-12">
                <asp:Label ID="lblEmptyOrder" runat="server" Text="No Orders Yet" Visible="false"></asp:Label>
                <asp:GridView ID="GridViewOrder" runat="server" CssClass="custom-gridview" AutoGenerateColumns="False" DataKeyNames="OrderID,CustomerID" DataSourceID="SqlDataSource1" AllowPaging="True" OnSelectedIndexChanged="GridViewOrder_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="OrderID" HeaderText="Order ID" ReadOnly="True" SortExpression="OrderID" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Date" SortExpression="OrderDate" DataFormatString="{0:dd/MM/yyyy}"  ItemStyle-Width="15%"/>
                        <asp:BoundField DataField="RecipientName" HeaderText="Recipient" SortExpression="RecipientName"  ItemStyle-Width="20%"/>
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"  ItemStyle-Width="30%"/>
                        <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber"  ItemStyle-Width="15%"/>
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"  ItemStyle-Width="10%"/>
                    </Columns>
                </asp:GridView>
            </div>
            <div class="col-md-12 mt-5">
                <asp:GridView ID="GridView1" runat="server" CssClass="custom-gridview" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                    <Columns>
                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                                <asp:Image runat="server" ImageUrl='<%# Eval("ProductImage") %>' Width="50px" Height="50px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductName" HeaderText="Product" SortExpression="ProductName" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                        <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                    </Columns>
                </asp:GridView>
                <div class="col-md-4 m-2 float-end">
                <asp:Button ID="btnRate" runat="server" Text="Rate" CssClass="btn btn-success" Style="width:100px;" Visible="false" OnClick="BtnRate_Click" />
                 </div>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT OrderDetails.ProductID, Product.ProductImage, Product.ProductName, OrderDetails.Quantity, (Product.UnitPrice * OrderDetails.Quantity) AS Total FROM OrderDetails INNER JOIN Product ON Product.ProductID = OrderDetails.ProductID WHERE OrderDetails.OrderID = @OrderID ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridViewOrder" Name="OrderID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Order] WHERE (([CustomerID] = @CustomerID) AND ([Status] = @Status)) ORDER BY [OrderID] DESC">
                    <SelectParameters>
                        <asp:SessionParameter Name="CustomerID" SessionField="CustomerID" Type="String" />
                        <asp:Parameter DefaultValue="Pending" Name="Status" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
