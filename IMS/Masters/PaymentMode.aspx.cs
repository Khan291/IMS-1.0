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
    public partial class PaymentMode : System.Web.UI.Page
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
                User_id = Convert.ToString(Session["UserID"]);
                companyId = Convert.ToInt32(Session["company_id"]);
                branchId = Convert.ToInt32(Session["branch_id"]);
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
            grvlist.DataSource = context.sp_SelectPM(companyId,branchId); ;
            grvlist.DataBind();
        }
        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_paymentmode", "paymentmode_name", useroremail);
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
        public void savedcode()
        {
            try
            {
                tbl_paymentmode paymentmode = new tbl_paymentmode();
                paymentmode.branch_id = companyId;
                paymentmode.company_id = branchId;
                paymentmode.paymentmode_name = txtName.Text;
                paymentmode.created_by = User_id;
                paymentmode.created_date = DateTime.Today;
                paymentmode.modified_by = "";
                paymentmode.modified_date = null;
                paymentmode.status = true;
                ////Shakeeb
                ////pad.Insert(pad);
                //Entity Framework Saving Awais
                context.tbl_paymentmode.Add(paymentmode);
                context.SaveChanges();
                loadDataTable();

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

       
        protected void grvlist_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = grvlist.SelectedRow;
                int rack_id = Convert.ToInt32(grvlist.DataKeys[row.RowIndex].Value);
                //int taxId = GridView1.SelectedIndex;

                txtName.Text = row.Cells[0].Text;
                //ddlGodownName.SelectedValue = row.Cells[2].Text;
                btnSave.Visible = false;
                btnUpdate.Visible = true;

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

       

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = grvlist.SelectedRow;
                int paymentode_id = Convert.ToInt32(grvlist.DataKeys[row.RowIndex].Value);
                
                //decimal TaxPercent = decimal.Parse(txtTaxPercent.Text);
                context.sp_UpdatePMode(companyId,branchId, paymentode_id,txtName.Text, User_id, DateTime.Today);
                btnUpdate.Visible = false;
                btnSave.Visible = true;

                loadDataTable();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        

        
        protected void grvlist_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    int rowIndex = Convert.ToInt32(e.CommandArgument);
                    context.sp_DeletePMode(companyId, branchId, rowIndex);
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
                btnSave.Visible = true;
                btnUpdate.Visible = false;
                ViewState["gridrow"] = null;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
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