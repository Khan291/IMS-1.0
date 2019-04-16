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
    public partial class Rack : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
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
                    PageLoad();
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

        private void PageLoad()
        {
            loadDataTable();
            //txtRackName.Focus();
        }
        private void SessionValue()
        {
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }


        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail, string g_id)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.checkrackingodwon(useroremail, Convert.ToInt32(g_id), Convert.ToInt32(HttpContext.Current.Session["company_id"]));
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
        //public void ddlgodownbind()
        //{
        //    List<tbl_godown> gd = context.tbl_godown.Where(x => x.status == true && x.company_id == companyId).ToList();

        //    ddlGodownName.DataTextField = "godown_name";
        //    ddlGodownName.DataValueField = "godown_id";
        //    ddlGodownName.DataSource = gd;
        //    ddlGodownName.DataBind();
        //    ddlGodownName.Items.Insert(0, new ListItem("--Select Godown--", "0"));
        //}
        public void loadDataTable()
        {

            //SqlCommand cmd = new SqlCommand();
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.CommandText = "sp_SelectRack";
            //cmd.Parameters.AddWithValue("@company_id", c_id);
            //cmd.Parameters.AddWithValue("@branch_id", b_id);
            //cmd.Connection = con;
            try
            {

                //con.Open();
                //DataSet ds = new DataSet();
                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //da.Fill(ds);
                GridView1.DataSource = context.sp_SelectRack(companyId, branchId); //ds.Tables[0];
                GridView1.DataBind();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
            finally
            {
                //con.Close();
                //con.Dispose();
            }
        }

        //private void savecode()
        //{
        //    try
        //    {
        //        if (hd.Value != "true")
        //        {

        //            lblcheckDoubleError.Text = String.Empty;
        //            tbl_rack rack = new tbl_rack();
        //            rack.company_id = companyId;
        //            rack.branch_id = branchId;
        //            rack.godown_id = Int32.Parse(ddlGodownName.SelectedValue);
        //            rack.rack_name = txtRackName.Text;
        //            rack.created_by = User_id;
        //            rack.created_date = DateTime.Today;
        //            rack.status = true;
        //            rack.modified_by = "";
        //            rack.modified_date = null;
        //            ////Shakeeb
        //            ////rd.Insert(rd);
        //            //Entity Framework Saving Awais
        //            context.tbl_rack.Add(rack);
        //            context.SaveChanges();

        //            loadDataTable();
        //            divalert.Visible = true;
        //            lblAlert.Text = "Rack Saved Successfully";
        //            clr();


        //            //lblError.Text = string.Empty;
        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            lblcheckDoubleError.Text = "This Rack name already Exists";
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
        //            lblcheckDoubleError.Text = String.Empty;
        //            GridViewRow row = GridView1.SelectedRow;
        //            int rack_id = Convert.ToInt32(row.Cells[3].Text);
        //            int godown_id = Int32.Parse(ddlGodownName.SelectedValue);
        //            //decimal TaxPercent = decimal.Parse(txtTaxPercent.Text);
        //            context.sp_UpdateRack(companyId, branchId, rack_id, godown_id, txtRackName.Text, User_id, DateTime.Today);
        //            btnUpdate.Visible = false;
        //            btnSave.Visible = true;
        //            divalert.Visible = true;
        //            lblAlert.Text = "Rack Updated Successfully";
        //            ViewState["gridrow"] = 0;
        //            loadDataTable();
        //            clr();
        //        }
        //        else
        //        {
        //            divalert.Visible = false;
        //            lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
        //            lblcheckDoubleError.Text = "This Rack name already Exists";
        //            return;
        //        }
        //    }
        //    catch (Exception ex)
        //    {

        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }
        //}

        //public void clr()
        //{

        //    txtRackName.Text = string.Empty;
        //    ddlGodownName.SelectedIndex = 0;
        //}

        #endregion
        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        //protected void btnSave_Click(object sender, EventArgs e)
        //{
        //    savecode();
        //}

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
               // lblcheckDoubleError.Text = String.Empty;
                GridViewRow row = GridView1.SelectedRow;
                int rack_id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                //int taxId = GridView1.SelectedIndex;
                ViewState["gridrow"] = 1;
                ctrlrack.rackid = GridView1.DataKeys[row.RowIndex].Value.ToString();
                ctrlrack.rackname = row.Cells[0].Text;
                ctrlrack.godownid = row.Cells[2].Text;
                //btnSave.Visible = false;
                //btnUpdate.Visible = true;
                //divalert.Visible = false;
                //txtRackName.Focus();
                //hd.Value = string.Empty;
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    if (Convert.ToInt32(ViewState["gridrow"]) != 1)
                    {
                  //  divalert.Visible = false;
                    ViewState["unit_id"] = Convert.ToInt32(e.CommandArgument);
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                    loadDataTable();
                    }
                    else
                    {
                        //divalert.Visible = true;
                       
                        //lblAlert.Text = "Please Update The rack first";
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
                int rowIndex = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteRack(companyId, branchId, rowIndex);
                //divalert.Visible = true;
                //lblAlert.Text = "Rack Deleted ";
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
                //lblcheckDoubleError.Text = String.Empty;
                //btnSave.Visible = true;
                //btnUpdate.Visible = false;
                //divalert.Visible = false;
                //clr();
                ViewState["gridrow"] = null;
                //hd.Value = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }



        //protected void btnClear_Click(object sender, EventArgs e)
        //{
        // //   clr();
        //}

        //protected void ddlGodownName_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        //if (txtRackName.Text != null)
        //        //{
        //        //    lblcheckDoubleError.Text = String.Empty;
        //        //    divalert.Visible = false;
        //        //    CheckDouble(txtRackName.Text, ddlGodownName.SelectedValue.ToString());
        //        //}
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