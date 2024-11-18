using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace AssignmentWAD.Employee
{
    public partial class ApplyLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtLeaveID.Text = GenerateNextID();
            txtStaffID.Text = (String)Session["EmployeeID"];
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
            string query = "SELECT TOP 1 LeaveId FROM Leave ORDER BY LeaveId DESC";

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
                return "L0001"; // Initial ID if the table is empty
            }

            // Extract the numeric part of the ID and increment it
            int numericPart = int.Parse(lastID.Substring(1)) + 1;

            // Format the new ID
            string nextID = string.Format("L{0:D4}", numericPart);

            // Check if the next ID already exists, if so, find the next available ID
            while (IDExistsInDatabase(nextID))
            {
                numericPart++;
                nextID = string.Format("L{0:D4}", numericPart);
            }

            return nextID;
        }

        private bool IDExistsInDatabase(string idToCheck)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            string query = "SELECT COUNT(*) FROM Leave WHERE LeaveID = @ID";
            using (SqlCommand command = new SqlCommand(query, conn))
            {
                command.Parameters.AddWithValue("@ID", idToCheck);

                int count = (int)command.ExecuteScalar();

                return count > 0;
            }

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileName = Path.GetFileName(FileUpload1.FileName);
            FileUpload1.SaveAs(Server.MapPath("../LeaveImage/" + fileName));

            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            string strInsert = "Insert Into Leave(LeaveID,EmployeeID,StartDate,EndDate,Reason,LeaveImage) VALUES(@LeaveID,@EmployeeID,@StartDate,@EndDate,@Reason,@LeaveImage) ";

            SqlCommand cmdInsert;
            cmdInsert = new SqlCommand(strInsert, conn);
            cmdInsert.Parameters.AddWithValue("@LeaveID", txtLeaveID.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@EmployeeID", txtStaffID.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@StartDate", txtDateFrom.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@EndDate", txtDateTo.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@Reason", txtReason.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@LeaveImage", "../LeaveImage/" + fileName);

            cmdInsert.ExecuteNonQuery();
            conn.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "showSuccessMessage();", true);

        }


    }
}