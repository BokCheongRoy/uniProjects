<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="LeaveRecord.aspx.cs" Inherits="AssignmentWAD.Employee.LeaveRecord" %>
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
        .button5{
             display: flex;
 justify-content: flex-end; 
 margin-bottom: 10px;
        }
      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <h1>Leave Record</h1>
            <div class="auto-style5">

                <asp:Button ID="Button5" CssClass="btn btn-success btn-lg" runat="server" Text="Apply" Width="90px" Style="padding-left: 5px; padding-right: 5px;" PostBackUrl="~/Employee/ApplyLeave.aspx"/> </div>
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="LeaveId" DataSourceID="SqlDataSource1" CssClass="gridview-style">
                    <Columns>
                        <asp:BoundField DataField="LeaveId" HeaderText="LeaveId" ReadOnly="True" SortExpression="LeaveId" />
                        <asp:BoundField DataField="EmployeeID" HeaderText="EmployeeID" SortExpression="EmployeeID" />
                        <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" DataFormatString="{0:dd/MM/yyyy}"/>
                        <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate" DataFormatString="{0:dd/MM/yyyy}"/>
                        <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
                        <asp:TemplateField HeaderText="SupportingDocument" SortExpression="Image">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Image") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl='<%# Eval("LeaveImage") %>' Width="150px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Leave]"></asp:SqlDataSource>
           
            </div>
        </div>
</asp:Content>