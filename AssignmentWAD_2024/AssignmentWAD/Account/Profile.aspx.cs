using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace AssignmentWAD.Account
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                string customerID = Session["CustomerID"] as string;
                string empID = Session["EmployeeID"] as string;

                if (customerID != null)
                {
                    LoadCustomerDetails(customerID);

                }
                else if (empID != null)
                {
                    LoadEmployeeDetails(empID);
                }



            }
        }

        private void LoadCustomerDetails(string username)
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("SELECT CustomerID, CustomerName,CustomerEmail,CustomerPhoneNum FROM Customer WHERE CustomerID = @CustomerId", connection))
                {
                    command.Parameters.AddWithValue("@CustomerId", username);

                    try
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {


                                // Populate the table cells with customer details
                                txtName.Text = reader["CustomerName"].ToString();
                                txtEmail.Text = reader["CustomerEmail"].ToString();
                                txtContactNumber.Text = reader["CustomerPhoneNum"].ToString();


                            }
                            else
                            {
                                // Handle the case when no customer details are found
                                txtName.Text = "N/A";
                                txtContactNumber.Text = "N/A";
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("An error occurred: " + ex.Message);

                    }
                }
            }
        }


        private void LoadEmployeeDetails(string eID)
        {
            using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("SELECT EmployeeID, EmployeeName,EmployeeEmail,EmployeePhoneNum FROM Employee WHERE EmployeeID = @empId", connection))
                {
                    command.Parameters.AddWithValue("@empId", eID);

                    try
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {


                                // Populate the table cells with customer details
                                txtName.Text = reader["EmployeeName"].ToString();
                                txtEmail.Text = reader["EmployeeEmail"].ToString();
                                txtContactNumber.Text = reader["EmployeePhoneNum"].ToString();


                            }
                            else
                            {
                                // Handle the case when no customer details are found
                                txtName.Text = "N/A";
                                txtContactNumber.Text = "N/A";
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("An error occurred: " + ex.Message);

                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string customerID = Session["CustomerID"] as string;
                string empID = Session["EmployeeID"] as string;

                using (SqlConnection connection = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True"))
                {
                    connection.Open();

                    if (customerID != null)
                    {

                        using (SqlCommand command = new SqlCommand("UPDATE Customer SET CustomerName = @Name , CustomerPhoneNum = @PhoneNum WHERE CustomerID = @CustomerId", connection))
                        {
                            command.Parameters.AddWithValue("@Name", txtName.Text);
                            command.Parameters.AddWithValue("@PhoneNum", txtContactNumber.Text);
                            command.Parameters.AddWithValue("@CustomerId", customerID);

                            int rowsAffected = command.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Update successful
                                LoadCustomerDetails(customerID);
                                lblMsg.Text = "Your Name and Contact Number have been saved successfully.";

                            }
                            else
                            {
                                lblMsg.Text = "Failed to save. No changes were made.";
                            }
                        }
                    }
                    else if (empID != null)
                    {
                        using (SqlCommand command = new SqlCommand("UPDATE Employee SET EmployeeName = @Name , EmployeePhoneNum = @PhoneNum WHERE EmployeeID = @empId", connection))
                        {
                            command.Parameters.AddWithValue("@Name", txtName.Text);
                            command.Parameters.AddWithValue("@PhoneNum", txtContactNumber.Text);
                            command.Parameters.AddWithValue("@empId", empID);

                            int rowsAffected = command.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Update successful
                                LoadEmployeeDetails(empID);
                                lblMsg.Text = "Your Name and Contact Number have been saved successfully.";

                            }
                            else
                            {
                                lblMsg.Text = "Failed to save. No changes were made.";
                            }
                        }

                    }


                }

            }
            catch (Exception ex)
            {
                Console.Write("An error occured: " + ex.Message);
                lblMsg.Text = "An error occurred while saving your information. Please try again.";
            }

        }



    }


}