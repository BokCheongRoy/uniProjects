using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;

namespace AssignmentWAD
{
    public partial class ViewProductList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }


        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            FileUpload fileUpload = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("FileUploadImage");
            //TextBox ProductName = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtProductName");
            //DropDownList CategoryID = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList1");
            CheckBoxList Ingredient = (CheckBoxList)GridView1.Rows[e.RowIndex].FindControl("CheckBoxList1");
            List<string> selectedValues = Ingredient.Items.Cast<ListItem>()
                                    .Where(li => li.Selected)
                                    .Select(li => li.Value)
                                    .ToList();

            // Concatenate the selected values with commas
            string concatenatedValues = string.Join(",", selectedValues);
            //TextBox UnitPrice = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox1");
            //TextBox Size = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox2");

            if (fileUpload.HasFile)
            {
                // Get the file name and extension
                string fileName = Path.GetFileName(fileUpload.FileName);
                fileUpload.SaveAs(Server.MapPath("../ProductImage/" + fileName));
                string ProductID = GridView1.DataKeys[e.RowIndex].Value.ToString();
                UpdateProductImage(ProductID, fileName);
            }
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();
            SqlCommand cmd = new SqlCommand("UPDATE Product SET Ingredient = @Ingredient WHERE ProductID = @ProductID", conn);
            //SqlCommand cmd = new SqlCommand("UPDATE Product SET ProductName = @ProductName, CategoryID = @CategoryID, Size = @Size, Ingredient = @Ingredient ,UnitPrice = @UnitPrice  WHERE ProductID = @ProductID", conn);

            cmd.Parameters.AddWithValue("@ProductID", GridView1.DataKeys[e.RowIndex].Value.ToString());
            //cmd.Parameters.AddWithValue("@ProductName",ProductName.Text.ToString());
            //cmd.Parameters.AddWithValue("@CategoryID", CategoryID.SelectedValue.ToString());
            //cmd.Parameters.AddWithValue("@Size", Size.Text.ToString());
            cmd.Parameters.AddWithValue("@Ingredient", concatenatedValues);
            //cmd.Parameters.AddWithValue("@UnitPrice", UnitPrice.Text.ToString());


            cmd.ExecuteNonQuery();
            conn.Close();

        }

        private void UpdateProductImage(string ProductID, string ProductImage)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();

            using (SqlCommand cmd = new SqlCommand("UPDATE Product SET ProductImage = @ProductImage WHERE ProductID = @ProductID", conn))
            {
                cmd.Parameters.AddWithValue("@ProductID", ProductID);
                cmd.Parameters.AddWithValue("@ProductImage", "../ProductImage/" + ProductImage); // Use SqlDbType.VarBinary for byte array data

                cmd.ExecuteNonQuery();
            }

            conn.Close();
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();

            // Perform the search using your data source (SqlDataSource1)
            //SqlDataSource1.SelectCommand = "SELECT * FROM [Product] WHERE [ProductID] LIKE '%' + @SearchTerm + '%' OR [ProductName] LIKE '%' + @SearchTerm + '%' OR [CategoryID] LIKE '%' + @SearchTerm + '%' OR [UnitPrice] LIKE '%' + @SearchTerm + '%' OR [Size] LIKE '%' + @SearchTerm + '%' OR [Ingredient] LIKE '%' + @SearchTerm + '%'";
            SqlDataSource1.SelectCommand = "SELECT P.*, C.CategoryName FROM [Product] P LEFT JOIN [Category] C ON P.CategoryID = C.CategoryID WHERE P.[ProductID] LIKE '%' + @SearchTerm + '%'  OR P.[ProductName] LIKE '%' + @SearchTerm + '%'  OR CAST(P.[CategoryID] AS NVARCHAR(MAX)) LIKE '%' + @SearchTerm + '%'  OR CAST(P.[UnitPrice] AS NVARCHAR(MAX)) LIKE '%' + @SearchTerm + '%' OR P.[Size] LIKE '%' + @SearchTerm + '%'  OR P.[Ingredient] LIKE '%' + @SearchTerm + '%' OR C.[CategoryName] LIKE '%' + @SearchTerm + '%'";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("SearchTerm", DbType.String, "%" + searchTerm + "%");

            try
            {
                GridView1.DataBind();

                // Check if any rows are returned
                if (GridView1.Rows.Count == 0)
                {
                    // No results found, display appropriate message
                    lblErrorMessage.Text = "Oops, No results found.";
                    lblErrorMessage.Visible = true;
                }
                else
                {
                    // Results found, hide error message
                    lblErrorMessage.Visible = false;
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions that may occur during the data binding process
                lblErrorMessage.Text = $"Oops, an error occurred: {ex.Message}";
                lblErrorMessage.Visible = true;
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(ProductID) AS amount from OrderDetails WHERE ProductID = @ProductID", conn);

            cmd.Parameters.AddWithValue("@ProductID", GridView1.DataKeys[e.RowIndex].Value.ToString());
            int count = (int)cmd.ExecuteScalar();

            
                if (count > 0)
                {
                    conn.Close();
                Label2.Text = "Product ID contains orders and cannot be deleted!";
                return;
                }
                else
                {
                SqlCommand cmd2 = new SqlCommand("SELECT COUNT(ProductID) AS amount From WishList WHERE ProductID = @ProductID", conn);

                cmd2.Parameters.AddWithValue("@ProductID", GridView1.DataKeys[e.RowIndex].Value.ToString());
                int count1 = (int)cmd2.ExecuteScalar();
                if (count1 > 0)
                {
                    using (SqlCommand cmd3 = new SqlCommand("DELETE FROM [WishList] WHERE [ProductID] = @ProductID", conn))
                    {
                        cmd3.Parameters.AddWithValue("@ProductID", GridView1.DataKeys[e.RowIndex].Value.ToString());
                        cmd3.ExecuteNonQuery();
                        Label2.Text = "Deleted successfully!";
                    }
                }
                SqlCommand cmd4 = new SqlCommand("SELECT COUNT(ProductID) AS amount from Cart WHERE ProductID = @ProductID", conn);

                cmd4.Parameters.AddWithValue("@ProductID", GridView1.DataKeys[e.RowIndex].Value.ToString());
                int count2 = (int)cmd4.ExecuteScalar();
                if (count2 > 0)
                {
                    using (SqlCommand cmd5 = new SqlCommand("DELETE FROM [Cart] WHERE [ProductID] = @ProductID", conn))
                    {
                        cmd5.Parameters.AddWithValue("@ProductID", GridView1.DataKeys[e.RowIndex].Value.ToString());
                        cmd5.ExecuteNonQuery();
                        Label2.Text = "Deleted successfully!";
                    }
                }

                using (SqlCommand cmd6 = new SqlCommand("DELETE FROM [Product] WHERE [ProductID] = @ProductID", conn))
                    {
                        cmd6.Parameters.AddWithValue("@ProductID", GridView1.DataKeys[e.RowIndex].Value.ToString());
                        cmd6.ExecuteNonQuery();
                        conn.Close();
                    Label2.Text = "Deleted successfully!";
                    return;
                    
                }
                }
            }
        }
    }

