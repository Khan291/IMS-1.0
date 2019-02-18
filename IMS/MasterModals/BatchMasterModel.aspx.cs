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

namespace IMS.Masters
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
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
                    txtBatchName.Focus();
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
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_batch", "batch_name", useroremail);
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
        public void savedlogic()
        {
            try
            {
                if (CheckDouble(txtBatchName.Text) == "false")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    tbl_batch bat = new tbl_batch();
                    bat.branch_id = branchId;//Convert.ToInt32(Session["branch_id"]); 
                    bat.company_id = companyId;//Convert.ToInt32(Session["company_id"]);
                    bat.batch_name = txtBatchName.Text;
                    bat.created_by = User_id; //Convert.ToString(Session["UserID"]);
                    bat.created_date = DateTime.Today;
                    bat.modified_by = "";
                    bat.modified_date = null;
                    bat.status = true;
                    context.tbl_batch.Add(bat);
                    context.SaveChanges();

                    divalert.Visible = true;
                    lblAlert.Text = "Saved Successfully";
                    txtBatchName.Text = string.Empty;
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Batch name already Exists";
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
        protected void btnSave_Click(object sender, EventArgs e)
        {
            savedlogic();
        }

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

            }
            catch
            {

            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowindex = Convert.ToInt32(ViewState["rowIndex"]);

                context.sp_Deletebatch(companyId, rowindex, branchId);
                divalert.Visible = true;
                lblAlert.Text = "Deleted Successfully";
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
                lblcheckDoubleError.Text = String.Empty;
                btnSave.Visible = true;
                divalert.Visible = false;
                txtBatchName.Text = string.Empty;
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