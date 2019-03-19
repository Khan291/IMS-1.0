using IMSBLL.EntityModel;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.Reports
{
    public partial class ReportViewer : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        string Connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ToString();
        int id ,partyId= 0;
        string reportName = string.Empty;
        DateTime StartDate;
        DateTime EndDate;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
           {
                 reportName = Request.QueryString["ReportName"].ToString();
                 id = Convert.ToInt32(Request.QueryString["Id"]);
                ////used only for Inventory Report
                if (Request.QueryString["StartDate"] != null && Request.QueryString["EndDate"]!= null && Request.QueryString["PartyId"] != null)
                {
                    StartDate = Convert.ToDateTime(Request.QueryString["StartDate"]);
                    EndDate = Convert.ToDateTime(Request.QueryString["EndDate"]);
                    partyId = Convert.ToInt32(Request.QueryString["PartyId"]);
                }
                //string reportName = "CombinePurchaseAndReturnReport";
                CallReport(reportName);
            }
        }

        public void CallReport(string reportName)
        {
            
            SqlParameter[] sqlParams;
            ReportParameter reportParam;

            int companyId = Convert.ToInt32(Session["company_id"]);
            var logo = context.tbl_company.Where(w => w.company_id == companyId).Select(s=>s.logo).SingleOrDefault();
            string logoPath = new Uri(Server.MapPath(logo)).AbsoluteUri;

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Local;
            var setting = context.tbl_setting.Where(w => w.company_id == companyId).FirstOrDefault();

            string reportDataSet = string.Empty;
            string dataTable = string.Empty;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("../Reports/" + setting.InvoiceTemplateName);
            ReportViewer1.LocalReport.EnableExternalImages = true;
            switch (reportName)
            {              

                //Original Purchase Order Report 
                case "PurchaseReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","PURCHASE")
                    };
                    
                    
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    CreateReport(Connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);
                    
                    ReportViewer1.LocalReport.Refresh();
                    //ReportViewer1.LocalReport.SubreportProcessing += new Microsoft.Reporting.WebForms.SubreportProcessingEventHandler(PurchaseReturnReport_SubreportProcessing);
                    break;

                //Only Purchase Return Order Report 
                case "PurchaseReturnReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","PURCHASERETRUN")
                    };
                    //ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/PurchaseSaleReturnReport.rdlc");
                    //ReportViewer1.LocalReport.EnableExternalImages = true;
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);                    
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";
                    CreateReport(Connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);                 
                    ReportViewer1.LocalReport.Refresh();
                    //ReportViewer1.LocalReport.SubreportProcessing += new Microsoft.Reporting.WebForms.SubreportProcessingEventHandler(PurchaseReturnReport_SubreportProcessing);
                    break;

                //Combine Purchase Return Order Report 
                case "CombinePurchaseAndReturnReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","COMBINEPURCHASEANDRETURNREPORT")
                    };                   
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/CombineReport.rdlc");
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    reportDataSet = "CombineDataSet";
                    dataTable = "CombineDataTable";
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    CreateReport(Connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);

                   SqlParameter[] sqlParams1 = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","COMBINEPURCHASEANDRETURNREPORT")
                    }; 
                   string reportDataSet1 = "PaymentDetailsDataSet";
                   string dataTable1 = "PaymentDetailsDataTable";
                   CreateReport(Connectionstring, "SaleOrPurchaseOrReturnReport", sqlParams1, ref ReportViewer1, reportDataSet1, dataTable1);    
                    ReportViewer1.LocalReport.Refresh();
                    break;


                //Original Sale Order Report 
                case "SaleReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","SALE")
                    };
                    //ReportViewer1.LocalReport.ReportPath = Server.MapPath("../Reports/PurchaseSaleReturnReport.rdlc");
                    //ReportViewer1.LocalReport.EnableExternalImages = true;
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    CreateReport(Connectionstring, "SaleOrSaleReturnReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);
                    ReportViewer1.LocalReport.Refresh();
                    break;

                //Only Sale Return Order Report 
                case "SaleReturnReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","SALERETURN")
                    };
                    //ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/PurchaseSaleReturnReport.rdlc");
                    //ReportViewer1.LocalReport.EnableExternalImages = true;
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    reportDataSet = "PurchaseSaleReturnDataSet";
                    dataTable = "PurchaseSaleDataTable";
                    CreateReport(Connectionstring, "SaleOrSaleReturnReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);
                    ReportViewer1.LocalReport.Refresh();
                    break;

                //Combine Sale Return Order Report 
                case "CombineSaleAndReturnReport":
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","COMBINESALEANDRETURN")
                    };
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/CombineReport.rdlc");
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                        reportDataSet = "CombineDataSet";
                        dataTable = "CombineDataTable";
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    CreateReport(Connectionstring, "SaleOrSaleReturnReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);

                    
                    sqlParams1 = new SqlParameter[] {
                         new SqlParameter("@Id", id),
                         new SqlParameter("@FromTable","COMBINESALEANDRETURN")
                    }; 
                    reportDataSet1 = "PaymentDetailsDataSet";
                    dataTable1 = "PaymentDetailsDataTable";
                   CreateReport(Connectionstring, "SaleOrPurchaseOrReturnReport", sqlParams1, ref ReportViewer1, reportDataSet1, dataTable1);  

                    ReportViewer1.LocalReport.Refresh();
                    break;


                case "InventoryReport":
                    sqlParams = new SqlParameter[] {
                          new SqlParameter("@CompanyId", id),
                         new SqlParameter("@PartyId",partyId),
                         new SqlParameter("@StartDate",StartDate),
                         new SqlParameter("@EndDate",EndDate)
                    };
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/InventoryReport.rdlc");
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    reportDataSet = "CombineDataSet";
                    dataTable = "CombineDataTable";
                    CreateReport(Connectionstring, "InventoryReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);                 
                    ReportViewer1.LocalReport.Refresh();
                    break;

                case "SaleOrderReport":
                     sqlParams = new SqlParameter[] {
                       new SqlParameter("@SaleId", id) //,
                       //new SqlParameter("@Add_Source_Type", "Employee")
                    };
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/SaleOrderReport.rdlc");
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    reportParam = new ReportParameter("LogoPath", logoPath, true);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    reportDataSet = "SaleOrderDataSet";
                    dataTable = "SaleOrderDataTable";                    
                    CreateReport(Connectionstring, "SaleOrderReport", sqlParams, ref ReportViewer1, reportDataSet, dataTable);                    
                    ReportViewer1.LocalReport.Refresh();
                    break;
                   default:
                    break;
            }
           
            
        }

        void CombinePurchaseAndPurchaseReturnReport_SubreportProcessing(object sender, Microsoft.Reporting.WebForms.SubreportProcessingEventArgs e)
        {

            
            // get Sub Table Id from the parameters
            int purchasedetailsId = Convert.ToInt32(e.Parameters[0].Values[0]);
            //int purchasereturndetailsId = Convert.ToInt32(e.Parameters[1].Values[0]);
            var dataSourceName = e.DataSourceNames;
            // remove all previously attached Datasources, since we want to attach one
            e.DataSources.Clear();
            // Retrieve employeeFamily list based on EmpID
            var purcahseDetails = context.tbl_purchasedetails.Where(s=>s.purchasedetails_id== purchasedetailsId).ToList();

            //var purcahsereturnDetails = context.tbl_purchasereturndetails.Where(s => s.purchasereturndetails_id == purchasereturndetailsId).ToList();

            // add retrieved dataset or you can call it lis   t to data source
            e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
            {
                Name = dataSourceName.FirstOrDefault(),
                Value = purcahseDetails
            });

        }

        public void CreateReport(String connectionstring, string storeProcedureName, SqlParameter[] parameter, ref Microsoft.Reporting.WebForms.ReportViewer reportViewer, string reportDataSource, string tableName)
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
                ReportDataSource datasource = new ReportDataSource(reportDataSource, ds.Tables[tableName]);
                //if (ds.Tables[tableName].Rows.Count > 0)
                //{
                    //reportViewer.LocalReport.DataSources.Clear();
                    reportViewer.LocalReport.DataSources.Add(datasource);
                //}
            }
        }
    }
}