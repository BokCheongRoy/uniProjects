<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="Rating.aspx.cs" Inherits="AssignmentWAD.Customer.Rating" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .repeater-container {
            width: 700px;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: auto;
        }

        .rating-container {
            align-items: center;
            text-align: center;
        }
        .custom-radio label {
            display: block;
            margin-bottom: 8px;
        }

        .custom-radio input[type="radio"] {
            display: none;
        }

            .custom-radio input[type="radio"] + label {
                position: relative;
                padding-left: 30px; 
                cursor: pointer;
                display: inline-block;
            }

                .custom-radio input[type="radio"] + label:before {
                    content: '';
                    position: absolute;
                    left: 0;
                    top: 0;
                    width: 20px;
                    height: 20px; 
                    background-image: url('../assets/img/star.png'); 
                    background-size: cover; 
                    background-repeat: no-repeat;
                    transition: background-color 0.3s, border-color 0.3s;
                }

            .custom-radio input[type="radio"]:checked + label:before {
                background-image: url('../assets/img/filled-star.png'); 
            }

        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }

        td {
            padding: 10px;
            text-align: justify;
        }

        #txtReview {
            width: 100%; 
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="repeater-container">
        <div class="col-lg-9 mt-5">
                <h1>Rating</h1>
            </div>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
            <ItemTemplate>
                <table style="height: 150px; width: 100%;">
                    <tr>
                        <td style="width: 10%; height: 100px;">
                            <asp:Image runat="server" ImageUrl='<%# Eval("ProductImage") %>' Width="100" Height="100" />
                        </td>
                        <td style="width: 50%;">
                            <asp:HiddenField ID="hfProductID" runat="server" Value='<%# Eval("ProductID") %>' />
                            <%#Eval("ProductName") %>
                        </td>
                        <td style="width: 10%;">x <%#Eval("Quantity")%>
                        </td>
                        <td style="width: 20%;">RM<%#Eval("Total")%></td>
                    </tr>
                    <tr>
                        <td colspan="4" style="height: 30px; align-content: center;">
                            <div class="rating-container">
                                <asp:RadioButtonList ID="rblRating" runat="server" RepeatDirection="Horizontal" CssClass="custom-radio">
                                    <asp:ListItem Text="1" Value="1" />
                                    <asp:ListItem Text="2" Value="2" />
                                    <asp:ListItem Text="3" Value="3" />
                                    <asp:ListItem Text="4" Value="4" />
                                    <asp:ListItem Text="5" Value="5" />
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rblRating" ErrorMessage="Rate is required" ForeColor="Red">&nbsp;</asp:RequiredFieldValidator>
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:TextBox runat="server" ID="txtReview" TextMode="MultiLine" Style="width: 100%;" Placeholder="Enter your review here"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
        <div class="col-md-4 m-2 float-end">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success" Style="width: 100px;" OnClick="BtnSubmit_Click" />
        </div>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT OrderDetails.ProductID, Product.ProductImage, Product.ProductName, OrderDetails.Quantity, (Product.UnitPrice * OrderDetails.Quantity) AS Total FROM OrderDetails INNER JOIN Product ON Product.ProductID = OrderDetails.ProductID WHERE OrderDetails.OrderID = @OrderID ">
        <SelectParameters>
            <asp:SessionParameter Name="OrderID" SessionField="OrderID" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
