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
    public partial class RackMasterModel : System.Web.UI.Page
    {
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
            ddlgodownbind();
            txtRackName.Focus();
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
        public void ddlgodownbind()
        {
            List<tbl_godown> gd = context.tbl_godown.Where(x => x.status == true && x.company_id == companyId).ToList();

            ddlGodownName.DataTextField = "godown_name";
            ddlGodownName.DataValueField = "godown_id";
            ddlGodownName.DataSource = gd;
            ddlGodownName.DataBind();
            ddlGodownName.Items.Insert(0, new ListItem("--Select Godown--", "0"));
        }

        private void savecode()
        {
            try
            {
                if (hd.Value != "true")
                {

                    lblcheckDoubleError.Text = String.Empty;
                    tbl_rack rack = new tbl_rack();
                    rack.company_id = companyId;
                    rack.branch_id = branchId;
                    rack.godown_id = Int32.Parse(ddlGodownName.SelectedValue);
                    rack.rack_name = txtRackName.Text;
                    rack.created_by = User_id;
                    rack.created_date = DateTime.Today;
                    rack.status = true;
                    rack.modified_by = "";
                    rack.modified_date = null;
                    ////Shakeeb
                    ////rd.Insert(rd);
                    //Entity Framework Saving Awais
                    context.tbl_rack.Add(rack);
                    context.SaveChanges();
                    divalert.Visible = true;
                    lblAlert.Text = "Rack Saved Successfully";
                    clr();


                    //lblError.Text = string.Empty;
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Rack name already Exists";
                    return;
                }

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }
        public void clr()
        {

            txtRackName.Text = string.Empty;
            ddlGodownName.SelectedIndex = 0;
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
        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteRack(companyId, branchId, rowIndex);
                divalert.Visible = true;
                lblAlert.Text = "Rack Deleted ";
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

        protected void ddlGodownName_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtRackName.Text != null)
                {
                    lblcheckDoubleError.Text = String.Empty;
                    divalert.Visible = false;
                    CheckDouble(txtRackName.Text, ddlGodownName.SelectedValue.ToString());
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }

        }
        #endregion
    }
}