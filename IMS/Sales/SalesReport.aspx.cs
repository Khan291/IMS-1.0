using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS
{
    public partial class SalesReport : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region objects
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        int companyId;
        int branchId;
        string User_id;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();
            if (!IsPostBack)
            {               
                bindgrid(0, "", "", "");
                ddlVendorbind();
               getdate();
            }
        }
        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        private void SessionValue()
        {
            if (Session["UserID"] == null || Session["company_id"] == null || Session["branch_id"] == null || Session["financialyear_id"] == null)
            {
                Response.Redirect("~/Registration/Login.aspx");
            }
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }
        public void getdate()
        {
            try
            {
                var finicialyear = context.tbl_financialyear.Where(f => f.company_id == companyId && f.status == true).SingleOrDefault();
                //CalendarExtender1.StartDate = Convert.ToDateTime(finicialyear.start_date);
                //CalendarExtender1.EndDate = Convert.ToDateTime(finicialyear.end_date)

                CalendarExtender1.StartDate = Convert.ToDateTime(finicialyear.start_date);
                CalendarExtender1.EndDate = Convert.ToDateTime(finicialyear.end_date);


                CalendarExtender2.StartDate = Convert.ToDateTime(finicialyear.start_date);
                CalendarExtender2.EndDate = Convert.ToDateTime(finicialyear.end_date);
                //RangeValidator1.MinimumValue =  (finicialyear.start_date);
                //RangeValidator1.MaximumValue = (finicialyear.end_date);
                //hd1.Value = finicialyear.start_date;
                //hd2.Value = finicialyear.end_date;
                //hd3.Value = finicialyear.start_date;
                //hd4.Value = finicialyear.end_date;
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
            }
        }
        public void ddlVendorbind()
        {
            

            try
            {
                List<tbl_party> cd = context.tbl_party.Where(x => x.status == true && x.company_id == companyId && x.party_type == "Customer").ToList();
                ddlVendor.DataTextField = "party_name";
                ddlVendor.DataValueField = "party_id";
                ddlVendor.DataSource = cd;
                ddlVendor.DataBind();
                ddlVendor.Items.Insert(0, new ListItem("--Select Vendor--", "0"));
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }
        public void bindgrid(int partyid,string invno,string fromdate,string enddate)
        {
         //   DateTime ? fdate=null;
         //   DateTime ? edate=null;
         //   if (fromdate != "")
	        //{
         //       fdate = DateTime.ParseExact(fromdate, "yyyy-mm-dd", null);
         //           //Convert.ToDateTime(fromdate);
	        //}
         //   if (enddate != "")
	        //{
         //       edate = DateTime.ParseExact(enddate, "yyyy-mm-dd", null); 
         //           //Convert.ToDateTime(enddate);
	        //}
         //   int c_id = Convert.ToInt32(Session["company_id"]);

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_SelectSalesReport";
            cmd.Parameters.AddWithValue("@company_id", companyId);
            cmd.Parameters.AddWithValue("@partyid", partyid);
            cmd.Parameters.AddWithValue("@invoiceNumber", invno);
            cmd.Parameters.AddWithValue("@fromdate", fromdate);
            cmd.Parameters.AddWithValue("@enddate", enddate);
            cmd.Connection = con;
            try
            {

                con.Open();
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
            //           GridView1.DataSource = context.sp_SelectPurchase(c_id);
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
            }
            finally 
            {
                con.Close();
                con.Dispose();
            }


        }
        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            bindgrid(Convert.ToInt32(ddlVendor.SelectedValue), txtInvoiceNo.Text, txtStartDate.Text,txtenddate.Text);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            bindgrid(0, "", "", "");
            ddlVendor.SelectedIndex = 0;
            txtInvoiceNo.Text = string.Empty;
            txtStartDate.Text = string.Empty;
            txtenddate.Text = string.Empty;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow grv = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer);
                int id = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName == "Order")
                {
                    Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Reports/ReportViewer.aspx?Id={0}&ReportName={1}", id, "SaleReport"))));
                   // Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Reports/PurchaseSaleReturnReport.aspx?Id={0}&ReportName={1}", id, "SaleReport"))));
                }
                else if (e.CommandName == "Invoice")
                {
                    Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Reports/ReportViewer.aspx?Id={0}&ReportName={1}", id, "CombineSaleAndReturnReport"))));
                  //  Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Reports/CombineReport.aspx?Id={0}&ReportName={1}", id, "CombineSaleAndReturnReport"))));
                }
                else if (e.CommandName == "Return")
                {
                    Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Reports/ReportViewer.aspx?Id={0}&ReportName={1}", id, "SaleReturnReport"))));
                    //Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Reports/PurchaseSaleReturnReport.aspx?Id={0}&ReportName={1}", id, "SaleReturnReport"))));
                }
                else if (e.CommandName == "ViewORPayBalance")
                {
                    bool enablePayBalance = false;

                    if (grv.Cells[5].Text != "0.00")
                    {
                        enablePayBalance = true;
                    }
                    Response.Redirect(string.Format("~/Sales/ViewORPayBalanceSale.aspx?Id={0}&ViewOrPayBalance={1}", id, enablePayBalance));
                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        public void ExportToExcel(DataTable dt)
        {
            if (dt.Rows.Count > 0)
            {
                string filename = "SaleReport.xls";
                System.IO.StringWriter tw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
                DataGrid dgGrid = new DataGrid();
                dgGrid.DataSource = dt;
                dgGrid.DataBind();

                //Get the HTML for the control.
                dgGrid.RenderControl(hw);
                //Write the HTML back to the browser.
                //Response.ContentType = application/vnd.ms-excel;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
                this.EnableViewState = false;
                Response.Write(tw.ToString());
                Response.End();
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            bindgrid(0, "", "", "");
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }
        protected void btnExporttoexcel_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            DataRow dr;
            dt.Columns.Add("SRNo");
            dt.Columns.Add("Order Number"); dt.Columns.Add("Purchase Number"); dt.Columns.Add("Vendor"); dt.Columns.Add("Date");dt.Columns.Add("Given Amnt"); dt.Columns.Add("Balance Amnt"); dt.Columns.Add("Grand Total"); 
            foreach (GridViewRow row in GridView1.Rows)
            {
                dr = dt.NewRow();
                dr[0] = row.Cells[0].Text;
                dr[1] = row.Cells[1].Text;
                dr[2] = row.Cells[2].Text;
                dr[3] = row.Cells[3].Text;
                dr[4] = row.Cells[4].Text;
                dr[5] = row.Cells[5].Text;
                dr[6] = row.Cells[6].Text;
                dt.Rows.Add(dr);
            }
            ExportToExcel(dt);
        }
        #endregion

        //protected void CalendarExtender1_PreRender(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        var finicialyear = context.tbl_financialyear.Where(f => f.company_id == companyId && f.status == true).SingleOrDefault();
        //        CalendarExtender1.StartDate = Convert.ToDateTime(finicialyear.start_date);
        //        CalendarExtender1.EndDate = Convert.ToDateTime(finicialyear.end_date);

        //    }
        //    catch (Exception ex)
        //    {

        //        ErrorLog.saveerror(ex);
        //    }
        //}
    }
}