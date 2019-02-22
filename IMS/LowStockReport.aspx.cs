using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IMSBLL.EntityModel;
using System.Data;

namespace IMS
{
    public partial class LowStockReport : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                GetLowstockproducts();
            }
        }
        private void GetLowstockproducts()
        {
            try
            {
                int companyid = 0;
                int branchid = 0;

                if (Session["company_id"] != null)
                {
                    companyid = Convert.ToInt32(Session["company_id"]);
                }
                if (Session["branch_id"] != null)
                {
                    Convert.ToInt32(Session["branch_id"]);
                }
                //context.sp_product_relorderlevel_report_forcompany_only
                if (Session["UserRoleSession"] != null)
                {
                    if (Session["UserRoleSession"].ToString() == "Manager")
                    {
                        var query = context.sp_product_relorderlevel_report_forcompany_only(companyid);

                        DataTable dt = new DataTable();
                        //dt = context.sp_product_relorderlevel_report_forcompany_only(companyid);
                        //GenerateLowstockGridonindexpage(dt);
                                                
                        gvLowSTockReport.DataSource = context.sp_product_relorderlevel_report_forcompany_only(companyid);
                        gvLowSTockReport.DataBind();
                    }
                    else
                    {
                        //var query = context.sp_product_relorderlevel_report_forcompany_only(companyid);

                        //DataTable dt = new DataTable();
                        //dt = sh.LINQToDataTable(query);
                        //GenerateLowstockGridonindexpage(dt);
                        gvLowSTockReport.DataSource = context.sp_product_relorderlevel_report_companybranch(companyid, branchid);
                        gvLowSTockReport.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}