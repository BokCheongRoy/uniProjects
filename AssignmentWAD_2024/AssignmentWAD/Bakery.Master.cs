using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD
{
    public partial class Bakery : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { 
            if (Session["CustomerID"] != null)
            {
                string customerID = Session["CustomerID"] as string;
                int cartCount = GetCartCount(customerID);

                Label lblCart = LoginView1.FindControl("lblCart") as Label;

                lblCart.Text = cartCount.ToString();
            }
            }
        }

        protected void LoginStatus3_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Session.Clear();
            Session.Abandon();

        }

        private int GetCartCount(string customerID)
        {

            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";
            string selectQuery = "SELECT COUNT(*) FROM [Cart] WHERE CustomerID = @CustomerID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);

                    connection.Open();

                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToInt32(result);
                    }
                    else
                    {
                        return 0;
                    }
                }
            }
        }

        public void UpdateCartCount()
        {
            if (Session["CustomerID"] != null)
            {
                string customerID = Session["CustomerID"] as string;
                Label lblCart = LoginView1.FindControl("lblCart") as Label;

                if (lblCart != null)
                {
                    lblCart.Text = GetCartCount(customerID).ToString();
                }
            }
        }
    }
}