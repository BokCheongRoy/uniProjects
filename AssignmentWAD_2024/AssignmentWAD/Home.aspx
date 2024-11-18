<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="AssignmentWAD.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:LoginView ID="LoginView2" runat="server">
        <AnonymousTemplate>
            <asp:Panel runat="server" CssClass="bg-light">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <asp:Image runat="server" CssClass="img-fluid" ImageUrl="./assets/img/christmas.jpg" AlternateText="Logo Image" />
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left align-self-center">
                                <h2 class="h2 text-dark">Celebrate the <strong class="text-danger">Magic of Christmas</strong><br />
                                    with <strong class="text-success">Pâtisserie Terroirs</strong></h2>
                                <br />
                                <p class="text-dark">
                                    Welcome to the season of joy, warmth, and delightful festivities!<br />
                                    At <strong class="text-success">Pâtisserie Terroirs</strong>,<br />
                                    we're thrilled to be your companion in making this Christmas truly special.
                                    <br />
                                    Step into our world of holiday wonders, where every moment is wrapped
                                    <br />
                                    in the spirit of giving, sharing, and creating cherished memories.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel runat="server" CssClass="container py-5">
                <div class="row text-center pt-3">
                    <div class="col-lg-6 m-auto">
                        <h1 class="h1">Categories of Sales</h1>
                    </div>
                    <div class="row">
                        <div class="col-12 col-md-4 p-5 mt-3">
                            <asp:HyperLink runat="server" NavigateUrl="Product.aspx?CategoryID=1">
                    <img src=".././assets/img/Baguette.jpg" class="rounded-circle img-fluid border" alt="Bread Image" />
                            </asp:HyperLink>
                            <h5 class="text-center mt-3 mb-3">Bread</h5>
                            <p class="text-center">
                                <asp:HyperLink runat="server" CssClass="btn btn-success" NavigateUrl="Product.aspx?CategoryID=1">View</asp:HyperLink>
                            </p>
                        </div>
                        <div class="col-12 col-md-4 p-5 mt-3">
                            <asp:HyperLink runat="server" NavigateUrl="Product.aspx?CategoryID=2">
                    <img src=".././assets/img/strawberry-shortcake.jpg" class="rounded-circle img-fluid border" alt="Cake Image" />
                            </asp:HyperLink>
                            <h2 class="h5 text-center mt-3 mb-3">Cake</h2>
                            <p class="text-center">
                                <asp:HyperLink runat="server" CssClass="btn btn-success" NavigateUrl="Product.aspx?CategoryID=2">View</asp:HyperLink>
                            </p>
                        </div>
                        <div class="col-12 col-md-4 p-5 mt-3">
                            <asp:HyperLink runat="server" NavigateUrl="Product.aspx?CategoryID=3">
                    <img src=".././assets/img/Almond-Tulles.jpg" class="rounded-circle img-fluid border" alt="Cookie Image" />
                            </asp:HyperLink>
                            <h2 class="h5 text-center mt-3 mb-3">Cookie</h2>
                            <p class="text-center">
                                <asp:HyperLink runat="server" CssClass="btn btn-success" NavigateUrl="Product.aspx?CategoryID=3">View</asp:HyperLink>
                            </p>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </AnonymousTemplate>
        <RoleGroups>
            <asp:RoleGroup Roles="customer">
                <ContentTemplate>
                    <asp:Panel runat="server" CssClass="bg-light">
                        <div class="container">
                            <div class="row p-5">
                                <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                                    <asp:Image runat="server" CssClass="img-fluid" ImageUrl="./assets/img/christmas.jpg" AlternateText="Logo Image" />
                                </div>
                                <div class="col-lg-6 mb-0 d-flex align-items-center">
                                    <div class="text-align-left align-self-center">
                                        <h2 class="h2 text-dark">Celebrate the <strong class="text-danger">Magic of Christmas</strong><br />
                                            with <strong class="text-success">Pâtisserie Terroirs</strong></h2>
                                        <br />
                                        <p class="text-dark">
                                            Welcome to the season of joy, warmth, and delightful festivities!<br />
                                            At <strong class="text-success">Pâtisserie Terroirs</strong>,<br />
                                            we're thrilled to be your companion in making this Christmas truly special.
                                            <br />
                                            Step into our world of holiday wonders, where every moment is wrapped
                                            <br />
                                            in the spirit of giving, sharing, and creating cherished memories.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel runat="server" CssClass="container py-5">
                        <div class="row text-center pt-3">
                            <div class="col-lg-6 m-auto">
                                <h1 class="h1">Categories of Sales</h1>
                            </div>
                            <div class="row">
                                <div class="col-12 col-md-4 p-5 mt-3">
                                    <asp:HyperLink runat="server" NavigateUrl="Product.aspx?CategoryID=1">
                    <img src=".././assets/img/Baguette.jpg" class="rounded-circle img-fluid border" alt="Bread Image" />
                                    </asp:HyperLink>
                                    <h5 class="text-center mt-3 mb-3">Bread</h5>
                                    <p class="text-center">
                                        <asp:HyperLink runat="server" CssClass="btn btn-success" NavigateUrl="Product.aspx?CategoryID=1">View</asp:HyperLink>
                                    </p>
                                </div>
                                <div class="col-12 col-md-4 p-5 mt-3">
                                    <asp:HyperLink runat="server" NavigateUrl="Product.aspx?CategoryID=2">
                    <img src=".././assets/img/strawberry-shortcake.jpg" class="rounded-circle img-fluid border" alt="Cake Image" />
                                    </asp:HyperLink>
                                    <h2 class="h5 text-center mt-3 mb-3">Cake</h2>
                                    <p class="text-center">
                                        <asp:HyperLink runat="server" CssClass="btn btn-success" NavigateUrl="Product.aspx?CategoryID=2">View</asp:HyperLink>
                                    </p>
                                </div>
                                <div class="col-12 col-md-4 p-5 mt-3">
                                    <asp:HyperLink runat="server" NavigateUrl="Product.aspx?CategoryID=3">
                    <img src=".././assets/img/Almond-Tulles.jpg" class="rounded-circle img-fluid border" alt="Cookie Image" />
                                    </asp:HyperLink>
                                    <h2 class="h5 text-center mt-3 mb-3">Cookie</h2>
                                    <p class="text-center">
                                        <asp:HyperLink runat="server" CssClass="btn btn-success" NavigateUrl="Product.aspx?CategoryID=3">View</asp:HyperLink>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </ContentTemplate>
            </asp:RoleGroup>
            <asp:RoleGroup Roles="employee">
                <ContentTemplate>
                    <div class="row justify-content-center" style="height: 500px;">

                        <div class="col-lg-9 ">
                            <h2>&nbsp;</h2>
                            <h2>&nbsp;</h2>
                            <h2>Welcome ! You have successful log in to Patisserie Terroirs Management Page!</h2>
                            <br />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:RoleGroup>
            <asp:RoleGroup Roles="admin">
                <ContentTemplate>
                    <div class="row justify-content-center" style="height: 500px;">

                        <div class="col-lg-9 ">
                            <h2>&nbsp;</h2>
                            <h2>&nbsp;</h2>
                            <h2>Welcome ! You have successful log in to Patisserie Terroirs Management Page!</h2>
                            <br />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>


</asp:Content>
