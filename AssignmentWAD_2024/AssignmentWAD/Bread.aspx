<%@ Page Title="" Language="C#" MasterPageFile="~/NoLogin.Master" AutoEventWireup="true" CodeBehind="Bread.aspx.cs" Inherits="AssignmentWAD.Bread" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="Product">
            <ItemTemplate>
                <div class="col-12 col-md-4 mb-4 mx-auto">
                    <div class="card h-100">
                        <a>
                            <img src="./assets/img/pt_logo1.png" class="card-img-top" alt="...">
                        </a>
                        <div class="card-body">
                            <a class="text-decoration-none text-dark"><%# Eval("ProductName") %></a>
                            <br />
                            <ul class="list-unstyled d-flex justify-content-between">
                                <li class="text-muted text-right">RM<%# Eval("UnitPrice") %></li>
                            </ul>
                            <asp:HyperLink runat="server" NavigateUrl='<%# "ProductDetails?ProductID=" + Eval("ProductID") %>'>Details</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <asp:SqlDataSource ID="Product" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice] FROM [Product] WHERE [CategoryID] = 1"></asp:SqlDataSource>
</asp:Content>
