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
    public partial class UC_Batch : System.Web.UI.UserControl
    {
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        int companyId;
        int branchId;
        string User_id;
        #endregion


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
                    ((Batch)this.Page).loadDataTable();
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

        public void updatelogic()
        {
            try
            {
                if (hd.Value != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;
                   // GridViewRow row = GridView1.SelectedRow;
                    int batch_id = 0;
                    context.sp_Updatebatch(companyId, batch_id, branchId, txtBatchName.Text, User_id, DateTime.Today);
                    divalert.Visible = true;
                    lblAlert.Text = "Updated Successfully";
                    txtBatchName.Text = string.Empty;
                    ((Batch)this.Page).loadDataTable();
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Batch name already Exists";

                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SessionValue();
               
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void btnbtchSave_Click(object sender, EventArgs e)
        {
            savedlogic();
        }

        protected void btnbtchUpdate_Click(object sender, EventArgs e)
        {
            updatelogic();
        }
    }
}