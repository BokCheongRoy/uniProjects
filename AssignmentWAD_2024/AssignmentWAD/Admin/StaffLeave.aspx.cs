using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD.Employee
{
    public partial class StaffLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowNoDataMessage();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Leave]";
            GridView1.DataBind();
            ShowNoDataMessage();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Leave] WHERE [Status] = 'Pending'";
            GridView1.DataBind();
            ShowNoDataMessage();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Leave] WHERE [Status] = 'Approved'";
            GridView1.DataBind();
            ShowNoDataMessage();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Leave] WHERE [Status] = 'Rejected'";
            GridView1.DataBind();
            ShowNoDataMessage();
        }
        private void ShowNoDataMessage()
        {
            if (GridView1.Rows.Count == 0)
            {
                // No data, display a message
                GridView1.EmptyDataText = "Sorry, there is no data.";
            }
            else
            {
                // Clear the message if there is data
                GridView1.EmptyDataText = string.Empty;
            }
        }

    }
}