using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace AssignmentWAD.Admin
{
    public partial class MonthlyProfit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Chart3.Width = 900;
        }
        protected void SqlDataSource4_DataBound(object sender, EventArgs e)
        {
            // Add a debug statement
            Debug.WriteLine("SqlDataSource4_DataBound event triggered.");

            // Check if there are no data points in the series
            if (Chart3.Series["Series1"].Points.Count == 0)
            {
                // Hide the chart to avoid displaying an empty chart area
                Chart3.Visible = false;

                // You can display a message or take other actions as needed
                // In this example, I'm showing a JavaScript alert
                ScriptManager.RegisterStartupScript(this, GetType(), "NoDataAlert", "alert('Oops, no data available for the selected month.');", true);
            }
            else
            {
                // Show the chart if there are data points
                Chart3.Visible = true;
            }
        }

        
        //protected void SqlDataSource7_DataBound(object sender, EventArgs e)
        //{


        //}

        //protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    SqlConnection conn;
        //    string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        //    conn = new SqlConnection(strCon);
        //    conn.Open();
        //    string strRetrieve = "SELECT SUM(TotalPrice) AS TotalSum FROM(SELECT Product.ProductID, Product.ProductName, Product.UnitPrice * OrderDetails.Quantity AS TotalPrice, OrderDetails.ProductID AS Expr1, OrderDetails.Quantity FROM Product INNER JOIN OrderDetails ON Product.ProductID = OrderDetails.ProductID INNER JOIN[Order] ON OrderDetails.OrderID = [Order].OrderID WHERE MONTH([Order].OrderDate) = @month AND YEAR([Order].OrderDate) = @year) AS Subquery";

        //    SqlCommand cmdRetrieve;
        //    cmdRetrieve = new SqlCommand(strRetrieve, conn);
        //    cmdRetrieve.Parameters.AddWithValue("@month", DropDownList1.SelectedValue.ToString());
        //    cmdRetrieve.Parameters.AddWithValue("@year", DropDownList2.SelectedValue.ToString());

        //    Label2.Text = (String)cmdRetrieve.ExecuteScalar();
        //    conn.Close();

        //}
    }
}