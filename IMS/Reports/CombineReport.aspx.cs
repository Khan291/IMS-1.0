using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IMSBLL.EntityModel;
using IMSBLL.DAL;
using System.Configuration;
using System.IO;
using IMS.Reports;

namespace IMS.Reports
{
    public partial class CombineReport : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        string connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        int id = 0;
        string reportName = string.Empty;
        int companyId, branchId;
        string User_id;
        bool displayInventoryColumns = false;
        bool isReportType = false;
        bool isInvoiceType=false;
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();
            if (!IsPostBack)
            {
                reportName = Request.QueryString["ReportName"].ToString();
                id = Convert.ToInt32(Request.QueryString["Id"]);
            }           
            CallReport(reportName);           
            logo();
        }
        public void CallReport(string reportName)
        {
            SqlParameter[] sqlParams;

            string reportDataSet = string.Empty;
            string dataTable = string.Empty;
            switch (reportName)
            {

                //Combine Purchase Return Order Report 
                case "CombinePurchaseAndReturnReport":
                    isReportType = true;
                    isInvoiceType = true;
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","COMBINEPURCHASEANDRETURNREPORT")
                    };

                    reportDataSet = "CombineDataSet";
                    dataTable = "CombineDataTable";
                    CreateReport(connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams, reportDataSet, dataTable);
                    break;
              
                //Combine Sale Return Order Report 
                case "CombineSaleAndReturnReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","COMBINESALEANDRETURN")
                    };
                    reportDataSet = "CombineDataSet";
                    dataTable = "CombineDataTable";
                    CreateReport(connectionstring, "SaleOrSaleReturnReport", sqlParams, reportDataSet, dataTable);
                    break;

                default:
                    break;
            }


        }
        public void CreateReport(String connectionstring, string storeProcedureName, SqlParameter[] parameter, string reportDataSource, string tableName)
        {
            using (SqlConnection con = new SqlConnection(connectionstring))
            {
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = storeProcedureName;
                if (parameter != null)
                {
                    com.Parameters.AddRange(parameter);
                }
                CommonDataSet ds = new CommonDataSet();
                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(ds, tableName);
                grdreport.DataSource = (DataTable)ds.Tables[tableName];
                grdreport.DataBind();              
               
                decimal totalAmount = 0;
                decimal totalTax = 0;
                decimal totalDiscount = 0;
                decimal grandTotal = 0;
               
                for (int i = 0; i < ds.Tables[tableName].Rows.Count; i++)
                {                    
                    lblCompanyName.Text = ds.Tables[tableName].Rows[i]["Company"].ToString();
                    lblAddress.Text = ds.Tables[tableName].Rows[i]["CompanyAddress"].ToString();
                    // lblemail.Text = ds.Tables[tableName].Rows[i]["company_address"].ToString();
                    //lblzipcode.Text = ds.Tables[tableName].Rows[i]["company_address"].ToString();

                    lbldate.Text = ds.Tables[tableName].Rows[i]["Date"].ToString();
                    lblpartyname.Text = ds.Tables[tableName].Rows[i]["Party"].ToString();
                    lblpartyaddress.Text = ds.Tables[tableName].Rows[i]["PartyAddress"].ToString();
                    lblinvoiceno.Text = ds.Tables[tableName].Rows[i]["InvoiceNumber"].ToString();

                    //lblGivenAmnt.Text = ds.Tables[tableName].Rows[i]["GivenAmnt"].ToString();
                    //lblBalanceAmnt.Text = ds.Tables[tableName].Rows[i]["BalanceAmnt"].ToString();

                    //for resolve calculation Error Occur 

                    if (isInvoiceType)
                    {
                        var purchase = context.tbl_PurchasePaymentDetials.Where(p => p.PurchaseId == id).FirstOrDefault();
                        totalAmount = Convert.ToDecimal(purchase.SubTotal);
                        totalTax = Convert.ToDecimal(purchase.TaxAmount);
                        totalDiscount = Convert.ToDecimal(purchase.DiscountAmount);
                        grandTotal = Convert.ToDecimal(purchase.GrandTotal);
                        lblGivenAmnt.Text = purchase.GivenAmnt.ToString();
                        lblBalanceAmnt.Text = purchase.BalanceAmnt.ToString();

                    }
                    else
                    {

                        var sale = context.tbl_SalePaymentDetails.Where(s => s.SaleId == id).FirstOrDefault();
                        totalAmount = Convert.ToDecimal(sale.SubTotal);
                        totalTax = Convert.ToDecimal(sale.TaxAmount);
                        totalDiscount = Convert.ToDecimal(sale.DiscountAmount);
                        grandTotal = Convert.ToDecimal(sale.GrandTotal);
                        lblGivenAmnt.Text = sale.GivenAmnt.ToString();
                        lblBalanceAmnt.Text = sale.BalanceAmnt.ToString();
                    }
                    
                    //if (ds.Tables[tableName].Rows[i]["Type"].ToString() == "Purchase")
                    //{
                    //    totalAmount = totalAmount + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalAmount"]);
                    //    totalTax = totalTax + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalTax"]);
                    //    totalDiscount = totalDiscount + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalDiscount"]);
                    //    grandTotal = grandTotal + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["GrandTotal"]);
                    //}
                    //else if (ds.Tables[tableName].Rows[i]["Type"].ToString() == "Sale")
                    //{
                    //    totalAmount = totalAmount + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalAmount"]);
                    //    totalTax = totalTax + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalTax"]);
                    //    totalDiscount = totalDiscount + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalDiscount"]);
                    //    grandTotal = grandTotal + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["GrandTotal"]);
                    //}
                    //else if (ds.Tables[tableName].Rows[i]["Type"].ToString() == "Return")
                    //{
                    //    totalAmount = totalAmount - Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalAmount"]);
                    //    totalTax = totalTax - Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalTax"]);
                    //    totalDiscount = totalDiscount - Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalDiscount"]);
                    //    grandTotal = grandTotal - Convert.ToDecimal(ds.Tables[tableName].Rows[i]["GrandTotal"]);

                    //}
                    //if (isReportType)
                    //{
                        //totalAmount = Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalAmount"]);
                        //totalTax =  Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalTax"]);
                        //totalDiscount = Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalDiscount"]);
                        //grandTotal = Convert.ToDecimal(ds.Tables[tableName].Rows[i]["GrandTotal"]);
                   // }
                    //totalAmount =  Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalAmount"]);
                    //totalTax =  Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalTax"]);
                    //totalDiscount =  Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalDiscount"]);
                    //grandTotal =  Convert.ToDecimal(ds.Tables[tableName].Rows[i]["TotalAmount"]);

                    lblsubtotal.Text = totalAmount.ToString();
                    lblTaxAmount.Text = totalTax.ToString();
                    lblDiscountAmt.Text = totalDiscount.ToString();
                    lblGrandTotal.Text = grandTotal.ToString();
                }
            }
        }
        private void SessionValue()
        {
            if (Session["UserID"] == null || Session["company_id"] == null || Session["branch_id"] == null)
            {
                Response.Redirect("~/Registration/Login.aspx");
            }
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }       
        public void logo()
        {
            var logo = context.tbl_company.Where(w => w.company_id == companyId).FirstOrDefault();
            try
            {
               
                if (logo != null)
                {

                    if (File.Exists(Server.MapPath(logo.logo)))
                    {
                        imglogo.ImageUrl = logo.logo;
                    }
                    else
                    {
                        imglogo.Visible = false;
                        lblIms.Visible = true;
                    }
                }
                else
                {
                    imglogo.Visible = false;
                    lblIms.Visible = true;
                }               
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }            
        }
       
    }
}