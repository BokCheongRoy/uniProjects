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

namespace AssignmentWAD
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtProductID.Text = GenerateNextID();
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
            string query = "SELECT TOP 1 ProductID FROM Product ORDER BY ProductID DESC";

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
                return "P0001"; // Initial ID if the table is empty
            }

            // Extract the numeric part of the ID and increment it
            int numericPart = int.Parse(lastID.Substring(1)) + 1;

            // Format the new ID
            string nextID = string.Format("P{0:D4}", numericPart);

            // Check if the next ID already exists, if so, find the next available ID
            while (IDExistsInDatabase(nextID))
            {
                numericPart++;
                nextID = string.Format("P{0:D4}", numericPart);
            }

            return nextID;
        }

        private bool IDExistsInDatabase(string idToCheck)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            string query = "SELECT COUNT(*) FROM Product WHERE ProductID = @ID";
            using (SqlCommand command = new SqlCommand(query, conn))
            {
                command.Parameters.AddWithValue("@ID", idToCheck);

                int count = (int)command.ExecuteScalar();

                return count > 0;
            }


        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Check if a file is selected
            if (fileUploadProductImage.HasFile)
            {
                // Get the file name and extension
                string fileName = Path.GetFileName(fileUploadProductImage.FileName);
                fileUploadProductImage.SaveAs(Server.MapPath("../ProductImage/" + fileName));

                AddProductIntoDatabase(fileName);

            }
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "showSuccessMessage();", true);
        }

        private void AddProductIntoDatabase(String ProductImagePath)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            string strInsert = "Insert Into Product(ProductID,ProductName,CategoryID,UnitPrice,Size,Ingredient,ProductImage) VALUES(@ProductID,@ProductName,@CategoryID,@UnitPrice,@Size,@Ingredient,@ProductImage) ";

            SqlCommand cmdInsert;
            cmdInsert = new SqlCommand(strInsert, conn);
            cmdInsert.Parameters.AddWithValue("@ProductID", txtProductID.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@ProductName", txtProductName.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@CategoryID", ddlCategoryName.SelectedValue);
            cmdInsert.Parameters.AddWithValue("@UnitPrice", txtUnitPrice.Text.ToString());
            cmdInsert.Parameters.AddWithValue("@Size", txtSize.Text.ToString());
            List<string> selectedValues = cblIng.Items.Cast<ListItem>()
                                     .Where(li => li.Selected)
                                     .Select(li => li.Value)
                                     .ToList();

            // Concatenate the selected values with commas
            string concatenatedValues = string.Join(",", selectedValues);

            // Add the concatenated values to the parameter
            cmdInsert.Parameters.AddWithValue("@Ingredient", concatenatedValues);
            cmdInsert.Parameters.AddWithValue("@ProductImage", "../ProductImage/" + ProductImagePath);

            cmdInsert.ExecuteNonQuery();
            conn.Close();
        }



    }
}