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
using System.Reflection;

namespace IMS.Masters
{
    public partial class TaxGroup : System.Web.UI.Page
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
                if (ViewState["Details"] == null)
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Columns.Add("group_id");
                    dataTable.Columns.Add("type_name");
                    dataTable.Columns.Add("type_id");
                    dataTable.Columns.Add("tax_percentage");
                    dataTable.Columns.Add("taxdetails_id");
                    ViewState["Details"] = dataTable;
                }
                if (!IsPostBack)
                {
                    lbTaxBind();
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

        protected void BindGrid()
        {
            try
            {
                gvtaxdetails.DataSource = (DataTable)ViewState["Details"];
                gvtaxdetails.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        private void loadDataTable()
        {

            GridView1.DataSource = context.tbl_taxgroup.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).ToList();
            GridView1.DataBind();
        }
       
        private bool GetAllDataForValidation()
        {
            bool isValid = false;
            try
            {
                bool isExist = false;
                int count = 0;


                List<TaxGroupDetaileViewModel> data = new List<TaxGroupDetaileViewModel>();
                data = (from tg in context.tbl_taxgroup
                        join td in context.tbl_taxdetails on tg.group_id equals td.group_id

                        join t in context.tbl_taxtype on td.type_id equals t.type_id
                        where tg.company_id == companyId && tg.branch_id == branchId && tg.status == true
                        select new TaxGroupDetaileViewModel
                        {
                            typeId = t.type_id,
                            groupId = tg.group_id,
                            taxPercentage = td.tax_percentage,
                            groupName = tg.group_name,
                            taxdetailId = td.taxdetails_id,
                            typeName = t.type_name
                        }).ToList();
                for (int i = 0; i <= gvtaxdetails.Rows.Count - 1; i++)
                {
                    int typeId = Convert.ToInt32(gvtaxdetails.Rows[i].Cells[3].Text);
                    string txtpercentage = gvtaxdetails.Rows[i].Cells[2].Text;
                    decimal percent = Convert.ToDecimal(txtpercentage);
                    isExist = data.Where(w => w.typeId == typeId && w.taxPercentage == percent).Any();
                    if (isExist)
                    {
                        count++;
                    }

                }

                if (count == gvtaxdetails.Rows.Count)
                {
                    isValid = true;
                }

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }

            return isValid;
        }
        public void lbTaxBind()
        {

            List<tbl_taxtype> cd = context.tbl_taxtype.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).ToList();
            ddlTaxType.DataTextField = "type_name";
            ddlTaxType.DataValueField = "type_id";
            ddlTaxType.DataSource = cd;
            ddlTaxType.DataBind();
            ddlTaxType.Items.Insert(0, new ListItem("Select Tax Type", "0"));
        }

        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_taxgroup", "group_name", useroremail);
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
            if (!GetAllDataForValidation())
            {
                tbl_taxgroup taxGroup = new tbl_taxgroup();
                taxGroup.company_id = companyId;
                taxGroup.branch_id = branchId;
                taxGroup.group_name = txtGrouphName.Text;
                taxGroup.status = true;
                taxGroup.created_by = User_id;
                taxGroup.created_date = DateTime.Now;
                taxGroup.modified_by = "";
                taxGroup.modified_date = null;

                for (int i = 0; i <= gvtaxdetails.Rows.Count - 1; i++)
                {
                    string txtpercentage = gvtaxdetails.Rows[i].Cells[2].Text;
                    tbl_taxdetails taxDetailes = new tbl_taxdetails();
                    taxDetailes.type_id = Convert.ToInt32(gvtaxdetails.Rows[i].Cells[2].Text);
                    taxDetailes.tax_percentage = Convert.ToInt32(gvtaxdetails.Rows[i].Cells[1].Text);
                    taxDetailes.status = true;
                    taxDetailes.created_by = User_id;
                    taxDetailes.created_date = DateTime.Now;
                    taxDetailes.modified_by = "";
                    taxDetailes.modified_date = null;
                    taxGroup.tbl_taxdetails.Add(taxDetailes);
                }

                context.tbl_taxgroup.Add(taxGroup);
                context.SaveChanges();
                loadDataTable();
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Saved successfully');", true);
            }
            else
            {

                divalert.Visible = true;
                lblAlert.Text = "There is already a tax group created  with the selected type.";
            }
        }

        public void update()
        {
            try
            {

                lblcheckDoubleError.Text = string.Empty;
                GridViewRow row = GridView1.SelectedRow;
                int groupId = Convert.ToInt32(ViewState["group_id"]);

                var taxGroup = context.tbl_taxgroup.FirstOrDefault(x => x.group_id == groupId);
                if (taxGroup != null)
                {
                    taxGroup.group_name = txtGrouphName.Text;
                    taxGroup.modified_by = User_id;
                    taxGroup.modified_date = DateTime.Now;

                }

                for (int i = 0; i <= gvtaxdetails.Rows.Count - 1; i++)
                {
                    int taxdetailId = Convert.ToInt32(gvtaxdetails.Rows[i].Cells[3].Text);
                    var taxdetails = context.tbl_taxdetails.FirstOrDefault(x => x.taxdetails_id == taxdetailId);
                    string txtpercentage = gvtaxdetails.Rows[i].Cells[1].Text;
                    if (taxdetails != null)
                    {
                        taxdetails.type_id = Convert.ToInt32(gvtaxdetails.Rows[i].Cells[2].Text);
                        taxdetails.tax_percentage = Convert.ToDecimal(txtpercentage);
                        taxdetails.modified_by = User_id;
                        taxdetails.modified_date = DateTime.Now;

                    }
                    taxGroup.tbl_taxdetails.Add(taxdetails);
                }

                context.SaveChanges();
                loadDataTable();
                btnUpdate.Visible = false;
                btnSave.Visible = true;
                divalert.Visible = true;
                lblAlert.Text = "Update Successfully";
                txtGrouphName.Text = string.Empty;
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Update successfully);", true);
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        #endregion

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

        protected void btnAdd_Click(object sender, EventArgs e)
        {


            try
            {
                if (ViewState["type_id"] != null && ViewState["type_name"] != null)
                {
                    int TypeId = Convert.ToInt32(ViewState["type_id"]);
                    string TypeName = ViewState["type_name"].ToString();
                    int percentage = Convert.ToInt32(txtPercent.Text);
                    //TextBox txtpercentage = (TextBox)gvtaxdetails.FooterRow.FindControl("tax_percentage");
                    DataTable tbl = (DataTable)ViewState["Details"];

                    tbl.Rows.Add(0, TypeName, TypeId, percentage, 0);
                    ViewState["Details"] = tbl;
                    this.BindGrid();
                    ddlTaxType.Items.FindByValue(TypeId.ToString()).Enabled = false;

                    txtPercent.Text = string.Empty;
                }


            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void ddlTaxType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ViewState["type_id"] = ddlTaxType.SelectedValue;
                ViewState["type_name"] = ddlTaxType.SelectedItem.Text;
                UpdatePanel1.Update();
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
                    ViewState["id"] = Convert.ToInt32(e.CommandArgument);
                    divalert.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
                    this.BindGrid();
                }
                else if (e.CommandName == "UpdateRow")
                {
                    int rowIndex = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowIndex];
                    int groupId = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);


                    txtGrouphName.Text = row.Cells[1].Text.ToString().Replace("&#215;", "X");
                    var list = context.tbl_taxdetails.Join(context.tbl_taxtype, td => td.type_id, t => t.type_id, (td, t) => new { td.type_id, td.group_id, td.tax_percentage, t.type_name, td.taxdetails_id }).Where(p => p.group_id == groupId).ToList();

                    ViewState["Details"] = ToDataTable(list);
                    gvtaxdetails.DataSource = (DataTable)ViewState["Details"];//context.tbl_taxdetails.Join(context.tbl_taxtype, td => td.type_id, t => t.type_id, (td, t) => new { td.type_id, td.group_id, td.tax_percentage, t.type_name, td.taxdetails_id }).Where(p => p.group_id == groupId).ToList();
                    gvtaxdetails.DataBind();
                    // ddlTaxType.Visible = false;
                    // btnAdd.Visible = false;
                    ViewState["group_id"] = groupId;
                    //ddlTaxType.SelectedValue = row.Cells[1].Text;


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
        public static DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Defining type of data column gives proper data table 
                var type = (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType);
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name, type);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
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

        protected void gvtaxdetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow grv = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer);
                if (e.CommandName == "Delete row")
                {
                    int rowIndex = grv.RowIndex;
                    ViewState["id"] = rowIndex;
                    divalert.Visible = false;
                    DataTable dt = ViewState["Details"] as DataTable;
                    dt.Rows[rowIndex].Delete();
                    ViewState["Details"] = dt;
                    this.BindGrid();
                }
                else if (e.CommandName == "Update Row")
                {
                    int rowIndex = grv.RowIndex;
                    GridViewRow row = gvtaxdetails.Rows[rowIndex];
                    int taxdetailsId = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    string typeId = row.Cells[2].Text.ToString();
                    ddlTaxType.Items.FindByValue(typeId).Enabled = true;
                    // txtGrouphName.Text = row.Cells[1].Text.ToString().Replace("&#215;", "X");
                    ddlTaxType.SelectedValue = row.Cells[2].Text.ToString();
                    txtPercent.Text = row.Cells[1].Text.ToString().Replace("&#215;", "X");
                    // ddlTaxType.Visible = false;
                    btnAdd.Visible = false;
                    ViewState["taxdetailsId"] = taxdetailsId;
                    //ddlTaxType.SelectedValue = row.Cells[1].Text;
                    btnUpdateDetailes.Visible = true;

                    btnSave.Visible = false;

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

        protected void btnUpdateDetailes_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                dt = (DataTable)ViewState["Details"];
                int taxTypeId = Convert.ToInt32(ddlTaxType.SelectedValue);
                DataRow dr = dt.Select("type_id=" + taxTypeId + "").FirstOrDefault();

                if (dr != null)
                {

                    dr["type_name"] = ddlTaxType.SelectedItem.Text;
                    dr["tax_percentage"] = txtPercent.Text;
                    dr["type_id"] = taxTypeId;
                    ViewState["Details"] = dt;
                }
                this.BindGrid();

                txtPercent.Text = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void gvtaxdetails_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = gvtaxdetails.SelectedRow;
                int groupId = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);


                txtGrouphName.Text = row.Cells[1].Text;
                ddlTaxType.SelectedValue = row.Cells[2].Text;
                txtPercent.Text = row.Cells[3].Text.ToString().Replace("&#215;", "X");
                // ddlTaxType.Visible = false;
                btnAdd.Visible = false;
                ViewState["group_id"] = groupId;
                //ddlTaxType.SelectedValue = row.Cells[1].Text;
                btnUpdateDetailes.Visible = true;

                btnSave.Visible = false;
                btnUpdate.Visible = true;
                loadDataTable();
                divalert.Visible = false;
                hd.Value = string.Empty;
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
                int rowIndex = Convert.ToInt32(ViewState["id"]);
                //context.sp_DeleteTax(companyId, branchId, rowIndex);
                var taxGroup = context.tbl_taxgroup.SingleOrDefault(t => t.group_id == rowIndex);
                if (taxGroup != null)
                {
                    taxGroup.status = false;
                    context.SaveChanges();
                }
                divalert.Visible = true;
                lblAlert.Text = "Tax Group Deleted Successfully ";
                loadDataTable();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtGrouphName.Text = string.Empty;
            ddlTaxType.SelectedIndex = 0;
            txtPercent.Text = "0";
            DataTable ds = new DataTable();
            ds = null;
            gvtaxdetails.DataSource = ds;
            gvtaxdetails.DataBind();
            btnSave.Visible = true;
            btnUpdate.Visible = false;
        }

        //    protected void gvtaxdetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //    {
        //        //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
        //        gvtaxdetails.EditIndex = -1;
        //        loadgvtaxdetails();
        //    }

        //    protected void gvtaxdetails_RowEditing(object sender, GridViewEditEventArgs e)
        //    {
        //        //NewEditIndex property used to determine the index of the row being edited.  
        //        gvtaxdetails.EditIndex = e.NewEditIndex;
        //        loadgvtaxdetails();
        //    }

        //    protected void gvtaxdetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //    {
        //        //Finding the controls from Gridview for the row which is going to update  
        //        Label typeName = gvtaxdetails.Rows[e.RowIndex].FindControl("lblTypeName") as Label;
        //        Label typeId = gvtaxdetails.Rows[e.RowIndex].FindControl("lblTypeId") as Label;
        //        Label taxDetailsId = gvtaxdetails.Rows[e.RowIndex].FindControl("lbltaxdetails_id") as Label;
        //        TextBox taxPercentage = gvtaxdetails.Rows[e.RowIndex].FindControl("txt_tax_percentage") as TextBox;

        //        var _taxDetailsId = Convert.ToUInt32(taxDetailsId.Text);

        //        var taxDetails = context.tbl_taxdetails.Where(w => w.taxdetails_id == _taxDetailsId).FirstOrDefault();
        //        taxDetails.tax_percentage = Convert.ToDecimal(taxPercentage.Text);
        //        context.SaveChanges();
        //        //con = new SqlConnection(cs);
        //        //con.Open();
        //        ////updating the record  
        //        //SqlCommand cmd = new SqlCommand("Update tbl_Employee set Name='" + name.Text + "',City='" + city.Text + "' where ID=" + Convert.ToInt32(id.Text), con);
        //        //cmd.ExecuteNonQuery();
        //        //con.Close();
        //        //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
        //        gvtaxdetails.EditIndex = -1;
        //        //Call ShowData method for displaying updated data  
        //        loadgvtaxdetails();
        //    }
        //private void loadgvtaxdetails()
        //{
        //    int groupId = Convert.ToInt32(ViewState["group_id"]);
        //    var taxDetails = context.tbl_taxtype.Join(context.tbl_taxdetails, tt => tt.type_id, td => td.type_id, (tt, td) => new { td.type_id, td.taxdetails_id, td.tax_percentage, tt.type_name, td.group_id }).Where(w => w.group_id == groupId).ToList();
        //    gvtaxdetails.DataSource = taxDetails;
        //    gvtaxdetails.DataBind();
        //}
    }
}