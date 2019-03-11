﻿using System;
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
using IMS.Reports;
using System.Globalization;

namespace IMS
{
    public partial class Sale : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlHelper helper = new SqlHelper();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        int companyId = 0, branchId = 0, financialYearId = 0;
        string User_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //txtdate.Text = DateTime.Now.ToString("mm/dd/yyyy");
                SessionValue();
                if (!IsPostBack)
                {

                    if (ViewState["Details"] == null)
                    {
                        DataTable dataTable = new DataTable();

                        dataTable.Columns.Add("Vendore");
                        dataTable.Columns.Add("Batch");
                        dataTable.Columns.Add("Product_id");
                        dataTable.Columns.Add("SON");
                        dataTable.Columns.Add("Date");
                        dataTable.Columns.Add("Product");
                        dataTable.Columns.Add("Quantity");
                        dataTable.Columns.Add("Price");
                        dataTable.Columns.Add("Discount");
                        dataTable.Columns.Add("Discount Amount");
                        dataTable.Columns.Add("purchasetaxgroup_id");
                        dataTable.Columns.Add("totalTaxAmnt");
                        dataTable.Columns.Add("Sub Total");
                        dataTable.Columns.Add("batch_id");
                        dataTable.Columns.Add("group_name");
                        dataTable.Columns.Add("group_id");
                        ViewState["Details"] = dataTable;
                    }
                    txtdate.Text = DateTime.Now.ToString();
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
                    ddlCustomerbind();
                    ddlproductbind();
                    ddlpaymentmodebind();
                    getdate();
                    txtSONo.Text = Common.GenerateInvoicenumber(companyId, branchId, Constants.Sale);
                    ClearAll();
                }
                

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        //Methods--------------------------------------------------------------------(

        public void ddltaxBind(int p_id, int batchID)
        {
            int batchId=Convert.ToInt32(ddlBatch.SelectedValue) ;
            var taxGroup = context.tbl_ActualPurchaseTaxAndPrice.Join(
                context.tbl_purchasetaxgroup, t => t.purchaseTaxId, pt => pt.purchasetaxgroup_id,
                (t, pt) => new { pt.group_id, pt.group_name, t.product_id, t.batch_id,pt.purchasetaxgroup_id 
                }).Where(t => t.batch_id == batchId && t.product_id == p_id).Select(a => new { a.group_name, a.group_id }).Distinct().ToList();
          //  var distTaxGroup = taxGroup.Select(a => new { a.group_name,a.group_id }).Distinct().ToList();
            ddlTaxGroup.DataValueField = "group_id";
            ddlTaxGroup.DataTextField = "group_name";
            ddlTaxGroup.DataSource = taxGroup;

            ddlTaxGroup.DataBind();
            ddlTaxGroup.Items.Insert(0, new ListItem("--Select tax--", "0"));
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

        private void SessionValue()
        {
            if (Session["UserID"] == null || Session["company_id"] ==null || Session["branch_id"]==null || Session["financialyear_id"]==null)
            {
                Response.Redirect("~/Registration/Login.aspx");
            }
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
            financialYearId = Convert.ToInt32(Session["financialyear_id"]);
        }
        public void batchbind(int product_id)
        {
            ddlBatch.DataTextField = "batch_name";
            ddlBatch.DataValueField = "batch_id";
            var batchs = context.sp_selectbatchbyproduct(companyId, branchId, product_id);
            ddlBatch.DataSource = batchs;
            ddlBatch.DataBind();
            ddlBatch.Items.Insert(0, new ListItem("--Select Batch--", "0"));
            if (batchs == null)
            {
                //TODO
                lblbatcherror.Text = "No purchase for the product";
            }
            else{
                lblbatcherror.Text = string.Empty;
            }
                
            
        }

        public void getdate()
        {
            try
            {
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
        public void ddlproductbind()
        {
            var cd = context.tbl_product.Join(context.tbl_stock,p=>p.product_id,s=>s.product_id,(p,s)=>new { p.product_id,p.product_name,p.status,p.company_id,p.branch_id}).Where(x => x.status == true && x.company_id == companyId && x.branch_id==branchId).Distinct().ToList();
            ddlproduct.DataTextField = "product_name";
            ddlproduct.DataValueField = "product_id";
            ddlproduct.DataSource = cd;
            ddlproduct.DataBind();
            ddlproduct.Items.Insert(0, new ListItem("--Select Product--", "0"));
        }

        public void ddlpaymentmodebind()
        {
            List<tbl_paymentmode> cd = context.tbl_paymentmode.Where(x => x.status == true).ToList();
            ddlPaymentMode.DataTextField = "paymentmode_name";
            ddlPaymentMode.DataValueField = "paymentode_id";
            ddlPaymentMode.DataSource = cd;
            ddlPaymentMode.DataBind();
            //ddlPaymentMode.Items.Insert(0, new ListItem("Select Payment Mode", "0"));
        }
        protected void BindGrid()
        {
            gvSalesdetails.DataSource = (DataTable)ViewState["Details"];
            gvSalesdetails.DataBind();
        }

        public void ddlCustomerbind()
        {
            List<tbl_party> cd = context.tbl_party.Where(x => x.status == true && x.company_id == companyId && x.party_type == "Customer").ToList();
            ddlVendor.DataTextField = "party_name";
            ddlVendor.DataValueField = "party_id";
            ddlVendor.DataSource = cd;
            ddlVendor.DataBind();
            ddlVendor.Items.Insert(0, new ListItem("Select Customer", "0"));
        }

        public bool validationss()
        {
            ////Shakeeb
            Validationss v = new Validationss();

            string[] array = new string[] { txtGivenAmt.Text, txtBalanceAmt.Text };
            if (v.emtystringvalidtion(array) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('All fields are Required');", true);
                return false;
            }

            return true;
        }

        public void clr()
        {
            ddlproduct.SelectedIndex = 0;
            ddlBatch.SelectedIndex = 0;
            txtprice.Text = string.Empty;
            txtquantity.Text = string.Empty;
            txtDiscount.Text = "0";
            txtGivenAmt.Text = string.Empty;
            txtBalanceAmt.Text = string.Empty;
        }
        public void ClearAll()
        {
            txtdate.Text = string.Empty;
            ddlVendor.SelectedIndex = 0;
            ddlBatch.SelectedIndex = 0;
            ddlproduct.SelectedIndex = 0;
            txtquantity.Text = string.Empty;
            txtprice.Text = string.Empty;
            txtDiscount.Text = string.Empty;
            txtDiscount.Text = string.Empty;
            txtBalanceAmt.Text = string.Empty;
            txtGivenAmt.Text = string.Empty;
        }
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

            gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text));
            lblGrandTotal.Text = gtot.ToString();


        }

