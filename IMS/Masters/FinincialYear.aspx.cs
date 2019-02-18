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
    public partial class FinincialYear : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        int companyId;
        int branchId;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                companyId = Convert.ToInt32(Session["company_id"]);
                branchId = Convert.ToInt32(Session["branch_id"]); 
                if (!IsPostBack)
                {

                    
                    //loadDataTable();
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
            GridView1.DataSource = context.sp_SelectFY(companyId,branchId); ;
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
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_financialyear", "start_date", useroremail);
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
        [System.Web.Services.WebMethod]
        public static string CheckDouble1(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_financialyear", "end_date", useroremail);
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
                if (hd.Value == "false" && hd12.Value == "false")
                {
                string User_id = Convert.ToString(Session["UserID"]);
                tbl_financialyear financialyear = new tbl_financialyear();


                financialyear.branch_id = branchId;
                financialyear.company_id = companyId;
                financialyear.start_date = txtStartdate.Text;
                financialyear.end_date = txtEndDate.Text;
                //cat.created_by = "admin";
                financialyear.created_by = User_id;
                financialyear.created_date = DateTime.Today;
                ////Shakeeb
                ////cat.Insert(cat);
                context.tbl_financialyear.Add(financialyear);
                context.SaveChanges();
                //loadDataTable();

                divalert.Visible = true;
                lblAlert.Text = "Financial year Saved Successfully ";
                }
                else
                {
                    divalert.Visible = true;
                    lblAlert.ForeColor = System.Drawing.Color.Red;
                    lblAlert.Text = "Please Choose Another Date";
                }

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        public void updataelogic()
        {
            try
            {
                string User_id = Convert.ToString(Session["UserID"]);
                GridViewRow row = GridView1.SelectedRow;
                int financialyear_id = Convert.ToInt32(ViewState["financialyear_id"]);
                context.sp_UpdateFyear(companyId, financialyear_id, branchId, txtStartdate.Text, txtEndDate.Text, User_id, DateTime.Today);
                btnUpdate.Visible = false;
                btnSave.Visible = true;

                loadDataTable();

                divalert.Visible = true;
                lblAlert.Text = "Financial year Updated Successfully";
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    ViewState["financialyear_id"] = Convert.ToInt32(e.CommandArgument);
                    divalert.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);

                    loadDataTable();
                }
                else if (e.CommandName == "UpdateRow")
                {
                    int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowIndex];

                    ViewState["financialyear_id"] = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    //int taxId = GridView1.SelectedIndex;

                    txtStartdate.Text = row.Cells[0].Text;
                    txtEndDate.Text = row.Cells[1].Text;
                    btnSave.Visible = false;
                    btnUpdate.Visible = true;
                    divalert.Visible = false;
                    loadDataTable();
                }
            }

               catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            updataelogic();
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(ViewState["financialyear_id"]);
                context.sp_DeleteFyear(companyId, branchId, rowIndex);

                divalert.Visible = true;
                lblAlert.Text = "Financial year Deleted Successfully ";
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
                btnSave.Visible = true;
                btnUpdate.Visible = false;
                divalert.Visible = false;
                
                ViewState["gridrow"] = null;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
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