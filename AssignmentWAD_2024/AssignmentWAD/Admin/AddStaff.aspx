<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Bakery.Master" CodeBehind="addStaff.aspx.cs" Inherits="AssignmentWAD.addStaff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 792px;
        }

        .auto-style2 {
            color: #615253;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function showConfirmation() {
            if (Page_ClientValidate()) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You are about to add the item.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, add it!'
                }).then((result) => {
                    if (result.isConfirmed) {
        // Trigger postback on button click
                    <%= Page.ClientScript.GetPostBackEventReference(btnAdd, null) %>;
                    }
                });
            }
            return false; // Prevents default form submission
        }

        // Function to show success message after postback
        function showSuccessMessage() {
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: 'The item has been added successfully.',
                timer: 5000,
                timerProgressBar: true,
                showConfirmButton: false
            });

            // Clear text fields after success
            document.getElementById('<%=txtStaffID.ClientID%>').value = '<%= GenerateNextID() %>';
            document.getElementById('<%=txtName.ClientID%>').value = '';
            document.getElementById('<%=txtEmail.ClientID%>').value = '';
            document.getElementById('<%=txtPhoneNum.ClientID%>').value = '';



        }
    </script>
    <div class="row justify-content-center">
        <div class="col-lg-9 ">



            <table class="w-100">
                <tr>
                    <td class="auto-style1">
                        <h1 class="auto-style2">Add Staff</h1>
                    </td>
                    <td class="text-end">
                        <asp:Button ID="BtnStaffAdd" CssClass="btn btn-success btn-lg" runat="server" Enabled="False" Text="Add" Width="90px" UseSubmitBehavior="False" />
                        <asp:Button ID="btnStaffList" CssClass="btn btn-success btn-lg" runat="server" Text="List" Width="90px" PostBackUrl="~/Admin/ViewStaffList.aspx" CausesValidation="False" UseSubmitBehavior="False" />
                        <asp:Button ID="BtnStaffLeave" CssClass="btn btn-success btn-lg" runat="server" Text="Leave" Width="90px" PostBackUrl="~/Admin/StaffLeave.aspx" CausesValidation="False" UseSubmitBehavior="False" />
                    </td>
                </tr>
            </table>
            <div class="row">

                <div class="card-body">
                    <h6 class="auto-style2">Staff ID: </h6>
                    <p>
                        &nbsp;<asp:TextBox ID="txtStaffID" runat="server" Style="width: 100%;" ReadOnly="true"></asp:TextBox>
                    </p>
                    <h6 class="auto-style2">Name: </h6>
                    <p>
                        &nbsp;<asp:TextBox ID="txtName" runat="server" Style="width: 100%;"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Fill In Staff Name!" EnableClientScript="True" ControlToValidate="txtName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </p>
                    <h6><span class="auto-style2">Email:</span> </h6>
                    <p>
                        &nbsp;<asp:TextBox ID="txtEmail" runat="server" Style="width: 100%;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Fill In Email!" EnableClientScript="True" ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </p>
                    <h6 class="auto-style2">Phone Number: </h6>
                    <p>
                        &nbsp;<asp:TextBox ID="txtPhoneNum" runat="server" Style="width: 100%;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Fill In Phone Number!" EnableClientScript="True" ControlToValidate="txtPhoneNum" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegexValidatorPhone" runat="server" ErrorMessage="Invalid phone number format(Eg.010-2049999)"
                            ControlToValidate="txtPhoneNum" ValidationExpression="^\d{3}-\d{7,8}$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </p>

                    <div class="row pb-3">
                        <div class="col d-grid">
                            <asp:Button runat="server" ID="btnAdd" CssClass="btn btn-success btn-lg" Text="Add" OnClick="btnAdd_Click" OnClientClick="return showConfirmation();" />

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="Product" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice] FROM [Product] WHERE [CategoryID] = 1"></asp:SqlDataSource>
</asp:Content>
