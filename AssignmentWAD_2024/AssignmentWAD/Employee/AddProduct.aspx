<%@ Page Title="" Language="C#" MasterPageFile="~/Bakery.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="AssignmentWAD.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 792px;
        }

        .auto-style2 {
            color: #615253;
        }

        .auto-style3 {
            width: 100%;
            margin-bottom: 0;
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
        document.getElementById('<%=txtProductID.ClientID%>').value = '<%= GenerateNextID() %>';
        document.getElementById('<%=txtProductName.ClientID%>').value = '';
        document.getElementById('<%=txtUnitPrice.ClientID%>').value = '';
        document.getElementById('<%=txtSize.ClientID%>').value = '';

        // You may need to add similar lines for other text fields and controls
    }
</script>

    <div class="row justify-content-center">

        <div class="col-lg-9 ">



            <table style="width: 100%;">
                <tr>
                    <td class="auto-style1">
                        <h1 class="auto-style2">Add Product</h1>
                    </td>
                    <td class="text-end">
                        <asp:Button ID="BtnProdAdd" CssClass="btn btn-success btn-lg" runat="server" Enabled="False" Text="Add" Width="90px" UseSubmitBehavior="False" />
                        <asp:Button ID="btnPordList" CssClass="btn btn-success btn-lg" runat="server" Text="List" Width="90px" PostBackUrl="~/Employee/ViewProductList.aspx" CausesValidation="False" UseSubmitBehavior="False" />


                    </td>
                </tr>
            </table>

            <div class="row">
                <div class="card-body">

                    <h6 class="auto-style2">Product ID : </h6>
                    <p>

                        <asp:TextBox ID="txtProductID" runat="server" Style="width: 100%;" ReadOnly="true"></asp:TextBox>
                    </p>
                    <h6 class="auto-style2">Product Name: </h6>
                    <p>

                        <asp:TextBox ID="txtProductName" runat="server" CssClass="auto-style3" ForeColor="Black"></asp:TextBox><asp:RequiredFieldValidator ID="PnameReq" runat="server" ErrorMessage="Please fill in Product Name!" EnableClientScript="True" ControlToValidate="txtProductName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </p>

                    <h6 class="auto-style2">Category Name: </h6>
                    <p>
                        <asp:DropDownList ID="ddlCategoryName" runat="server" DataSourceID="SqlDataSource1" DataTextField="CategoryName" DataValueField="CategoryID">
                        </asp:DropDownList>
                    </p>
                    <p>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
                    </p>

                    <h6 class="auto-style2">Unit Price: </h6>
                    <p>

                        <asp:TextBox ID="txtUnitPrice" runat="server" Style="width: 100%;"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please fill in  Unit Price!" EnableClientScript="True" ControlToValidate="txtUnitPrice" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Please fill in a number between 0 and 1000."
                            ControlToValidate="txtUnitPrice" Type="Integer"
                            MinimumValue="0" MaximumValue="1000" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>
                    </p>
                    <h6 class="auto-style2">Size: </h6>
                    <p>

                        <asp:TextBox ID="txtSize" runat="server" Style="width: 100%;"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please fill in  Size!" EnableClientScript="True" ControlToValidate="txtSize" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </p>

                    <h6 class="auto-style2">Ingredient: </h6>
                    <p>

                        <asp:CheckBoxList ID="cblIng" runat="server">
                            <asp:ListItem Selected="True">Gluten</asp:ListItem>
                            <asp:ListItem Selected="True">Milk</asp:ListItem>
                            <asp:ListItem>Eggs</asp:ListItem>
                            <asp:ListItem>Chicken sausage</asp:ListItem>
                            <asp:ListItem>Nuts</asp:ListItem>
                            <asp:ListItem>Gelatin(Fish)</asp:ListItem>
                        </asp:CheckBoxList>
                    </p>

                    <h6 class="auto-style2">Image: </h6>
                    <asp:FileUpload runat="server" ID="fileUploadProductImage" CssClass="form-control" RequiredFieldValidatorID="requiredImageValidator" />
                    <asp:RequiredFieldValidator runat="server" ID="requiredImageValidator" ControlToValidate="fileUploadProductImage" ErrorMessage="Please choose an image." ForeColor="Red" Display="Dynamic" />
                    <br>

                    <div class="row pb-3">
                        <div class="col d-grid">
                         
                            <asp:Button runat="server" ID="btnAdd" CssClass="btn btn-success btn-lg" Text="Add" OnClientClick="return showConfirmation();" OnClick="btnAdd_Click" />


                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>