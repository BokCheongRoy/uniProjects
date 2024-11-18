using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD.Customer
{
    public partial class WishList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Repeater1.DataBind();
                CheckWishListEmpty();
            }
        }

        private void CheckWishListEmpty()
        {
            if (Repeater1.Items.Count == 0)
            {
                lblEmptyWishList.Visible = true;
            }
            else
            {
                lblEmptyWishList.Visible = false;
            }
        }

        protected void BtnFavourite_Click(object sender, EventArgs e)
        {
            string productID = ((HiddenField)((RepeaterItem)((Control)sender).NamingContainer).FindControl("hfProductID")).Value;
            string customerID = Session["CustomerID"] as string;

            RemoveFromWishList(customerID, productID);
            Repeater1.DataBind();
            CheckWishListEmpty();

        }
        private void RemoveFromWishList(string customerID, string productID)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string deleteQuery = "DELETE FROM WishList WHERE CustomerID = @CustomerID AND ProductID = @ProductID";

                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);
                    command.Parameters.AddWithValue("@ProductID", productID);

                    command.ExecuteNonQuery();
                }
            }
        }
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblRate = e.Item.FindControl("lblRate") as Label;
                HiddenField hfProductIDForRating = e.Item.FindControl("hfProductID") as HiddenField;

                if (lblRate != null && hfProductIDForRating != null)
                {
                    string productID = hfProductIDForRating.Value;

                    decimal averageRating = CalculateAverageRating(productID);

                    lblRate.Text = string.Format("★ {0:F1}", averageRating);
                }
            }
        }

        private decimal CalculateAverageRating(string productID)
        {
            decimal averageRating = GetAverageRatingFromDatabase(productID);

            return averageRating;
        }

        private decimal GetAverageRatingFromDatabase(string productID)
        {

            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";
            string selectQuery = "SELECT AVG(CAST(Rating AS DECIMAL(5, 2))) FROM OrderDetails WHERE ProductID = @ProductID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductID", productID);

                    connection.Open();

                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToDecimal(result);
                    }
                    else
                    {
                        return 0.0m; 
                    }
                }
            }
        }

    }

}