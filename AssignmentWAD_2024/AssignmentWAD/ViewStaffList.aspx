<%@ Page Title="" Language="C#" MasterPageFile="~/LoginEmployee.Master" AutoEventWireup="true" CodeBehind="ViewStaffList.aspx.cs" Inherits="AssignmentWAD.ViewStaffList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            color: #605152;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container py-5">
        <div class="row">
            <div class="col-lg-9">
                <h1 class="auto-style1">Staff List</h1>
                <p>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;
                    <asp:Button ID="Button1" runat="server" Text="Button" />
                </p>
                <p>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="EmployeeID" DataSourceID="SqlDataSource1" AllowPaging="True">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="EmployeeID" HeaderText="EmployeeID" ReadOnly="True" SortExpression="EmployeeID" />
                            <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" />
                            <asp:BoundField DataField="EmployeePhoneNum" HeaderText="EmployeePhoneNum" SortExpression="EmployeePhoneNum" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                            <asp:BoundField DataField="EmployeeEmail" HeaderText="EmployeeEmail" SortExpression="EmployeeEmail" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Employee] WHERE [EmployeeID] = @EmployeeID" InsertCommand="INSERT INTO [Employee] ([EmployeeID], [EmployeeName], [EmployeePhoneNum], [Gender], [EmployeeEmail]) VALUES (@EmployeeID, @EmployeeName, @EmployeePhoneNum, @Gender, @EmployeeEmail)" SelectCommand="SELECT [EmployeeID], [EmployeeName], [EmployeePhoneNum], [Gender], [EmployeeEmail] FROM [Employee]" UpdateCommand="UPDATE [Employee] SET [EmployeeName] = @EmployeeName, [EmployeePhoneNum] = @EmployeePhoneNum, [Gender] = @Gender, [EmployeeEmail] = @EmployeeEmail WHERE [EmployeeID] = @EmployeeID">
                        <DeleteParameters>
                            <asp:Parameter Name="EmployeeID" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="EmployeeID" Type="String" />
                            <asp:Parameter Name="EmployeeName" Type="String" />
                            <asp:Parameter Name="EmployeePhoneNum" Type="String" />
                            <asp:Parameter Name="Gender" Type="String" />
                            <asp:Parameter Name="EmployeeEmail" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="EmployeeName" Type="String" />
                            <asp:Parameter Name="EmployeePhoneNum" Type="String" />
                            <asp:Parameter Name="Gender" Type="String" />
                            <asp:Parameter Name="EmployeeEmail" Type="String" />
                            <asp:Parameter Name="EmployeeID" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </p>
                <p>&nbsp;</p>
                <div class="row">o
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone Number</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Table rows will be dynamically added here -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
