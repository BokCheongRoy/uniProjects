using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD.Customer
{
    public partial class CheckoutDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void BtnPay_Click(object sender, EventArgs e)
        {
            try
            {
                string currentOrderID = GetCurrentOrderID();
                string currentDate = DateTime.Now.ToString("yyyy-MM-dd");
                string customerID = Session["CustomerID"] as string;
                string recipientName = Rname.Text;
                string address = delAddress1.Text + ", " + postcode.Text + " " + state.Text;
                string status = "Pending";
                string contactNumber = Pno.Text;

                InsertNewOrder(currentOrderID, currentDate, customerID, recipientName, address, status, contactNumber);

                string currentTransactionID = GetCurrentTransactionID();
                string total = Session["Total"] as string;
                decimal totalPayment = decimal.Parse(total);
                string paymentMethod = paymentMethodList.SelectedValue;

                InsertNewTransaction(currentTransactionID, currentOrderID, totalPayment, paymentMethod);

                InsertOrderDetails(currentOrderID, customerID);

                ClearCart(customerID);

                Response.Redirect("~/Customer/Thankyou.aspx");
            }
            catch (SqlException sqlEx)
            {
                
                Response.Write($"SQL Exception: {sqlEx.Message}");
            }
            catch (Exception ex)
            {
                
                Response.Write($"An error occurred: {ex.Message} , {ex.InnerException}");
            }
        }


        private void InsertNewOrder(string orderID, string orderDate, string customerID, string recipientName, string address, string status, string contactNumber)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string insertQuery = "INSERT INTO [Order] (OrderID, OrderDate, CustomerID, RecipientName, Address, Status, ContactNumber) VALUES (@OrderID, @OrderDate, @CustomerID, @RecipientName, @Address, @Status, @ContactNumber)";

                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@OrderID", orderID);
                    command.Parameters.AddWithValue("@OrderDate", orderDate);
                    command.Parameters.AddWithValue("@CustomerID", customerID);
                    command.Parameters.AddWithValue("@RecipientName", recipientName);
                    command.Parameters.AddWithValue("@Address", address);
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@ContactNumber", contactNumber);

                    command.ExecuteNonQuery();
                }
            }

        }

        private void InsertNewTransaction(string transactionID, string orderID, decimal totalPayment, string paymentMethod)
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                string query = "INSERT INTO [Transaction] (TransactionID, OrderID, TotalPayment, PaymentMethod) VALUES (@TransactionID, @OrderID, @TotalPayment, @PaymentMethod)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TransactionID", transactionID);
                    command.Parameters.AddWithValue("@OrderID", orderID);
                    command.Parameters.AddWithValue("@TotalPayment", totalPayment);
                    command.Parameters.AddWithValue("@PaymentMethod", paymentMethod);

                    command.ExecuteNonQuery();
                }
            }
        }
        private string GetCurrentOrderID()
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                string query = "SELECT TOP 1 OrderID FROM [Order] ORDER BY OrderID DESC";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        int currentNumber = int.Parse(result.ToString().Substring(1));

                        currentNumber++;

                        string newOrderID = $"O{currentNumber:D4}";

                        return newOrderID;
                    }
                    else
                    {
                        // No existing orders, start from O0001
                        return "O0001";
                    }
                }
            }
        }

        // Function to get the current transaction ID
        private string GetCurrentTransactionID()
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                string query = "SELECT TOP 1 TransactionID FROM [Transaction] ORDER BY TransactionID DESC";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        int currentNumber = int.Parse(result.ToString().Substring(1));

                        currentNumber++;

                        string newTransactionID = $"T{currentNumber:D4}";

                        return newTransactionID;
                    }
                    else
                    {
                        return "T0001";
                    }
                }
            }
        }

        private void InsertOrderDetails(string orderID, string customerID)
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                string query = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity) SELECT @OrderID, ProductID, Quantity FROM Cart WHERE CustomerID = @CustomerID";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@OrderID", orderID);
                    command.Parameters.AddWithValue("@CustomerID", customerID);

                    command.ExecuteNonQuery();
                }
            }
        }

        private void ClearCart(string customerID)
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                string query = "DELETE FROM Cart WHERE CustomerID = @CustomerID";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);

                    command.ExecuteNonQuery();
                }
            }
        }


        protected void btnReset_Click(object sender, EventArgs e)
        {
            Rname.Text = "";
            Pno.Text = "";
            delAddress1.Text = "";
            postcode.Text = "";
            paymentMethodList.ClearSelection();
            ddlExpMonth.ClearSelection();
            ddlExpYear.ClearSelection();
            cardName.Text = "";
            cardNo.Text = "";
            cvv.Text = "";
        }

        protected void PaymentMethodList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (paymentMethodList.SelectedValue == "Cash")
            {
                cardDetails.Visible = false;
                cardNameDetails.Visible = false;
                cardExpDetails.Visible = false;
                cvvDetails.Visible = false;
            }
            else
            {
                cardDetails.Visible = true;
                cardNameDetails.Visible = true;
                cardExpDetails.Visible = true;
                cvvDetails.Visible = true;
            }
        }
    }
}