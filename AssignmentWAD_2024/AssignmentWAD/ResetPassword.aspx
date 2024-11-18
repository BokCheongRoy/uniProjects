<%@ Page Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="AssignmentWAD.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 205px;
        }
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="margin-top: 20px; margin-left: auto; margin-right: auto" align="center">

        <h3>Forgot Password</h3>

        <br />

  <asp:Label id="Msg" runat="server" ForeColor="maroon" /><br />

  Username: <asp:Textbox id="UsernameTextBox" Columns="30" runat="server" AutoPostBack="true" />
            <asp:RequiredFieldValidator id="UsernameRequiredValidator" runat="server"
                                        ControlToValidate="UsernameTextBox" ForeColor="red"
                                        Display="Static" ErrorMessage="Username is Required" >*</asp:RequiredFieldValidator>
        <br />
        <br />
  <asp:Button id="ResetPasswordButton" Text="Reset Password" 
              OnClick="ResetPassword_OnClick" runat="server" Enabled="false" CssClass="btn btn-success btn-lg px-3" />
        <br />
        <br />
    </div>
</asp:Content>
