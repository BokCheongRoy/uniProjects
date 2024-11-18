<%@ Page Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="AssignmentWAD.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="margin-top: 20px; margin-left: auto; margin-right: auto" align="center">

        <h3>Register</h3>
        <br />

        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" Width="463px" ContinueDestinationPageUrl="~/Home.aspx" BorderColor="#990000" BorderStyle="Solid" BorderWidth="1px" AutoLogin="false" OnCreatedUser="CreateUserWizard1_CreatedUser" ConfirmPasswordCompareErrorMessage="Error: The Password and Confirmation Password must match." ConfirmPasswordRequiredErrorMessage="Error: Confirm Password is required." EmailRegularExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" EmailRegularExpressionErrorMessage="Error: Please enter a valid e-mail." InvalidAnswerErrorMessage="Error: Please enter a different security answer." InvalidEmailErrorMessage="Error: Please enter a valid e-mail address." InvalidPasswordErrorMessage="Error: Password length minimum: {8}. Non-alphanumeric characters required: {1}." InvalidQuestionErrorMessage="Error: Please enter a different security question." PasswordRegularExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&amp;])[A-Za-z\d@$!%*?&amp;]{8,}$" PasswordRegularExpressionErrorMessage="Error: Please enter a valid password minimum 8 characters include letters, numerics and symbols." PasswordRequiredErrorMessage="Error: Password is required." UserNameRequiredErrorMessage="Error: User Name is required.">
            <ContinueButtonStyle BackColor="#c09958" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" ForeColor="Black" />
            <TitleTextStyle BackColor="#c09958" Font-Bold="True" ForeColor="White" />
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">

                    <CustomNavigationTemplate>
                        <table border="0" cellspacing="5" style="width: 100%; height: 100%; border-collapse: collapse;">
                            <tr>
                                <td colspan="2" style="height: 10px;"></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Register" BackColor="#c09958" BorderColor="Black" ValidationGroup="CreateUserWizard1"/>
                                </td>
                            </tr>
                        </table>
                    </CustomNavigationTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
            <HeaderStyle BackColor="#c09958" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="#333333" HorizontalAlign="Center" />
            <NavigationButtonStyle BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" ForeColor="#990000" />
            <SideBarButtonStyle ForeColor="black" />
            <SideBarStyle BackColor="black" Font-Size="0.9em" VerticalAlign="Top" />
        </asp:CreateUserWizard>

        <br />
        Already have an account?<asp:HyperLink ID="HyperLink1" NavigateUrl="~/Login.aspx" runat="server">Go to Login</asp:HyperLink>

    </div>
    <br />
    <br />
</asp:Content>
