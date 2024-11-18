using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssignmentWAD.Customer
{
    public partial class ViewOrderHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckOrderEmpty();
            }
        }
        private void CheckOrderEmpty()
        {
            if (GridViewOrder.Rows.Count == 0)
            {
                lblEmptyOrder.Visible = true;
            }
            else
            {
                lblEmptyOrder.Visible = false;
            }
        }

        protected void BtnPending_Click(object sender, EventArgs e)
        {
            string status = "Pending";
            SelectOrder(status);

        }

        protected void BtnPreparing_Click(object sender, EventArgs e)
        {
            string status = "Preparing";
            SelectOrder(status);

        }

        protected void BtnDelivered_Click(object sender, EventArgs e)
        {
            string status = "Delivered";
            SelectOrder(status);
        }

        

        protected void BtnRated_Click(object sender, EventArgs e)
        {
            string status = "Rated";
            SelectOrder(status);

        }
        private void SelectOrder(string status)
        {
            string customerId = Session["CustomerID"] as string;

            SqlDataSource1.SelectCommand = "SELECT * FROM [Order] WHERE (([CustomerID] = @CustomerID) AND ([Status] = @Status)) ORDER BY [OrderID] DESC";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("CustomerID", customerId);
            SqlDataSource1.SelectParameters.Add("Status", status);
            GridViewOrder.DataBind();
            CheckOrderEmpty();

            if (GridViewOrder.SelectedIndex > -1)
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
            if (status.Equals("Delivered", StringComparison.OrdinalIgnoreCase))
            {
                btnRate.Visible = true;
            }
            else
            {
                btnRate.Visible = false;
            }
        }
        private void SetVisibilityBasedOnStatus(string status)
        {
            if (status.Equals("Delivered", StringComparison.OrdinalIgnoreCase))
            {
                GridView1.Visible = true;
                btnRate.Visible = true;
            }
            else
            {
                GridView1.Visible = true;
                btnRate.Visible = false;
            }
        }

        protected void GridViewOrder_SelectedIndexChanged(object sender, EventArgs e)
        {
            CheckSelectedStatus();

            if (GridViewOrder.SelectedIndex > -1)
            {
                GridView1.DataBind();
            }

            SetVisibilityBasedOnStatus(GridViewOrder.SelectedRow.Cells[GridViewOrder.Columns.Count - 1].Text);

            if (GridViewOrder.SelectedRow.Cells[GridViewOrder.Columns.Count - 1].Text.Equals("Delivered", StringComparison.OrdinalIgnoreCase))
            {
                btnRate.Visible = true;
            }
            else
            {
                btnRate.Visible = false;
            }
        }

        protected void BtnRate_Click(object sender, EventArgs e)
        {
            if (GridViewOrder.SelectedIndex > -1 &&
                GridViewOrder.SelectedRow.Cells[GridViewOrder.Columns.Count - 1].Text.Equals("Delivered", StringComparison.OrdinalIgnoreCase))
            {
                Session["OrderID"] = GridViewOrder.SelectedDataKey["OrderID"].ToString();

                Response.Redirect("~/Customer/Rating.aspx");
            }
        }

        private void CheckSelectedStatus()
        {
            if (GridViewOrder.SelectedIndex > -1)
            {
                string selectedStatus = GridViewOrder.SelectedRow.Cells[GridViewOrder.Columns.Count - 1].Text; 
                if (selectedStatus.Equals("Delivered", StringComparison.OrdinalIgnoreCase))
                {
                    Session["OrderID"] = GridViewOrder.SelectedDataKey["OrderID"].ToString();
                }
                else
                {
                }
            }
            
        }

    }
}