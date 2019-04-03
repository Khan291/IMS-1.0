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
using System.Security.Cryptography;
using System.Text;


namespace IMS.Masters
{
    public partial class WebForm1 : System.Web.UI.Page
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
                    
                    getddlrole();
                    getddlbranch();
                    gridbind();
                    txtFirstName.Focus();
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
        private void SessionValue()
        {
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }
        public bool valid()
        {
            ////Shakeeb
            Validationss v = new Validationss();
            if (v.emialvalidation(txtUserEmail.Text) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Proper Email');", true);
                return false;
            }
            return true;
        }
      
        public void gridbind()
        {
            //UserRol p = new UserRol();
            //int c_id = Convert.ToInt32(Session["company_id"]);
            //p.company_id = c_id;
            ////Shakeeb
            GridView1.DataSource = context.sp_SelectUserRole(companyId);
            GridView1.DataBind();
           

        }
        public void getddlbranch()
        {
            List<tbl_branch> gd = context.tbl_branch.Where(x => x.status == true && x.company_id == companyId).ToList();

            ddlBranch.DataTextField = "branch_name";
            ddlBranch.DataValueField = "branch_id";
            ddlBranch.DataSource = gd;
            ddlBranch.DataBind();
            ddlBranch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
        }

        public void getddlrole()
        {

            List<tbl_role> gd = context.tbl_role.Where(x => x.status == true).ToList();

            ddlRole.DataTextField = "role_name";
            ddlRole.DataValueField = "role_id";
            ddlRole.DataSource = gd;
            ddlRole.DataBind();
            ddlRole.Items.Insert(0, new ListItem("--Select Role--", "0"));
        }


      
        [System.Web.Services.WebMethod]
        public static string CheckDouble1(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.checkusersdata2(useroremail);
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
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.checkusersdata(useroremail);
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
        private void savedcode()
        {
            try
            {
                if (valid())
                {
                    if (hd.Value == "false")
                    {
                        if (hde.Value == "false")
                        {
                            //UserRol r = new UserRol();
                            //r.user_name = txtUserEmail.Text;
                            //r.first_name = txtFirstName.Text;
                            //r.last_name = txtLastname.Text;
                            //r.user_mobieno = txtContactNo.Text;
                            //r.user_Emai = txtUserEmail.Text;
                            //string enPswd = GetSwcSHA1(txtPassword.Text);
                            //r.password = enPswd;
                            //r.role_id = Convert.ToInt32(ddlRole.SelectedValue);
                            //r.branch_id = Convert.ToInt32(ddlBranch.SelectedValue);
                            //r.status = true;
                            ////r.created_by = "admin";
                            //r.created_by = User_id;
                            //r.created_date = DateTime.Now;
                            //r.company_id = companyId;
                            ////Shakeeb
                            ////r.Insert(r);
                            context.sp_AddUser2(txtUserEmail.Text, txtUserEmail.Text, txtContactNo.Text, 
                                EncryptionHelper.GetSwcSHA1(txtPassword.Text), Convert.ToInt32(ddlRole.SelectedValue)
                                , branchId, companyId, true, User_id, DateTime.Now, txtFirstName.Text, txtLastname.Text);
                            gridbind();
                            divalert.Visible = true;
                            lblAlert.ForeColor = System.Drawing.Color.Green;
                            lblAlert.Text = "User Saved Successfully ";
                            clr();
                        }
                        else
                        {
                            lblcheck.ForeColor = System.Drawing.Color.Red;
                            lblcheck.Text = "Mobile No is already exists";
                        }

                    }
                    else
                    {
                        lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                        lblcheckDoubleError.Text = "Email-ID already exists";
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        private void updatecode()
        {
            try
            {
                if (hd.Value == "false" && hde.Value == "false")
                {
                    //UserRol r = new UserRol();
                   // GridViewRow row = GridView1.SelectedRow;
                    //r.userbranch_id = Convert.ToInt32(ViewState["bachid"]);
                    //r.role_id = Convert.ToInt32(ddlRole.SelectedValue);
                    //r.branch_id = Convert.ToInt32(ddlBranch.SelectedValue);
                    //r.user_name = txtUserEmail.Text;
                    //r.first_name = txtFirstName.Text;
                    //r.last_name = txtLastname.Text;
                    //r.user_Emai = txtUserEmail.Text;
                    //r.user_mobieno = txtContactNo.Text;
                    //r.company_id = companyId;
                    //r.userbranch_id = Convert.ToInt32(ViewState["Userbranch"]);
                    //r.user_id = Convert.ToInt32(ViewState["user"].ToString());
                    //r.status = true;
                    //r.modified_by = User_id;
                    //r.modified_date = DateTime.Now;
                    ////Shakeeb
                    ////r.Update(r);

                    context.sp_UpdateUser(Convert.ToInt32(ViewState["bachid"])
                        , Convert.ToInt32(ViewState["user"].ToString())
                        , txtUserEmail.Text
                        , txtUserEmail.Text
                        , txtContactNo.Text
                       , Convert.ToInt32(ddlRole.SelectedValue)
                       , Convert.ToInt32(ddlBranch.SelectedValue)
                       , companyId
                       , true
                       , User_id
                       , DateTime.Now
                       , txtFirstName.Text
                       , txtLastname.Text
                       );

                        //context.tbl_User.


                    btnUpdate.Visible = false;
                    btnSave.Visible = true;
                    gridbind();
                    txtPassword.Enabled = true;
                    clr();
                    divalert.Visible = true;
                    lblAlert.Text = "User Updated Successfully ";
                    rfcontact.Enabled = true;
                    txtContactNo.Enabled = true;
                    rgx.Enabled = true;
                    RequiredFieldValidator3.Enabled = true;
                    txtUserEmail.Enabled = true;
                }
                else
                {
                    divalert.Visible = true;
                    lblAlert.Text = "Email Or Contact No Is Already Exists ";
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        private void cancelcode()
        {
            try
            {
                lblcheckDoubleError.Text = String.Empty;
                btnSave.Visible = true;
                btnUpdate.Visible = false;
                divalert.Visible = false;
                rfPassword.Enabled = true;
                rfcontact.Enabled = true;
                txtContactNo.Enabled = true;
                txtPassword.Enabled = true;
                rgx.Enabled = true;
                RequiredFieldValidator3.Enabled = true;
                txtUserEmail.Enabled = true;
                divalert.Visible = false;
                clr();
                ViewState["gridrow"] = null;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        public void clr()
        {
            txtContactNo.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtUserEmail.Text = string.Empty;
            txtFirstName.Text = string.Empty;
            txtLastname.Text = string.Empty;
            ddlBranch.SelectedIndex = 0;
            ddlRole.SelectedIndex = 0;
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
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "UpdateRow")
                {
                    int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowIndex];
               
                    //int tax_id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    //int.Parse(e.CommandArgument.ToString());
                    //int taxId = GridView1.SelectedIndex;
                    txtFirstName.Text = row.Cells[0].Text;
                    txtLastname.Text = row.Cells[1].Text;
                    ddlRole.SelectedValue = row.Cells[9].Text;
                    txtUserEmail.Text = row.Cells[3].Text;
                    txtContactNo.Text = row.Cells[4].Text;
                    txtPassword.Enabled = false;
                    ddlBranch.SelectedValue = row.Cells[8].Text;
                    ddlRole.SelectedValue = row.Cells[9].Text;
                    ViewState["bachid"] = rowIndex;
                    ViewState["user"] = row.Cells[7].Text;
                    ViewState["Userbranch"] = row.Cells[10].Text;
                    btnSave.Visible = false;
                    btnUpdate.Visible = true;
                    rfPassword.Enabled = false;
                    rfcontact.Enabled = false;
                    txtContactNo.Enabled = false;
                    rgx.Enabled = false;
                    RequiredFieldValidator3.Enabled = false;
                    txtUserEmail.Enabled = false;
                    divalert.Visible = false;
                    txtFirstName.Focus();
                
                }
                else if (e.CommandName == "DeleteRow")
                {
                    int userbranch_id = Convert.ToInt32(e.CommandArgument);
                    int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowIndex];
                    ViewState["userbranch_id"] = userbranch_id;
                    ViewState["user_id"] = row.Cells[7].Text;
                    ViewState["branch_id"] = row.Cells[8].Text;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                    divalert.Visible = false;
                    
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            updatecode();
        }
        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
             {


                ////Shakeeb
                ////p.Delete(p);

                 context.sp_DeleteUser(companyId, Convert.ToInt32(ViewState["userbranch_id"]), Convert.ToInt32(ViewState["user_id"]), branchId);
                    gridbind();

                    divalert.Visible = true;
                    lblAlert.Text = "User Deleted Successfully ";
                    clr();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            cancelcode();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            clr();
            divalert.Visible = false;
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