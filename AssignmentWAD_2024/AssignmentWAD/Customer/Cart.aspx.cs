using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckCartEmpty();
            }
        }
        private void CheckCartEmpty()
        {
            if (GridView1.Rows.Count == 0)
            {
                tblCartDetails.Visible = false;
                lblEmptyCartMessage.Visible = true;
            }
            else
            {
                tblCartDetails.Visible = true;
                lblEmptyCartMessage.Visible = false;
                CalculateSubtotalAndTotal();
            }
        }

        protected void DecreaseQuantity_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            int rowIndex = row.RowIndex;

            Label lblQuantity = (Label)row.FindControl("lblQuantity");
            int currentQuantity = int.Parse(lblQuantity.Text);

            if (currentQuantity > 1)
            {
                currentQuantity--;

                lblQuantity.Text = currentQuantity.ToString();

                UpdateQuantityInDatabase(rowIndex, currentQuantity);
                UpdateTotalInGridView(row, currentQuantity);
                CalculateSubtotalAndTotal();
            }
        }

        protected void IncreaseQuantity_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            int rowIndex = row.RowIndex;

            Label lblQuantity = (Label)row.FindControl("lblQuantity");
            int currentQuantity = int.Parse(lblQuantity.Text);

            currentQuantity++;

            lblQuantity.Text = currentQuantity.ToString();

            UpdateQuantityInDatabase(rowIndex, currentQuantity);
            UpdateTotalInGridView(row, currentQuantity);
            CalculateSubtotalAndTotal();
        }

        private void UpdateTotalInGridView(GridViewRow row, int newQuantity)
        {
            decimal unitPrice = Convert.ToDecimal(row.Cells[2].Text); 
            decimal total = newQuantity * unitPrice;
            row.Cells[4].Text = total.ToString(); 
        }

        private void CalculateSubtotalAndTotal()
        {
            decimal subtotal = 0;

            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    decimal total = Convert.ToDecimal(row.Cells[4].Text); 
                    subtotal += total;
                }
            }

            decimal deliveryFee = 5.00m;
            decimal grandTotal = subtotal + deliveryFee;

            lblSubtotal.Text = subtotal.ToString();
            lblTotal.Text = grandTotal.ToString();
        }
        private void UpdateQuantityInDatabase(int rowIndex, int newQuantity)
        {
            try
            {
                string customerID = Session["CustomerID"] as string;
                string productID = GridView1.DataKeys[rowIndex].Values["ProductID"].ToString();

                string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                   
                            string updateQuery = "UPDATE Cart SET Quantity = @Quantity WHERE CustomerID = @CustomerID AND ProductID = @ProductID";
                            using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                            {
                                updateCommand.Parameters.AddWithValue("@Quantity", newQuantity);
                                updateCommand.Parameters.AddWithValue("@CustomerID", customerID);
                                updateCommand.Parameters.AddWithValue("@ProductID", productID);

                                updateCommand.ExecuteNonQuery();

                            }
                   
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            Button btnDelete = (Button)sender;
            GridViewRow row = (GridViewRow)btnDelete.NamingContainer;

            DeleteCartItem(row);

            GridView1.DataBind();

            CheckCartEmpty();
        }

        private void DeleteCartItem(GridViewRow row)
        {
            try
            {
                string customerID = Session["CustomerID"] as string;
                string productID = GridView1.DataKeys[row.RowIndex].Values["ProductID"].ToString();

                string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string deleteQuery = "DELETE FROM Cart WHERE CustomerID = @CustomerID AND ProductID = @ProductID";

                    using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
                    {
                        deleteCommand.Parameters.AddWithValue("@CustomerID", customerID);
                        deleteCommand.Parameters.AddWithValue("@ProductID", productID);

                        deleteCommand.ExecuteNonQuery();
                    }
                }
                Bakery masterPage = this.Master as Bakery;
                masterPage?.UpdateCartCount();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        protected void BtnCheckOut_Click(object sender, EventArgs e)
        {
            Session["Total"] = lblTotal.Text;
            Response.Redirect("~/Customer/CheckOutDetails.aspx");
        }
    }
}