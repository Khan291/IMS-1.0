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
namespace IMS
{
    public partial class Category : System.Web.UI.Page
    {    /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object     
        IMS_TESTEntities context = new IMS_TESTEntities();

        static int companyId = 0;
        static int branchId = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["company_id"] == null || Session["branch_id"] == null  )
                {
                    Response.Redirect("~/Registration/Login.aspx");
                    
                }
                companyId = Convert.ToInt32(HttpContext.Current.Session["company_id"]);
                branchId = Convert.ToInt32(HttpContext.Current.Session["branch_id"]);
                if (!IsPostBack)
                {
                    loadDataTable();
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
        private void loadDataTable()
        {
            List<tbl_category> dt = context.tbl_category.Where(x => x.status == true && x.company_id== companyId && x.branch_id== branchId).ToList();

            GridView1.DataSource = dt;// context.sp_SelectCategory(c_id, b_id);
            GridView1.DataBind();
        }

        [System.Web.Services.WebMethod]
        public static bool CheckDouble(string categoryName)
        {
            try
            {
                if (companyId!= 0)
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
            catch(Exception ex)
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
                    loadDataTable();
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

        public void Update()
        {
            try
            {
                if (hd.Value != "true")
                {
                    lblcheckDoubleError.Text = string.Empty;
                    GridViewRow row = GridView1.SelectedRow;
                    int category_id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    //context.sp_UpdateCategory(c_id, category_id, b_id, txtCategoryName.Text, "admin", DateTime.Today);
                    context.sp_UpdateCategory(companyId, category_id, txtCategoryName.Text, Convert.ToString(Session["UserID"]), DateTime.Today);
                    btnUpdate.Visible = false;
                    btnSave.Visible = true;
                    ViewState["gridrow"] = null;
                    loadDataTable();
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


        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                lblcheckDoubleError.Text = string.Empty;
                GridViewRow row = GridView1.SelectedRow;
                int category_id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                //int taxId = GridView1.SelectedIndex;      
                txtCategoryName.Text = row.Cells[0].Text;
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                ViewState["gridrow"] = true;
                txtCategoryName.Focus();
                hd.Value = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.UseAccessibleHeader = false;
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                GridView1.FooterRow.TableSection = TableRowSection.TableFooter;
                int CellCount = GridView1.FooterRow.Cells.Count;
                GridView1.FooterRow.Cells.Clear();
                GridView1.FooterRow.Cells.Add(new TableCell());
                GridView1.FooterRow.Cells[0].ColumnSpan = CellCount - 1;
                GridView1.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                GridView1.FooterRow.Cells.Add(new TableCell());

                TableFooterRow tfr = new TableFooterRow();
                for (int i = 0; i < CellCount; i++)
                {
                    tfr.Cells.Add(new TableCell());
                }
                GridView1.FooterRow.Controls[1].Controls.Add(tfr);
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Update();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                divalert.Visible = false;
                if (e.CommandName == "DeleteRow")
                {
                    if (ViewState["gridrow"] == null)
                    {
                        ViewState["rowIndex"] = Convert.ToInt32(e.CommandArgument);
                        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                        loadDataTable();
                    }
                    else
                    {
                        divalert.Visible = true;
                        lblAlert.Text = "While update you can't delete row";
                    }
                }
            }

             catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowindex = Convert.ToInt32(ViewState["rowIndex"]);
                context.sp_DeleteCategory(companyId, rowindex, branchId);
                loadDataTable();

                divalert.Visible = true;
                lblAlert.Text = "Category Deleted ";
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
            
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            //check if the row is the header row
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //add the thead and tbody section programatically
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        #endregion
    }
}