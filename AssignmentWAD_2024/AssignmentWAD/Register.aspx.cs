using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            try
            {
                //get username
                MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);

                if (newUser != null)
                {
                    Guid userId = (Guid)newUser.ProviderUserKey;
                    Roles.AddUserToRole(newUser.UserName, "customer");
                    string customerId = GetCurrentCustomerID();
                    string customerEmail = CreateUserWizard1.Email;
                    InsertIntoCustomerTable(customerId,customerEmail, userId);
                   
                    Session["CustomerID"] = customerId;
                }

            }
            catch (Exception ex)
            {

                System.Diagnostics.Trace.TraceError($"Exception during role assignment: {ex.Message}");
            }


        }


        private void InsertIntoCustomerTable(string customerId, string customerEmail,Guid userId)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string insertQuery = "INSERT INTO Customer (CustomerID,CustomerEmail,UserId) VALUES (@CustomerID,@Email, @UserId)";

                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerId);
                    command.Parameters.AddWithValue("@Email", customerEmail);
                    command.Parameters.AddWithValue("@UserId", userId);

                    command.ExecuteNonQuery();
                }
            }
        }


        private string GetCurrentCustomerID()
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                string query = "SELECT TOP 1 CustomerID FROM [Customer] ORDER BY CustomerID DESC";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        int currentNumber = int.Parse(result.ToString().Substring(1));

                        currentNumber++;

                        string newOrderID = $"C{currentNumber:D4}";

                        return newOrderID;
                    }
                    else
                    {
                        return "C0001";
                    }
                }
            }
        }

    }
}