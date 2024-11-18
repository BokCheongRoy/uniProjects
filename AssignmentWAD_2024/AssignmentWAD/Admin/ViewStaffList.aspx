<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="ViewStaffList.aspx.cs" Inherits="AssignmentWAD.Admin.ViewStaffList" %>

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
                text-align: center;
            }

            .gridview-style th {
                background-color: rgb(61, 52, 53);
                font-weight: bold;
                 color:white;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <table class="w-100">
                <tr>
                    <td class="auto-style1">
                        <h1>Staff List</h1>
                    </td>
                    <td class="text-end">
                        <asp:Button ID="BtnStaffAdd" CssClass="btn btn-success btn-lg" runat="server" Text="Add" Width="90px" PostBackUrl="~/Admin/AddStaff.aspx" />
                        <asp:Button ID="BtnStaffList" CssClass="btn btn-success btn-lg" runat="server" Enable="False" Text="List" Width="90px" PostBackUrl=" "  />
                         <asp:Button ID="BtnStaffLeave" CssClass="btn btn-success btn-lg" runat="server" Text="Leave" Width="90px" PostBackUrl="~/Admin/StaffLeave.aspx" />
                    </td>
                </tr>
            </table>

            <p>
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                &nbsp;
                <asp:Button ID="Button1" runat="server" Text="Search" CssClass="btn-success" PostBackUrl="~/Admin/ViewStaffList.aspx" OnClick="Button1_Click" />
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>

            </p>
            <p>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="EmployeeID" AllowPaging="True" DataSourceID="SqlDataSource1" CssClass="gridview-style" AllowSorting="True" OnRowDeleting="GridView1_RowDeleting">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" ReadOnly="True" SortExpression="EmployeeID" />
                        <asp:TemplateField HeaderText="Name" SortExpression="EmployeeName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Please Fill In Name!" ForeColor="Red"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email" SortExpression="EmployeeEmail">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("EmployeeEmail") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Please Fill In Email!" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Invalid Email format!" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmployeeEmail") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone Number" SortExpression="EmployeePhoneNum">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("EmployeePhoneNum") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Please Fill In Phone Number!" ForeColor="Red"></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="RegexValidatorPhone" runat="server" ErrorMessage="<br/>Invalid phone number format<br/>(Eg.010-1234567 OR 011-12345678)"
    ControlToValidate="TextBox3" ValidationExpression="^01(?:1-\d{8}|0-\d{7}|[2-9]-\d{7})$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("EmployeePhoneNum") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Employee] WHERE [EmployeeID] = @EmployeeID" InsertCommand="INSERT INTO [Employee] ([EmployeeID], [EmployeeName], [EmployeeEmail], [EmployeePhoneNum]) VALUES (@EmployeeID, @EmployeeName, @EmployeeEmail, @EmployeePhoneNum)" SelectCommand="SELECT * FROM [Employee] ORDER BY [EmployeeID]" UpdateCommand="UPDATE [Employee] SET [EmployeeName] = @EmployeeName, [EmployeeEmail] = @EmployeeEmail, [EmployeePhoneNum] = @EmployeePhoneNum WHERE [EmployeeID] = @EmployeeID">
                    <DeleteParameters>
                        <asp:Parameter Name="EmployeeID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="EmployeeID" Type="String" />
                        <asp:Parameter Name="EmployeeName" Type="String" />
                        <asp:Parameter Name="EmployeeEmail" Type="String" />
                        <asp:Parameter Name="EmployeePhoneNum" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="EmployeeName" Type="String" />
                        <asp:Parameter Name="EmployeeEmail" Type="String" />
                        <asp:Parameter Name="EmployeePhoneNum" Type="String" />
                        <asp:Parameter Name="EmployeeID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </p>
            <p>&nbsp;</p>
            <div class="row">
            </div>
        </div>
    </div>
</asp:Content>
