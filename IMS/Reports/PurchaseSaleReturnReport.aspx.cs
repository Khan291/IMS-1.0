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
    public partial class PurchaseSaleReturnReport : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        string connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        int id = 0;
        string reportName = string.Empty;
        int companyId, branchId;
        string User_id;
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

                //Original Purchase Order Report 
                case "PurchaseReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","PURCHASEREPORT")
                    };
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";

                    CreateReport(connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams, reportDataSet, dataTable);
                    break;

                //Only Purchase Return Order Report 
                case "PurchaseReturnReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","PURCHASERETURNREPORT")
                    };
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";
                    CreateReport(connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams, reportDataSet, dataTable);
                    break;

                //Original Sale Order Report 
                case "SaleReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","SALE")
                    };
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";
                    CreateReport(connectionstring, "SaleOrSaleReturnReport", sqlParams, reportDataSet, dataTable);
                    break;

                //Only Sale Return Order Report 
                case "SaleReturnReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","SALERETURN")
                    };
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";
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
                decimal givenAmt = 0;
                decimal balanceAmt = 0;
              for (int i = 0; i < ds.Tables[tableName].Rows.Count; i++)
                {                  
                    lblCompanyName.Text = ds.Tables[tableName].Rows[i]["company_name"].ToString();
                    lblAddress.Text = ds.Tables[tableName].Rows[i]["company_address"].ToString();
                    // lblemail.Text = ds.Tables[tableName].Rows[i]["company_address"].ToString();
                    //lblzipcode.Text = ds.Tables[tableName].Rows[i]["company_address"].ToString();

                    lbldate.Text = ds.Tables[tableName].Rows[i]["created_date"].ToString();
                    lblpartyname.Text = ds.Tables[tableName].Rows[i]["party_name"].ToString();
                    lblpartyaddress.Text = ds.Tables[tableName].Rows[i]["party_address"].ToString();

                    lblinvoiceno.Text = ds.Tables[tableName].Rows[i]["InvoiceNumber"].ToString();

                    totalAmount = totalAmount + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["amount"]);
                    totalTax = totalTax + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["tax_amt"]);
                    totalDiscount = totalDiscount + Convert.ToDecimal(ds.Tables[tableName].Rows[i]["discount_amnt"]);
                    grandTotal = grandTotal + totalAmount+totalTax -totalDiscount;

                   
                  
                    
                }
              lblsubtotal.Text = totalAmount.ToString(); //ds.Tables[tableName].Rows[i]["total_amount"].ToString();given_amnt
              lblTaxAmount.Text = totalTax.ToString();//ds.Tables[tableName].Rows[i]["total_tax"].ToString();
              lblDiscountAmt.Text = totalDiscount.ToString(); //ds.Tables[tableName].Rows[i]["total_discount"].ToString();
              lblGrandTotal.Text = grandTotal.ToString();//ds.Tables[tableName].Rows[i]["grand_total"].ToString();
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