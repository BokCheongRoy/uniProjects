using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace AssignmentWAD
{
    public partial class addStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtStaffID.Text = GenerateNextID();
        }
        public string GenerateNextID()
        {
            // Connect to your database
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            // Retrieve the last ID from the database
            string lastID = GetLastIDFromDatabase(conn);

            // Generate the next ID
            string nextID = IncrementID(lastID);


            return nextID;

        }
        private string GetLastIDFromDatabase(SqlConnection connection)
        {
            string query = "SELECT TOP 1 EmployeeID FROM Employee ORDER BY EmployeeID DESC";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                object result = command.ExecuteScalar();
                return result != null ? result.ToString() : null;
            }
        }

        private string IncrementID(string lastID)
        {
            if (string.IsNullOrEmpty(lastID))
            {
                return "ST0001"; // Initial ID if the table is empty
            }

            // Extract the numeric part of the ID and increment it
            int numericPart = int.Parse(lastID.Substring(2)) + 1;

            // Format the new ID
            string nextID = string.Format("ST{0:D4}", numericPart);

            // Check if the next ID already exists, if so, find the next available ID
            while (IDExistsInDatabase(nextID))
            {
                numericPart++;
                nextID = string.Format("ST{0:D4}", numericPart);
            }

            return nextID;
        }

        private bool IDExistsInDatabase(string idToCheck)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            string query = "SELECT COUNT(*) FROM EMPLOYEE WHERE EmployeeID = @ID";
            using (SqlCommand command = new SqlCommand(query, conn))
            {
                command.Parameters.AddWithValue("@ID", idToCheck);

                int count = (int)command.ExecuteScalar();

                return count > 0;
            }

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Membership.CreateUser(GenerateNextID(), GenerateNextID() + "@@", txtEmail.Text);
            MembershipUser newUser = Membership.GetUser(GenerateNextID());
            Guid userId = (Guid)newUser.ProviderUserKey;

            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            string strInsert = "INSERT INTO Employee(EmployeeID, EmployeeName, EmployeeEmail, EmployeePhoneNum,UserId) VALUES(UPPER(@EmployeeID),UPPER(@EmployeeName), UPPER(@EmployeeEmail), UPPER(@EmployeePhoneNum), @UserId)";


            SqlCommand cmdInsert;
            cmdInsert = new SqlCommand(strInsert, conn);
            cmdInsert.Parameters.AddWithValue("@EmployeeID", GenerateNextID());
            cmdInsert.Parameters.AddWithValue("@EmployeeName", txtName.Text);
            cmdInsert.Parameters.AddWithValue("@EmployeeEmail", txtEmail.Text);
            cmdInsert.Parameters.AddWithValue("@EmployeePhoneNum", txtPhoneNum.Text);
            cmdInsert.Parameters.AddWithValue("@UserId", userId);
            Roles.AddUserToRole(GenerateNextID(), "employee");
            cmdInsert.ExecuteNonQuery();
            conn.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "showSuccessMessage();", true);
        }



    }
}