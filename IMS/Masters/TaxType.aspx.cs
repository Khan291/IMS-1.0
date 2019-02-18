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

namespace IMS.Masters
{
    public partial class TaxType : System.Web.UI.Page
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

        private void loadDataTable()
        {
            GridView1.DataSource = context.tbl_taxtype.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).ToList();
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
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_taxtype", "type_name", useroremail);
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
        public void Save()
        {
            if (CheckDouble(txtTaxtype.Text) == "false")
            {
                lblcheckDoubleError.Text = String.Empty;
                tbl_taxtype type = new tbl_taxtype();
                type.branch_id = branchId;//Convert.ToInt32(Session["branch_id"]); 
                type.company_id = companyId;//Convert.ToInt32(Session["company_id"]);
                type.type_name = txtTaxtype.Text;
                type.created_by = User_id; //Convert.ToString(Session["UserID"]);
                type.created_date = DateTime.Today;
                type.modified_by = "";
                type.modified_date = null;
                type.status = true;
                context.tbl_taxtype.Add(type);
                context.SaveChanges();

                loadDataTable();
                divalert.Visible = true;
                lblAlert.Text = "Saved Successfully";
                txtTaxtype.Text = string.Empty;
            }
            else
            {
                divalert.Visible = false;
                lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                lblcheckDoubleError.Text = "This type name already Exists";
                return;
            }
        }


        public void update()
        {
            try
            {

                lblcheckDoubleError.Text = string.Empty;
                GridViewRow row = GridView1.SelectedRow;
                int type_id = Convert.ToInt32(ViewState["type_id"]);

                var result = context.tbl_taxtype.SingleOrDefault(x => x.type_id == type_id);
                if (result != null)
                {
                    result.type_name = txtTaxtype.Text;
                    result.modified_by = User_id;
                    result.modified_date = DateTime.Now;
                    context.SaveChanges();
                }
                loadDataTable();
                btnUpdate.Visible = false;
                btnSave.Visible = true;
                divalert.Visible = true;
                lblAlert.Text = "Update Successfully";
                txtTaxtype.Text = string.Empty;
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        #endregion


        #region Events
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DeleteRow")
                {
                    ViewState["rowIndex"] = Convert.ToInt32(e.CommandArgument);
                    divalert.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                }
                else if (e.CommandName == "UpdateRow")
                {
                    int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowIndex];
                    ViewState["type_id"] = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    if (row.Cells[0].Text.ToString().Contains("&#215;"))
                    {
                        txtTaxtype.Text = row.Cells[0].Text.ToString().Replace("&#215;", "X");
                    }
                    else
                    {
                        txtTaxtype.Text = row.Cells[0].Text.ToString();
                    }

                    btnSave.Visible = false;
                    btnUpdate.Visible = true;
                    loadDataTable();
                    divalert.Visible = false;
                    hd.Value = string.Empty;
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
            try
            {
                update();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        #endregion
    }
}