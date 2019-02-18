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
    public partial class UnitMasterModel : System.Web.UI.Page
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

                    txtUnitName.Focus();

                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods

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

        #endregion
        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnSave_Click(object sender, EventArgs e)
        {
            savedcode();
        }


        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int unit_ID = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteUnit(companyId, branchId, unit_ID);

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                lblcheckDoubleError.Text = string.Empty;
                btnSave.Visible = true;
                divalert.Visible = false;
                txtUnitName.Text = string.Empty;
                ViewState["gridrow"] = null;
                hd.Value = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        #endregion
    }
}