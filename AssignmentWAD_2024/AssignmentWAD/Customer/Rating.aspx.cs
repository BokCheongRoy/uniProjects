using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;


namespace AssignmentWAD.Customer
{
    public partial class Rating : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var ratingContainer = FindControlRecursive(e.Item, "rating") as HtmlGenericControl;

                if (ratingContainer != null)
                {
                    ratingContainer.Attributes.Add("id", "ratingContainer_" + e.Item.ItemIndex);
                }
            }
        }

        private Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id)
                return root;

            foreach (Control control in root.Controls)
            {
                Control foundControl = FindControlRecursive(control, id);
                if (foundControl != null)
                    return foundControl;
            }

            return null;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string orderID = Session["OrderID"] as string;
            foreach (RepeaterItem item in Repeater1.Items)
            {
                HiddenField hfProductID = item.FindControl("hfProductID") as HiddenField;
                TextBox txtReview = item.FindControl("txtReview") as TextBox;
                RadioButtonList rblRating = item.FindControl("rblRating") as RadioButtonList;

                string productID = hfProductID.Value;
                int rating = Convert.ToInt32(rblRating.SelectedValue);
                string review = txtReview.Text;
                if (String.IsNullOrWhiteSpace(review))
                {
                    review = "No comment left";
                }
                DateTime ratingDate = DateTime.Now;
                UpdateReview(rating,review, ratingDate, productID, orderID);

            }
            UpdateOrder(orderID,"Rated");
            Response.Redirect("~/Customer/ViewOrderHistory.aspx");
        }

        private void UpdateReview(int rating, string review, DateTime ratingDate, string productID, string orderID)
        {
            try
            {
                string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string updateQuery = "UPDATE OrderDetails SET Rating = @Rating, Review = @Review, RatingDate = @RatingDate WHERE ProductID = @ProductID AND OrderID = @OrderID";

                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Rating", rating);
                        command.Parameters.AddWithValue("@Review", review);
                        command.Parameters.AddWithValue("@ProductID", productID);
                        command.Parameters.AddWithValue("@OrderID", orderID);
                        command.Parameters.AddWithValue("@RatingDate", ratingDate);

                        command.ExecuteNonQuery();

                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"An error occurred during database update: {ex.Message}<br>");
                Response.Write($"StackTrace: {ex.StackTrace}<br>");
                Response.Write($"InnerException: {ex.InnerException}<br>");
            }
        }

        private void UpdateOrder(string orderID, string status)
        {
            try
            {
                string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Bakery.mdf;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string updateQuery = "UPDATE [Order] SET Status = @Status WHERE OrderID = @OrderID";

                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Status", status); 
                        command.Parameters.AddWithValue("@OrderID", orderID);

                        command.ExecuteNonQuery();

                    }
                }
                Response.Write(orderID + "success update to " + status);
            }
            catch (Exception ex)
            {
                Response.Write($"An error occurred during database update: {ex.Message}<br>");
                Response.Write($"StackTrace: {ex.StackTrace}<br>");
                Response.Write($"InnerException: {ex.InnerException}<br>");
            }
        }
    }
}