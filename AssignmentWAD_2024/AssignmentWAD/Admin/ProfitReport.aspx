<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ProfitReport.aspx.cs" Inherits="AssignmentWAD.Admin.ProfitReport" %>

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
        }
        .auto-style4 {
            height: 29px;
        }
        .auto-style5 {
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
                        <asp:Button ID="Button6" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Overall" Width="90px" Enabled="False"  />
                        <asp:Button ID="Button7" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Monthly" Width="90px" PostBackUrl="~/Admin/MonthlyProfit.aspx"  />
                        <asp:Button ID="Button8" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Yearly" Width="90px" PostBackUrl="~/Admin/YearProfit.aspx" />


                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style4"></td>
                    <td class="auto-style4">
                        <strong>
                            <asp:Label ID="Label1" runat="server" Text="Overall Profit" CssClass="auto-style3" style="font-size: 2em;" ></asp:Label>
                        </strong>
                    </td>
                    <td class="auto-style4"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>

                    <td>
                        &nbsp;</td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td class="auto-style5">
            <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource2" Height="400">
                <Series>
                    <asp:Series Name="Series1" XValueMember="ProductName" YValueMembers="TotalPrice" Color="#C09958"></asp:Series>
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
                    <td class="text-start">
                        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource2">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                &nbsp;: RM<asp:Label ID="Label3" runat="server" Text='<%# Eval("TotalPrice") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:DataList>
                        ---------------------------------------<asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource3">
                            <ItemTemplate>
                                Overall Profit: RM
                                <asp:Label ID="Overall_ProfitLabel" runat="server" Text='<%# Eval("[Overall Profit]") %>' />
                                <br />
<br />
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM(TotalPrice) AS [Overall Profit] FROM (
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
 )&nbsp;AS&nbsp;Subquery;"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Product.ProductID, Product.ProductName, Product.UnitPrice * OrderDetails.Quantity AS TotalPrice, OrderDetails.ProductID AS Expr1, OrderDetails.Quantity FROM Product INNER JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID"></asp:SqlDataSource>
            <br />
            <br />
            <br />
        </div>
    </div>
</asp:Content>
