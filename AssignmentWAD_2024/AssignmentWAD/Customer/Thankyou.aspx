<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Bakery.Master" CodeBehind="Thankyou.aspx.cs" Inherits="AssignmentWAD.Customer.Thankyou" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row text-center py-3">
        <div class="col-lg-6 m-auto">
            <span class="icon-check_circle display-3 text-success"></span>

            <h1 class="h1">Thank you for Purchasing!</h1>
            <p class="lead mb-5">You order was successfully completed.</p>
            <br />
            <br />
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Customer/ViewOrderHistory.aspx">Click Here</asp:HyperLink>&nbsp; to View Order History                    
        </div>
    </div>
</asp:Content>
