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

namespace IMS.Masters
{
    public partial class CategoryMasterModal : System.Web.UI.Page
    {
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        static int companyId = 0;
        static int branchId = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                companyId = Convert.ToInt32(HttpContext.Current.Session["company_id"]);
                branchId = Convert.ToInt32(HttpContext.Current.Session["branch_id"]);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        #region Methods

        [System.Web.Services.WebMethod]
        public static bool CheckDouble(string categoryName)
        {
            try
            {
                if (companyId != 0)
                {
                    SqlHelper helper = new SqlHelper();
                    // DataTable data = helper.CheckDoubleValues(companyId, branchId, "tbl_category", "category_name", useroremail);
                    IMS_TESTEntities context = new IMS_TESTEntities();
                    var data = context.tbl_category.Any(w => w.category_name == categoryName);
                    if (data)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return true;
        }

        public void Save()
        {
            try
            {

                if (CheckDouble(txtCategoryName.Text) == false)
                {
                    tbl_category cat = new tbl_category();
                    cat.branch_id = branchId;
                    cat.company_id = companyId;
                    cat.category_name = txtCategoryName.Text;
                    cat.created_by = Convert.ToString(Session["UserID"]);
                    cat.created_date = DateTime.Today;
                    cat.modified_by = "";
                    cat.modified_date = null;
                    cat.status = true;
                    context.tbl_category.Add(cat);
                    context.SaveChanges();
                    txtCategoryName.Text = string.Empty;
                    divalert.Visible = true;
                    lblAlert.Text = "Category Saved";
                    lblcheckDoubleError.Text = string.Empty;
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.Text = "Category Already Exists.";
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

        #region Events
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }       
        
        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowindex = Convert.ToInt32(ViewState["rowIndex"]);
                context.sp_DeleteCategory(companyId, rowindex, branchId);
                divalert.Visible = true;
                lblAlert.Text = "Category Deleted ";
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }

        #endregion

    }
}