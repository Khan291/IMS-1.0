using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IMS.Masters;
using System.IO;

namespace IMS.UserControl
{
    public partial class UC_Product : System.Web.UI.UserControl
    {
        #region properties
        public ListBox Taxdropdown
        {
            get
            {
                foreach (ListItem item in ddlTaxgroup.Items)
                {
                    item.Selected = true;
                }
                return this.ddlTaxgroup;
               
            }
           

        }  
        public string productid
        {
            set { hdproductid.Value = value; 
            }
        }
        public string productname
        {
            set 
            { 
                txtProductName.Text = value;
                if (txtProductName.Text != "")
                {
                    btnprdUpdate.Visible = true;
                    btnprdSave.Visible = false;
                }
                else
                {
                    btnprdSave.Visible = true;
                    btnprdUpdate.Visible = false;
                }
            }
        }
        public string productcode
        {
            set { txtProductCode.Text = value; }
        }
        public string HSNcode
        {
            set { txtHSNCode.Text = value; }
        }
        public decimal purchprice
        {
            set { txtPurchasePrice.Text = Convert.ToDecimal(value).ToString(); }
        }
        public decimal saleprice
        {
            set { txtSalesPrice.Text = Convert.ToDecimal(value).ToString(); }
        }
        public int godownid
        {
            set { ddlGodown.SelectedValue = Convert.ToInt32(value).ToString(); }
        }
        public int rackid
        {
            set { ddlRack.SelectedValue = Convert.ToDecimal(value).ToString(); }
        }
        public int categoryid
        {
            set { ddlCategory.SelectedValue = Convert.ToDecimal(value).ToString(); }
        }
        public int unitid
        {
            set { ddlUnit.SelectedValue = Convert.ToInt32(value).ToString(); }
        }
        public int reorderlevel
        {
            set { txtReorderqty.Text = Convert.ToInt32(value).ToString(); }
        }
        #endregion

        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        int companyId;
        int branchId;
        string User_id;
        DataTable dataTable;
        #endregion

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
            List<tbl_rack> cd = context.tbl_rack.Where(x => x.status == true && x.company_id == companyId  && x.godown_id == godownid).ToList();
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
            List<tbl_taxgroup> cd = context.tbl_taxgroup.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).ToList();
            dataTable = ToDataTable(cd);
            ddlTaxgroup.DataTextField = "group_name";
            ddlTaxgroup.DataValueField = "group_id";
            ddlTaxgroup.DataSource = cd;
            ddlTaxgroup.DataBind();
        }

        private void savedcode()
        {
            try
            {
                if (hdprodname.Value == "false")
                {
                    if (hdprodname.Value == "false")
                    {
                        lblmsgprodname.Text = String.Empty;
                        lblcheckDoubleError.Text = String.Empty;
                        tbl_product product = new tbl_product();
                        product.company_id = companyId;
                        product.branch_id = branchId;
                        product.category_id = Int32.Parse(ddlCategory.SelectedValue);
                        product.unit_id = Int32.Parse(ddlUnit.SelectedValue);
                        product.godown_id = Int32.Parse(ddlGodown.SelectedValue);
                        product.rack_id = Int32.Parse(ddlRack.SelectedValue);
                        //product.tax_id = Int32.Parse(ddlTax.SelectedValue);
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

                        foreach (ListItem item in ddlTaxgroup.Items)
                        {

                            if (item.Selected)
                            {
                                tbl_productTaxGroup productTax = new tbl_productTaxGroup();
                                productTax.group_id = Convert.ToInt32(item.Value);
                                productTax.isSelected = true;
                                product.tbl_productTaxGroup.Add(productTax);
                            }

                        }

                        context.tbl_product.Add(product);
                        context.SaveChanges();
                        clr();
                        divalert.Visible = true;
                        lblAlert.Text = "Product Saved Successfully ";
                        ((Product)this.Page).loadDataTable();


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
                    lblmsgprodname.ForeColor = System.Drawing.Color.Red;
                    lblmsgprodname.Text = "This Product name already Exists";
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
                if (hdprodname.Value != "true")
                {
                    if (hdprodcode.Value != "true")
                    {
                        lblmsgprodname.Text = string.Empty;
                        lblcheckDoubleError.Text = String.Empty;
                      //  GridViewRow row = GridView1.SelectedRow;
                        int product_id = Convert.ToInt32(hdproductid.Value);
                        decimal sales_price = decimal.Parse(txtSalesPrice.Text);
                        decimal purchase_price = decimal.Parse(txtPurchasePrice.Text);
                        int cat_id = Int32.Parse(ddlCategory.SelectedValue);
                        int unit_id = Int32.Parse(ddlUnit.SelectedValue);
                        int godown_id = Int32.Parse(ddlGodown.SelectedValue);
                        int rack_id = Int32.Parse(ddlRack.SelectedValue);
                        //int tax_id = Int32.Parse(ddlTax.SelectedValue);

                        //context.sp_UpdateProduct(companyId, branchId, product_id, cat_id, rack_id, godown_id, tax_id, unit_id, orderlevel, purchase_price, sales_price, txtProductCode.Text, txtHSNCode.Text, txtProductName.Text, User_id, DateTime.Today);

                        var product = context.tbl_product.Where(w => w.product_id == product_id).FirstOrDefault();
                        product.product_name = txtProductName.Text;
                        product.product_code = txtProductCode.Text;
                        product.hsn_code = txtHSNCode.Text;
                        product.purchas_price = decimal.Parse(txtPurchasePrice.Text);
                        product.reorder_level = Convert.ToInt32(txtReorderqty.Text);
                        product.sales_price = decimal.Parse(txtSalesPrice.Text);
                        product.rack_id = rack_id;
                        product.category_id = cat_id;
                        product.godown_id = godown_id;

                        //Delete Existing Mapping and add new mapping for product and tax group
                        //var tbl_productTaxGroup = new tbl_productTaxGroup { product_id = product_id};
                        //context.tbl_productTaxGroup.Attach(tbl_productTaxGroup);
                        //context.tbl_productTaxGroup.Remove(tbl_productTaxGroup);
                        //context.SaveChanges();
                        foreach (var grpType in context.tbl_productTaxGroup.Where(w => w.product_id == product_id).ToList())
                        {
                            product.tbl_productTaxGroup.Remove(grpType);
                        }

                        for (int i = 0; i < ddlTaxgroup.Items.Count; i++)
                        {


                            if (ddlTaxgroup.Items[i].Selected)
                            {

                                tbl_productTaxGroup productTaxGroup = new tbl_productTaxGroup();
                                ListItem item = ddlTaxgroup.Items[i];
                                int groupId = int.Parse(ddlTaxgroup.Items[i].Value);
                                productTaxGroup.product_id = product_id;
                                productTaxGroup.group_id = groupId;
                                product.tbl_productTaxGroup.Add(productTaxGroup);
                            }
                        }


                        product.unit_id = unit_id;
                        product.modified_by = User_id;
                        product.modified_date = DateTime.Now;


                        context.SaveChanges();



                        btnprdUpdate.Visible = false;
                        btnprdSave.Visible = true;
                        divalert.Visible = true;
                        clr();
                        lblAlert.Text = "Product Updated Successfully ";
                        ((Product)this.Page).loadDataTable();
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
                    lblmsgprodname.ForeColor = System.Drawing.Color.Red;
                    lblmsgprodname.Text = "This Product Name already Exists";
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
            ddlTaxgroup.SelectedIndex = 0;
            ddlUnit.SelectedIndex = 0;
        }

        #endregion


        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string pagename= Path.GetFileName(Request.Path);
                if (pagename == "Purchase.aspx" || pagename == "Sale.aspx")
                {
                    spncategory.Visible = false;
                    spnunit.Visible = false;
                    spngodown.Visible = false;
                    spnrack.Visible = false;
                }
                else
                {
                    spncategory.Visible = true;
                    spnunit.Visible = true;
                    spngodown.Visible = true;
                    spnrack.Visible = true;
                }
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

        protected void btnprdSave_Click(object sender, EventArgs e)
        {
            savedcode();
        }

        protected void btnprdUpdate_Click(object sender, EventArgs e)
        {
            updatecode();
        }

        protected void btncloseofmodelcategory_ServerClick(object sender, EventArgs e)
        {
                //on close of popup below code will select last inserted category in category dropdown
                var set = context.tbl_category.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).OrderByDescending(x => x.category_id).FirstOrDefault();
                ddlcategorybind();
                ddlCategory.SelectedValue = set.category_id.ToString(); 
        }

        protected void btnrckmodelclose_ServerClick(object sender, EventArgs e)
        {
            // on close of popup below code will select last inserted Rack in Rack dropdown
            int g_id = Convert.ToInt32(ddlGodown.SelectedValue);
            var set = context.tbl_rack.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId && x.godown_id == g_id).OrderByDescending(x => x.rack_id).FirstOrDefault();
            ddlrackbind(g_id);
            if (set != null)
            {
                ddlRack.SelectedValue = set.rack_id.ToString();    
            }

        }

        protected void btngwdnmodelclose_ServerClick(object sender, EventArgs e)
        {
            // on close of popup below code will select last inserted Godown in Godown dropdown
            var set = context.tbl_godown.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).OrderByDescending(x => x.godown_id).FirstOrDefault();
            ddlgodownbind();
            ddlGodown.SelectedValue = set.godown_id.ToString();
            //UC_Rack r = new UC_Rack();
            //r.ddlgodownbind(companyId);
        }

        protected void btnunitmodelclose_ServerClick(object sender, EventArgs e)
        {
            // on close of popup below code will select last inserted Unit in unit dropdown
            var set = context.tbl_unit.Where(x => x.status == true && x.company_id == companyId && x.branch_id == branchId).OrderByDescending(x => x.unit_id).FirstOrDefault();
            ddlunitbind();
            ddlUnit.SelectedValue = set.unit_id.ToString();
        }

        #endregion




    }
}