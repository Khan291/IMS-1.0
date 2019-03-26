using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.UserControl
{
    public partial class UC_Unit : System.Web.UI.UserControl
    {
        #region properties
        // declaration of properties for taking category name and ID from category.aspx for update functionality
        public string UnitID
        {
            set { hdunitid.Value = value; }
        }
        public string Unit
        {

            get { return txtUnitName.Text; }

            set
            {
                txtUnitName.Text = value;
                if (txtUnitName.Text != "")
                {
                    btnunitUpdate.Visible = true;
                    btnunitsave.Visible = false;
                }
                else
                {
                    btnunitsave.Visible = true;
                    btnunitUpdate.Visible = false;
                }
            }

        }
        #endregion

        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        int companyId;
        int branchId;
        string User_id;
        #endregion

        #region methods
        private void SessionValue()
        {
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }

        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_unit", "unit_name", useroremail);
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

        private void savedcode()
        {
            try
            {

                if (CheckDouble(txtUnitName.Text) == "false")
                {
                    lblcheckDoubleError.Text = string.Empty;
                    tbl_unit u = new tbl_unit();
                    u.branch_id = branchId;
                    u.company_id = companyId;
                    u.unit_name = txtUnitName.Text;
                    u.created_by = User_id;
                    u.created_date = DateTime.Today;
                    u.modified_by = "";
                    u.modified_date = null;
                    u.status = true;
                    ////Shakeeb
                    ////u.AddUnit(u);
                    //Entity Framework Saving Awais
                    context.tbl_unit.Add(u);
                    context.SaveChanges();
                    divalert.Visible = true;
                    lblAlert.Text = "Unit Saved Successfully ";
                    txtUnitName.Text = string.Empty;
                    ((Unit)this.Page).loadDataTable();
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.Text = "This unit name already Exists";
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    return;
                }

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        private void updatecode()
        {
            try
            {
                if (hd.Value != "true")
                {
                    lblcheckDoubleError.Text = string.Empty;
                 //   GridViewRow row = GridView1.SelectedRow;
                    int unit_id = Convert.ToInt32(hdunitid.Value);
                    //decimal TaxPercent = decimal.Parse(txtTaxPercent.Text);
                    context.sp_UpdateUnit(companyId, branchId, unit_id, txtUnitName.Text, User_id, DateTime.Today);
                    btnunitUpdate.Visible = false;
                    btnunitsave.Visible = true;
                    txtUnitName.Text = "";
                    divalert.Visible = true;
                    lblAlert.Text = "Unit Updated Successfully";
                    txtUnitName.Text = string.Empty;
                    ((Unit)this.Page).loadDataTable();
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This unit name already Exists";
                    return;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        #endregion

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            //-- Create your controls here
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SessionValue();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnunitsave_Click(object sender, EventArgs e)
        {
            savedcode();
        }

        protected void btnunitUpdate_Click(object sender, EventArgs e)
        {
            updatecode();
        }

      


    }
}