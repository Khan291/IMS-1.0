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
    public partial class Batch : System.Web.UI.Page
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
                  //  txtBatchName.Focus();
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
            //List<tbl_batch> dt = context.tbl_batch.Where(x => x.status == true).ToList();

            GridView1.DataSource = context.sp_SelectBatch(companyId,branchId); 
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
        //public void savedlogic()
        //{
        //    try
        //    {
        //        if (CheckDouble(txtBatchName.Text) == "false")
        //        {
        //            lblcheckDoubleError.Text = String.Empty;
        //            tbl_batch bat = new tbl_batch();
        //            bat.branch_id = branchId;//Convert.ToInt32(Session["branch_id"]); 
        //            bat.company_id = companyId;//Convert.ToInt32(Session["company_id"]);
        //            bat.batch_name = txtBatchName.Text;
        //            bat.created_by = User_id; //Convert.ToString(Session["UserID"]);
        //            bat.created_date = DateTime.Today;
        //            bat.modified_by = "";
        //            bat.modified_date = null;
        //            bat.status = true;                                    
        //            context.tbl_batch.Add(bat);
        //            context.SaveChanges();

        //            loadDataTable();
        //            divalert.Visible = true;
        //            lblAlert.Text = "Saved Successfully";
        //            txtBatchName.Text = string.Empty;
        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            lblcheckDoubleError.Text = "This Batch name already Exists";
        //            return;
        //        }

        //    }
        //    catch (Exception ex)
        //    {

        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }

        //}

        //public void updatelogic()
        //{
        //    try
        //    {
        //        if (hd.Value != "true")
        //        {
        //            lblcheckDoubleError.Text = String.Empty;
        //            GridViewRow row = GridView1.SelectedRow;
        //            int batch_id = Convert.ToInt32(ViewState["batchid"].ToString());
        //            context.sp_Updatebatch(companyId, batch_id, branchId, txtBatchName.Text, User_id, DateTime.Today);
        //            btnUpdate.Visible = false;
        //            btnSave.Visible = true;
        //            loadDataTable();
        //            divalert.Visible = true;
        //            lblAlert.Text = "Updated Successfully";
        //            txtBatchName.Text = string.Empty;
        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            lblcheckDoubleError.Text = "This Batch name already Exists";

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
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                
            }
            catch
            {

            }
        }

       
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    ViewState["rowIndex"] = Convert.ToInt32(e.CommandArgument); 
                  //  divalert.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                }
                else if (e.CommandName == "UpdateRow")
                {
                    int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowIndex];
                    ViewState["batchid"] = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    //if (row.Cells[0].Text.ToString().Contains("&#215;"))
                    //{
                    //  //  txtBatchName.Text = row.Cells[0].Text.ToString().Replace("&#215;","X");
                    //}
                    //else
                    //{
                    //    txtBatchName.Text = row.Cells[0].Text.ToString();
                    //}

                    //btnSave.Visible = false;
                    //btnUpdate.Visible = true;
                    loadDataTable();
                   // divalert.Visible = false;
                   // hd.Value = string.Empty;
                }
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
        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowindex = Convert.ToInt32(ViewState["rowIndex"]);

                context.sp_Deletebatch(companyId, rowindex, branchId);
                loadDataTable();

                //divalert.Visible = true;
                //lblAlert.Text = "Deleted Successfully";
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
                //lblcheckDoubleError.Text = String.Empty;
                //btnSave.Visible = true;
                //btnUpdate.Visible = false;
                //divalert.Visible = false;
                //txtBatchName.Text = string.Empty;
                //ViewState["gridrow"] = null;
                //hd.Value = string.Empty;
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