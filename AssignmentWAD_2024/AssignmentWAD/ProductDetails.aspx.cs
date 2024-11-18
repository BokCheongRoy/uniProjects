using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD
{
    public partial class ProductDetails : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string productId = Request.QueryString["ProductID"];

                SqlDataSource2.SelectParameters["ProductID"].DefaultValue = productId;

                Repeater1.DataBind();
                GridView1.DataBind();

                if (GridView1.Rows.Count == 0)
                {
                    lblNoReview.Visible = true;
                }
                else
                {
                    lblNoReview.Visible = false;
                }

            }
        }
        protected void BtnIncrease_Click(object sender, EventArgs e)

        {
            Button btnIncrease = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnIncrease.NamingContainer;
            TextBox txtQty = (TextBox)item.FindControl("txtQty");

            int currentQty = int.Parse(txtQty.Text);
            txtQty.Text = (currentQty + 1).ToString();
        }

        protected void BtnDecrease_Click(object sender, EventArgs e)
        {
            Button btnDecrease = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnDecrease.NamingContainer;
            TextBox txtQty = (TextBox)item.FindControl("txtQty");

            int currentQty = int.Parse(txtQty.Text);
            if (currentQty > 1)
            {
                txtQty.Text = (currentQty - 1).ToString();
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Button btnIncrease = (Button)e.Item.FindControl("btnIncrease");
                Button btnDecrease = (Button)e.Item.FindControl("btnDecrease");

                btnIncrease.Click += BtnIncrease_Click;
                btnDecrease.Click += BtnDecrease_Click;
            }
        }
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    string customerID = Session["CustomerID"] as string;

                    HiddenField hfProductID = e.Item.FindControl("hfProductID") as HiddenField;
                    Button btnFavourite = e.Item.FindControl("btnFavourite") as Button;

                    if (IsInWishList(customerID, hfProductID.Value))
                    {
                        btnFavourite.Text = "♥";
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

        protected void BtnAddToCart_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            else
            {
                string productID = Request.QueryString["ProductID"];
                string customerID = Session["CustomerID"] as string;
                RepeaterItem repeaterItem = (RepeaterItem)((Control)sender).NamingContainer;
                TextBox txtQty = (TextBox)repeaterItem.FindControl("txtQty");
                int quantity = int.Parse(txtQty.Text);
                AddToCart(productID, customerID, quantity);
                Label lblAdded = (Label)repeaterItem.FindControl("lblAdded");
                lblAdded.Text = "Added to Cart";

            }

        }


        private void AddToCart(string productID, string customerID, int quantity)
        {
            try
            {
                if (IsRecordExists(customerID, productID))
                {
                    UpdateQuantity(customerID, productID, quantity);
                }
                else
                {
                    InsertNewRecord(customerID, productID, quantity);
                }
                Bakery masterPage = this.Master as Bakery;
                masterPage?.UpdateCartCount();


            }
            catch (Exception ex)
            {
                Response.Write("Error adding item to cart: " + ex.Message);
            }
        }

        private bool IsRecordExists(string customerID, string productID)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string selectQuery = "SELECT COUNT(*) FROM Cart WHERE CustomerID = @CustomerID AND ProductID = @ProductID";

                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);
                    command.Parameters.AddWithValue("@ProductID", productID);

                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }

        }
        private void UpdateQuantity(string customerID, string productID, int quantity)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string updateQuery = "UPDATE Cart SET Quantity = @Quantity WHERE CustomerID = @CustomerID AND ProductID = @ProductID";

                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);
                    command.Parameters.AddWithValue("@ProductID", productID);
                    command.Parameters.AddWithValue("@Quantity", quantity);

                    command.ExecuteNonQuery();
                }
            }
        }

        private void InsertNewRecord(string customerID, string productID, int quantity)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string insertQuery = "INSERT INTO Cart (CustomerID, ProductID, Quantity) VALUES (@CustomerID, @ProductID, @Quantity)";

                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", customerID);
                    command.Parameters.AddWithValue("@ProductID", productID);
                    command.Parameters.AddWithValue("@Quantity", quantity);

                    command.ExecuteNonQuery();
                }
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
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rating = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Rating"));

                Label lblRatingStars = (Label)e.Row.FindControl("lblRatingStars");

                lblRatingStars.Text = GetStarRating(rating);
            }

            if (GridView1.Rows.Count == 0)
            {
                lblNoReview.Visible = true;
            }
            else
            {
                lblNoReview.Visible = false;
            }
        }

        protected string GetStarRating(object ratingObject)
        {
            int ratingValue = Convert.ToInt32(ratingObject);

            switch (ratingValue)
            {
                case 1:
                    return "★";
                case 2:
                    return "★★";
                case 3:
                    return "★★★";
                case 4:
                    return "★★★★";
                case 5:
                    return "★★★★★";
                default:
                    return string.Empty;
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