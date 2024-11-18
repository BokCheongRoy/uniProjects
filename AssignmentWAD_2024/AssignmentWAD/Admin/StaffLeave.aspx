<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="StaffLeave.aspx.cs" Inherits="AssignmentWAD.Employee.StaffLeave" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row justify-content-center">
        <div class="col-lg-9 ">
            <table class="w-100">
                <tr>
                    <td class="auto-style1">
                        <h1 class="auto-style2">Manage Staff Leave</h1>
                    </td>
                    <td class="text-end">
                        <asp:Button ID="BtnStaffAdd" CssClass="btn btn-success btn-lg" runat="server" Text="Add" Width="90px" PostBackUrl="~/Admin/AddStaff.aspx" UseSubmitBehavior="False" />
                        <asp:Button ID="btnStaffList" CssClass="btn btn-success btn-lg" runat="server" Text="List" Width="90px" PostBackUrl="~/Admin/ViewStaffList.aspx" UseSubmitBehavior="False" />
                        <asp:Button ID="BtnStaffLeave" CssClass="btn btn-success btn-lg" runat="server" Enabled="False" Text="Leave" Width="90px" PostBackUrl="~/Admin/StaffLeave.aspx" />
                    </td>
                </tr>
                <tr>

                    <td class="text-end">
                    

                        <asp:Button ID="Button2" CssClass="btn btn-success btn-lg" runat="server" Text="All" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button1_Click" />

                        <asp:Button ID="Button3" CssClass="btn btn-success btn-lg" runat="server" Text="Pending" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button2_Click" />

                        <asp:Button ID="Button4" CssClass="btn btn-success btn-lg" runat="server" Text="Approved" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button3_Click" />

                        <asp:Button ID="Button5" CssClass="btn btn-success btn-lg" runat="server" Text="Reject" Width="90px" Style="padding-left: 5px; padding-right: 5px;" OnClick="Button4_Click" />
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="LeaveId" CssClass="gridview-style" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:TemplateField HeaderText="LeaveId" SortExpression="LeaveId">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("LeaveId") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("LeaveId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EmployeeID" SortExpression="EmployeeID">
                        <EditItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="StartDate" SortExpression="StartDate">
                        <EditItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("StartDate","{0:dd/MM/yyyy}") %>'></asp:Label >
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("StartDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EndDate" SortExpression="EndDate">
                        <EditItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("EndDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("EndDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reason" SortExpression="Reason">
                        <EditItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SupportingDocument" SortExpression="LeaveImage">
                        <EditItemTemplate>
                            <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("LeaveImage") %>' Width="150px" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("LeaveImage") %>' Width="150px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="Status">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("Status") %>'>
                                <asp:ListItem Value="Pending                                           ">Pending</asp:ListItem>
                                <asp:ListItem Value="Approved                                          ">Approved</asp:ListItem>
                                <asp:ListItem Value="Rejected                                          ">Rejected</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Leave] WHERE [LeaveId] = @LeaveId" InsertCommand="INSERT INTO [Leave] ([LeaveId], [EmployeeID], [StartDate], [EndDate], [Reason], [Image], [Status]) VALUES (@LeaveId, @EmployeeID, @StartDate, @EndDate, @Reason, @Image, @Status)" SelectCommand="SELECT * FROM [Leave]" UpdateCommand="UPDATE [Leave] SET [Status] = @Status WHERE [LeaveId] = @LeaveId">
                <DeleteParameters>
                    <asp:Parameter Name="LeaveId" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="LeaveId" Type="String" />
                    <asp:Parameter Name="EmployeeID" Type="String" />
                    <asp:Parameter DbType="Date" Name="StartDate" />
                    <asp:Parameter DbType="Date" Name="EndDate" />
                    <asp:Parameter Name="Reason" Type="String" />
                    <asp:Parameter Name="Image" Type="Object" />
                    <asp:Parameter Name="Status" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="EmployeeID" Type="String" />
                    <asp:Parameter DbType="Date" Name="StartDate" />
                    <asp:Parameter DbType="Date" Name="EndDate" />
                    <asp:Parameter Name="Reason" Type="String" />
                    <asp:Parameter Name="Image" Type="Object" />
                    <asp:Parameter Name="Status" Type="String" />
                    <asp:Parameter Name="LeaveId" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>