<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="YearProfit.aspx.cs" Inherits="AssignmentWAD.Admin.YearProfit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 1241px;
        }

        .auto-style2 {
            width: 107px;
        }

        .auto-style3 {
            text-decoration: underline;
            font-weight: bold;
            font-size: large;
        }
        .auto-style4 {
            height: 499px;
            width: 848px;
        }
        .auto-style5 {
            height: 499px;
            text-align: left;
        }
        .auto-style6 {
            width: 848px;
        }
        .auto-style7 {
            margin-left: 1px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <table style="width: 100%;">
        <tr>
            <td class="auto-style1">&nbsp;</td>
            <td class="auto-style2">
                <asp:Button ID="Button5" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Sales" Width="90px" PostBackUrl="~/Admin/SalesReport.aspx" />
            </td>
            <td>
                <asp:Button ID="Button4" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Profit" Enabled="False" Width="90px" />
            </td>
        </tr>
    </table>

    <div class="row justify-content-center">
        <div class="col-lg-9 text-center">
            <table style="width: 100%;">
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="Button6" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Overall" Width="90px" PostBackUrl="~/Admin/ProfitReport.aspx"/>
                        <asp:Button ID="Button7" CssClass="btn btn-success btn-lg float-right" runat="server"  Text="Monthly" Width="90px" PostBackUrl="~/Admin/MonthlyProfit.aspx" />
                        <asp:Button ID="Button8" CssClass="btn btn-success btn-lg float-right" runat="server" Enabled="False" Text="Yearly" Width="90px" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <strong>
                            <asp:Label ID="Label1" runat="server" Text="Yearly Profit" CssClass="auto-style3" style="font-size: 2em;"></asp:Label>
                        </strong>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <h5>Select the Year for the Yearly Profit Report</h5>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource6" DataTextField="OrderYear" DataValueField="OrderYear" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table class="w-100">
                <tr>
                    <td class="auto-style4">
            <asp:Chart ID="Chart3" runat="server" DataSourceID="SqlDataSource4">
                <Series>
                    <asp:Series Name="Series1" XValueMember="ProductName" YValueMembers="TotalPrice" Color="#C09958">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                        <AxisY Title="Total Profit(RM)" TitleForeColor="#C09958">
                            <MajorGrid LineColor="#C0C0C0" />
                        </AxisY>
                        <AxisX Title="Product Name" TitleForeColor="#C09958">
                            <MajorGrid LineColor="#C0C0C0" />
                        </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
                    </td>
                    <td class="auto-style5">
                        <div class="text-start">
                            <asp:DataList ID="DataList1" runat="server" CssClass="auto-style7" DataSourceID="SqlDataSource4">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                    &nbsp;: RM<asp:Label ID="Label3" runat="server" Text='<%# Eval("TotalPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <div class="text-start">
                            ---------------------------------------</div>
                        <div class="text-start">
                            <asp:DataList ID="DataList2" runat="server" DataSourceID="sum">
                                <ItemTemplate>
                                    Yearly Profit:
                                    <asp:Label ID="Yearly_ProfitLabel" runat="server" Text='<%# Eval("[Yearly Profit]") %>' />
                                    <br />
<br />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <asp:SqlDataSource ID="sum" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM(TotalPrice) AS [Yearly Profit] FROM (
    SELECT 
        Product.ProductID,
        Product.ProductName,
        Product.UnitPrice * OrderDetails.Quantity AS TotalPrice,
        OrderDetails.ProductID AS Expr1,
        OrderDetails.Quantity 
    FROM 
        Product 
        INNER JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID
        INNER JOIN [Order] ON OrderDetails.OrderID = [Order].OrderID
    WHERE 
        YEAR([Order].OrderDate) = @year
)&nbsp;AS&nbsp;Subquery;">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList2" Name="year" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="text-start">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="text-start">&nbsp;</td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT Product.ProductID, Product.ProductName, Product.UnitPrice * OrderDetails.Quantity AS TotalPrice, OrderDetails.ProductID AS Expr1, OrderDetails.Quantity 
                                FROM Product 
                                INNER JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID
                                INNER JOIN [Order] ON OrderDetails.OrderID = [Order].OrderID
                                WHERE YEAR([Order].OrderDate) = @year">

                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="year" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT  DISTINCT YEAR(OrderDate) AS OrderYear
FROM [Order];
"></asp:SqlDataSource>
            <br />
            <br />
        </div>
    </div>
</asp:Content>

