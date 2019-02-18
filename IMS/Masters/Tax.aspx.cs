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
    public partial class Tax : System.Web.UI.Page
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
                    txtTaxName.Focus();
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
            GridView1.DataSource = context.sp_SelectTax(companyId,branchId); 
            GridView1.DataBind();

        }
        public void clr()
        {
            txtTaxName.Text = string.Empty;
            txtTaxPercent.Text = string.Empty;
            divalert.Visible = false;
        }
        private void savecode()
        {
            try
            {
                if (CheckDouble(txtTaxName.Text) != "true")
                {

                    lblcheckDoubleError.Text = String.Empty;
                    tbl_tax cat = new tbl_tax();
                    cat.branch_id = branchId;
                    cat.company_id = companyId;
                    cat.tax_name = txtTaxName.Text;
                    cat.tax_percentage = decimal.Parse(txtTaxPercent.Text);
                    cat.created_by = User_id;
                    cat.created_date = DateTime.Today;
                    cat.modified_by = "";
                    cat.modified_date = null;
                    cat.status = true;
                    ////Shakeeb
                    ////cat.Insert(cat);
                    //Entity Framework Saving Awais
                    context.tbl_tax.Add(cat);
                    context.SaveChanges();
                    loadDataTable();
                    clr();
                    divalert.Visible = true;
                    lblAlert.Text = "Tax Saved Successfully ";

                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Tax name already Exists";
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

                    lblcheckDoubleError.Text = String.Empty;
                    GridViewRow row = GridView1.SelectedRow;
                    int tax_id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    decimal TaxPercent = decimal.Parse(txtTaxPercent.Text);
                    context.sp_UpdateTax(companyId, branchId, tax_id, txtTaxName.Text, TaxPercent, User_id, DateTime.Today);
                    btnUpdate.Visible = false;
                    btnSave.Visible = true;
                    clr();
                    loadDataTable();
                    divalert.Visible = true;
                    lblAlert.Text = "Tax Updated Successfully ";

                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Tax name already Exists";
                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_tax", "tax_name", useroremail);
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

        #endregion
        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnSave_Click(object sender, EventArgs e)
        {
            savecode();
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                divalert.Visible = false;
                lblcheckDoubleError.Text = String.Empty;
                GridViewRow row = GridView1.SelectedRow;
                int tax_id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                //int taxId = GridView1.SelectedIndex;
              
                txtTaxName.Text = row.Cells[0].Text;
                txtTaxPercent.Text = row.Cells[1].Text;
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                txtTaxName.Focus();
                hd.Value = string.Empty;
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            updatecode();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow")
            {
                ViewState["unit_id"] = Convert.ToInt32(e.CommandArgument);
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);

                loadDataTable();
            }
        }
        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteTax(companyId, branchId, rowIndex);
                clr();
                divalert.Visible = true;
                lblAlert.Text = "Tax Deleted Successfully ";
                loadDataTable();
               
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
                clr();
                ViewState["gridrow"] = null;
                hd.Value = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clr();
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