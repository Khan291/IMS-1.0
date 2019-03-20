using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.Stock
{
    public partial class StockAdjustment : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                BindStock();
            }
        }
        public void BindStock()
        {
            try
            {
                int companyID = 1008;// for testing purpose only
                int branchId = 2009;// for testing purpose only
                var stockDetails = context.tbl_stock.Join(context.tbl_product, s => s.stock_id, p => p.product_id, (s, p) => new
                {
                    s.stock_id,
                    p.product_id,
                    p.product_name,
                    s.qty,
                    s.company_id,
                    s.status,
                    s.branch_id
                }).Where(w => w.company_id == companyID && w.status == true && w.branch_id == branchId).ToList();
                if (stockDetails != null)
                {
                    gvStockDetails.DataSource = stockDetails;
                    gvStockDetails.DataBind();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        protected void gvStockDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            //Setting the EditIndex property to - 1 to cancel the Edit mode in Gridview
            gvStockDetails.EditIndex = -1;
            BindStock();
        }

        protected void gvStockDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //NewEditIndex property used to determine the index of the row being edited.  
            gvStockDetails.EditIndex = e.NewEditIndex;
            BindStock();
        }

        protected void gvStockDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //Finding the controls from Gridview for the row which is going to update
            Label lblStockId = gvStockDetails.Rows[e.RowIndex].FindControl("lblStockId") as Label;
            TextBox txtqty = gvStockDetails.Rows[e.RowIndex].FindControl("txtqty") as TextBox;

            var _stockId = Convert.ToUInt32(lblStockId.Text);

            var stockDetails = context.tbl_stock.Where(w => w.stock_id == _stockId).FirstOrDefault();
            stockDetails.qty = Convert.ToInt32(txtqty.Text);
            context.SaveChanges(); 
            gvStockDetails.EditIndex = -1;
            BindStock();
        }
    }
}