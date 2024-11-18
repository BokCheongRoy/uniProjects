using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD
{
    public partial class ViewUserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();

            // Perform the search using your data source (SqlDataSource1)
            SqlDataSource1.SelectCommand = "SELECT * FROM [Customer] WHERE [CustomerID] LIKE @SearchTerm OR [CustomerName] LIKE @SearchTerm OR [CustomerEmail] LIKE @SearchTerm OR [CustomerPhoneNum] LIKE @SearchTerm";

            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("SearchTerm", DbType.String, "%" + searchTerm + "%");

            try
            {
                GridViewUser.DataBind();

                // Check if any rows are returned
                if (GridViewUser.Rows.Count == 0)
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblDataList.Text = Convert.ToString(GridView1.SelectedValue);
        }
    }
}