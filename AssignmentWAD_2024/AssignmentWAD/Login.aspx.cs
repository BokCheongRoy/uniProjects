using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;

namespace AssignmentWAD
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (Membership.ValidateUser(login1.UserName, login1.Password))
                {

                    if (login1.RememberMeSet == true)
                    {
                        HttpCookie rememberMeCookie = new HttpCookie("RememberMeCookie");

                        // Set the cookie value
                        rememberMeCookie.Values["Username"] = login1.UserName;
                        rememberMeCookie.Values["Password"] = login1.Password;
                        rememberMeCookie.Expires = DateTime.Now.AddDays(30);

                        // Add the cookie to the response
                        Response.Cookies.Add(rememberMeCookie);
                    }

                    Guid userId = (Guid)Membership.GetUser(login1.UserName).ProviderUserKey;

                    if (Roles.IsUserInRole(login1.UserName, "customer"))
                    {
                        string customerId = GetCustomerId(userId);

                        if (!string.IsNullOrEmpty(customerId))
                        {
                            Session["CustomerID"] = customerId;
                            Session["User"] = login1.UserName;
                        }
                    }
                    else if (Roles.IsUserInRole(login1.UserName, "employee") || Roles.IsUserInRole(login1.UserName, "admin"))
                    {
                        string employeeId = GetEmployeeId(userId);

                        if (!string.IsNullOrEmpty(employeeId))
                        {
                            Session["EmployeeID"] = employeeId;
                            Session["User"] = login1.UserName;
                        }
                    }

                  
                }
                else
                {
                    login1.FailureText = "Invalid login attempt. Please check your username and password.";
                }

           
        }
    catch (Exception ex)
    {
                login1.FailureText = $"An error occurred: {ex.Message}";
    }
}


            
        

       
        private string GetCustomerId(Guid userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT CustomerID FROM Customer WHERE UserId = @UserID", connection);
                command.Parameters.AddWithValue("@UserID", userId);
                object result = command.ExecuteScalar();
                return result?.ToString();
            }
        }

        private string GetEmployeeId(Guid userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT EmployeeID FROM Employee WHERE UserId = @UserID", connection);
                command.Parameters.AddWithValue("@UserID", userId);
                object result = command.ExecuteScalar();
                return result?.ToString();
            }
        }
    }
}