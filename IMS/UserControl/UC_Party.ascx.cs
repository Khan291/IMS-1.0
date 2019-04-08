using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.UserControl
{
    public partial class UC_Party : System.Web.UI.UserControl
    {
        #region properties
        // declaration of properties for taking category name and ID from category.aspx for update functionality
        public string partyID
        {
            set { hdpartyid.Value = value; }
        }
        public string partyname
        {
            get { return txtPartyName.Text; }
            set
            {
                txtPartyName.Text = value;
                if (txtPartyName.Text != "")
                {
                    btnprtyUpdate.Visible = true;
                    btnprtySave.Visible = false;
                }
                else
                {
                    btnprtySave.Visible = true;
                    btnprtyUpdate.Visible = false;
                }
            }

        }
        public string partyaddress
        {
            set { txtPartyAddress.Text = value; }
        }
        public string contactno
        {
            set { txtContactNo.Text = value; }
        }
        public string GSTNo
        {
            set { txtGSTIN.Text = value; }
        }
        public string partytype
        {
            set { ddlPartyType.SelectedValue = value; }
        }
        public string partystate
        {
            set { ddlState.SelectedValue = value; }
        }
        #endregion
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        //session globale object Awais
        int companyId;
        int branchId;
        string User_id;
        SqlHelper helper = new SqlHelper();
        #endregion


        #region Methods
        public void statebind()
        {

            TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;

            var title = "WAR AND PEACE";

            title = textInfo.ToTitleCase(title);
            //Console.WriteLine(title); //WAR AND PEACE

            ////You need to call ToLower to make it work
            //title = textInfo.ToTitleCase(title.ToLower());
            //Console.WriteLine(title);


            List<tbl_state> gd = context.tbl_state.Where(x => x.status == true).ToList();
            DataTable dt = new DataTable();
            dt = helper.LINQToDataTable(gd);
            IEnumerable<DataRow> rows = dt.Rows.Cast<DataRow>();

            foreach (DataRow row in dt.Rows)
            {
                var lowerValue = row["state_name"].ToString();
                lowerValue = textInfo.ToTitleCase(lowerValue.ToLower());
                row["state_name"] = lowerValue;
                //row.SetField(row["state_name"].ToString(), row["state_name"][lowerValue]);
            }

            ddlState.DataSource = dt;
            ddlState.DataTextField = "state_name";
            ddlState.DataValueField = "state_id";
            //gd.ConvertAll(r => textInfo.ToTitleCase(r.state_name.ToLower())).ToList();
            //ddlState.DataSource = textInfo.ToTitleCase(title.ToLower());
            //ddlState.DataSource = dt;
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
        }
       
        
        private void updatelogic()
        {
            try
            {
                if (hde.Value != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;

                    int a = Convert.ToInt32(ddlState.SelectedValue);
                    int party_id = Convert.ToInt32(hdpartyid.Value);
                    context.sp_UpdateParty(companyId, branchId, party_id, a, txtPartyName.Text, txtPartyAddress.Text, txtContactNo.Text, ddlPartyType.SelectedItem.Text, txtGSTIN.Text, User_id, DateTime.Today);
                    divalert.Visible = true;
                    lblAlert.Text = "Party Updated Successfully ";
                    CLR();
                    ((Party)this.Page).loadDataTable();
                }

                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "Party Name is already exists ";
                }
            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        private void savedlogic()
        {
            try
            {
                if (hde.Value != "true")
                {
                    if (hd2.Value != "true")
                    {
                        lblcheckDoubleError.Text = String.Empty;
                        tbl_party p = new tbl_party();
                        p.company_id = companyId;
                        p.branch_id = branchId;
                        p.party_name = txtPartyName.Text;
                        p.party_address = txtPartyAddress.Text;
                        p.contact_no = txtContactNo.Text;
                        p.gstin_no = txtGSTIN.Text;
                        p.party_type = ddlPartyType.SelectedValue;
                        p.state_id = Convert.ToInt32(ddlState.SelectedValue);
                        //p.created_by = "admin";
                        p.created_by = User_id;
                        p.created_date = DateTime.Today;
                        p.status = true;
                        ////Shakeeb
                        ////p.Insert(p);
                        //Entity Framework Saving Awais
                        context.tbl_party.Add(p);
                        context.SaveChanges();
                        divalert.Visible = true;
                        lblAlert.Text = "Party Saved Successfully ";
                        CLR();
                        ((Party)this.Page).loadDataTable();
                    }
                    else
                    {
                        divalert.Visible = false;
                        lblgstinerror.Text = "GSTIN No Must be 15 digit alphanumeric only";
                    }
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "Party Name is already exists ";
                }


            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        public void CLR()
        {
            txtContactNo.Text = string.Empty;
            txtGSTIN.Text = string.Empty;
            txtPartyAddress.Text = string.Empty;
            txtPartyName.Text = string.Empty;
            ddlPartyType.SelectedIndex = 0;
            ddlState.SelectedIndex = 0;

        }

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                User_id = Convert.ToString(Session["UserID"]);
                companyId = Convert.ToInt32(Session["company_id"]);
                branchId = Convert.ToInt32(Session["branch_id"]);
                 string pagename= Path.GetFileName(Request.Path);
                 if (pagename == "Purchase.aspx")
                 {
                     ddlPartyType.SelectedValue = "Vendor";
                     ddlPartyType.Enabled = false;
                 }
                 if (pagename == "Sale.aspx")
                 {
                     ddlPartyType.SelectedValue = "Customer";
                     ddlPartyType.Enabled = false;
                 }
                if (!IsPostBack)
                {

                    statebind();
                    txtPartyName.Focus();
                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }


        protected void btnprtySave_Click(object sender, EventArgs e)
        {
            savedlogic();
        }

        protected void btnprtyUpdate_Click(object sender, EventArgs e)
        {
            updatelogic();
        }
    }
}