<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="MonthlySales.aspx.cs" Inherits="AssignmentWAD.Admin.MonthlySales" %>
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
                <asp:Button ID="Button5" CssClass="btn btn-success btn-lg float-right" Enabled="False" runat="server" Text="Sales" Width="90px"  />
            </td>
            <td>
                <asp:Button ID="Button4" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Profit" PostBackUrl="~/Admin/ProfitReport.aspx" Width="90px" />
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
                        <asp:Button ID="Button6" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Overall" Width="90px"   PostBackUrl="~/Admin/SalesReport.aspx" />
                        <asp:Button ID="Button7" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Monthly" Width="90px" Enabled="False"/>
                        <asp:Button ID="Button8" CssClass="btn btn-success btn-lg float-right" runat="server" Text="Yearly" Width="90px" PostBackUrl="~/Admin/YearSales.aspx"   />


                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style4"></td>
                    <td class="auto-style4">
                        <strong>
                            <asp:Label ID="Label1" runat="server" Text="Monthly Sales Quantity" CssClass="auto-style3" style="font-size: 2em;" ></asp:Label>
                        </strong>
                    </td>
                    <td class="auto-style4"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>

                    <td>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3" DataTextField="OrderMonth" DataValueField="OrderMonth" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="OrderYear" DataValueField="OrderYear" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <!-- Chart1 control -->
            <table style="width:100%;">
                <tr>
                    <td class="auto-style5">
            <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Height="400px">
    <Series>
        <asp:Series Name="Series1" XValueMember="ProductName" YValueMembers="TotalQuantity" Font="30px" Color="#C09958"></asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1">
            <AxisY Title="Total Quantity" TitleForeColor="#C09958">
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
                            <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                    &nbsp;:
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("TotalQuantity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <div class="text-start">
                            ---------------------------------------</div>
                        <div>
                            <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource4">
                                <ItemTemplate>
                                    TotalQty:
                                    <asp:Label ID="TotalQtyLabel" runat="server" Text='<%# Eval("TotalQty") %>' />
                                    <br />
<br />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SUM(TotalQuantity) AS TotalQty
FROM (
SELECT Product.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM Product
INNER JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID
INNER JOIN [Order] ON OrderDetails.OrderID = [Order].OrderID
WHERE Month([Order].OrderDate) = @month
 AND Year([Order].OrderDate) = @year GROUP BY Product.ProductName
)&nbsp;AS&nbsp;Subquery;">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList2" Name="month" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList1" Name="year" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
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
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Product.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM Product
INNER JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID
INNER JOIN [Order] ON OrderDetails.OrderID = [Order].OrderID
WHERE  MONTH([Order].OrderDate) = @month AND  YEAR([Order].OrderDate) = @year 
GROUP BY Product.ProductName
">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="month" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="year" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT MONTH(OrderDate) AS OrderMonth
FROM [Order];
"></asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT  DISTINCT YEAR(OrderDate) AS OrderYear
FROM [Order] Where MONTH(OrderDate) = @month;
">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="month" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </div>
    </div>
</asp:Content>
