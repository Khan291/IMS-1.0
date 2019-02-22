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
using System.IO;
using IMS.Reports;

namespace IMS.Reports
{
    public class Product
    {
        public int product_id { get; set; }
        public int? reorder_level { get; set; }
        public string product_name { get; set; }
        public int? qty { get; set; }
    }
    public partial class CommonReport : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        string connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        int companyId, branchId;
        string User_id;
        Boolean isReportTypeBalance=false;
        Boolean isReportTypeStockReport = false;
        Boolean isReportTypeproductInventory = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();
            if (!IsPostBack)
            {
                BindProducts();
                BindVendors();
                BindCustomers();

                ddlFilerBy.Items[4].Enabled = false;
            }
            logo();
        }

        private void BindProducts()
        
        {
            var products = context.tbl_product.Where(w => w.company_id == companyId).Select(s => new Product {product_id= s.product_id,product_name= s.product_name, reorder_level= s.reorder_level }).ToList();

            if (ddlReportType.SelectedItem.Text == "Low Stock Report")
            {
                products = products.Join(context.tbl_stock, p => p.product_id, s => s.product_id, (p, s) => new Product { qty = s.qty, reorder_level = p.reorder_level, product_id = p.product_id ,product_name=p.product_name}).Where(w => w.qty < w.reorder_level).ToList();
            }

            lstProduct.DataTextField = "product_name";
            lstProduct.DataValueField = "product_id";
            lstProduct.DataSource = products;
            lstProduct.DataBind();
        }
        private void BindVendors()
        {
            var party = context.tbl_party.Where(w => w.company_id == companyId && w.party_type == "Vendor").ToList();
            lstVendor.DataTextField = "party_name";
            lstVendor.DataValueField = "party_id";
            lstVendor.DataSource = party;
            lstVendor.DataBind();
        }
        private void BindCustomers()
        {
            var party = context.tbl_party.Where(w => w.company_id == companyId && w.party_type == "Customer").ToList();
            lstCustomers.DataTextField = "party_name";
            lstCustomers.DataValueField = "party_id";
            lstCustomers.DataSource = party;
            lstCustomers.DataBind();
        }

        private void BindGodowns()
        {
            var godown = context.tbl_godown.Where(w => w.company_id == companyId ).ToList();
            lstGodowns.DataTextField = "godown_name";
            lstGodowns.DataValueField = "godown_id";
            lstGodowns.DataSource = godown;
            lstGodowns.DataBind();
        }

        public void clear()
        {
            displayReportSection.Visible = false;
            ddlReportType.SelectedIndex = 0;
            ddlFilerBy.SelectedIndex = 0;
            lstProduct.Items.Clear();
            txtStartDate.Text = string.Empty;
            txtenddate.Text = string.Empty;
            ddlFilerBy.Enabled = true;
            txtStartDate.Enabled = true;
            txtenddate.Enabled = true;
            lstCustomers.Items.Clear();
            lstGodowns.Items.Clear();
            lstVendor.Items.Clear();
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        private bool ValidDate()
        {
            bool valid=false;
            if (txtStartDate.Text != "" && txtenddate.Text != "")
            {
                valid = true;
                
            }
            else if (cbEnable.Checked)
            {
                valid = true;
            }
            return valid;
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidDate())
                {
                    displayReportSection.Visible = true;
                    var filterIds = string.Empty;
                    foreach (ListItem item in lstProduct.Items)
                    {
                        if (item.Selected)
                        {
                            filterIds += item.Value + ",";
                        }
                    }

                    foreach (ListItem item in lstVendor.Items)
                    {
                        if (item.Selected)
                        {
                            filterIds += "," + item.Value;
                        }
                    }
                    foreach (ListItem item in lstCustomers.Items)
                    {
                        if (item.Selected)
                        {
                            filterIds += "," + item.Value;
                        }
                    }
                    foreach (ListItem item in lstGodowns.Items)
                    {
                        if (item.Selected)
                        {
                            filterIds += "," + item.Value;
                        }
                    }
                    //if (ddlReportType.SelectedItem.Text != "Stock Report")
                    //{
                    //    btnSearch.ValidationGroup = "search";
                    //}

                    SqlParameter[] sqlParams;
                    int companyId = Convert.ToInt32(Session["company_id"]);

                    string reportDataSet = string.Empty;
                    string dataTable = string.Empty;
                    CommonDataSet ds = new CommonDataSet();
                    string reportType = string.Empty;
                    switch (ddlReportType.SelectedItem.Text)
                    {

                        case "Stock Report":
                            isReportTypeStockReport = true;
                            if (ddlFilerBy.SelectedItem.Text == "Product Wise")
                            {
                                reportType = "PRODUCTSTOCKREPORT";
                                isReportTypeproductInventory = true;
                            }
                            else if (ddlFilerBy.SelectedItem.Text == "Godown Wise")
                            {
                                reportType = "GODOWNSTOCKREPORT";
                            }
                            sqlParams = new SqlParameter[] {
                         new SqlParameter("@ReportType",reportType),
                         new SqlParameter("@CompanyId", companyId),
                          new SqlParameter("@start_date",txtStartDate.Text),
                           new SqlParameter("@end_date",txtenddate.Text),
                          new SqlParameter("@FilterIds",filterIds)
                    };
                            CreateReport(connectionstring, "CommonReport", sqlParams);
                            break;

                        case "Low Stock Report":
                           
                            
                                reportType = "LOWSTOCKREPORT";
                                isReportTypeproductInventory = true;
                           
                           
                            sqlParams = new SqlParameter[] {
                         new SqlParameter("@ReportType",reportType),
                         new SqlParameter("@CompanyId", companyId),
                          new SqlParameter("@start_date",txtStartDate.Text),
                           new SqlParameter("@end_date",txtenddate.Text),
                          new SqlParameter("@FilterIds",filterIds)
                    };
                            CreateReport(connectionstring, "CommonReport", sqlParams);
                            break;
                        case "Inventory Report":

                            //string reportType = string.Empty;
                            if (ddlFilerBy.SelectedItem.Text == "Product Wise")
                            {
                                reportType = "PRODUCTINVENTORYREPORT";
                                isReportTypeproductInventory = true;
                            }
                            else if (ddlFilerBy.SelectedItem.Text == "Vendor Wise")
                            {
                                reportType = "VENDORINVENTORYREPORT";
                            }
                            else if (ddlFilerBy.SelectedItem.Text == "Cutomer Wise")
                            {
                                reportType = "CUSTOMERINVENTORYREPORT";
                            }
                            sqlParams = new SqlParameter[] {
                         new SqlParameter("@ReportType",reportType),
                         new SqlParameter("@CompanyId", companyId),
                          new SqlParameter("@start_date",txtStartDate.Text),
                           new SqlParameter("@end_date",txtenddate.Text),
                          new SqlParameter("@FilterIds",filterIds)
                    };

                            CreateReport(connectionstring, "CommonReport", sqlParams);
                            break;
                        case "Balance Report":
                            isReportTypeBalance = true;
                            if (ddlFilerBy.SelectedItem.Text == "Cutomer Wise")
                            {
                                reportType = "CUSTOMERBALANCEREPORT";
                                
                            }
                            else if (ddlFilerBy.SelectedItem.Text == "Vendor Wise")
                            {
                                reportType = "VENDORBALANCEREPORT";
                            }
                            sqlParams = new SqlParameter[] {
                         new SqlParameter("@ReportType",reportType),
                         new SqlParameter("@CompanyId", companyId),
                          new SqlParameter("@start_date",txtStartDate.Text),
                           new SqlParameter("@end_date",txtenddate.Text),
                          new SqlParameter("@FilterIds",filterIds)
                    };
                            CreateReport(connectionstring, "CommonReport", sqlParams);
                            break;

                        default:
                            break;
                    }

                }

                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter The Dates Or Check The Financial Year CheckeBox ');", true);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }

        }

        protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                cbEnable.Checked = false;
                if (ddlReportType.SelectedItem.Text == "Low Stock Report")
                {
                    ddlFilerBy.Items[1].Enabled = true;
                    ddlFilerBy.Items[2].Enabled = false;
                    ddlFilerBy.Items[3].Enabled = false;
                    ddlFilerBy.Items[4].Enabled = false;
                    //ddlFilerBy.Items[5].Enabled = false;

                }
                //else
                //{
                //    ddlFilerBy.Items[2].Enabled = true;
                //    ddlFilerBy.Items[3].Enabled = true;
                //    ddlFilerBy.Items[4].Enabled = true;
                //    ddlFilerBy.Items[5].Enabled = true;
                //}
                else if (ddlReportType.SelectedItem.Text == "Stock Report")
                {   
                    ddlFilerBy.Items[2].Enabled = false;
                    ddlFilerBy.Items[3].Enabled = false;
                    ddlFilerBy.Items[4].Enabled = true;
                    //ddlFilerBy.Enabled = false;
                    //txtenddate.Enabled = false;
                    //txtStartDate.Enabled = false;
                    
                }
                //else
                //{
                //    ddlFilerBy.Items[2].Enabled = true;
                //    ddlFilerBy.Items[3].Enabled = true;
                //    ddlFilerBy.Items[4].Enabled = false;
                //    txtenddate.Enabled = true;
                //    txtStartDate.Enabled = true;
                //}
                else if (ddlReportType.SelectedItem.Text == "Balance Report")
                {
                    ddlFilerBy.Items[1].Enabled = false;
                    ddlFilerBy.Items[2].Enabled = true;
                    ddlFilerBy.Items[3].Enabled = true;
                    ddlFilerBy.Items[4].Enabled = false;
                }
                else
                {
                    ddlFilerBy.Items[1].Enabled = true; 
                    ddlFilerBy.Items[2].Enabled = true;
                    ddlFilerBy.Items[3].Enabled = true;
                    ddlFilerBy.Items[4].Enabled = true;
                    txtenddate.Enabled = true;
                    txtStartDate.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }


        public void CreateReport(String connectionstring, string storeProcedureName, SqlParameter[] parameter)
        {
            var ds = Common.FillDataSet(connectionstring, storeProcedureName, parameter);
            try
            {
                if (ds != null)
                {
                    if (ds.Tables["Table"].Rows.Count > 0  )
                    {
                        lblCompanyName.Text = ds.Tables["Table"].Rows[0]["Company"].ToString();
                        lblAddress.Text = ds.Tables["Table"].Rows[0]["CompanyAddress"].ToString();
                        lblStartDate.Text = ds.Tables["Table"].Rows[0]["StartDate"].ToString();
                        lblEndDate.Text = ds.Tables["Table"].Rows[0]["EndDate"].ToString();
                        //lblpartyname.Text = ds.Tables["Table"].Rows[0]["Party"].ToString();
                        //lblpartyaddress.Text = ds.Tables["Table"].Rows[0]["PartyAddress"].ToString();
                    }

                    if (!isReportTypeBalance)
                    {
                        ds.Tables["Table"].Columns.Remove("Date");
                    }

                    
                    if (!isReportTypeproductInventory && !isReportTypeBalance && !isReportTypeStockReport)
                    {
                        ds.Tables["Table"].Columns.Remove("PartyId");
                        ds.Tables["Table"].Columns.Remove("CompanyId");
                        ds.Tables["Table"].Columns.Remove("Id");

                    }
                    if (isReportTypeStockReport)
                    {
                        ds.Tables["Table"].Columns.Remove("batch_id");
                        ds.Tables["Table"].Columns.Remove("modified_date");
                        ds.Tables["Table"].Columns.Remove("company_id");
                        ds.Tables["Table"].Columns.Remove("InvoiceNumber");
                        ds.Tables["Table"].Columns.Remove("PartyId");
                        ds.Tables["Table"].Columns.Remove("Party");
                    }
                    ds.Tables["Table"].Columns.Remove("Company");
                    ds.Tables["Table"].Columns.Remove("CompanyAddress");
                    ds.Tables["Table"].Columns.Remove("StartDate");
                    ds.Tables["Table"].Columns.Remove("EndDate");
                    ds.Tables["Table"].Columns.Remove("PartyAddress");
                    grdreport.DataSource = ds.Tables["Table"];
                    grdreport.DataBind();
                }

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void ddlFilerBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlFilerBy.SelectedItem.Text == "Product Wise" || ddlFilerBy.SelectedItem.Text == "Low Stock Report")
                {
                    BindProducts();
                    Products.Visible = true;
                    Vendors.Visible = false;
                    Customers.Visible = false;
                    Godowns.Visible = false;
                }
                else if (ddlFilerBy.SelectedItem.Text == "Vendor Wise")
                {
                    BindVendors();
                    Vendors.Visible = true;
                    Customers.Visible = false;
                    Products.Visible = false;
                    Godowns.Visible = false;
                }
                else if (ddlFilerBy.SelectedItem.Text == "Cutomer Wise")
                {
                    BindCustomers();
                    Vendors.Visible = false;
                    Products.Visible = false;
                    Customers.Visible = true;
                    Godowns.Visible = false;
                }
                else if (ddlFilerBy.SelectedItem.Text == "Godown Wise")
                {
                    BindGodowns();
                    Vendors.Visible = false;
                    Products.Visible = false;
                    Customers.Visible = false;
                    Godowns.Visible = true;
                }

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        private void SessionValue()
        {
            if (Session["UserID"] == null || Session["company_id"] == null || Session["branch_id"] == null)
            {
                Response.Redirect("~/Registration/Login.aspx");
            }
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }

        protected void grdreport_DataBound(object sender, EventArgs e)
        {
            try
            {
                int firstRowSpan = 2;
                int secondRowSpan = 2;
                for (int i = grdreport.Rows.Count - 2; i >= 0; i--)
                {
                    GridViewRow currRow = grdreport.Rows[i];
                    GridViewRow prevRow = grdreport.Rows[i + 1];
                    if (currRow.Cells[1].Text == prevRow.Cells[1].Text)
                    {
                        currRow.Cells[1].RowSpan = firstRowSpan;
                        prevRow.Cells[1].Visible = false;
                        firstRowSpan += 1;

                        currRow.Cells[0].RowSpan = secondRowSpan;
                        prevRow.Cells[0].Visible = false;
                        secondRowSpan += 1;
                    }
                    else
                    {
                        firstRowSpan = 2;
                        secondRowSpan = 2;
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        public void logo()
        {
            var logo = context.tbl_company.Where(w => w.company_id == companyId).FirstOrDefault();
            try
            {

                if (logo != null)
                {

                    if (File.Exists(Server.MapPath(logo.logo)))
                    {
                        imglogo.ImageUrl = logo.logo;
                    }
                    else
                    {
                        imglogo.Visible = false;
                        lblIms.Visible = true;
                    }
                }
                else
                {
                    imglogo.Visible = false;
                    lblIms.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void cbEnable_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                if (cbEnable.Checked)
                {
                    txtStartDate.Enabled = false;
                    txtenddate.Enabled = false;
                }
                else
                {
                    txtStartDate.Enabled = true;
                    txtenddate.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }







    }
}