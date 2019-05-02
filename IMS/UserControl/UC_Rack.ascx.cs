using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.UserControl
{
    public partial class UC_Rack : System.Web.UI.UserControl
    {

        #region properties

        public string rackid 
        {
            set { hdrack.Value = value; }
        }
        public string rackname
        {
            get { return txtRackName.Text; }
            set
            {
                txtRackName.Text = value;
                if (txtRackName.Text != "")
                {
                    btnrckUpdate.Visible = true;
                    btnrckSave.Visible = false;
                }
                else
                {
                    btnrckSave.Visible = true;
                    btnrckUpdate.Visible = false;
                }
            }
        }
        public string godownid
        {

            set { ddlGodownName.SelectedValue = value; }
        }

        #endregion

        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        int companyId;
        int branchId;
        string User_id;
        #endregion


        #region Methods

      
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
        public void ddlgodownbind(int companyid)
        {
            List<tbl_godown> gd = context.tbl_godown.Where(x => x.status == true && x.company_id == companyid).ToList();
            ddlGodownName.DataTextField = "godown_name";
            ddlGodownName.DataValueField = "godown_id";
            ddlGodownName.DataSource = gd;
            ddlGodownName.DataBind();
        }
        public void fillgodown(List<tbl_godown> dt)
        {

            ddlGodownName.DataTextField = "godown_name";
            ddlGodownName.DataValueField = "godown_id";
            ddlGodownName.DataSource = dt;
            ddlGodownName.DataBind();
        }
       

        public void savecode()
        {
            try
            {
                if (CheckDouble(txtRackName.Text, ddlGodownName.SelectedValue) == "false")
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
                    ((Rack)this.Page).loadDataTable();

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

        private void updatecode()
        {
            try
            {
                if (hd.Value != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    //GridViewRow row = GridView1.SelectedRow;
                    int rack_id = Convert.ToInt32(hdrack.Value);
                    int godown_id = Convert.ToInt32(ddlGodownName.SelectedValue);
                    //decimal TaxPercent = decimal.Parse(txtTaxPercent.Text);
                    context.sp_UpdateRack(companyId, branchId, rack_id, godown_id, txtRackName.Text, User_id, DateTime.Today);
                    divalert.Visible = true;
                    lblAlert.Text = "Rack Updated Successfully";
                    ViewState["gridrow"] = 0;
                    clr();
                    ((Rack)this.Page).loadDataTable();
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
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SessionValue();
                ddlgodownbind(companyId);
                //if (!IsPostBack)
                //{
                    
                //}
            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
            
        }

        protected void btnrckSave_Click(object sender, EventArgs e)
        {
            savecode();
        }

        protected void btnrckUpdate_Click(object sender, EventArgs e)
        {
            updatecode();
        }

        protected void btnrckClear_Click(object sender, EventArgs e)
        {
            clr();
        }
    }
}