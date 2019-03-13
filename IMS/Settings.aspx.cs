using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS
{
    public partial class Setting : System.Web.UI.Page
    {
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        static int companyId = 0;
        static int branchId = 0;
        #endregion
        #region method
        public void getcurrencysymbols()
        {
            try
            {
               var cd = context.tbl_currency.Select(s => new { currency_code =s.currency_code + "-" + s.currency_symbol,s.currency_id}).ToList();
               ddlCurrency.DataTextField = "currency_code";
                ddlCurrency.DataValueField = "currency_id";
                ddlCurrency.DataSource = cd;
                ddlCurrency.DataBind();
                ddlCurrency.Items.Insert(0, new ListItem("--Select Country--", "0"));
            }
            catch (Exception ex)
            {
                 ErrorLog.saveerror(ex);
            }
        }
        public void getalldetials()
        {
            try
            {
                var set = context.tbl_setting.Where(w => w.company_id == companyId).FirstOrDefault();
                ddlCurrency.SelectedValue = set.currency_id.ToString();
                if (set.Enable_Invoice_Tax==true)
                {
                    rbinvoicetax.Checked = true;
                }
                else
                {
                    rbproducttax.Checked = true;
                }
                
                chbprintaddress.Checked = Convert.ToBoolean(set.Print_address);
                chbPrintTin.Checked = Convert.ToBoolean(set.Print_Tin_on_Invoice);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        #endregion
        #region Event
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Convert.ToInt32(Session["mcid"]) == 1)
                    {
                        fydiv.Visible = true;
                    }
                    getcurrencysymbols();
                    getalldetials();
                    companyId = Convert.ToInt32(HttpContext.Current.Session["company_id"]);
                    branchId = Convert.ToInt32(HttpContext.Current.Session["branch_id"]);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                bool tax;
                if (rbinvoicetax.Checked)
                {
                    tax = true;
                }
                else
                {
                    tax = false;
                }
                var set = context.tbl_setting.Where(w => w.company_id == companyId).FirstOrDefault();
                // tbl_setting set = new tbl_setting();
                set.modify_by = Convert.ToString(Session["UserID"]);
                set.modifydate = DateTime.Today;
                set.Enable_Invoice_Tax = tax;
                set.Print_Tin_on_Invoice = Convert.ToBoolean(chbPrintTin.Checked);
                set.currency_id = Convert.ToInt32(ddlCurrency.SelectedValue);
                set.Decimal_Places = Convert.ToInt32(txtdecimalplaces.Text);
                set.Print_address = Convert.ToBoolean(chbprintaddress.Checked);
                context.SaveChanges();
                divalert.Visible = true;
                lblAlert.Text = "Setting Saved";
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        #endregion
    }
}