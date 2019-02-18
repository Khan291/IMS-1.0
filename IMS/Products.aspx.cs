using IMSBLL.DAL;
using IMSBLL.EntityModel;
using IMSBLL.EntityModel.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS
{
    public partial class Products : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS2Entities context = new IMS2Entities();
        InventoryReport R = new InventoryReport();
        tbl_product p = new tbl_product();
        tbl_stock s = new tbl_stock();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetTable();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods

        private void GetTable()
        {
            try
            {
                int c_id = Convert.ToInt32(Session["company_id"]);
                int b_id = Convert.ToInt32(Session["branch_id"]);

                p.company_id = c_id;
                p.branch_id = b_id;
                GrProducts.DataSource = R.GetProduct(p, s);
                GrProducts.DataBind();


            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        #endregion
    }
}