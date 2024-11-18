<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ApplyLeave.aspx.cs" Inherits="AssignmentWAD.Employee.ApplyLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .gridview-style {
            width: 100%;
            border: 2px solid black;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .gridview-style th,
        .gridview-style td {
            border: 2px solid black;
            padding: 10px;
            text-align: left;
        }

        .gridview-style th {
            background-color: rgb(61, 52, 53);
            color: white;
        }

        .gridview-style th a {
            color: white;
            text-decoration: none;
        }

        .gridview-style td a {
            color: black;
        }

        .gridview-style tr {
            border: 2px solid black;
        }

        .button-container {
            text-align: right;
            padding-bottom: 10%;
        }

        .button1 {
            background-color: #C09958;
        }

        .auto-style5 {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .button5 {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
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
                        __doPostBack('<%= Button1.UniqueID %>', '');
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
            document.getElementById('<%=txtLeaveID.ClientID%>').value = '<%= GenerateNextID() %>';
            document.getElementById('<%=txtDateFrom.ClientID%>').value = '';
            document.getElementById('<%=txtDateTo.ClientID%>').value = '';
            document.getElementById('<%=txtReason.ClientID%>').value = '';
        }
    </script>
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <h1>Apply Leave</h1>
            <div class="auto-style5">
                <asp:Button ID="Button5" CssClass="btn btn-success btn-lg" runat="server" Text="Record" Width="90px" Style="padding-left: 5px; padding-right: 5px;" PostBackUrl="~/Employee/LeaveRecord.aspx" CausesValidation="False" />
            </div>
            <table class="gridview-style" align="center">
                <tr>
                    <td class="auto-style1">Leave ID:</td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtLeaveID" runat="server" CssClass="full-width" Style="width: 100%;" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Staff ID:</td>
                    <td>
                        <asp:TextBox ID="txtStaffID" runat="server" CssClass="full-width" Style="width: 100%;" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Apply Date:</td>
                    <td>From:
                        <asp:TextBox ID="txtDateFrom" runat="server" TextMode="Date" CssClass="full-width" Style="width: 100%;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateFrom" Display="Dynamic" ErrorMessage="Please Select a Date!" ForeColor="Red"></asp:RequiredFieldValidator>
                        &nbsp;&nbsp;
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtDateTo" ControlToValidate="txtDateFrom" ErrorMessage="From Date cannot later than To date!" ForeColor="Red" Operator="LessThan" Type="Date"></asp:CompareValidator>
                        <br />
                        To:
                        <asp:TextBox ID="txtDateTo" runat="server" TextMode="Date" CssClass="full-width" Style="width: 100%;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDateTo" Display="Dynamic" ErrorMessage="Please Select a Date!" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtDateFrom" ControlToValidate="txtDateTo" Display="Dynamic" ErrorMessage="To Date cannot be before than From Date!" ForeColor="Red" Operator="GreaterThan" Type="Date"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Reason:</td>
                    <td>
                        <asp:TextBox ID="txtReason" runat="server" CssClass="full-width" Style="width: 100%;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtReason" Display="Dynamic" ErrorMessage="Please Fill In Reason!" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Supporting Document:</td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="full-width" />
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FileUpload1" Display="Dynamic" ErrorMessage="Please Upload a Document!" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <div class="button-container">
                <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn-success" OnClick="Button1_Click" OnClientClick="return showConfirmation();" />
            </div>
        </div>
    </div>
</asp:Content>