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
using System.Globalization;

namespace IMS
{
    public partial class Party : System.Web.UI.Page
    {
    
         /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        //session globale object Awais
        int companyId;
        int branchId;
        string User_id;
        SqlHelper helper = new SqlHelper();
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

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

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
        private void loadDataTable()
        {
            try
            {
                GridView1.DataSource = context.sp_SelectParty(companyId, branchId); 
                GridView1.DataBind();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
            }
            finally
            {
                //con.Close();
                //con.Dispose();
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
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_party", "party_name", useroremail);
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
        public static string checkGstinNo(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_party", "gstin_no", useroremail);
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
        public static string checkContactNo(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_party", "contact_no", useroremail);
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

        private void updatelogic()
        {
             try
            {
                if (hde.Value != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;
                   
                    int a = Convert.ToInt32(ddlState.SelectedValue);
                    int party_id = Convert.ToInt32(ViewState["party_id"]);
                    context.sp_UpdateParty(companyId, branchId, party_id, a, txtPartyName.Text, txtPartyAddress.Text, txtContactNo.Text, ddlPartyType.SelectedItem.Text, txtGSTIN.Text, User_id, DateTime.Today);
                    btnUpdate.Visible = false;
                    btnSave.Visible = true;
                    divalert.Visible = true;
                    lblAlert.Text = "Party Updated Successfully ";
                    CLR();
                    loadDataTable();
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
                        loadDataTable();
                        divalert.Visible = true;
                        lblAlert.Text = "Party Saved Successfully ";
                        CLR();
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
           updatelogic();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {


            try
            {
                lblcheckDoubleError.Text = String.Empty;
                GridViewRow row = GridView1.SelectedRow;
                ViewState["party_id"] = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                txtPartyName.Text = row.Cells[0].Text;
                txtPartyAddress.Text = row.Cells[1].Text;
                txtContactNo.Text = row.Cells[2].Text;
                txtGSTIN.Text = row.Cells[3].Text;
                ddlPartyType.SelectedValue = row.Cells[4].Text;
                ddlState.SelectedValue = row.Cells[5].Text;
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                divalert.Visible = false;
                txtPartyName.Focus();
                hde.Value = string.Empty;
            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    ViewState["unit_id"] = Convert.ToInt32(e.CommandArgument);
                    divalert.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
               
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
                int c_id = Convert.ToInt32(Session["company_id"]);
                int b_id = Convert.ToInt32(Session["branch_id"]);
                int rowIndex = Convert.ToInt32(ViewState["unit_id"]);
                context.sp_DeleteParty(c_id, b_id, rowIndex);
                divalert.Visible = true;
                lblAlert.Text = "Party Deleted Successfully ";
                loadDataTable();
                CLR();
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
                btnUpdate.Visible = false;
                divalert.Visible = false;
                CLR();
                ViewState["gridrow"] = null;
                hde.Value = string.Empty;
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