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
    public partial class WebForm1 : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    countrybind();
                    statebind();
                    grdbind();
                    txtBranchName.Focus();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        public void countrybind()
        {

            List<tbl_country> gd = context.tbl_country.Where(x => x.status == true).ToList();

            ddlcountry.DataTextField = "country_name";
            ddlcountry.DataValueField = "country_id";
            ddlcountry.DataSource = gd;
            ddlcountry.DataBind();
            if (ddlcountry.Items.Count > 0)
            {
                ddlcountry.SelectedItem.Text = "India";
                ddlcountry.Enabled = false;
            }
        }
        public void statebind()
        {
            try
            {
                List<tbl_state> gd = context.tbl_state.Where(x => x.status == true).ToList();
                ddlState.DataTextField = "state_name";
                ddlState.DataValueField = "state_id";
                ddlState.DataSource = gd;
                ddlState.DataBind();
                ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        public void grdbind()
        {
            try
            {

                int a = Convert.ToInt32(Session["company_id"]);
                GridView1.DataSource = context.sp_SelectBranch(a);
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
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
                    DataTable data = helper.checkbranch_name(Convert.ToInt32(HttpContext.Current.Session["company_id"]), useroremail);
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
        public void clr()
        {
            txtBranchName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtCity.Text = string.Empty;
            txtFaxno.Text = string.Empty;
            txtpincode.Text = string.Empty;
            txttelephoneno.Text = string.Empty;
            ddlState.SelectedValue = "0";
        }

        public void savedlogic()
        {
            try
            {
                if (CheckDouble(txtBranchName.Text) == "false")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    int a = Convert.ToInt32(Session["company_id"]);
                    int b = Int32.Parse(ddlcountry.SelectedValue);
                    int c = Int32.Parse(ddlState.SelectedValue);
                    string name = Convert.ToString(Session["username"]);
                    context.sp_InsertBranch(a, txtBranchName.Text, txtAddress.Text, txtpincode.Text, txtFaxno.Text, txttelephoneno.Text, b, c, txtCity.Text, name, DateTime.Now);
                    divalert.Visible = true;
                    lblAlert.Text = "Branch Saved Successfully ";
                    clr();
                    grdbind();
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Branch name is already Exists";
                    return;
                }
            }

            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        public void Updatelogic()
        {
            try
            {
                if (hd.Value != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    int a = Convert.ToInt32(Session["company_id"]);
                    int bf = Int32.Parse(ddlcountry.SelectedValue);
                    int c = Int32.Parse(ddlState.SelectedValue);
                    string name = Convert.ToString(Session["username"]);
                    int b = Convert.ToInt32(ViewState["branchid"]);

                    context.sp_UpdateBranch(b, a, txtBranchName.Text, txtAddress.Text, txtpincode.Text, txttelephoneno.Text, txtFaxno.Text, bf, c, txtCity.Text, name);
                    btnUpdate.Visible = false;
                    btnSave.Visible = true;
                    divalert.Visible = true;
                    lblAlert.Text = "Branch Updated Successfully ";
                    clr();
                    grdbind();
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Branch name is already Exists";
                    return;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }

        }

        public void deletelogic()
        {
            try
            {
                int c_id = Convert.ToInt32(Session["company_id"]);
                int b_id = Convert.ToInt32(Session["branch_id"]);
                int b = Convert.ToInt32(ViewState["b"]);
                int a = Convert.ToInt32(Session["company_id"]);
                context.sp_DeleteBranch(b, a);
                divalert.Visible = true;
                lblAlert.Text = "Branch Deleted Successfully ";
                clr();
                grdbind();
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Updatelogic();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.SelectedRow;
                int rowIndex = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
             

                //int tax_id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                //int.Parse(e.CommandArgument.ToString());
                //int taxId = GridView1.SelectedIndex;
                txtBranchName.Text = row.Cells[0].Text;
                txtAddress.Text = row.Cells[1].Text;
                txtpincode.Text = row.Cells[2].Text;
                txtCity.Text = row.Cells[3].Text;
                txtFaxno.Text = row.Cells[4].Text;
                txttelephoneno.Text = row.Cells[5].Text;
                ddlcountry.SelectedValue = row.Cells[9].Text;
                ddlState.SelectedItem.Text = row.Cells[7].Text;
                ViewState["branchid"] = row.Cells[8].Text;
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                divalert.Visible = false;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateRow")
            {
                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowIndex];
                txtBranchName.Text = row.Cells[0].Text;
                txtAddress.Text = row.Cells[1].Text;
                txtpincode.Text = row.Cells[2].Text;
                txtCity.Text = row.Cells[3].Text;
                txtFaxno.Text = row.Cells[4].Text;
                txttelephoneno.Text = row.Cells[5].Text;
                // ddlcountry.SelectedItem.Text = row.Cells[6].Text;
                ddlState.SelectedValue = row.Cells[9].Text;
                ViewState["branchid"] = row.Cells[8].Text;
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                divalert.Visible = false;
                txtBranchName.Focus();
            }
            else if (e.CommandName == "DeleteRow")
            {
                int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowIndex];
                ViewState["id"] = rowIndex;
                divalert.Visible = false;
                ViewState["b"] = Convert.ToInt32(row.Cells[8].Text);
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);


            }
        }
        protected void btnYes_Click(object sender, EventArgs e)
        {
            deletelogic();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                btnSave.Visible = true;
                btnUpdate.Visible = false;
                divalert.Visible = false;
                clr();
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