<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="AssignmentWAD.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-8">
        <div class="row p-3">
            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
            &nbsp;  
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-success" OnClick="BtnSearch_Click" />
        </div>
        <div class="row">
            <asp:Label ID="lblNoResults" runat="server" Text="No results found." Style="margin: 200px auto;" Visible="false"></asp:Label>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="Products" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <div class="col-12 col-md-3 mb-4">
                        <div class="card h-100 m-3 text-align-content-center">
                            <asp:Image runat="server" ImageUrl='<%# Eval("ProductImage") %>' CssClass="card-img-top" />
                            <div class="card-body text-center d-flex flex-column justify-content-center">
                                <div class="mb-2">
                                    <asp:Label ID="lblRate" runat="server" Text="" Style="color:#C09958;float:right;"></asp:Label>
                                </div>
                                <div class="mb-2">
                                    <asp:HiddenField ID="hfProductID" runat="server" Value='<%# Eval("ProductID") %>' />
                                    <a class="text-decoration-none text-dark"><%# Eval("ProductName") %></a>
                                </div>
                                <div class="mb-2">
                                    <ul class="list-unstyled">
                                        <li class="text-center">RM<%# Eval("UnitPrice") %></li>
                                    </ul>
                                </div>
                                 
                                <div class="mb-2">
                                    <asp:Button ID="btnFavourite" runat="server" Style="width: 100%; background-color: transparent; border: none; font-size: 24px; color: red;" Text="&#x2661;" OnClick="BtnFavourite_Click" />
                                </div>
                                <asp:HyperLink runat="server" CssClass="btn btn-success btn-align-content-lg-center" NavigateUrl='<%# "~/ProductDetails.aspx?ProductID=" + Eval("ProductID") %>'>Details</asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <asp:SqlDataSource ID="Products" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Product] WHERE ([CategoryID] = @CategoryID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="CategoryID" QueryStringField="CategoryID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
