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
using System.Data.Entity.Core.Objects;
using System.Globalization;
using IMS.Models;
using IMSBLL.DTO;

namespace IMS
{
    public partial class Purchase : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        int companyId = 0, branchId = 0, financialYearId = 0;
        string user_id = string.Empty;
        bool viewOrPayBalance = false;
        int purchase_Id = 0;
        int counter = 0;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);

        SqlHelper helper = new SqlHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["ReportName"] != null && Request.QueryString["Id"] != null)
                {
                    viewOrPayBalance = Convert.ToBoolean(Request.QueryString["ReportName"]);
                    purchase_Id = Convert.ToInt32(Request.QueryString["Id"]);

                    if (viewOrPayBalance)
                    {

                    }
                }

                SessionValue();
                if (!IsPostBack)
                {
                   // CalendarExtender1.StartDate = DateTime.Now.Date;
                    //txtdate.Text = DateTime.Now.ToString();
                    if (ViewState["Details"] == null)
                    {
                        DataTable dataTable = new DataTable();

                        dataTable.Columns.Add("Vendore");
                        dataTable.Columns.Add("Product_id");
                        dataTable.Columns.Add("PON");
                        dataTable.Columns.Add("Date");
                        dataTable.Columns.Add("Product");
                        dataTable.Columns.Add("Batch");
                        dataTable.Columns.Add("Batch_id");
                        dataTable.Columns.Add("Quantity");
                        dataTable.Columns.Add("Price");
                        dataTable.Columns.Add("Discount");
                        dataTable.Columns.Add("Discount Amount");
                        dataTable.Columns.Add("SalePrice");
                        dataTable.Columns.Add("Sub Total");
                        dataTable.Columns.Add("group_id");
                        dataTable.Columns.Add("totalTaxAmnt");
                        dataTable.Columns.Add("group_name");
                        dataTable.Columns.Add("taxPercentage");
                        ViewState["Details"] = dataTable;
                    }
                    this.BindGrid();

                    if (ViewState["TaxDetails"] == null)
                    {
                        DataTable dataTable2 = new DataTable();

                        dataTable2.Columns.Add("product_name");
                        dataTable2.Columns.Add("product_id");
                        dataTable2.Columns.Add("group_id");
                        dataTable2.Columns.Add("group_name");
                        dataTable2.Columns.Add("type_name");
                        dataTable2.Columns.Add("tax_percentage");
                        dataTable2.Columns.Add("totalTaxPercetage");
                        dataTable2.Columns.Add("totalTaxAmnt");
                        dataTable2.Columns.Add("type_id");
                        ViewState["TaxDetails"] = dataTable2;
                    }
                    this.BindTaxGrid();
                    ddlVendorbind();
                    ddlproductbind();
                    ddlbatchbind();
                    //txtdate.Text = DateTime.Now.ToString();
                    ddlpaymentmodebind();
                    getdate();
                    lblInvoice.Text = Common.GenerateInvoicenumber(companyId, branchId, Constants.Purchase);
                    ClearAll();
                }

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void SaveAPI()
        {
            try
            {
                PurchaseViewModel purchaseViewModel = new PurchaseViewModel();


                // tbl_purchase purchase = new tbl_purchase();
                purchaseViewModel.company_id = companyId;
                purchaseViewModel.branch_id = branchId;
                purchaseViewModel.financialyear_id = financialYearId;
                purchaseViewModel.InvoiceNumber = lblInvoice.Text;

                purchaseViewModel.PaymentMode_id = Convert.ToInt32(ddlPaymentMode.SelectedValue);
                purchaseViewModel.status = true;
                purchaseViewModel.party_id = Convert.ToInt32(ddlVendor.SelectedValue);
                purchaseViewModel.Po_Date = DateTime.ParseExact(txtdate.Text, "dd/MM/yyyy", new CultureInfo("en-US"));
                purchaseViewModel.po_no = txtPONo.Text;
                purchaseViewModel.Note = txtNotePurchase.Text;
                purchaseViewModel.other_expenses = Convert.ToDecimal(txtotherexpence.Text);

                purchaseViewModel.created_by = user_id;
                purchaseViewModel.created_date = DateTime.Now;

                //insert into Purchase Payment Details 
                purchaseViewModel.TaxAmount = Convert.ToDecimal(lblTaxAmount.Text);
                purchaseViewModel.DiscountAmount = Convert.ToDecimal(lblDiscountAmt.Text);
                purchaseViewModel.SubTotal = Convert.ToDecimal(lblsubtotal.Text);
                purchaseViewModel.GrandTotal = Convert.ToDecimal(lblGrandTotal.Text);
                purchaseViewModel.PaidAmnt = Convert.ToDecimal(txtPaidAmt.Text);
                purchaseViewModel.GivenAmnt = Convert.ToDecimal(txtPaidAmt.Text);
                purchaseViewModel.BalanceAmnt = Convert.ToDecimal(txtBalanceAmt.Text);
                purchaseViewModel.FromTable = "Purchase";
               


                for (int i = 0; i <= gvpurchasedetails.Rows.Count - 1; i++)
                {
                    int productId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[2].Text);
                    int batchId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[4].Text);
                    tbl_product product = context.tbl_product.Where(w => w.product_id == productId).FirstOrDefault();
                    var qty = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                    //Add into Purchase Details table for each product
                    List<tbl_purchasedetails> lstPurchaseDetails = new List<tbl_purchasedetails>();
                    tbl_purchasedetails purchaseDetails = new tbl_purchasedetails();
                    purchaseDetails.product_id = productId;
                    purchaseDetails.batch_id = batchId;
                    // purchaseDetails.tax_id = product.tax_id;
                    purchaseDetails.unit_id = product.unit_id;
                    purchaseDetails.tax_amt = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[13].Text);
                    purchaseDetails.dicount_amt = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[9].Text);
                    purchaseDetails.quantity = qty;
                    purchaseDetails.amount = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[10].Text);
                    purchaseDetails.created_by = Convert.ToString(user_id);
                    purchaseDetails.created_date = DateTime.Now;
                    purchaseDetails.status = true;

                    var groupId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[11].Text);

                    DataTable taxgroupTypes = helper.LINQToDataTable(context.SelectProductTaxGroup(groupId, productId, qty));
                    ViewState["TotalTaxPercent"] = null;
                    for (int j = 0; j <= taxgroupTypes.Rows.Count - 1; j++)
                    {
                        ViewState["TotalTaxPercent"] = taxgroupTypes.Rows[j].Field<decimal>("totalTaxPercetage");
                    }

                    //insert into tax group purchase
                    tbl_purchasetaxgroup purchaseTaxGroup = new tbl_purchasetaxgroup();
                    purchaseTaxGroup.group_id = groupId;
                    purchaseTaxGroup.product_id = productId;
                    //purchaseTaxGroup.totalTaxPercentage = (Decimal)ViewState["TotalTaxPercent"];
                    purchaseTaxGroup.group_name = gvpurchasedetails.Rows[i].Cells[12].Text;
                    //Get the Tax type saved from db 
                    //insert into tax group detailes
                    // var taxGroupTypes = context.tbl_productTaxGroup.Join(context.tbl_taxgroup, t => t.group_id, pt => pt.group_id, (t, pt) => new { t.group_id, pt.group_name, t.product_id }).Where(t => t.product_id == productId).ToList();


                    for (int j = 0; j <= taxgroupTypes.Rows.Count - 1; j++)
                    {
                        tbl_purchasetaxgroupdetails purchaseTaxDetails = new tbl_purchasetaxgroupdetails();
                        purchaseTaxDetails.type_id = taxgroupTypes.Rows[j].Field<int>("type_id");
                        purchaseTaxDetails.tax_percentage = taxgroupTypes.Rows[j].Field<decimal>("tax_percentage");
                        purchaseTaxGroup.tbl_purchasetaxgroupdetails.Add(purchaseTaxDetails);
                    }

                    purchase.tbl_purchasetaxgroup.Add(purchaseTaxGroup);
                    //Enter Details In tbl_ActualPurchaseTaxAndPrice : to get the original Values at the time of Purchase Return
                    tbl_ActualPurchaseTaxAndPrice actualPurchase = new tbl_ActualPurchaseTaxAndPrice();
                    actualPurchase.product_id = productId;
                    actualPurchase.status = true;
                    //actualPurchase.tax_percent = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[10].Text);
                    actualPurchase.purchase_rate = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[6].Text);
                    actualPurchase.discount_percent = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[8].Text);
                    actualPurchase.discount_amnt = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[9].Text);
                    actualPurchase.batch_id = batchId;
                    actualPurchase.sale_price = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[7].Text);
                    actualPurchase.created_by = Convert.ToString(user_id);
                    actualPurchase.created_date = DateTime.Now;

                    //Add into Actual Purchase Tax And Return Table
                    purchaseViewModel.tbl_ActualPurchaseTaxAndPrice.Add(actualPurchase);


                    //Add Stock if not exist or update the Stock against the product
                    tbl_stock stock = new tbl_stock();
                    if (!IsProductStockExists(companyId, branchId, productId, batchId))
                    {
                        stock.company_id = companyId;
                        stock.branch_id = branchId;
                        stock.product_id = productId;
                        stock.batch_id = batchId;
                        stock.qty = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                        stock.status = true;
                        stock.created_by = Convert.ToString(user_id);
                        stock.created_date = DateTime.Now;
                        context.tbl_stock.Add(stock);
                    }
                    else
                    {
                        stock = context.tbl_stock.Where(w => w.company_id == companyId && w.branch_id == branchId && w.product_id == productId && w.batch_id == batchId).FirstOrDefault();
                        stock.qty = stock.qty + Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                        stock.modified_by = Convert.ToString(user_id);
                        stock.modified_date = DateTime.Now;
                    }
                    purchaseViewModel.tbl_purchasedetails.Add(purchaseDetails);
                }


                //context.tbl_purchase.Add(purchase);
                //context.SaveChanges();
                //string order = purchase.InvoiceNumber;
                //Session["p_id"] = purchase.purchase_id;
                //ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Saved successfully, Your order number is " + order + "');", true);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        //Methods------------------
        protected void Save()
        {
            try
            {

                tbl_purchase purchase = new tbl_purchase();
                purchase.company_id = companyId;
                purchase.branch_id = branchId;
                purchase.financialyear_id = financialYearId;
                purchase.InvoiceNumber = lblInvoice.Text;

                purchase.PaymentMode_id = Convert.ToInt32(ddlPaymentMode.SelectedValue);
                purchase.status = true;
                purchase.party_id = Convert.ToInt32(ddlVendor.SelectedValue);
                purchase.Po_Date = DateTime.ParseExact(txtdate.Text, "dd/MM/yyyy", new CultureInfo("en-US"));
                purchase.po_no = txtPONo.Text;
                purchase.Note = txtNotePurchase.Text;
                purchase.other_expenses = Convert.ToDecimal(txtotherexpence.Text);
                
                purchase.created_by = user_id;
                purchase.created_date = DateTime.Now;

                //insert into Purchase Payment Details 
                tbl_PurchasePaymentDetials purchasePaymentDetail = new tbl_PurchasePaymentDetials();
                purchasePaymentDetail.TaxAmount = Convert.ToDecimal(lblTaxAmount.Text);
                purchasePaymentDetail.DiscountAmount = Convert.ToDecimal(lblDiscountAmt.Text);
                purchasePaymentDetail.SubTotal = Convert.ToDecimal(lblsubtotal.Text);
                purchasePaymentDetail.GrandTotal = Convert.ToDecimal(lblGrandTotal.Text);
                purchasePaymentDetail.PaidAmnt = Convert.ToDecimal(txtPaidAmt.Text);
                purchasePaymentDetail.GivenAmnt = Convert.ToDecimal(txtPaidAmt.Text);
                purchasePaymentDetail.BalanceAmnt = Convert.ToDecimal(txtBalanceAmt.Text);
                purchasePaymentDetail.CreatedDate = DateTime.Now;
                purchasePaymentDetail.CreatedBy = user_id;
                purchasePaymentDetail.FromTable = "Purchase";
                purchase.tbl_PurchasePaymentDetials.Add(purchasePaymentDetail);
                

                for (int i = 0; i <= gvpurchasedetails.Rows.Count - 1; i++)
                {
                    int productId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[2].Text);
                    int batchId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[4].Text);
                    tbl_product product = context.tbl_product.Where(w => w.product_id == productId).FirstOrDefault();
                    var qty = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                    //Add into Purchase Details table for each product
                    tbl_purchasedetails purchaseDetails = new tbl_purchasedetails();
                    purchaseDetails.product_id = productId;
                    purchaseDetails.batch_id = batchId;
                    // purchaseDetails.tax_id = product.tax_id;
                    purchaseDetails.unit_id = product.unit_id;
                    purchaseDetails.tax_amt = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[13].Text);
                    purchaseDetails.dicount_amt = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[9].Text);
                    purchaseDetails.quantity = qty;
                    purchaseDetails.amount = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[14].Text);
                    purchaseDetails.created_by = Convert.ToString(user_id);
                    purchaseDetails.created_date = DateTime.Now;
                    purchaseDetails.status = true;

                    var groupId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[10].Text);

                    DataTable taxgroupTypes = helper.LINQToDataTable(context.SelectProductTaxGroup(groupId, productId, qty));
                    ViewState["TotalTaxPercent"] = null;
                    for (int j = 0; j <= taxgroupTypes.Rows.Count - 1; j++)
                    {
                        ViewState["TotalTaxPercent"] = taxgroupTypes.Rows[j].Field<decimal>("totalTaxPercetage");
                    }

                    //insert into tax group purchase
                    tbl_purchasetaxgroup purchaseTaxGroup = new tbl_purchasetaxgroup();
                    purchaseTaxGroup.group_id = groupId;
                    purchaseTaxGroup.product_id = productId;
                    purchaseTaxGroup.totalTaxPercentage = (Decimal)ViewState["TotalTaxPercent"];
                    purchaseTaxGroup.group_name = gvpurchasedetails.Rows[i].Cells[11].Text;
                    //Get the Tax type saved from db 
                    //insert into tax group detailes
                    // var taxGroupTypes = context.tbl_productTaxGroup.Join(context.tbl_taxgroup, t => t.group_id, pt => pt.group_id, (t, pt) => new { t.group_id, pt.group_name, t.product_id }).Where(t => t.product_id == productId).ToList();
                    

                    for (int j = 0; j <= taxgroupTypes.Rows.Count - 1; j++)
                    {
                        tbl_purchasetaxgroupdetails purchaseTaxDetails = new tbl_purchasetaxgroupdetails();
                        purchaseTaxDetails.type_id = taxgroupTypes.Rows[j].Field<int>("type_id");
                        purchaseTaxDetails.tax_percentage = taxgroupTypes.Rows[j].Field<decimal>("tax_percentage");                       
                        purchaseTaxGroup.tbl_purchasetaxgroupdetails.Add(purchaseTaxDetails);
                    }

                    purchase.tbl_purchasetaxgroup.Add(purchaseTaxGroup);
                    //Enter Details In tbl_ActualPurchaseTaxAndPrice : to get the original Values at the time of Purchase Return
                    tbl_ActualPurchaseTaxAndPrice actualPurchase = new tbl_ActualPurchaseTaxAndPrice();
                    actualPurchase.product_id = productId;
                    actualPurchase.status = true;
                    //actualPurchase.tax_percent = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[10].Text);
                    actualPurchase.purchase_rate = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[6].Text);
                    actualPurchase.discount_percent = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[8].Text);
                    actualPurchase.discount_amnt = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[9].Text);
                    actualPurchase.batch_id = batchId;
                    actualPurchase.sale_price = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[7].Text);
                    actualPurchase.created_by = Convert.ToString(user_id);
                    actualPurchase.created_date = DateTime.Now;

                    //Add into Actual Purchase Tax And Return Table
                    purchase.tbl_ActualPurchaseTaxAndPrice.Add(actualPurchase);


                    //Add Stock if not exist or update the Stock against the product
                    tbl_stock stock = new tbl_stock();
                    if (!IsProductStockExists(companyId, branchId, productId, batchId))
                    {
                        stock.company_id = companyId;
                        stock.branch_id = branchId;
                        stock.product_id = productId;
                        stock.batch_id = batchId;
                        stock.qty = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                        stock.status = true;
                        stock.created_by = Convert.ToString(user_id);
                        stock.created_date = DateTime.Now;
                        context.tbl_stock.Add(stock);
                    }
                    else
                    {
                        stock = context.tbl_stock.Where(w => w.company_id == companyId && w.branch_id == branchId && w.product_id == productId && w.batch_id == batchId).FirstOrDefault();
                        stock.qty = stock.qty + Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                        stock.modified_by = Convert.ToString(user_id);
                        stock.modified_date = DateTime.Now;
                    }
                    purchase.tbl_purchasedetails.Add(purchaseDetails);
                }


                context.tbl_purchase.Add(purchase);
                context.SaveChanges();
                string order = purchase.InvoiceNumber;
                Session["p_id"] = purchase.purchase_id;
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Saved successfully, Your order number is " + order + "');", true);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }


        private bool IsProductStockExists(int companyId, int branchId, int productId, int batchId)
        {
            return context.tbl_stock.Where(w => w.company_id == companyId && w.branch_id == branchId && w.product_id == productId && w.batch_id == batchId).Any();
        }

        private void SessionValue()
        {
            if (Session["UserID"] == null || Session["company_id"] == null || Session["branch_id"] == null || Session["financialyear_id"] == null)
            {
                Response.Redirect("~/Registration/Login.aspx");
            }
            user_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
            financialYearId = Convert.ToInt32(Session["financialyear_id"]);
        }


        public void clr()
        {
            ddlBatch.SelectedIndex = 0;
            ddlproduct.SelectedIndex = 0;
            txtquantity.Text = string.Empty;
            txtprice.Text = string.Empty;
            txtDiscount.Text = string.Empty;
            txtsalesprice.Text = string.Empty;
            ddlTaxGroup.SelectedIndex = 0;
            txtPaidAmt.Text = string.Empty;
            txtBalanceAmt.Text = string.Empty;
        }
        public void ClearAll()
        {
            txtdate.Text = string.Empty;
            txtPONo.Text = string.Empty;
            ddlVendor.SelectedIndex = 0;
            ddlBatch.SelectedIndex = 0;
            ddlproduct.SelectedIndex = 0;
            txtquantity.Text = string.Empty;
            txtprice.Text = string.Empty;
            txtDiscount.Text = string.Empty;
            txtsalesprice.Text = string.Empty;
            txtBalanceAmt.Text = string.Empty;
            txtPaidAmt.Text = string.Empty;
        }

        public void updatecal()
        {
            decimal a1 = Convert.ToDecimal(lblsubtotal.Text) - Convert.ToDecimal(ViewState["subtot"]);
            decimal b1 = Convert.ToDecimal(lblDiscountAmt.Text) - Convert.ToDecimal(ViewState["discountamount"]);
            decimal c = Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(ViewState["taxamount"]);
            lblsubtotal.Text = a1.ToString();
            lblDiscountAmt.Text = b1.ToString();
            lblTaxAmount.Text = c.ToString();
            decimal d = (a1 + c) - b1;
            lblGrandTotal.Text = d.ToString();
        }
        public void ddlVendorbind()
        {

            List<tbl_party> cd = context.tbl_party.Where(x => x.status == true && x.company_id == companyId && x.party_type == "Vendor").ToList();
            ddlVendor.DataTextField = "party_name";
            ddlVendor.DataValueField = "party_id";
            ddlVendor.DataSource = cd;
            ddlVendor.DataBind();
            ddlVendor.Items.Insert(0, new ListItem("--Select Vendor--", "0"));
        }

        public void ddlproductbind()
        {
            //context.tbl_product.Where(x => x.status == true && x.company_id == c_id).ToList();
            ddlproduct.DataTextField = "product_name";
            ddlproduct.DataValueField = "product_id";
            ddlproduct.DataSource = context.tbl_product.Where(x => x.status == true && x.company_id == companyId).ToList();
            ddlproduct.DataBind();
            ddlproduct.Items.Insert(0, new ListItem("--Select Product--", "0"));
        }

        public void ddlbatchbind()
        {
            List<tbl_batch> cd = context.tbl_batch.Where(x => x.status == true && x.company_id == companyId).ToList();
            ddlBatch.DataTextField = "batch_name";
            ddlBatch.DataValueField = "batch_id";
            ddlBatch.DataSource = cd;
            ddlBatch.DataBind();
            ddlBatch.Items.Insert(0, new ListItem("--Select Batch--", "0"));
        }
        public void ddlpaymentmodebind()
        {
            List<tbl_paymentmode> cd = context.tbl_paymentmode.Where(x => x.status == true).ToList();
            ddlPaymentMode.DataTextField = "paymentmode_name";
            ddlPaymentMode.DataValueField = "paymentode_id";
            ddlPaymentMode.DataSource = cd;
            ddlPaymentMode.DataBind();
        }

        public bool validateddl()
        {
            if (ddlBatch.SelectedIndex == 0)
            {
                return false;
            }
            else
            {
                return true;
            }

        }
        protected void BindGrid()
        {
            try
            {
                gvpurchasedetails.DataSource = (DataTable)ViewState["Details"];
                gvpurchasedetails.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void BindTaxGrid()
        {
            try
            {
                gvTaxDetailsNew.DataSource = (DataTable)ViewState["TaxDetails"];
                gvTaxDetailsNew.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        //code done by afroz for other expence and hdfGrandTotalWithoutExpenses 
        public void calculation(decimal amt, decimal tax, decimal dis)
        {
            decimal tot = 0;
            decimal tottax = 0;
            decimal dec = 0;
            decimal gtot = 0;
            tot = Convert.ToDecimal(lblsubtotal.Text) + amt;
            lblsubtotal.Text = tot.ToString();
            tottax = Convert.ToDecimal(lblTaxAmount.Text) + tax;
            lblTaxAmount.Text = tottax.ToString();
            dec = Convert.ToDecimal(lblDiscountAmt.Text) + dis;
            lblDiscountAmt.Text = dec.ToString();
            if(string.IsNullOrWhiteSpace(txtotherexpence.Text))
            {
                txtotherexpence.Text = "0";
            }

            gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text) + Convert.ToDecimal(txtotherexpence.Text));
            lblGrandTotal.Text = gtot.ToString();
            hdfGrandTotalWithoutExpenses.Value = lblGrandTotal.Text;


        }

        public void ddltaxBind(int p_id)
        {
            var taxGroup = context.tbl_productTaxGroup.Join(context.tbl_taxgroup, t => t.group_id, pt => pt.group_id, (t, pt) => new { t.group_id, pt.group_name, t.product_id }).Where(t => t.product_id == p_id).ToList();
            ddlTaxGroup.DataValueField = "group_id";
            ddlTaxGroup.DataTextField = "group_name";
            ddlTaxGroup.DataSource = taxGroup;
            ddlTaxGroup.DataBind();
            ddlTaxGroup.Items.Insert(0, new ListItem("--Select tax--", "0"));
        }
        public void getdate()
        {
            try
            {
                //ef code awais
                var finicialyear = context.tbl_financialyear.Where(f => f.company_id == companyId && f.status == true).SingleOrDefault();
                hd1.Value = finicialyear.start_date;
                hd2.Value = finicialyear.end_date;

                CalendarExtender1.StartDate = Convert.ToDateTime(finicialyear.start_date);
                CalendarExtender1.EndDate = Convert.ToDateTime(finicialyear.end_date);
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
            }
        }

        //Events-----
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblcheckDoubleError.Text = string.Empty;
            try
            {
                string discount = txtDiscount.Text.Trim();
                int productId = Convert.ToInt32(ddlproduct.SelectedValue);
                int batchId = Convert.ToInt32(ddlBatch.SelectedValue);
                if (string.IsNullOrEmpty(discount))
                {
                    discount = "0";
                }

                if (!ValidateQuantity(productId, batchId))
                {
                    decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(txtprice.Text);
                    decimal a = subTotal / 100;
                    decimal discountamt = a * decimal.Parse(discount);
                    int groupTaxId = int.Parse(ddlTaxGroup.SelectedValue);




                    //Pouct Tax Group details Gridview Code


                    decimal qty = Convert.ToDecimal(txtquantity.Text);
                    DataTable taxDetailesGV = helper.LINQToDataTable(context.SelectProductTaxGroup(groupTaxId, productId, qty));
                    decimal tax_amnt = 0;
                    DataTable dt2 = (DataTable)ViewState["TaxDetails"];
                    decimal taxPercentage = 0;
                    if (taxDetailesGV.Rows.Count > 0)
                    {
                        for (int i = 0; i < taxDetailesGV.Rows.Count; i++)
                        {
                            dt2.Rows.Add(taxDetailesGV.Rows[i].Field<string>("product_name"),
                                          taxDetailesGV.Rows[i].Field<int>("product_id"),
                                           taxDetailesGV.Rows[i].Field<int>("group_id"),
                                          taxDetailesGV.Rows[i].Field<string>("group_name"),
                                          taxDetailesGV.Rows[i].Field<string>("type_name"),
                                          taxDetailesGV.Rows[i].Field<decimal>("tax_percentage"),
                                          taxDetailesGV.Rows[i].Field<decimal>("totalTaxPercetage"),
                                          taxDetailesGV.Rows[i].Field<decimal>("totalTaxAmnt"),
                                          taxDetailesGV.Rows[i].Field<int>("type_id")
                                          );
                            taxPercentage = taxDetailesGV.Rows[i].Field<decimal>("totalTaxPercetage");
                            tax_amnt = taxDetailesGV.Rows[i].Field<decimal>("totalTaxAmnt");
                        }
                    }
                    ViewState["TaxDetails"] = dt2;
                    this.BindTaxGrid();


                    DataTable dt = (DataTable)ViewState["Details"];
                    dt.Rows.Add(ddlVendor.SelectedItem.Text.Trim(), productId, txtPONo.Text.Trim(), txtdate.Text.Trim(), ddlproduct.SelectedItem.Text.Trim(), ddlBatch.SelectedItem.Text.Trim(),
                                      batchId, txtquantity.Text.Trim(), txtprice.Text.Trim(), discount, discountamt, txtsalesprice.Text.Trim(), subTotal, groupTaxId, tax_amnt, ddlTaxGroup.SelectedItem.Text,taxPercentage);
                    ViewState["Details"] = dt;
                    this.BindGrid();
                    lblcheckDoubleError.Text = string.Empty;
                    clr();
                    txtPaidAmt.Enabled = true;
                    calculation(subTotal, tax_amnt, discountamt);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }


        public bool ValidateQuantity(int productId, int batchId)
        {
            bool isfail = false;
            try
            {
                if (!btnUpdate.Visible)
                {
                    for (int i = 0; i <= gvpurchasedetails.Rows.Count - 1; i++)
                    {
                        int pId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[2].Text);
                        decimal qty = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[5].Text);
                        int bId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[4].Text);
                        if (pId == productId && batchId == bId)
                        {
                            isfail = true;
                            lblcheckDoubleError.Visible = true;
                            lblcheckDoubleError.Text = "Already product and batch added, Please select different product and batch or update existing product.";
                            return isfail;
                        }
                    }
                }
                decimal salePrice = Convert.ToDecimal(txtsalesprice.Text);
                decimal purchasePrice = Convert.ToDecimal(txtprice.Text);
                int taxGroupId = Convert.ToInt32(ddlTaxGroup.SelectedValue);
                //decimal tax= Convert.ToDecimal(txtTaxpercentage.Text);
                //var isProductExsits = context.tbl_ActualPurchaseTaxAndPrice.Where(w => w.product_id == productId && w.batch_id == batchId).FirstOrDefault();
                var isProductExsits = context.tbl_ActualPurchaseTaxAndPrice.Join(context.tbl_productTaxGroup, t => t.product_id, pt => pt.product_id,
                        (t, pt) => new { t.product_id, pt.group_id, t.batch_id, t.sale_price, t.purchase_rate }
                        ).Where(t => t.product_id == productId && t.batch_id == batchId).FirstOrDefault();
                if (isProductExsits != null)
                {
                    
                    // var samePriceExists = context.tbl_ActualPurchaseTaxAndPrice.Where(w => w.product_id == productId && w.batch_id == batchId && w.sale_price== salePrice && w.purchase_rate==purchasePrice && w.tax_percent== tax).Any();
                    if (isProductExsits.sale_price != salePrice || isProductExsits.purchase_rate != purchasePrice || isProductExsits.group_id != taxGroupId)
                    {
                        isfail = true;
                        lblcheckDoubleError.Visible = true;
                        lblcheckDoubleError.Text = "Please change batch, As per configuration Purchase Price, Sale Price Or Tax has been changed.";
                        return isfail;

                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return isfail;
        }
        protected void btnUpdate_Click(object sender, System.EventArgs e)
        {
            txtPaidAmt.Text = string.Empty;
            txtBalanceAmt.Text = string.Empty;
            lblcheckDoubleError.Text = string.Empty;
            ddlproduct.Enabled = true;
            try
            {
                DataTable dt = new DataTable();
                dt = (DataTable)ViewState["Details"];
                int productId = Convert.ToInt32(ddlproduct.SelectedValue);
                int batchId = Convert.ToInt32(ddlBatch.SelectedValue);
                string discount = txtDiscount.Text.Trim();
                if (discount == "" || discount == null)
                {
                    discount = "0";
                }

                if (!ValidateQuantity(productId, batchId))
                {


                    int groupTaxId = int.Parse(ddlTaxGroup.SelectedValue);

                    decimal qty = Convert.ToDecimal(txtquantity.Text);
                    SqlHelper helper = new SqlHelper();
                    DataTable taxDetailesGV = helper.LINQToDataTable(context.SelectProductTaxGroup(groupTaxId, productId, qty));
                    decimal tax_amnt = 0;
                    DataTable dt2 = (DataTable)ViewState["TaxDetails"];
                    decimal taxPercentage = 0;
                    if (taxDetailesGV.Rows.Count > 0)
                    {
                        for (int i = 0; i < taxDetailesGV.Rows.Count; i++)
                        {
                            dt2.Rows.Add(taxDetailesGV.Rows[i].Field<string>("product_name"),
                                          taxDetailesGV.Rows[i].Field<int>("product_id"),
                                           taxDetailesGV.Rows[i].Field<int>("group_id"),
                                          taxDetailesGV.Rows[i].Field<string>("group_name"),
                                          taxDetailesGV.Rows[i].Field<string>("type_name"),
                                          taxDetailesGV.Rows[i].Field<decimal>("tax_percentage"),
                                          taxDetailesGV.Rows[i].Field<decimal>("totalTaxPercetage"),
                                          taxDetailesGV.Rows[i].Field<decimal>("totalTaxAmnt"),
                                          taxDetailesGV.Rows[i].Field<int>("type_id")
                                          );
                            taxPercentage = taxDetailesGV.Rows[i].Field<decimal>("totalTaxPercetage");
                            tax_amnt = taxDetailesGV.Rows[i].Field<decimal>("totalTaxAmnt");
                        }
                    }
                    ViewState["TaxDetails"] = dt2;
                    this.BindTaxGrid();


                    DataRow dr = dt.Select("Product_id=" + productId + "").FirstOrDefault();
                    if (dr != null)
                    {
                        decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(dr["Price"]);
                        decimal a = subTotal / 100;
                        //decimal discount_percent = (Convert.ToDecimal(discount) * 100) / Convert.ToDecimal(dr["Sub Total"]);
                        decimal discountamt = a * Convert.ToDecimal(discount);
                        decimal tax_amount = tax_amnt;

                        dr["Quantity"] = txtquantity.Text;
                        dr["Discount"] = Convert.ToDecimal(discount);
                        dr["Discount Amount"] = discountamt;
                        dr["Sub Total"] = subTotal;
                        dr["Price"] = txtprice.Text;
                        dr["SalePrice"] = txtsalesprice.Text;
                        dr["Batch_id"] = batchId;
                        dr["Batch"] = ddlBatch.SelectedItem.Text.Trim();
                        dr["totalTaxAmnt"] = tax_amount;
                        dr["group_id"] = groupTaxId;
                        dr["group_name"] = ddlTaxGroup.SelectedItem.Text.Trim();
                        dr["taxPercentage"] = taxPercentage;
                        clr();
                        calculation(subTotal, tax_amount, discountamt);
                        txtPaidAmt.Enabled = true;
                        ViewState["Details"] = dt;
                        btnAdd.Visible = true;
                        btnUpdate.Visible = false;
                        counter = 0;
                        this.BindGrid();
                    }
                }
            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }


        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            //savelogic();
            Save();

        }
        //public string a_date;
        //public string b_date;
        protected void gvpurchasedetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow grv = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer);
                decimal subTotal = Convert.ToDecimal(grv.Cells[5].Text) * Convert.ToDecimal(grv.Cells[6].Text);
                decimal a = subTotal / 100;
                decimal discount_percent = Convert.ToDecimal(grv.Cells[8].Text);
                decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                decimal tax_amount = decimal.Parse(grv.Cells[13].Text);

                if (e.CommandName == "Delete row")
                {
                    int rowIndex = grv.RowIndex;
                    int productId = Convert.ToInt32(grv.Cells[2].Text.ToString());
                    ViewState["id"] = rowIndex;
                    DataTable dt = ViewState["Details"] as DataTable;
                    dt.Rows[rowIndex].Delete();
                    ViewState["Details"] = dt;
                    this.BindGrid();

                    DataTable taxDetails = (DataTable)ViewState["TaxDetails"];

                    for (int i = taxDetails.Rows.Count - 1; i >= 0; i--)
                    {
                        DataRow dr = taxDetails.Rows[i];
                        if (dr.Field<string>("product_id") == productId.ToString())
                            dr.Delete();
                    }

                    ViewState["TaxDetails"] = taxDetails;
                    this.BindTaxGrid();
                    DeleteCalculation(subTotal, tax_amount, discountamt);
                    clr();

                }
                else if (e.CommandName == "Update Row")
                {
                    if (!btnUpdate.Visible)
                    {
                        ViewState["id"] = grv.RowIndex;
                        int productId = Convert.ToInt32(grv.Cells[2].Text.ToString());
                        ddlproduct.SelectedValue = productId.ToString();
                        ddlBatch.SelectedValue = grv.Cells[4].Text.ToString();
                        txtquantity.Text = grv.Cells[5].Text.ToString();
                        txtprice.Text = grv.Cells[6].Text.ToString();
                        txtsalesprice.Text = grv.Cells[7].Text.ToString();
                        txtDiscount.Text = grv.Cells[8].Text.ToString();
                        btnUpdate.Visible = true;
                        btnAdd.Visible = false;
                        ddlproduct.Enabled = false;
                        ddlTaxGroup.SelectedValue= grv.Cells[10].Text.ToString();
                        //tax group implementation

                        DataTable dt = (DataTable)ViewState["TaxDetails"];

                        for (int i = dt.Rows.Count - 1; i >= 0; i--)
                        {
                            DataRow dr = dt.Rows[i];
                            if (dr.Field<string>("product_id") == productId.ToString())
                                dr.Delete();
                        }

                        ViewState["TaxDetails"] = dt;
                        this.BindTaxGrid();
                        //ddlTaxGroup.SelectedValue = grv.Cells[11].Text;
                        DeleteCalculation(subTotal, tax_amount, discountamt);
                        //counter++;
                    }
                }


            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        //code done by afroz for other expence and IsNullOrWhiteSpace 
        private void DeleteCalculation(decimal subTotal, decimal tax_amount, decimal discountamt)
        {
            decimal tot = 0;
            decimal tottax = 0;
            decimal dec = 0;
            decimal gtot = 0;
            tot = Convert.ToDecimal(lblsubtotal.Text) - subTotal;
            lblsubtotal.Text = tot.ToString("0.##");
            tottax = Convert.ToDecimal(lblTaxAmount.Text) - tax_amount;
            lblTaxAmount.Text = tottax.ToString("0.##");
            dec = Convert.ToDecimal(lblDiscountAmt.Text) - discountamt;
            lblDiscountAmt.Text = dec.ToString("0.##");

            if (string.IsNullOrWhiteSpace(txtotherexpence.Text))
            {
                txtotherexpence.Text = "0";
            }

            gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)- Convert.ToDecimal(txtotherexpence.Text));
            lblGrandTotal.Text = gtot.ToString("0.##");
        }
        protected void btnclear_Click(object sender, System.EventArgs e)
        {
            Response.Redirect("../Purchases/Purchase.aspx", false);
        }

        protected void Button1_Click(object sender, System.EventArgs e)
        {
            try
            {
                if (Convert.ToString(ViewState["total"]) != "" && Convert.ToString(ViewState["dis"]) != "" && Convert.ToString(ViewState["tax"]) != "")
                {

                    decimal t = Convert.ToDecimal(lblsubtotal.Text) - Convert.ToDecimal(ViewState["total"]);
                    decimal tx = Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(ViewState["tax"]);
                    decimal d = Convert.ToDecimal(lblDiscountAmt.Text) - Convert.ToDecimal(ViewState["dis"]);
                    lblsubtotal.Text = t.ToString();
                    lblTaxAmount.Text = tx.ToString();
                    lblDiscountAmt.Text = d.ToString();

                    if (Convert.ToString(ViewState["Details"]) != "")
                    {

                        DataTable dt = ViewState["Details"] as DataTable;
                        int row = Convert.ToInt32(ViewState["id"]);
                        dt.Rows[row].Delete();

                        gvpurchasedetails.DataSource = dt;
                        gvpurchasedetails.DataBind();
                    }

                    decimal gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text));
                    lblGrandTotal.Text = gtot.ToString();
                    txtBalanceAmt.Text = lblGrandTotal.Text;
                }

                else
                {
                    lblError.Text = "Row is empty";
                }
            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        //protected void btnCancel_Click(object sender, System.EventArgs e)
        //{
        //    Response.Redirect("PurchaseHome.aspx");
        //}



        protected void txtGivenAmt_TextChanged(object sender, System.EventArgs e)
        {
            try
            {
                decimal a = Convert.ToDecimal(lblGrandTotal.Text);
                decimal b = Convert.ToDecimal(txtPaidAmt.Text);
                if (a < b)
                {
                    txtPaidAmt.Text = lblGrandTotal.Text;
                    txtBalanceAmt.Text = "0";
                }

                else
                {
                    decimal c = Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(txtPaidAmt.Text);
                    txtBalanceAmt.Text = c.ToString();
                }
                UpdatePanel2.Update();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void ddlBatch_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lblbatch.Visible == true)
            {
                lblbatch.Visible = false;
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            //savelogic();
            Save();
            int a = Convert.ToInt32(Session["p_id"]);
            if (a != 0 || Convert.ToString(a) == null)
            {
             //Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Reports/ReportViewer.aspx?Id={0}&ReportName={1}", a, "PurchaseReport"))));
                //Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Purchases/ReportViewer.aspx?id={0}", a, "PurchaseReport"))));
              Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Purchases/PrintPurchase.aspx?id={0}", a))));
            }
        }

        protected void btnClsFilter_Click(object sender, EventArgs e)
        {

        }


        protected void btn_Click(object sender, EventArgs e)
        {
            try
            {
                lblModalHeader.Text = "Add Product";
                //ModalIfram.Attributes.Add("src", "~/MasterModals/ProductMasterModel.aspx");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Pop", "AddSrcToIfram();", true);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        //------===code done by afroz for other expence & add grand total in txtotherexpence and hdfGrandTotalWithoutExpenses is hidden field---=====>
        protected void txtotherexpence_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if(string.IsNullOrWhiteSpace(txtotherexpence.Text))
                {
                    txtotherexpence.Text= "0";
                }
                lblGrandTotal.Text = hdfGrandTotalWithoutExpenses.Value;
                decimal grandTotal = Convert.ToDecimal(lblGrandTotal.Text);
                lblGrandTotal.Text = Convert.ToString(grandTotal + Convert.ToDecimal(txtotherexpence.Text));

            }
            catch (Exception ex){

                ErrorLog.saveerror(ex);
                //Do Logging

            }
        }

        protected void ddlproduct_SelectedIndexChanged1(object sender, EventArgs e)
        {
            try
            {
                lblcheckDoubleError.Text = string.Empty;
                txtprice.Text = string.Empty;
                txtsalesprice.Text = string.Empty;
                int p_id = Convert.ToInt32(ddlproduct.SelectedValue);
                
                var product = context.tbl_product.Where(p => p.company_id == companyId && p.branch_id == branchId && p.product_id == p_id).SingleOrDefault();

                ddltaxBind(p_id);

                txtprice.Text = Convert.ToString(product.purchas_price);
                txtsalesprice.Text = Convert.ToString(product.sales_price);
                // txtTaxpercentage.Text = Convert.ToString(product.tax_percentage);
                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }


        protected void btnCloseMode_Click(object sender, EventArgs e)
        {
            try
            {
                ddlproductbind();
                ddlVendorbind();
                ddlbatchbind();
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