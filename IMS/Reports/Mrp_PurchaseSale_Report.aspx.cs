using IMSBLL.EntityModel;
using System;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IMS.Helpers;

namespace IMS.Reports
{
    public partial class Mrp_PurchaseSale_Report : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        string Connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string flag = "";
                if (Request.QueryString["flag"] != null)
                {
                    flag = Request.QueryString["flag"].ToString();
                    mrp_PurchaseSale(flag);
                }
                //string strQuery = "[sp_mrpSalePurchase]";
                //SqlDataAdapter da = new SqlDataAdapter(strQuery, con);
                //DataTable dt = new DataTable();
                //da.Fill(dt);
                //RDLC ds = new RDLC();
                //ds.Tables[""].Merge(dt);




            }

        }

        private void mrp_PurchaseSale(string flag)
        {
            SqlParameter[] sqlParams;
            ReportParameter reportParam;
            try
            {
                int companyId = Convert.ToInt32(Session["company_id"]);
                var logo = context.tbl_company.Where(w => w.company_id == companyId).Select(s => s.logo).SingleOrDefault();
                string logoPath = new Uri(Server.MapPath(logo)).AbsoluteUri;

                try
                {
                    int companyid = 0;
                    if (Session["company_id"] != null)
                    {
                        companyid = Convert.ToInt32(Session["company_id"]);
                    }
                    sqlParams = new SqlParameter[] {
                         new SqlParameter("@companyId", companyid),
                         new SqlParameter("@flag",flag)
                    };

                    string reportDataSet = "MostReturnDataSet";
                    string dataTable = "Mrp_PurchaseSale";
                    reportParam = new ReportParameter("LogoPath", logoPath);
                    ReportViewer1.LocalReport.SetParameters(reportParam);
                    //ReportViewer1.Width = 90;
                    CommonHelper.CreateReport(Connectionstring, "sp_mrpSalePurchase", sqlParams, ref ReportViewer1, reportDataSet, dataTable);
                    
                    ReportViewer1.LocalReport.Refresh();

                }
                catch (Exception ex)
                {
                    ErrorLog.saveerror(ex);
                }
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "mrpModal();", true);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
    }
}