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

namespace IMS
{
    public partial class TaxMasterModel : System.Web.UI.Page
    {
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        int companyId;
        int branchId;
        string User_id;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SessionValue();
                if (!IsPostBack)
                {
                    txtTaxName.Focus();
                }
            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }

        #region Methods

        private void SessionValue()
        {
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }
        public void clr()
        {
            txtTaxName.Text = string.Empty;
            txtTaxPercent.Text = string.Empty;
            divalert.Visible = false;
        }
        private void savecode()
        {
            try
            {
                if (CheckDouble(txtTaxName.Text) != "true")
                {

                    lblcheckDoubleError.Text = String.Empty;
                    tbl_tax cat = new tbl_tax();
                    cat.branch_id = branchId;
                    cat.company_id = companyId;
                    cat.tax_name = txtTaxName.Text;
                    cat.tax_percentage = decimal.Parse(txtTaxPercent.Text);
                    cat.created_by = User_id;
                    cat.created_date = DateTime.Today;
                    cat.modified_by = "";
                    cat.modified_date = null;
                    cat.status = true;
                    ////Shakeeb
                    ////cat.Insert(cat);
                    //Entity Framework Saving Awais
                    context.tbl_tax.Add(cat);
                    context.SaveChanges();
                    clr();
                    divalert.Visible = true;
                    lblAlert.Text = "Tax Saved Successfully ";

                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Tax name already Exists";
                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        } [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_tax", "tax_name", useroremail);
                    if (data.Rows.Count > 0)
                    {
                        return "true";
                    }
                    else
                    {
                        return "false";
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return "true";
        }

        #endregion

    }
}