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
    public partial class ProductMasterModel : System.Web.UI.Page
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
           
            ddlcategorybind();
            ddlunitbind();
            ddlgodownbind();
            ddltaxbind();
            ddlCategory.Focus();
        }
        private void SessionValue()
        {
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }
        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_product", "product_code", useroremail);
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
        public static string CheckDouble1(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_product", "product_name", useroremail);
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
        public void ddlcategorybind()
        {
            
            List<tbl_category> cd = context.tbl_category.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).ToList();
            ddlCategory.DataTextField = "category_name";
            ddlCategory.DataValueField = "category_id";
            ddlCategory.DataSource = cd;
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));
        }
        public void ddlunitbind()
        {
            List<tbl_unit> cd = context.tbl_unit.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).ToList();
            ddlUnit.DataTextField = "unit_name";
            ddlUnit.DataValueField = "unit_id";
            ddlUnit.DataSource = cd;
            ddlUnit.DataBind();
            ddlUnit.Items.Insert(0, new ListItem("--Select Unit--", "0"));
        }

        public void ddlgodownbind()
        {
            List<tbl_godown> gd = context.tbl_godown.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).ToList();

            ddlGodown.DataTextField = "godown_name";
            ddlGodown.DataValueField = "godown_id";
            ddlGodown.DataSource = gd;
            ddlGodown.DataBind();
            ddlGodown.Items.Insert(0, new ListItem("--Select Godown--", "0"));
        }
        public void ddlrackbind(int godownid)
        {
            int g_id = Convert.ToInt32(ddlGodown.SelectedValue);
            List<tbl_rack> cd = context.tbl_rack.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId && x.godown_id==godownid).ToList();
            ddlRack.DataTextField = "rack_name";
            ddlRack.DataValueField = "rack_id";
            ddlRack.DataSource = cd;
            ddlRack.DataBind();
            ddlRack.Items.Insert(0, new ListItem("--Select Rack--", "0"));
            if (cd.Count == 0)
            {
                lblrackerror.Text = "No rack found ";
            }
            else
            {
                lblrackerror.Text = string.Empty;
            }
        }
        public void ddltaxbind()
        {
              List<tbl_tax> cd = context.tbl_tax.Where(x => x.status == true && x.company_id == companyId && x.branch_id==branchId).ToList();
            ddlTax.DataTextField = "tax_name";
            ddlTax.DataValueField = "tax_id";
            ddlTax.DataSource = cd;
            ddlTax.DataBind();
            ddlTax.Items.Insert(0, new ListItem("--Select Tax--", "0"));
        }

        private void savedcode()
        {
            try
            {
                if (hd.Value == "false")
                {
                    if (hde.Value == "false")
                    {
                        Label1.Text = String.Empty;
                        lblcheckDoubleError.Text = String.Empty;
                        tbl_product product = new tbl_product();
                        product.company_id = companyId;
                        product.branch_id = branchId;
                        product.category_id = Int32.Parse(ddlCategory.SelectedValue);
                        product.unit_id = Int32.Parse(ddlUnit.SelectedValue);
                        product.godown_id = Int32.Parse(ddlGodown.SelectedValue);
                        product.rack_id = Int32.Parse(ddlRack.SelectedValue);
                       // product.tax_id = Int32.Parse(ddlTax.SelectedValue);
                        product.product_name = txtProductName.Text;
                        product.product_code = txtProductCode.Text;
                        product.hsn_code = txtHSNCode.Text;
                        product.reorder_level = Int32.Parse(txtReorderqty.Text);
                        product.purchas_price = decimal.Parse(txtPurchasePrice.Text);
                        product.sales_price = decimal.Parse(txtSalesPrice.Text);
                        product.created_by = User_id;
                        product.created_date = DateTime.Today;
                        product.status = true;
                        product.modified_by = "";
                        product.modified_date = null;
                        ////Shakeeb
                        ////pd.Insert(pd);
                        //Entity Framework Saving Awais
                        context.tbl_product.Add(product);
                        context.SaveChanges();
                      clr();
                        divalert.Visible = true;
                        lblAlert.Text = "Product Saved Successfully ";


                        
                        //context.tbl_product.Add(pd);
                        //context.SaveChanges();
                    }
                    else
                    {
                        divalert.Visible = false;
                        lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                        lblcheckDoubleError.Text = "This Product Code name already Exists";
                    }

                }
                else
                {
                    divalert.Visible = false;
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "This Product name already Exists";
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
            txtHSNCode.Text = string.Empty;
            txtProductCode.Text = string.Empty;
            txtProductName.Text = string.Empty;
            txtPurchasePrice.Text = string.Empty;
            txtReorderqty.Text = string.Empty;
            txtSalesPrice.Text = string.Empty;
            ddlCategory.SelectedIndex = 0;
            ddlGodown.SelectedIndex = 0;
            ddlRack.SelectedIndex = 0;
            ddlTax.SelectedIndex = 0;
            ddlUnit.SelectedIndex = 0;
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

        
             protected void btnUpdate_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(ViewState["rowIndex"]);

                context.sp_DeleteProduct(companyId, rowIndex);
                divalert.Visible = true;
                lblAlert.Text = "Product Deleted Successfully ";
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
            try
            {
                lblcheckDoubleError.Text = String.Empty;
                btnSave.Visible = true;
                divalert.Visible = false;
                clr();
                ViewState["gridrow"] = null;
                hde.Value = string.Empty;
                hd.Value = string.Empty;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            clr();
        }

        protected void ddlGodown_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //lblrackerror.Text = string.Empty;
                int g_id = Convert.ToInt32(ddlGodown.SelectedValue);
                ddlrackbind(g_id);
                UpdatePanel1.Update();

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        #endregion

        protected void btnCloseMode_Click(object sender, EventArgs e)
        {
            try
            {
                ddlcategorybind();
                ddlgodownbind();
                ddlrackbind(Convert.ToInt32(ddlGodown.SelectedValue));
                ddltaxbind();
                ddlunitbind();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "Closepopup();", true);
                UpdatePanel1.Update();

            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
    }
}
