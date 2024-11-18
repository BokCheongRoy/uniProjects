using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD
{
    public partial class Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                string customerID = Session["CustomerID"] as string;

                foreach (RepeaterItem item in Repeater1.Items)
                {
                    HiddenField hfProductID = item.FindControl("hfProductID") as HiddenField;
                    Button btnFavourite = item.FindControl("btnFavourite") as Button;

                    if (IsInWishList(customerID, hfProductID.Value))
                    {
                        btnFavourite.Text = Server.HtmlDecode("&#x2665;");
                    }
                }
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    if (Session["CustomerID"] != null)
                    {
                        string customerID = Session["CustomerID"] as string;

                        HiddenField hfProductID = e.Item.FindControl("hfProductID") as HiddenField;
                        Button btnFavourite = e.Item.FindControl("btnFavourite") as Button;

                        if (IsInWishList(customerID, hfProductID.Value))
                        {
                            btnFavourite.Text = "♥";
                        }
                    }

                }
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

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                lblNoResults.Visible = false;
                Products.SelectCommand = "SELECT * FROM [Product] WHERE ProductName LIKE '%' + @SearchTerm + '%'";
                Products.SelectParameters.Clear();
                Products.SelectParameters.Add("SearchTerm", DbType.String, txtSearch.Text);
            }
            else
            {
                lblNoResults.Visible = false;
                Products.SelectCommand = "SELECT * FROM [Product] WHERE ([CategoryID] = @CategoryID)";
                Products.SelectParameters.Clear();
                Products.SelectParameters.Add("CategoryID", DbType.Int32, Request.QueryString["CategoryID"]);
            }

            Repeater1.DataBind();

            if (Repeater1.Items.Count == 0)
            {
                lblNoResults.Visible = true;
            }
        }

        protected void BtnFavourite_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                string productID = ((HiddenField)((RepeaterItem)((Control)sender).NamingContainer).FindControl("hfProductID")).Value;
                string customerID = Session["CustomerID"] as string;

                if (IsInWishList(customerID, productID))
                {
                    RemoveFromWishList(customerID, productID);
                }
                else
                {
                    AddToWishList(customerID, productID);
                }

                Repeater1.DataBind();
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        private bool IsInWishList(string customerID, string productID)
        {
            if (string.IsNullOrEmpty(customerID) || string.IsNullOrEmpty(productID))
            {
                return false;
            }



            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string selectQuery = "SELECT COUNT(*) FROM WishList WHERE CustomerID = @CustomerID AND ProductID = @ProductID";

                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);
                    command.Parameters.AddWithValue("@ProductID", productID);

                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private void AddToWishList(string customerID, string productID)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string insertQuery = "INSERT INTO WishList (CustomerID, ProductID) VALUES (@CustomerID, @ProductID)";

                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);
                    command.Parameters.AddWithValue("@ProductID", productID);

                    command.ExecuteNonQuery();
                }
            }
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