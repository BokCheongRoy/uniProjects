using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD.Admin
{
    public partial class ViewStaffList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();

            // Perform the search using your data source (SqlDataSource1)
            SqlDataSource1.SelectCommand = "SELECT * FROM [Employee] WHERE [EmployeeID] LIKE @SearchTerm OR [EmployeeName] LIKE @SearchTerm OR [EmployeeEmail] LIKE @SearchTerm OR [EmployeePhoneNum] LIKE @SearchTerm";

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
                    GridView1.Visible = true;
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
            Roles.RemoveUserFromRole(GridView1.DataKeys[e.RowIndex].Value.ToString(), "employee");
        }
    }
}