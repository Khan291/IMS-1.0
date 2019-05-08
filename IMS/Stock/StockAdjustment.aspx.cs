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
                int companyID = 0;
                int branchId = 0;
                if (Session["company_id"] != null  && Session["branch_id"] != null)
                {
                    companyID = Convert.ToInt32(Session["company_id"]);
                    branchId = Convert.ToInt32(Session["branch_id"]);
                }

                var stockDetails = (from s in context.tbl_stock
                              join p in context.tbl_product on s.product_id equals p.product_id
                              join g in context.tbl_godown on p.godown_id equals g.godown_id
                              where s.branch_id == branchId && s.company_id == companyID && s.status == true
                              select new
                              {
                                  s.stock_id,
                                  p.product_id,
                                  p.product_name,
                                  s.qty,
                                  s.company_id,
                                  s.status,
                                  s.branch_id,
                                  g.godown_name
                              }).ToList();

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

        protected void gvStockDetails_PreRender(object sender, EventArgs e)
        {
            if (gvStockDetails.Rows.Count > 0)
            {
                gvStockDetails.UseAccessibleHeader = false;
                gvStockDetails.HeaderRow.TableSection = TableRowSection.TableHeader;
                gvStockDetails.FooterRow.TableSection = TableRowSection.TableFooter;
                int CellCount = gvStockDetails.FooterRow.Cells.Count;
                gvStockDetails.FooterRow.Cells.Clear();
                gvStockDetails.FooterRow.Cells.Add(new TableCell());
                gvStockDetails.FooterRow.Cells[0].ColumnSpan = CellCount - 1;
                gvStockDetails.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                gvStockDetails.FooterRow.Cells.Add(new TableCell());

                TableFooterRow tfr = new TableFooterRow();
                for (int i = 0; i < CellCount; i++)
                {
                    tfr.Cells.Add(new TableCell());
                }
                gvStockDetails.FooterRow.Controls[1].Controls.Add(tfr);
            }
        }

        protected void gvStockDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //check if the row is the header row
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //add the thead and tbody section programatically
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }
    }
}