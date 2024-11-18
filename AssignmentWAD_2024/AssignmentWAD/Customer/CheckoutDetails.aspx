<%@ Page Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="CheckoutDetails.aspx.cs" Inherits="AssignmentWAD.Customer.CheckoutDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .auto-style1 {
            margin-left: 240px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5" style="margin: auto;">
        <h1>Check Out</h1>
        
        <div class="row py-5">
            <div class="col-md-6">
                <!-- Delivery Form -->
                <h2>Delivery Details</h2>
                <br />
                <div class="form-group row m-1">
                    <label class="col-lg-4 col-form-label mt-2" for="Rname">Receiver's Name</label>
                    <asp:TextBox ID="Rname" runat="server" CssClass="form-control" placeholder="Recipient Name" Style="width: 50%;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Rname" ErrorMessage="Name is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </div>
                <div class="form-group row m-1">

                    <label class="col-lg-4 col-form-label mt-2" for="Pno">Phone Number</label>
                    <asp:TextBox ID="Pno" runat="server" CssClass="form-control" Style="width: 50%;" placeholder="011-23456789" MaxLength="12"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Pno" ErrorMessage="Phone Number is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Pno" ErrorMessage="Phone Number's format must follow 011-23456789" ForeColor="Red" ValidationExpression="^01(?:1-\d{8}|0-\d{7}|[2-9]-\d{7})$">*</asp:RegularExpressionValidator>

                </div>
                <div class="form-group row m-1">
                    <label for="address" class="col-lg-4 col-form-label mt-2">Address</label>
                    <asp:TextBox ID="delAddress1" runat="server" TextMode="MultiLine" CssClass="form-control col-lg-8" MaxLength="60" placeholder="Address 1" Style="width: 50%;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="delAddress1" ErrorMessage="Address is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </div>
                <div class="form-group row m-1">
                    <label class="col-lg-4 col-form-label mt-2" for="postcode">Postcode</label>
                    <asp:TextBox ID="postcode" runat="server" CssClass="form-control" placeholder="12345" Style="width: 50%;" MaxLength="5"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="postcode" ErrorMessage="Postcode is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="postcode" ErrorMessage="Postcode must consist of 5 numbers only" ForeColor="Red" ValidationExpression="\d{5}">*</asp:RegularExpressionValidator>
                </div>
                <div class="form-group row m-1">

                    <label for="state" class="col-lg-4 col-form-label mt-2">State</label>
                    <asp:TextBox ID="state" runat="server" CssClass="form-control col-lg-8" MaxLength="20" placeholder="State" Style="width: 50%;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="state" ErrorMessage="State is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                </div>
                <br />

            </div>
            <div class="col-md-6">
                <div class='row cf'>
                    <div class='col-sm-12'>
                        <div id="paymentMethod" class="paymentMethod">
                            <h2>Payment</h2>
                            <br />
                            <div class="form-group row m-1">
                                <label class="col-lg-4 col-form-label mt-2">Payment Method</label>

                                <asp:RadioButtonList ID="paymentMethodList" runat="server" CssClass="d-flex align-items-center" AutoPostBack="True" OnSelectedIndexChanged="PaymentMethodList_SelectedIndexChanged">
                                    <asp:ListItem Text="Cash &#128181;" Value="Cash" />
                                    <asp:ListItem Text='Debit Card/Credit Card &amp;#128179;' Value="Card" />
                                </asp:RadioButtonList>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="paymentMethodList" ErrorMessage="Payment Method is required" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>

                            <div class="form-group row m-1" runat="server" id="cardDetails">
                                <label class="col-lg-4 col-form-label mt-2">Card Number </label>
                                <asp:TextBox ID="cardNo" runat="server" CssClass="form-control col-lg-8" placeholder="1111222233334444" Style="width: auto;" MaxLength="16" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cardNo" ErrorMessage="Card Number is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="cardNo" ErrorMessage="Card Number must consist of 16 numbers only." ForeColor="Red" ValidationExpression="\w{16}">*</asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group row m-1" runat="server" id="cardNameDetails">
                                <label class="col-lg-4 col-form-label mt-2">Name on Card</label>
                                <asp:TextBox ID="cardName" runat="server" CssClass="form-control col-lg-8" Placeholder="Card Name" Style="width: auto;" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="cardName" ErrorMessage="Card Name is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group row m-1" runat="server" id="cardExpDetails">
                                <label class="col-lg-4 col-form-label mt-2">Expired Date</label>
                                <div class="col-lg-8 d-flex align-items-center">
                                    <asp:DropDownList ID="ddlExpMonth" runat="server" CssClass="form-control" Width="100" AutoPostBack="True">
                                        <asp:ListItem>01</asp:ListItem>
                                        <asp:ListItem>02</asp:ListItem>
                                        <asp:ListItem>03</asp:ListItem>
                                        <asp:ListItem>04</asp:ListItem>
                                        <asp:ListItem>05</asp:ListItem>
                                        <asp:ListItem>06</asp:ListItem>
                                        <asp:ListItem>07</asp:ListItem>
                                        <asp:ListItem>08</asp:ListItem>
                                        <asp:ListItem>09</asp:ListItem>
                                        <asp:ListItem>10</asp:ListItem>
                                        <asp:ListItem>11</asp:ListItem>
                                        <asp:ListItem>12</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlExpMonth" ErrorMessage="Expired date in month is required" ForeColor="Red" EnableClientScript="True">*</asp:RequiredFieldValidator>

                                    <span class="mx-2">/</span>
                                    <asp:DropDownList ID="ddlExpYear" runat="server" CssClass="form-control" Width="100" AutoPostBack="True">
                                        <asp:ListItem>2024</asp:ListItem>
                                        <asp:ListItem>2025</asp:ListItem>
                                        <asp:ListItem>2026</asp:ListItem>
                                        <asp:ListItem>2027</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="cvv" ErrorMessage="Expired date in year is required" ForeColor="Red">*</asp:RequiredFieldValidator>

                                </div>
                            </div>

                            <div class="form-group row m-1" runat="server" id="cvvDetails">
                                <label class="col-lg-4 col-form-label mt-2">CVV</label>
                                <asp:TextBox ID="cvv" runat="server" CssClass="form-control col-lg-8" Style="width: auto;" Size="20" MaxLength="3" Placeholder="123" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cvv" ErrorMessage="CVV is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="cvv" ErrorMessage="CVV must consist of 3 numbers only" ForeColor="Red" ValidationExpression="\d{3}">*</asp:RegularExpressionValidator>


                            </div>
                            <div>
                                <br />
                                <asp:Button ID="btnPay" runat="server" Text="Confirm Payment" CssClass="btn btn-success btn-lg px-3" OnClick="BtnPay_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" CausesValidation="false" CssClass="btn btn-success btn-lg px-3" OnClick="btnReset_Click" />
                                <br />
                                <br />
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" />

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
