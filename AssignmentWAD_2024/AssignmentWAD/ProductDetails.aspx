<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="AssignmentWAD.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            margin-right: 1px;
        }
        .headerStyle {
        font-weight: bold;
    }
   
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand" OnItemDataBound="Repeater1_ItemDataBound">
        <ItemTemplate>
            <div class="container pb-5">
                <div class="row h-auto align-items-stretch">
                    <div class="col-lg-5 mt-5">
                        <div class="card h-100">
                            <asp:Image runat="server" ImageUrl='<%# Eval("ProductImage") %>' CssClass="card-img" />
                        </div>
                    </div>
                    <div class="col-lg-7 mt-5">
                        <div class="card h-100">
                            <div class="card-body">
                                <asp:Label ID="lblRate" runat="server" Text="" Style="color: #C09958; float: right;"></asp:Label>
                                <asp:HiddenField ID="hfProductID" runat="server" Value='<%# Eval("ProductID") %>' />

                                <h1 class="h2"><%#Eval("ProductName") %></h1>
                                <p class="h3 py-2">
                                    RM<%#Eval("UnitPrice")%><br />
                                    <br />
                                </p>
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <h6>Description:</h6>
                                    </li>
                                    <br />
                                    <li class="list-inline-item">
                                        <p>
                                            <strong>Size: </strong><%#Eval("Size")%><br />
                                            <strong>Ingredient: </strong><%#Eval("Ingredient")%>
                                        </p>
                                    </li>
                                </ul>
                                <br />
                                <br />
                                <h6>Quantity:</h6>
                                <asp:Button ID="btnDecrease" runat="server" CssClass="auto-style1 btn-success" Height="30px" Text="-" Width="30px" OnClick="BtnDecrease_Click" />
                                <asp:TextBox ID="txtQty" runat="server" CssClass="mt-0" Text="1" Width="38px" Enabled="false"></asp:TextBox>
                                <asp:Button ID="btnIncrease" runat="server" CssClass="auto-style1 btn-success" Height="30px" Text="+" Width="30px" OnClick="BtnIncrease_Click" />
                            </div>
                            <div class="row p-3">
                                <asp:Label ID="lblAdded" runat="server" Text="" Style="text-align: center; width: 90%;"></asp:Label><br />
                                <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-success btn-lg" Style="width: 90%;" Text="Add To Cart" OnClick="BtnAddToCart_Click" OnClientClick="myFunction(); return false;" />
                                <asp:Button ID="btnFavourite" runat="server" Style="width: 10%; background-color: transparent; border: none; font-size: 24px; color: red;" Text="&#x2661;" OnClick="BtnFavourite_Click" />
                            </div>
                        </div>
                    </div>
                </div>
        </ItemTemplate>
    </asp:Repeater>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Product] WHERE ([ProductID] = @ProductID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="container pb-5">
        <asp:Label ID="lblNoReview" runat="server" Text="No Comments Yet" Visible="false"></asp:Label>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="OrderID,ProductID" DataSourceID="SqlDataSource2" OnRowDataBound="GridView1_RowDataBound" >
            <Columns>
                <asp:BoundField DataField="RatingDate" HeaderText="Date" SortExpression="RatingDate" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Width="150px" HeaderStyle-CssClass="headerStyle" />
                <asp:TemplateField HeaderText="Rating" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblRatingStars" runat="server" Text='<%# GetStarRating(Eval("Rating")) %>' HtmlEncode="false" Style="color: #C09958;"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Review" HeaderText="Review" SortExpression="Review" ItemStyle-Width="600px" HeaderStyle-CssClass="headerStyle" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [OrderDetails] WHERE ([ProductID] = @ProductID AND [Rating] IS NOT NULL) ORDER BY [RatingDate] DESC">
            <SelectParameters>
                <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>

</asp:Content>
