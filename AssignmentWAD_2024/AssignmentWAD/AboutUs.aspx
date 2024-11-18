<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="AssignmentWAD.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel runat="server" CssClass="bg-light">
        <div class="container">
            <div class="row p-5">
                <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                    <asp:Image runat="server" CssClass="img-fluid" ImageUrl="./assets/img/pt_shop_sign.png" AlternateText="Shop Image" />
                </div>
                <div class="col-lg-6 mb-0 d-flex align-items-center">
                    <div class="text-align-left align-self-center">
                        <h2 class="h2 text-dark">Welcome to Pâtisserie Terroirs:<br />
                            A Taste of French Artistry<br />
                            in the Heart of Kuala Lumpur!</h2>
                        <br />
                        <p class="text-dark">
                            At Pâtisserie Terroirs,
                            <br />
                            we invite you to embark on a delectable journey 
                            <br />
                            through the rich and enchanting world of French pastry. 
                            <br />
                            Nestled in the vibrant city of Kuala Lumpur, Malaysia, 
                            <br />
                            our bakery shop is a celebration of 
                            <br />
                            authentic French flavors and craftsmanship. 
                            <br />
                            With a heritage deeply rooted in the heart of France, 
                            <br />
                            we bring the essence of French terroirs to your doorstep.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" CssClass="container py-5 h-100">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">Our Story</h1>
            </div>
        </div>
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <p>
                    Founded with a passion for exquisite pastries and a commitment to quality,
                    <br />
                    Pâtisserie Terroirs traces its roots to the charming landscapes of France.
                    <br />
                    Our journey began with a dream to share the timeless artistry
                    <br />
                    of French baking with the world.
                    <br />
                    After meticulous planning and a dedication to preserving
                    <br />
                    the authenticity of French flavors,
                    <br />
                    we proudly opened our first and only branch in Kuala Lumpur, Malaysia.<br />
                    <strong>Pâtisserie Terroirs, 12, Jalan Genting Klang, 53200 Kuala Lumpur</strong>
                </p>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" CssClass="bg-light">
    <div class="container">
        <div class="row p-5">
            <div class="col-lg-6 mb-0 d-flex align-items-center order-lg-last ps-3">
                <div class="text-align-left align-self-center">
                    <h2 class="h2 text-dark">Visit Us</h2>
                    <br />
                    <p class="text-dark">
                        Step into our elegant and inviting space in the heart of Kuala Lumpur<br />
                        and experience the magic of Pâtisserie Terroirs. <br />
                        Whether you're seeking a sweet escape, a delightful gift, <br />
                        or simply a taste of France in Malaysia, <br />
                        our bakery welcomes you with open arms <br />
                        and the irresistible aroma of freshly baked delights.<br />

                    </p>
                </div>
            </div>
            <div class="mx-auto col-md-8 col-lg-6">
                <asp:Image runat="server" CssClass="img-fluid" ImageUrl="./assets/img/pt_shop.jpg" AlternateText="Shop Image" />
            </div>
        </div>
    </div>
</asp:Panel>
</asp:Content>
