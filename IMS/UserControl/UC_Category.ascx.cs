using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.UserControl
{
    public partial class UC_Category : System.Web.UI.UserControl
    {
      

        private string M_Category_id;

        #region properties
        // declaration of properties for taking category name and ID from category.aspx for update functionality
        public string CategoryID
        {
            set { hdcategoryid.Value = value; }
        }
        public string Category
        {

            get { return txtCategoryName.Text; }

            set {
                txtCategoryName.Text = value;
                if (txtCategoryName.Text != "")
                {
                    btnctgryUpdate.Visible = true;
                    btnctgrySave123.Visible = false;
                }
                else
                {
                    btnctgrySave123.Visible = true;
                    btnctgryUpdate.Visible = false;
                }
            }

        }
        #endregion

        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();

        static int companyId = 0;
        static int branchId = 0;
        #endregion

        #region events
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
               
                if (Session["company_id"] == null || Session["branch_id"] == null)
                {
                    Response.Redirect("~/Registration/Login.aspx");

                }
                companyId = Convert.ToInt32(HttpContext.Current.Session["company_id"]);
                branchId = Convert.ToInt32(HttpContext.Current.Session["branch_id"]);

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
            }
        }
      
      
        #endregion

        #region methods
        [System.Web.Services.WebMethod]
        public static bool CheckDouble_category(string categoryName)
        {
            try
            {
                if (companyId != 0)
                {
                    SqlHelper helper = new SqlHelper();
                    // DataTable data = helper.CheckDoubleValues(companyId, branchId, "tbl_category", "category_name", useroremail);
                    IMS_TESTEntities context = new IMS_TESTEntities();
                    var data = context.tbl_category.Any(w => w.category_name == categoryName && w.company_id == companyId);
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

                if (CheckDouble_category(txtCategoryName.Text) == false)
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
                    // loadDataTable();
                    txtCategoryName.Text = string.Empty;
                    divalert.Visible = true;
                    lblAlert.Text = "Category Saved";
                    lblcheckDoubleError.Text = string.Empty;
                    ((Category)this.Page).loadDataTable();
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

        public void Update()
        {
            try
            {
                if (hd.Value != "true")
                {
                    lblcheckDoubleError.Text = string.Empty;
                    //GridViewRow row = GridView1.SelectedRow;
                    int category_id = Convert.ToInt32(hdcategoryid.Value);
                    //context.sp_UpdateCategory(c_id, category_id, b_id, txtCategoryName.Text, "admin", DateTime.Today);
                    context.sp_UpdateCategory(companyId, category_id, txtCategoryName.Text, Convert.ToString(Session["UserID"]), DateTime.Today);
                    btnctgryUpdate.Visible = false;
                    btnctgrySave123.Visible = true;
                    ViewState["gridrow"] = null;
                    ((Category)this.Page).loadDataTable();
                    divalert.Visible = true;
                    lblAlert.Text = "Category Update Successfully.";
                    txtCategoryName.Text = string.Empty;

                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "Category Name Already Exists.";
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

       

        protected void btnctgryUpdate_Click(object sender, EventArgs e)
        {
            Update();
        }

        protected void btnctgrySave123_Click(object sender, EventArgs e)
        {
            Save();
        }

      
    }
}