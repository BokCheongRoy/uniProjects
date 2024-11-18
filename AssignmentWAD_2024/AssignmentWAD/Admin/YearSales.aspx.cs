using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace AssignmentWAD.Admin
{
    public partial class YearSales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Chart1.Width = 900;
        }
    }
}