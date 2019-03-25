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
    public partial class Unit : System.Web.UI.Page
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
                 //   txtUnitName.Focus();
                   
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
        public void loadDataTable()
        {
            GridView1.DataSource = context.sp_SelectUnit(companyId,branchId);
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
        //private void savedcode()
        //{
        //    try
        //    {

        //        if (CheckDouble(txtUnitName.Text) == "false")
        //        {
        //            lblcheckDoubleError.Text = string.Empty;
        //            tbl_unit u = new tbl_unit();
        //            u.branch_id = branchId;
        //            u.company_id = companyId;
        //            u.unit_name = txtUnitName.Text;
        //            u.created_by = User_id;
        //            u.created_date = DateTime.Today;
        //            u.modified_by = "";
        //            u.modified_date = null;
        //            u.status = true;
        //            ////Shakeeb
        //            ////u.AddUnit(u);
        //            //Entity Framework Saving Awais
        //            context.tbl_unit.Add(u);
        //            context.SaveChanges();
        //            loadDataTable();
        //            divalert.Visible = true;
        //            lblAlert.Text = "Unit Saved Successfully ";
        //            txtUnitName.Text = string.Empty;

        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.Text = "This unit name already Exists";
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            return;
        //        }

        //    }
        //    catch (Exception ex)
        //    {

        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }
        //}
        //private void updatecode()
        //{
        //    try
        //    {
        //        if (hd.Value != "true")
        //        {
        //            lblcheckDoubleError.Text = string.Empty;
        //            GridViewRow row = GridView1.SelectedRow;
        //            int unit_id = Convert.ToInt32(ViewState["unit_id"]);
        //            //decimal TaxPercent = decimal.Parse(txtTaxPercent.Text);
        //            context.sp_UpdateUnit(companyId, branchId, unit_id, txtUnitName.Text, User_id, DateTime.Today);
        //            btnUpdate.Visible = false;
        //            btnSave.Visible = true;
        //            txtUnitName.Text = "";
        //            loadDataTable();
        //            divalert.Visible = true;
        //            lblAlert.Text = "Unit Updated Successfully";
        //            txtUnitName.Text = string.Empty;
        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            lblcheckDoubleError.Text = "This unit name already Exists";
        //            return;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }
        //}
        #endregion
        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        //protected void btnSave_Click(object sender, EventArgs e)
        //{
        //   // savedcode();
        //}
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    GridViewRow row = GridView1.SelectedRow;
                    ViewState["unit_id"] = Convert.ToInt32(e.CommandArgument);
                    //divalert.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                    loadDataTable();
                }
                else if (e.CommandName == "UpdateRow")
                {
                    int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowIndex];
                   ViewState["unit_id"] = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);

                   ctrlunit.UnitID = GridView1.DataKeys[row.RowIndex].Value.ToString();
                   ctrlunit.Unit = row.Cells[0].Text;
                    //txtUnitName.Text = row.Cells[0].Text;
                    //btnSave.Visible = false;
                    //btnUpdate.Visible = true;
                    //divalert.Visible = false;
                    //lblcheckDoubleError.Text = string.Empty;
                    //txtUnitName.Focus();
                    //hd.Value = string.Empty;
                }

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }
        //protected void btnUpdate_Click(object sender, EventArgs e)
        //{
        //    updatecode();
        //}
        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int unit_ID = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteUnit(companyId, branchId, unit_ID);
                loadDataTable();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }

        //protected void btnCancel_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        //lblcheckDoubleError.Text = string.Empty;
        //        //btnSave.Visible = true;
        //        //btnUpdate.Visible = false;
        //        //divalert.Visible = false;
        //        //txtUnitName.Text = string.Empty;
        //        ViewState["gridrow"] = null;
        //      //  hd.Value = string.Empty;
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLog.saveerror(ex);
        //    }
        //}

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