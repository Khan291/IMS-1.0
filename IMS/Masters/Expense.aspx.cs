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
    public partial class Expense : System.Web.UI.Page
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
                   
                    loadDataTable();
                    txtExpenseName.Focus();
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
        private void loadDataTable()
        {
            GridView1.DataSource = context.sp_SelectExpense(companyId,branchId); 
            GridView1.DataBind();
        }
        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_expense", "expense_name", useroremail);
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

        private string CheckDoubleFromDb(string ValueToCheck)
        {
            return "";
        }

        private void savedlogic()
        {
            try
            {
                if (CheckDouble(txtExpenseName.Text) != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    tbl_expense et = new tbl_expense();
                    et.company_id = companyId;
                    et.branch_id = branchId;
                    et.expense_name = txtExpenseName.Text;
                    et.created_by = User_id;
                    et.created_date = DateTime.Today;
                    et.status = true;
                    et.modified_by = "";
                    et.modified_date = null;
                    context.tbl_expense.Add(et);
                    context.SaveChanges();

                    loadDataTable();
                    divalert.Visible = true;
                    lblAlert.Text = "Expense Saved Successfully ";
                    txtExpenseName.Text = string.Empty;
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "Expense Name is already exists ";
                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        private void updatelogic()
        {
            try
            {
                if (hde.Value != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    int expense_id = Convert.ToInt32(ViewState["expense_id"]);
                    context.sp_UpdateExpense(companyId, branchId, expense_id, txtExpenseName.Text, User_id, DateTime.Today);
                    btnUpdate.Visible = false;
                    btnSave.Visible = true;
                    txtExpenseName.Text = string.Empty;
                    divalert.Visible = true;
                    lblAlert.Text = "Expense Updated Successfully ";
                    loadDataTable();
                }

                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "Expense Name is already exists ";
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
            savedlogic();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

            GridViewRow row = GridView1.SelectedRow;
            ViewState["expense_id"] = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
            txtExpenseName.Text = row.Cells[0].Text;
            divalert.Visible = false;
            btnUpdate.Visible = true;
            btnSave.Visible = false;
            txtExpenseName.Focus();
            hde.Value = string.Empty;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            updatelogic();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    ViewState["unit_id"] = Convert.ToInt32(e.CommandArgument);
                    divalert.Visible = false;
                   
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                    
                    loadDataTable();
                }
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
                btnUpdate.Visible = false;
                divalert.Visible = false;
                txtExpenseName.Text = string.Empty;
                ViewState["gridrow"] = null;
                hde.Value = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteExpense(companyId, branchId, rowIndex);
               
                divalert.Visible = true;
                lblAlert.Text = "Expense Deleted Successfully ";
                loadDataTable();
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