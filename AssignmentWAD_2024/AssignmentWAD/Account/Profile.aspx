<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Bakery.Master" CodeBehind="Profile.aspx.cs" Inherits="AssignmentWAD.Account.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 174px;
            color: #C09958;
            background-color: #605152;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border: 2px solid black;
        }

        td, th {
            border: 1px solid black;
            padding: 8px; /* Adjust padding as needed */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row justify-content-center m-5">
        <div class="col-lg-9">
            <h1>My Profile</h1>

            <div class="text-end mb-3">
                <asp:Button ID="btnSave" CssClass="btn btn-success btn-lg" runat="server" Text="Save" Width="180px" OnClick="btnSave_Click" />
                <asp:Button ID="btnChgPsw" CssClass="btn btn-success btn-lg" runat="server" Text="Change Password" Width="180px" PostBackUrl="~/Account/ChangePassword.aspx" CausesValidation="False" UseSubmitBehavior="False" />
            </div>
            <table style="width: 100%; border: 2px solid black;">
                <tr>
                    <td class="auto-style1">User Name:</td>
                    <td>
                        <asp:LoginName ID="LoginName3" runat="server" />
                    </td>

                </tr>
                <tr>
                    <td class="auto-style1">Name:</td>
                    <td>
                        <asp:TextBox ID="txtName" CssClass="edit-input" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" ForeColor="Red">*</asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Email:</td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Contact Number:</td>
                    <td>
                        <asp:TextBox ID="txtContactNumber" CssClass="edit-input" runat="server" placeholder="011-23456789" MaxLength="12"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtContactNumber" ErrorMessage="Contact Number is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtContactNumber" ErrorMessage="Contact Number's format must follow 011-23456789" ForeColor="Red" ValidationExpression="^01(?:1-\d{8}|0-\d{7}|[2-9]-\d{7})$">*</asp:RegularExpressionValidator>
                    </td>
                </tr>

            </table>
         <p style="margin-top:25px;">   <asp:Label ID="lblMsg" runat="server" ForeColor="#0066FF"></asp:Label></p>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
            <br />
        </div>
    </div>
</asp:Content>
