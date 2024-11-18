<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="MonthlyProfit.aspx.cs" Inherits="AssignmentWAD.Admin.MonthlyProfit" %>

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
            width: 848px;
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
        <div class="col-lg-9 text-center" style="text-align: center !important">
            <table style="width: 100%;">
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="Button6" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Overall" Width="90px" PostBackUrl="~/Admin/ProfitReport.aspx" />
                        <asp:Button ID="Button7" CssClass="btn btn-success btn-lg float-right" runat="server" Enabled="False" Text="Monthly" Width="90px" />
                        <asp:Button ID="Button8" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Yearly" Width="90px" PostBackUrl="~/Admin/YearProfit.aspx" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <strong>
                            <asp:Label ID="Label1" runat="server" Text="Monthly Profit" CssClass="auto-style3" Style="font-size: 2em;"></asp:Label>
                        </strong>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <h5>Select the Month for the Monthly Profit Report</h5>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource5" DataTextField="OrderMonth" DataValueField="OrderMonth" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource6" DataTextField="OrderYear" DataValueField="OrderYear" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width:100%;">
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
                    <td>
                        <div class="text-start">
                            <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource4">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                    &nbsp;: RM<asp:Label ID="Label3" runat="server" Text='<%# Eval("TotalPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <div class="text-start">
                            ---------------------------------------</div>
                        <div class="text-start">
                            <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource8">
                                <ItemTemplate>
                                    MonthlyProfit: RM
                                    <asp:Label ID="MonthlyProfitLabel" runat="server" Text='<%# Eval("MonthlyProfit") %>' />
                                    <br />
<br />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM(TotalPrice) AS [MonthlyProfit] FROM (
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
        Month([Order].OrderDate) = @month
 AND Year([Order].OrderDate) = @year
)&nbsp;AS&nbsp;Subquery;">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList1" Name="month" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList2" Name="year" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style4">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br />
            <%--<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>--%>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT Product.ProductID, Product.ProductName, Product.UnitPrice * OrderDetails.Quantity AS TotalPrice, OrderDetails.ProductID AS Expr1, OrderDetails.Quantity 
                                FROM Product 
                                INNER JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID
                                INNER JOIN [Order] ON OrderDetails.OrderID = [Order].OrderID
                                WHERE MONTH([Order].OrderDate) = @month AND YEAR([Order].OrderDate) = @year">

                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="month" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList2" Name="year" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT  DISTINCT  MONTH(OrderDate) AS OrderMonth
FROM [Order];
"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT  DISTINCT YEAR(OrderDate) AS OrderYear
FROM [Order] Where MONTH(OrderDate) = @month;
">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="month" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM(TotalPrice) AS TotalSum
FROM (
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
        MONTH([Order].OrderDate) = @month AND YEAR([Order].OrderDate) = @year
) AS Subquery;
">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="month" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList2" Name="year" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
        </div>
    </div>
</asp:Content>