        public bool ValidateQuantity(int productId, decimal enterdQuantity, int batchId )
        {
            bool isfail = false;
            try
            {                
                decimal availableQuantity = context.GetBatchwiseQuantity(batchId, productId).FirstOrDefault().Value;
                if (!btnUpdate.Visible)
                {                   
                    for (int i = 0; i <= gvSalesdetails.Rows.Count - 1; i++)
                    {
                        int pId = Convert.ToInt32(gvSalesdetails.Rows[i].Cells[3].Text);
                        decimal qty = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[6].Text);
                        int bId = Convert.ToInt32(gvSalesdetails.Rows[i].Cells[11].Text);
                        if (pId == productId && batchId == bId)
                        {
                            isfail = true;
                            lblcheckDoubleError.Visible = true;
                            lblcheckDoubleError.Text = "Already product and batch added, Please select different product and batch or update existing product.";
                            return isfail;
                        }
                    }
                }
                if (enterdQuantity > availableQuantity)
                {
                    isfail = true;
                    lblcheckDoubleError.Visible = true;
                    lblcheckDoubleError.Text = "Out of stock";
                    return isfail;
                }                
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return isfail;
        }
        protected void Save()
        {
            try
            {
                tbl_sale sale = new tbl_sale();
                sale.company_id = companyId;
                sale.branch_id = branchId;
                sale.financialyear_id = financialYearId;               
                sale.paymentmode_id = Convert.ToInt32(ddlPaymentMode.SelectedValue);
                sale.status = true;
                sale.party_id = Convert.ToInt32(ddlVendor.SelectedValue);
                sale.InvoiceNumber = txtSONo.Text;
                sale.sale_date = DateTime.Parse(txtdate.Text, new CultureInfo("en-US"));               
                sale.created_by = User_id;
                sale.created_date = DateTime.Now;

                //insert into Sale Payment Details 
                tbl_SalePaymentDetails salePaymentDetails = new tbl_SalePaymentDetails();
                salePaymentDetails.TaxAmount = Convert.ToDecimal(lblTaxAmount.Text);
                salePaymentDetails.DiscountAmount = Convert.ToDecimal(lblDiscountAmt.Text);
                salePaymentDetails.SubTotal = Convert.ToDecimal(lblsubtotal.Text);
                salePaymentDetails.GrandTotal = Convert.ToDecimal(lblGrandTotal.Text);
                salePaymentDetails.PaidAmnt = Convert.ToDecimal(txtGivenAmt.Text);
                salePaymentDetails.GivenAmnt = Convert.ToDecimal(txtGivenAmt.Text);
                salePaymentDetails.BalanceAmnt = Convert.ToDecimal(txtBalanceAmt.Text);
                salePaymentDetails.FromTable = "Sale";
                sale.tbl_SalePaymentDetails.Add(salePaymentDetails);

                for (int i = 0; i <= gvSalesdetails.Rows.Count - 1; i++)
                {
                    int productId = Convert.ToInt32(gvSalesdetails.Rows[i].Cells[3].Text);
                    int batchId = Convert.ToInt32(gvSalesdetails.Rows[i].Cells[9].Text);
                    decimal qty = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[4].Text);
                    tbl_product product = context.tbl_product.Where(w => w.product_id == productId).FirstOrDefault();

                    //Add into sale Details table for each product
                    tbl_saledetails saleDetails = new tbl_saledetails();
                    saleDetails.product_id = productId;
                    saleDetails.batch_id = batchId;
                   // saleDetails.tax_id = product.tax_id;
                    saleDetails.unit_id = product.unit_id;
                    saleDetails.tax_amt = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[12].Text);
                    saleDetails.dicount_amt = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[7].Text);
                    saleDetails.quantity = qty;
                    saleDetails.amount = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[8].Text);
                    saleDetails.created_by = Convert.ToString(User_id);
                    saleDetails.created_date = Convert.ToDateTime(DateTime.Now);
                    saleDetails.status = true;

                    

                    var PurchasegroupId = Convert.ToInt32(gvSalesdetails.Rows[i].Cells[10].Text);

                    DataTable taxgroupTypes1 = helper.LINQToDataTable(context.SelectPurcahseProductTaxGroup(PurchasegroupId, productId, qty));
                    ViewState["TotalTaxPercent"] = null;
                    for (int j = 0; j <= taxgroupTypes1.Rows.Count - 1; j++)
                    {
                        ViewState["TotalTaxPercent"] = taxgroupTypes1.Rows[j].Field<decimal>("totalTaxPercetage");
                    }

                    int groupId = Convert.ToInt32(gvSalesdetails.Rows[i].Cells[13].Text);
                    //insert into tax group purchase
                    tbl_saleTaxGroup saleTaxGroup = new tbl_saleTaxGroup();
                    saleTaxGroup.group_id = groupId;
                    saleTaxGroup.product_id = productId;
                    saleTaxGroup.totalTaxPercentage = (Decimal)ViewState["TotalTaxPercent"];
                    saleTaxGroup.group_name = gvSalesdetails.Rows[i].Cells[12].Text;
                    sale.tbl_saleTaxGroup.Add(saleTaxGroup);

                    //Get the Tax type saved from db 
                    //insert into tax group detailes
                    // var taxGroupTypes = context.tbl_productTaxGroup.Join(context.tbl_taxgroup, t => t.group_id, pt => pt.group_id, (t, pt) => new { t.group_id, pt.group_name, t.product_id }).Where(t => t.product_id == productId).ToList();


                    for (int j = 0; j <= taxgroupTypes1.Rows.Count - 1; j++)
                    {
                        tbl_saleTaxGroupDetailes saleTaxDetails = new tbl_saleTaxGroupDetailes();
                        saleTaxDetails.SaleTaxGroupId = saleTaxGroup.SaleTaxGroupId;
                        saleTaxDetails.type_id = taxgroupTypes1.Rows[j].Field<int>("type_id");
                        saleTaxDetails.tax_percentage = taxgroupTypes1.Rows[j].Field<decimal>("tax_percentage");

                        saleTaxDetails.created_by = Convert.ToString(User_id);
                        saleTaxDetails.created_date = DateTime.Now;
                        saleTaxDetails.status = true;
                        sale.tbl_saleTaxGroupDetailes.Add(saleTaxDetails);
                    }
                    
                    //Enter Details In tbl_ActualsaleTaxAndPrice : to get the original Values at the time of sale Return
                    tbl_ActualSalesTaxAndPrice actualSale = new tbl_ActualSalesTaxAndPrice();
                    actualSale.product_id = productId;
                    actualSale.status = true;
                    actualSale.discount_percent = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[6].Text);
                    actualSale.saleTaxGroupID = saleTaxGroup.SaleTaxGroupId;
                    actualSale.sale_rate = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[5].Text);
                    actualSale.discount_amnt = Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[7].Text);
                    actualSale.created_by = Convert.ToString(User_id);
                    actualSale.created_date = Convert.ToDateTime(DateTime.Now);
                    //Add into Actual sale Tax And Return Table
                    sale.tbl_ActualSalesTaxAndPrice.Add(actualSale);

                    //update the Stock against the product
                    tbl_stock stock = new tbl_stock();
                    stock = context.tbl_stock.Where(w => w.company_id == companyId && w.branch_id == branchId && w.product_id == productId && w.batch_id == batchId).FirstOrDefault();
                    stock.qty = stock.qty - Convert.ToInt32(gvSalesdetails.Rows[i].Cells[4].Text);
                    stock.modified_by = Convert.ToString(User_id);
                    stock.modified_date = Convert.ToDateTime(DateTime.Now);

                    sale.tbl_saledetails.Add(saleDetails);
                }

                context.tbl_sale.Add(sale);
                context.SaveChanges();
                Session["sale_id"] = sale.sale_id;
                string order = sale.InvoiceNumber;
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Saved successfully, Your order number is " + order + "');", true);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        public void orerid()
        {
            try
            {
                int a = 1;

                tbl_sale s = new tbl_sale();
                ////Shakeeb
                ////s.All(s);
                int b = s.sale_id;
                int c = a + b;
                txtSONo.Text = c.ToString();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        // Events-------------------------------------------------------------{}
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblcheckDoubleError.Text = string.Empty;
            try
            {
                decimal quantity=Convert.ToDecimal(txtquantity.Text);
                string discount = txtDiscount.Text.Trim();
                int productId = Convert.ToInt32(ddlproduct.SelectedValue);
                int batchId = Convert.ToInt32(ddlBatch.SelectedValue);
                int taxgroupId=Convert.ToInt32(ddlTaxGroup.SelectedValue);
                if (string.IsNullOrEmpty(discount))
                {
                    discount = "0";
                }
                               
                if (!ValidateQuantity(productId, quantity, batchId))
                {
                    decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(txtprice.Text);
                    decimal a = subTotal / 100;
                    decimal discountamt = a * decimal.Parse(discount);
                    //decimal tax_amount = a;// * decimal.Parse(txtTaxpercentage.Text);

                    var taxgrouplist = context.tbl_ActualPurchaseTaxAndPrice.Join(context.tbl_purchasetaxgroup, t => t.purchaseTaxId, pt => pt.purchasetaxgroup_id, (t, pt) => new { pt.group_id, pt.group_name, t.product_id, t.batch_id, pt.purchasetaxgroup_id }).Where(t => t.batch_id == batchId && t.product_id == productId).ToList();

                    var selectgroupId = taxgrouplist.Where(w => w.purchasetaxgroup_id == taxgroupId).FirstOrDefault().group_id;

                    DataTable TaxDetailes = helper.LINQToDataTable(context.SelectPurcahseProductTaxGroup(taxgroupId, productId, quantity));
                    decimal tax_amnt = 0;
                    DataTable dt2 = (DataTable)ViewState["TaxDetails"];
                    if (TaxDetailes.Rows.Count > 0)
                    {
                        for (int i = 0; i < TaxDetailes.Rows.Count; i++)
                        {
                            dt2.Rows.Add(TaxDetailes.Rows[i].Field<string>("product_name"),
                                          TaxDetailes.Rows[i].Field<int>("product_id"),
                                           TaxDetailes.Rows[i].Field<int>("group_id"),
                                          TaxDetailes.Rows[i].Field<string>("group_name"),
                                          TaxDetailes.Rows[i].Field<string>("type_name"),
                                          TaxDetailes.Rows[i].Field<decimal>("tax_percentage"),
                                          TaxDetailes.Rows[i].Field<decimal>("totalTaxPercetage"),
                                          TaxDetailes.Rows[i].Field<decimal>("totalTaxAmnt"),
                                          TaxDetailes.Rows[i].Field<int>("type_id")
                                          );

                            tax_amnt = TaxDetailes.Rows[i].Field<decimal>("totalTaxAmnt");
                        }
                    }
                    ViewState["TaxDetails"] = dt2;
                    this.BindTaxGrid();
                    DataTable dt = (DataTable)ViewState["Details"];
                    dt.Rows.Add(ddlVendor.SelectedItem.Text.Trim(), ddlBatch.SelectedItem.Text, productId, txtSONo.Text.Trim(), txtdate.Text.Trim(), ddlproduct.SelectedItem.Text.Trim(),
                                      txtquantity.Text.Trim(), txtprice.Text.Trim(), discount, discountamt, taxgroupId, tax_amnt, subTotal, batchId, ddlTaxGroup.SelectedItem.Text, selectgroupId);
                    ViewState["Details"] = dt;
                    this.BindGrid();
                    lblcheckDoubleError.Text = string.Empty;

                    clr();                   
                    txtGivenAmt.ReadOnly = false;
                    calculation(subTotal, tax_amnt, discountamt);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            // savelogic();
            Save();
        }


        protected void txtOK_Click(object sender, System.EventArgs e)
        {
            try
            {
                if (ViewState["total"] != null && ViewState["dis"] != null && ViewState["tax"] != null)
                {

                    decimal t = Convert.ToDecimal(lblsubtotal.Text) - Convert.ToDecimal(ViewState["total"]);
                    decimal tx = Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(ViewState["tax"]);
                    decimal d = Convert.ToDecimal(lblDiscountAmt.Text) - Convert.ToDecimal(ViewState["dis"]);
                    lblsubtotal.Text = t.ToString();
                    lblTaxAmount.Text = tx.ToString();
                    lblDiscountAmt.Text = d.ToString();

                    if (ViewState["Details"] != null)
                    {

                        DataTable dt = ViewState["Details"] as DataTable;
                        int row = Convert.ToInt32(ViewState["id"]);
                        dt.Rows[row].Delete();

                        gvSalesdetails.DataSource = dt;
                        gvSalesdetails.DataBind();
                    }

                    decimal gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text));
                    lblGrandTotal.Text = gtot.ToString();
                    txtBalanceAmt.Text = lblGrandTotal.Text;
                }

                else
                {
                    //lblError.Text = "Row is empty";
                }
            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void gvSalesdetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow grv = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer);
                decimal subTotal = Convert.ToDecimal(grv.Cells[4].Text) * Convert.ToDecimal(grv.Cells[5].Text);
                decimal a = subTotal / 100;
                decimal discount_percent = decimal.Parse(grv.Cells[7].Text) * 100 / decimal.Parse(grv.Cells[10].Text);
                decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                decimal tax_amount = a * decimal.Parse(grv.Cells[8].Text);
                

                if (e.CommandName == "Delete row")
                {    
                    int rowIndex = grv.RowIndex;
                    ViewState["id"] = rowIndex;
                    DataTable dt = ViewState["Details"] as DataTable;
                    dt.Rows[rowIndex].Delete();
                    ViewState["Details"] = dt;
                    this.BindGrid();
                    DeleteCalculation(subTotal, tax_amount, discountamt);
                    clr();
                }
                else if (e.CommandName == "Update Row")
                {
                    if (!btnUpdate.Visible)
                    {
                        ViewState["id"] = grv.RowIndex;
                        ddlproduct.SelectedValue = grv.Cells[3].Text.ToString();
                        ddlBatch.SelectedValue = grv.Cells[11].Text.ToString();
                        txtquantity.Text = grv.Cells[4].Text.ToString();
                        txtprice.Text = grv.Cells[5].Text.ToString();
                        txtDiscount.Text = grv.Cells[6].Text.ToString();
                        //txtTaxpercentage.Text = grv.Cells[8].Text.ToString();
                        btnUpdate.Visible = true;
                        btnAdd.Visible = false;
                        ddlproduct.Enabled = false;
                        DeleteCalculation(subTotal, tax_amount, discountamt);
                    }                   
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

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

            gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text));
            lblGrandTotal.Text = gtot.ToString("0.##");
        }
        protected void btnUpdate_Click(object sender, System.EventArgs e)
        {
            txtGivenAmt.Text = string.Empty;
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

                    if (!ValidateQuantity(productId, Convert.ToDecimal(txtquantity.Text), batchId))
                    {
                        DataRow dr = dt.Select("Product_id=" + productId + "").FirstOrDefault();
                        if (dr != null)
                        {
                            decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(dr["Price"]);
                            decimal a = subTotal / 100;
                            //decimal discount_percent = (Convert.ToDecimal(dr["Discount Amount"]) * 100) / Convert.ToDecimal(dr["Sub Total"]);
                            decimal discountamt = a * Convert.ToDecimal(discount);
                            decimal tax_amount = a * Convert.ToDecimal(dr["Tax"]);

                            dr["Quantity"] = txtquantity.Text;
                           // dr["Tax"] = txtTaxpercentage.Text;
                            dr["Discount"] = discount;
                            dr["Discount Amount"] = discountamt;
                            dr["Sub Total"] = subTotal;
                            dr["Tax Amount"] = tax_amount;
                            dr["Price"] = txtprice.Text;
                            dr["batch_id"] = batchId;
                            dr["Batch"] = ddlBatch.SelectedItem.Text.Trim();
                        clr();
                            calculation(subTotal, tax_amount, discountamt);
                            txtGivenAmt.Enabled = true;
                            ViewState["Details"] = dt;
                           
                            this.BindGrid();
                        btnUpdate.Visible = false;
                        btnAdd.Visible = true;                     
                        }                        
                    }
                }                
            
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void ddlproduct_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            try
            {
                lblcheckDoubleError.Text = string.Empty;
                int productId = Convert.ToInt32(ddlproduct.SelectedValue);
                //var product = context.tbl_ActualPurchaseTaxAndPrice.Join(context.tbl_batch .Where(p => p.product_id == productId && p.batch_id==).Select(s=>new { s.batch_id,s.});
                //txtprice.Text = Convert.ToString(product.sale_price);
                //int data = helper.GetStockQuantity(companyId, productId);
                //Session["quant"] = data;
                batchbind(productId);
                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void txtGivenAmt_TextChanged(object sender, System.EventArgs e)
        {
            try
            {

                //decimal a = Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(txtGivenAmt.Text);
                //txtBalanceAmt.Text = a.ToString();
                decimal a = Convert.ToDecimal(lblGrandTotal.Text);
                decimal b = Convert.ToDecimal(txtGivenAmt.Text);
                if (a < b)
                {
                    txtGivenAmt.Text = lblGrandTotal.Text;
                    txtBalanceAmt.Text = "0";
                }

                else
                {
                    decimal c = Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(txtGivenAmt.Text);
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

        protected void btnclear_Click(object sender, System.EventArgs e)
        {
            Response.Redirect("../Sales/Sale.aspx", false);
        }

        protected void ddlBatch_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                lblcheckDoubleError.Text = string.Empty;
                int productId = Convert.ToInt32(ddlproduct.SelectedValue);
                int batchId = Convert.ToInt32(ddlBatch.SelectedValue);
                var actualPurchaseTaxAndPrice = context.tbl_ActualPurchaseTaxAndPrice.Where(p => p.product_id == productId && p.batch_id == batchId).FirstOrDefault();
                txtprice.Text = Convert.ToString(actualPurchaseTaxAndPrice.sale_price);
                ddltaxBind(productId, batchId);
                //txtTaxpercentage.Text = actualPurchaseTaxAndPrice.tax_percent.ToString();                          
                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            //savelogic();
            Save();
            int a = Convert.ToInt32(Session["sale_id"]);
            if (a != 0 || Convert.ToString(a) == null)
            {              
                Response.Write(String.Format("<script>window.open('{0}','_blank')</script>", ResolveUrl(string.Format("~/Sales/printsale.aspx?id={0}", a))));
            }
        }


        protected void btnCloseMode_Click(object sender, EventArgs e)
        {
            try
            {
                ddlCustomerbind();
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