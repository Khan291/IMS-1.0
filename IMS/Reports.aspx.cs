using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnPurchase_Click(object sender, EventArgs e)
        {
            Session["Purchaseflag"] = 1;
            Response.Redirect("~/PurchaseFolder/PurchaseReport.aspx", false);
        }

        protected void btnSale_Click(object sender, EventArgs e)
        {
            Session["Salesflag"] = 1;
            Response.Redirect("~/SalesFolder/SalesReport.aspx", false);

        }

        #endregion
    }
}