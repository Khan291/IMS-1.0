﻿using System;
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
    public partial class Godown : System.Web.UI.Page
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
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]); 
            if (!IsPostBack)
            {
               
                loadDataTable();
             //   txtGodownName.Focus();
            }
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        public void loadDataTable()
        {
            GridView1.DataSource = context.sp_Selectgodown(companyId,branchId);
            GridView1.DataBind();
        }

        //public void clr()
        //{

        //    txtContactNo.Text = string.Empty;
        //    txtContactPerson.Text = string.Empty;
        //    txtGodownAddress.Text = string.Empty;
        //    txtGodownName.Text = string.Empty;
        //}
        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_godown", "godown_name", useroremail);
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
        //private void savedlogic()
        //{
        //    string User_id = Convert.ToString(Session["UserID"]);
        //    try
        //    {
        //        if (CheckDouble(txtGodownName.Text) == "false")
        //        {
        //            lblcheckDoubleError.Text = String.Empty;
        //            tbl_godown g = new tbl_godown();
        //            g.company_id = companyId;
        //            g.branch_id = branchId;
        //            g.godown_name = txtGodownName.Text;
        //            g.godown_address = txtGodownAddress.Text;
        //            g.contact_no = txtContactNo.Text;
        //            g.contact_person = txtContactPerson.Text;
        //            //g.created_by = "admin";
        //            g.created_by = User_id;
        //            g.created_date = DateTime.Today;
        //            g.status = true;
        //            g.modified_by = "";
        //            g.modified_date = null;
        //            ////Shakeeb
        //            ////g.AddGodown(g);
        //            //Entity Framework Saving Awais
        //            context.tbl_godown.Add(g);
        //            context.SaveChanges();
        //            clr();
        //            loadDataTable();
        //            divalert.Visible = true;
        //            lblAlert.Text = "Godown Saved Successfully";
        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            lblcheckDoubleError.Text = "This Godown name already Exists";
        //            return;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }
        //}

        //private void updatelogic()
        //{
        //    try
        //    {
        //        if (hd.Value != "true")
        //        {
        //            lblcheckDoubleError.Text = String.Empty;
        //            int godown_id = Convert.ToInt32(ViewState["godown_id"]);
        //            context.sp_UpdateGodown(companyId, branchId, godown_id, txtGodownName.Text, txtGodownAddress.Text, txtContactNo.Text, txtContactPerson.Text, Convert.ToString(Session["UserID"]), DateTime.Today);
        //            btnUpdate.Visible = false;
        //            btnSave.Visible = true;
        //            clr();
        //            divalert.Visible = true;
        //            lblAlert.Text = "Godown Updated Successfully";
        //            loadDataTable();
        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            lblcheckDoubleError.Text = "This Godown name already Exists";
        //            return;
        //        }
        //    }
        //     catch (Exception ex)
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
        protected void btnSave_Click(object sender, EventArgs e)
        {
            //savedlogic();
        }

      
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateRow")
            {
                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowIndex];
                ViewState["godown_id"] = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                ctrlgodown.godownID = GridView1.DataKeys[row.RowIndex].Value.ToString();
                ctrlgodown.godownname = row.Cells[0].Text;
                ctrlgodown.godownaddress = row.Cells[1].Text;
                ctrlgodown.contactno = row.Cells[2].Text;
                ctrlgodown.contactperson = row.Cells[3].Text;
                
                //btnSave.Visible = false;
                //btnUpdate.Visible = true;
                //divalert.Visible = false;
                loadDataTable();
                //lblcheckDoubleError.Text = String.Empty;
                //txtGodownName.Focus();
                //hd.Value = string.Empty;
            }

            else if (e.CommandName == "DeleteRow")
            {
                GridViewRow row = GridView1.SelectedRow;
                ViewState["unit_id"] = Convert.ToInt32(e.CommandArgument);
               // divalert.Visible = false;
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                loadDataTable();
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
                //lblcheckDoubleError.Text = String.Empty;
                //clr();
                ViewState["gridrow"] = null;
              //  hd.Value = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

      

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
          //  updatelogic();
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int godown_id = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteGodown(companyId, branchId, godown_id);
                //divalert.Visible = true;
                //lblAlert.Text = "Godown Deleted ";
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