using System;
using System.Data;

namespace AssignmentWAD
{
    public partial class OrderManage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Call ShowNoDataMessage on page load to handle initial state
            ShowNoDataMessage();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Order]";
            GridView1.DataBind();
            ShowNoDataMessage();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Order] WHERE [Status] = 'Pending'";
            GridView1.DataBind();
            ShowNoDataMessage();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Order] WHERE [Status] = 'Preparing'";
            GridView1.DataBind();
            ShowNoDataMessage();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Order] WHERE [Status] = 'Delivered'";
            GridView1.DataBind();
            ShowNoDataMessage();
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Order] WHERE [Status] = 'Rated'";
            GridView1.DataBind();
            ShowNoDataMessage();
        }
            
        private void ShowNoDataMessage()
        {
            if (GridView1.Rows.Count == 0)
            {
                GridView1.EmptyDataText = "Sorry, there is no data.";
            }
            else
            {
                GridView1.EmptyDataText = string.Empty;
            }
        }
        protected void Button5_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();

            // Perform the search using your data source (SqlDataSource1)
            SqlDataSource1.SelectCommand = "SELECT * FROM [Order] WHERE [OrderID] LIKE @SearchTerm OR [OrderDate] LIKE @SearchTerm OR [CustomerID] LIKE @SearchTerm OR [RecipientName] LIKE @SearchTerm OR [Address] LIKE @SearchTerm OR [Status] LIKE @SearchTerm OR [ContactNumber] LIKE @SearchTerm";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("SearchTerm", DbType.String, searchTerm);

            try
            {
                GridView1.DataBind();

                // Check if any rows are returned
                if (GridView1.Rows.Count == 0)
                {
                    // No results found, display error message
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
                LogException(ex);

                // Display a user-friendly error message
                lblErrorMessage.Text = "Oops, No results found.";
                lblErrorMessage.Visible = true;
            }
        }

        private void LogException(Exception ex)
        {
            // Log or display the exception details
            // For example, you can log to the console for simplicity
            Console.WriteLine($"Exception Message: {ex.Message}");
            Console.WriteLine($"Stack Trace: {ex.StackTrace}");
            // Add additional logging as needed
        }

    }
}
