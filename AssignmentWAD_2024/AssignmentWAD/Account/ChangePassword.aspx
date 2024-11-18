<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Bakery.Master" CodeBehind="ChangePassword.aspx.cs" Inherits="AssignmentWAD.Account.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .auto-style1 {
            width: 221px;
        }

        .auto-style2 {
            width: 496px;
        }
        .auto-style3 {
            height: 18px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-top: 40px; margin-left: auto; margin-right: auto; margin-bottom: 40px;" align="center">
        <br />
        <asp:ChangePassword ID="ChangePassword1" runat="server" CancelDestinationPageUrl="~/Account/Profile.aspx" ContinueDestinationPageUrl="~/Account/Profile.aspx" BorderStyle="Solid" BackColor="#F7F6F3" BorderColor="#990000" BorderPadding="4" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em">
            <CancelButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
            <ChangePasswordButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
            <ChangePasswordTemplate>
                <table cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                    <tr>
                        <td class="auto-style2">
                            <table cellpadding="2">
                                <tr>
                                    <td align="left" colspan="2">Change Your Password</td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="ChangePassword1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                                    </td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="ChangePassword1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="NewPassword" ErrorMessage="Please enter correct password format (minimum 8 chatacters include letters, numerics and symbols)" ForeColor="Red" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&amp;])[A-Za-z\d@$!%*?&amp;]{8,}$"></asp:RegularExpressionValidator>
                                        <br />
                                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="ChangePassword1" ForeColor="Red"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" CssClass="btn btn-success btn-lg px-3" OnClick="ChangePasswordPushButton_Click" Text="Change Password" ValidationGroup="ChangePassword1" />
                                        <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-success btn-lg px-3" Text="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ChangePasswordTemplate>
            <ContinueButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
            <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
            <PasswordHintStyle Font-Italic="True" ForeColor="#888888" />
            <SuccessTemplate>
                <table cellpadding="4" cellspacing="0" style="border-collapse: collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                <tr>
                                    <td align="center" style="color:white; background-color:#c09958; font-size:0.9em;font-weight:bold;">Change Password Complete</td>
                                </tr>
                                <tr>
                                    <td>Your password has been changed!</td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Button ID="ContinuePushButton" runat="server" BackColor="#C09958" BorderColor="#990000" BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="Continue" Font-Names="Verdana" ForeColor="#284775" Text="Continue" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </SuccessTemplate>
            <TextBoxStyle Font-Size="0.8em" />
            <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
        </asp:ChangePassword>
        <br />

    </div>
</asp:Content>
