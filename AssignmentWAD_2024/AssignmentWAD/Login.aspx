<%@ Page Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AssignmentWAD.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="margin-top: 20px; margin-left: auto; margin-right: auto" align="center">

        <h3>Login</h3>
        <p></p>
        <asp:Login ID="login1" runat="server" DestinationPageUrl="~/Home.aspx" BorderColor="#990000" BorderStyle="Solid" BorderWidth="1px">
            <LayoutTemplate>
                <table cellpadding="10" cellspacing="0" style="border-collapse: collapse;">
                    <tr>
                        <td>
                            <table cellpadding="5">
                                <tr>
                                    <td align="center" colspan="2">Log In</td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="LoginButton" runat="server" BackColor="#C09958" CommandName="Login" Text="Log In" ValidationGroup="Login1" BorderColor="#990000" OnClick="LoginButton_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:Login>
        <br />
        <br />
        Need to create a new account?<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Register.aspx">Click Here</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink2" NavigateUrl="~/ResetPassword.aspx" runat="server">Forgot Password?</asp:HyperLink>
        <br />
        <br />

    </div>
    <br />
    <br />

</asp:Content>

