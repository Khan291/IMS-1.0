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
using System.IO;
using System.Data.Entity;

namespace IMS.Sales
{
    public partial class SalesReturn : System.Web.UI.Page
    {
        /// <summary>
        /// Objects That are used in coding
        /// </summary>
        IMS_TESTEntities context = new IMS_TESTEntities();
        string connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        SqlHelper helper = new SqlHelper();
        static int companyId = 0, branchId = 0, financialYearId = 0; string user_id = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();

            if (!IsPostBack)
            {
                if (ViewState["Details"] == null)
                {
                    gvTableassign();
                }

                if (ViewState["TaxDetails"] == null)
                {
                    gvTaxTable();
                }
                this.BindTaxGrid();
                ddlpaymentmodebind();
            }
        }


        public void gvTableassign()
        {
            DataTable dataTable = new DataTable();

            dataTable.Columns.Add("saledetails_id");
            dataTable.Columns.Add("Product_id");
            dataTable.Columns.Add("batch_id");
            dataTable.Columns.Add("unit_id");
            dataTable.Columns.Add("group_id");
            dataTable.Columns.Add("amount");
            dataTable.Columns.Add("dicount_amt");
            dataTable.Columns.Add("tax_amt");
            dataTable.Columns.Add("sale_rate");
            dataTable.Columns.Add("quantity");
            dataTable.Columns.Add("product_name");
            dataTable.Columns.Add("unit_name");
            dataTable.Columns.Add("batch_name");
            dataTable.Columns.Add("tax_percentage");
            ViewState["Details"] = dataTable;
        }

        public void gvTaxTable()
        {
            DataTable dataTable2 = new DataTable();

            dataTable2.Columns.Add("product_id");
            dataTable2.Columns.Add("group_id");
            dataTable2.Columns.Add("group_name");
            dataTable2.Columns.Add("type_name");
            dataTable2.Columns.Add("tax_percentage");
            dataTable2.Columns.Add("totaltaxPercentage");
            dataTable2.Columns.Add("type_id");
            ViewState["TaxDetails"] = dataTable2;
        }
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> GetPoNumbers(string prefixText, int count)
        {
            IMS_TESTEntities context = new IMS_TESTEntities();
            //using (SqlConnection conn = new SqlConnection())
            //{
            //    conn.ConnectionString = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
            //    using (SqlCommand cmd = new SqlCommand())
            //    {
            int year = DateTime.Now.Year;
            //prefixText = year.ToString() + "S" + prefixText;
            var result = context.tbl_sale.Where(p => p.InvoiceNumber.Contains(prefixText) && p.company_id == companyId);
            List<string> customers = new List<string>();
            customers = result.Select(p => p.InvoiceNumber).ToList<string>();
            return customers;
            //    }
            //}
        }



        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>


        #region Methods
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


        private void BindTaxGrid()
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

        public void ddlpaymentmodebind()
        {
            List<tbl_paymentmode> cd = context.tbl_paymentmode.Where(x => x.status == true).ToList();
            ddlPaymentMode.DataTextField = "paymentmode_name";
            ddlPaymentMode.DataValueField = "paymentode_id";
            ddlPaymentMode.DataSource = cd;
            ddlPaymentMode.DataBind();
            //ddlPaymentMode.Items.Insert(0, new ListItem("Select Payment Mode", "0"));
        }

        public bool productvalid(int productid, decimal quantity, int count)
        {
            decimal totalqty = 0;
            decimal availableqty = 0;

            decimal q1 = Convert.ToDecimal(Session["quant"]);
            for (int i = 0; i <= gvsalesdetails.Rows.Count - 1; i++)
            {
                int pid = Convert.ToInt32(gvsalesdetails.Rows[i].Cells[2].Text);
                decimal qty = Convert.ToDecimal(gvsalesdetails.Rows[i].Cells[5].Text);

                if (pid == productid)
                {
                    if (count == 0)
                    {
                        totalqty = qty + quantity + totalqty;
                    }

                }
            }

            if (q1 < totalqty || q1 < quantity)
            {
                lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                lblcheckDoubleError.Text = "Out Of Stock";
                return false;
            }

            else
            {
                //availableqty = q1 - quantity;
                //lblcheckDoubleError.ForeColor = System.Drawing.Color.Green;
                //lblcheckDoubleError.Text = "Avialable Quantity In Stock " + availableqty;
                return true;
            }
            // if(total > avali)

        }

        public void clr()
        {

            ddlproduct.SelectedIndex = 0;
            txtquantity.Text = "";
            txtBalanceAmt.Text = string.Empty;
            txtPaidAmt.Text = string.Empty;
        }
        public void calculation(decimal sub_Total, decimal total_tax, decimal total_discount, decimal otherDiscForSelectedProds)
        {

            lblsubtotal.Text = (Convert.ToDecimal(Convert.ToDecimal(lblsubtotal.Text == "" ? lblsubtotal.Text = "0" : lblsubtotal.Text) + sub_Total).ToString("0.##"));
            lblResultSubTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text == "" ? lblTotalAmnt.Text = "0" : lblTotalAmnt.Text) - Convert.ToDecimal(lblsubtotal.Text)).ToString("0.##");


            lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text == "" ? lblTaxAmount.Text = "0" : lblTaxAmount.Text) + total_tax).ToString("0.##");
            lblResultTotalTaxAmnt.Text = (Convert.ToDecimal(lblTotalTax.Text == "" ? lblTotalTax.Text = "0" : lblTotalTax.Text) - Convert.ToDecimal(lblTaxAmount.Text)).ToString("0.##");


            lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text == "" ? "0" : lblDiscountAmt.Text) + total_discount).ToString("0.##");
            lblResultTotalDiscount.Text = (Convert.ToDecimal(lblTotalDiscount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");



            lblOtherDiscountText.Text = (Convert.ToDecimal(lblOtherDiscountText.Text == "" ? "0" : lblOtherDiscountText.Text) + otherDiscForSelectedProds).ToString("0.##");
            lblOtherDiscountTextResult.Text = (Convert.ToDecimal(lblOtherDiscountTextTotal.Text) - Convert.ToDecimal(lblOtherDiscountText.Text)).ToString("0.##");

            lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text == "" ? "0" : lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text == "" ? "0" : lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text) + otherDiscForSelectedProds).ToString("0.##");
            lblOriginalGrndTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text == "" ? lblTotalAmnt.Text = "0" : lblTotalAmnt.Text) + Convert.ToDecimal(lblTotalTax.Text == "" ? lblTotalTax.Text = "0" : lblTotalTax.Text) - Convert.ToDecimal(lblTotalDiscount.Text) + Convert.ToDecimal(lblOtherDiscountTextTotal.Text == "" ? "0" : lblOtherDiscountTextTotal.Text)).ToString("0.##");

            lblResultGrndTotal.Text = (Convert.ToDecimal(lblOriginalGrndTotal.Text) - Convert.ToDecimal(lblGrandTotal.Text)).ToString("0.##");

            txtBalanceAmt.Text = (Convert.ToDecimal(lblResultGrndTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text)).ToString("0.##");
            if (Convert.ToDecimal(txtBalanceAmt.Text) < 0)
            {
                btnPayBack.Visible = true;
            }
            else
            {
                btnPayBack.Visible = false;
            }
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
        protected void BindGrid()
        {
            try
            {
                gvsalesdetails.DataSource = (DataTable)ViewState["Details"];
                gvsalesdetails.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        public void GetSaleDetails()
        {
            try
            {
                var sale = context.tbl_sale.Where(w => w.InvoiceNumber == txtSoNo.Text && w.company_id == companyId && w.branch_id == branchId).FirstOrDefault();
                if (sale == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Invoice does not exist, Please enter valid Invoice Number.','True');", true);
                    return;
                }

                hdnSaleId.Value = sale.sale_id.ToString();

                var products = context.tbl_saledetails.Join(context.tbl_product, sd => sd.product_id, p => p.product_id, (sd, p) => new { sd.sale_id, sd.product_id, p.product_name }).Where(w => w.sale_id == sale.sale_id).ToList();

                ddlproduct.DataTextField = "product_name";
                ddlproduct.DataValueField = "product_id";
                ddlproduct.DataSource = products;
                ddlproduct.DataBind();
                ddlproduct.Items.Insert(0, new ListItem("--Select Product--", "0"));
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }

        }

        protected void Save()
        {
            try
            {
                int saleId = Convert.ToInt32(hdnSaleId.Value);
                if (saleId == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Sale No','False');", true);
                    return;
                }
                decimal paidAmt = 0;
                if (!string.IsNullOrEmpty(txtPaidAmt.Text))
                {
                    paidAmt = Convert.ToDecimal(txtPaidAmt.Text);
                }
                string path = "~/Uploads/AttachedFiles/Sale/";//path without filename to save file
                bool fileupMsg = uploadfile(fuAttacheFile, path, "");


                decimal remainingBalance = Convert.ToDecimal(lblResultGrndTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text);
                decimal paidAmnt = Convert.ToDecimal(txtPaidAmt.Text);

                var sale = context.tbl_sale.Where(pd => pd.sale_id == saleId && pd.company_id == companyId && pd.branch_id == branchId).FirstOrDefault();
                tbl_salereturn saleReturn = new tbl_salereturn();
                if (fileupMsg)
                {
                    path = path + Path.GetFileName(fuAttacheFile.PostedFile.FileName);
                    saleReturn.attachmentUrl = path;
                }
                saleReturn.sale_id = saleId;
                saleReturn.company_id = companyId;
                saleReturn.branch_id = branchId;
                saleReturn.financialyear_id = Convert.ToInt32(Session["financialyear_id"]);
                saleReturn.InvoiceNumber = txtSoNo.Text;
                saleReturn.paymentmode_id = Convert.ToInt32(ddlPaymentMode.SelectedValue);
                saleReturn.status = true;
                saleReturn.party_id = Convert.ToInt32(sale.party_id);
                saleReturn.created_by = user_id;
                saleReturn.created_date = DateTime.Now;
                //saleReturn.Note = txtSaleNote.Text;
                decimal givenAmnt = 0;
                if (remainingBalance < paidAmnt)
                {
                    givenAmnt = Convert.ToDecimal(lblGivenAmnt.Text) - Convert.ToDecimal(txtPaidAmt.Text);
                }
                else
                {
                    givenAmnt = Convert.ToDecimal(lblGivenAmnt.Text) + Convert.ToDecimal(txtPaidAmt.Text);
                }
                //Update into Sale Payment Details 
                tbl_SalePaymentDetails salePaymentDetails = context.tbl_SalePaymentDetails.Where(w => w.SaleId == saleId).FirstOrDefault();
                salePaymentDetails.PaidAmnt = paidAmt;
                salePaymentDetails.TaxAmount = Convert.ToDecimal(lblResultTotalTaxAmnt.Text);
                salePaymentDetails.DiscountAmount = Convert.ToDecimal(lblResultTotalDiscount.Text);
                salePaymentDetails.SubTotal = Convert.ToDecimal(lblResultSubTotal.Text);
                salePaymentDetails.GrandTotal = Convert.ToDecimal(lblResultGrndTotal.Text);
                salePaymentDetails.GivenAmnt = givenAmnt;
                salePaymentDetails.BalanceAmnt = Convert.ToDecimal(txtBalanceAmt.Text);
                salePaymentDetails.FromTable = "Return";
                salePaymentDetails.ModifiedBy = user_id;
                salePaymentDetails.ModifiedDate = DateTime.Now;

                //sale.tbl_SalePaymentDetails.Add(salePaymentDetails);
                // context.Entry(sale.tbl_SalePaymentDetails).State = EntityState.Deleted;
                //context.SaveChanges();
                saleReturn.tbl_SalePaymentDetails.Add(salePaymentDetails);

                for (int i = 0; i <= gvsalesdetails.Rows.Count - 1; i++)
                {
                    int productId = Convert.ToInt32(gvsalesdetails.Rows[i].Cells[2].Text);
                    int batchId = Convert.ToInt32(gvsalesdetails.Rows[i].Cells[4].Text);
                    int taxGroupId = Convert.ToInt32(gvsalesdetails.Rows[i].Cells[12].Text);
                    tbl_product product = context.tbl_product.Where(w => w.product_id == productId).FirstOrDefault();

                    tbl_salereturndetails saleeReturnDetails = new tbl_salereturndetails();
                    saleeReturnDetails.product_id = productId;
                    saleeReturnDetails.batch_id = batchId;
                    saleeReturnDetails.Sales_taxGroupId = taxGroupId;
                    saleeReturnDetails.unit_id = product.unit_id;
                    saleeReturnDetails.dicount_amt = Convert.ToDecimal(gvsalesdetails.Rows[i].Cells[7].Text);
                    saleeReturnDetails.tax_amt = Convert.ToDecimal(gvsalesdetails.Rows[i].Cells[9].Text);
                    saleeReturnDetails.quantity = Convert.ToInt32(gvsalesdetails.Rows[i].Cells[5].Text);
                    saleeReturnDetails.amount = Convert.ToDecimal(gvsalesdetails.Rows[i].Cells[10].Text);
                    saleeReturnDetails.created_by = Convert.ToString(user_id);
                    saleeReturnDetails.created_date = Convert.ToDateTime(DateTime.Now);
                    saleeReturnDetails.status = true;

                    tbl_stock stock = new tbl_stock();
                    stock = context.tbl_stock.Where(w => w.company_id == companyId && w.branch_id == branchId && w.product_id == productId && w.batch_id == batchId).FirstOrDefault();
                    stock.qty = stock.qty + Convert.ToInt32(gvsalesdetails.Rows[i].Cells[5].Text);
                    stock.modified_by = Convert.ToString(user_id);
                    stock.modified_date = Convert.ToDateTime(DateTime.Now);

                    saleReturn.tbl_salereturndetails.Add(saleeReturnDetails);
                }

                context.tbl_salereturn.Add(saleReturn);
                context.SaveChanges();
                string invoiceNumber = saleReturn.InvoiceNumber;
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('saved Successfully, You order number is " + invoiceNumber + "','True');", true);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        public void clrGvAndlbls()
        {
            gvsalesdetails.DataSource = null;
            gvsalesdetails.DataBind();
            gvTaxDetailsNew.DataSource = null;
            gvTaxDetailsNew.DataBind();
            ViewState["Details"] = null;
            ViewState["TaxDetails"] = null;
            gvTableassign();
            gvTaxTable();

            lblTotalAmnt.Text = "0";
            lblsubtotal.Text = "0";
            lblResultSubTotal.Text = "0";

            lblTotalTax.Text = "0";
            lblTaxAmount.Text = "0";
            lblResultTotalTaxAmnt.Text = "0";

            lblTotalDiscount.Text = "0";
            lblDiscountAmt.Text = "0";
            lblResultTotalDiscount.Text = "0";

            lblResultGrndTotal.Text = "0";
            lblGrandTotal.Text = "0";

            txtBalanceAmt.Text = "0";
            txtPaidAmt.Text = "0";
        }
        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>
        #region Events
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            clrGvAndlbls();

            OriginalSaleDetails.Visible = true;
            ddlproduct.Items.Clear();
            GetSaleDetails();
            //BindOrigianlSaleGrid();
            if (!string.IsNullOrEmpty(hdnSaleId.Value))
            {
                int saleId = Convert.ToInt32(hdnSaleId.Value);
                FetchData(saleId);
            }
        }

        private void FetchData(int saleId)
        {

            SqlParameter[] sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", saleId),
                         new SqlParameter("@FromTable","COMBINESALEANDRETURN")
                    };
            decimal? givenAmnt = 0, totalDiscount = 0, subTotal = 0, grandTotal = 0, totalTax = 0, OtherExp = 0;
            string OtherExpLabel = string.Empty; ;
            var ds = Common.FillDataSet(connectionstring, "SaleOrSaleReturnReport", sqlParams);

            if (ds.Tables["Table"] != null)
            {
                //    decimal givenAmnt = 0, totalDiscount = 0, subTotal = 0, grandTotal = 0, totalTax = 0;

                //    for (int i = 0; i < ds.Tables["Table"].Rows.Count; i++)
                //    {
                //        if (ds.Tables["Table"].Rows[i]["Type"].ToString() == "Sale")
                //        {
                //            totalTax = totalTax + Convert.ToDecimal(ds.Tables["Table"].Rows[i]["TaxAmnt"]);
                //            totalDiscount = totalDiscount + Convert.ToDecimal(ds.Tables["Table"].Rows[i]["DiscountAmnt"]);
                //            subTotal = subTotal + Convert.ToDecimal(ds.Tables["Table"].Rows[i]["ProductAmount"]);
                //        }
                //        else if (ds.Tables["Table"].Rows[i]["Type"].ToString() == "Return")
                //        {
                //            totalTax = totalTax - Convert.ToDecimal(ds.Tables["Table"].Rows[i]["TaxAmnt"]);
                //            totalDiscount = totalDiscount - Convert.ToDecimal(ds.Tables["Table"].Rows[i]["DiscountAmnt"]);
                //            subTotal = subTotal - Convert.ToDecimal(ds.Tables["Table"].Rows[i]["ProductAmount"]);
                //        }
                //        givenAmnt = Convert.ToDecimal(ds.Tables["Table"].Rows[i]["GivenAmnt"]);
                //    }

                var paymentDetails = context.tbl_SalePaymentDetails.Where(w => w.SaleId == saleId)
              .Select(s => new { s.GivenAmnt, s.BalanceAmnt, s.GrandTotal, s.SubTotal, s.PaidAmnt, s.TaxAmount, s.DiscountAmount, s.OtherExp, s.OtherExpLabel }).FirstOrDefault();
                if (paymentDetails != null)
                {
                    givenAmnt = paymentDetails.GivenAmnt;
                    //balanceAmnt = paymentDetails.BalanceAmnt;
                    subTotal = paymentDetails.SubTotal;
                    totalTax = paymentDetails.TaxAmount;
                    totalDiscount = paymentDetails.DiscountAmount;
                    OtherExpLabel = paymentDetails.OtherExpLabel;
                    OtherExp = paymentDetails.OtherExp;
                }

                grandTotal = subTotal + totalTax - totalDiscount + OtherExp;

                //DataRow dr = ds.Tables["Table"].Select("Id=" + saleId + "").FirstOrDefault();

                lblGivenAmnt.Text = givenAmnt.ToString();
                //lblBalanceAmnt.Text = dr["BalanceAmnt"].ToString();
                //assign it to the the current return screen as well as the original purchase field
                lblGivenAmnt.Text = givenAmnt.ToString();
                lblTotalAmnt.Text = subTotal.ToString();
                lblTotalTax.Text = totalTax.ToString();
                lblTotalDiscount.Text = totalDiscount.ToString();
                lblOriginalGrndTotal.Text = grandTotal.ToString();
                lblOtherDiscountLabel.Text = OtherExpLabel;
                lblOtherDiscountTextTotal.Text = OtherExp.ToString();
                ///////////////////////////


                //txtPaidAmt.Text = lblGivenAmnt.Text;
                GrdOriginalSale.DataSource = ds.Tables["Table"];
                GrdOriginalSale.DataBind();
            }
        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int saleId = Convert.ToInt32(hdnSaleId.Value);
            //lblcheckDoubleError.Text = string.Empty;
            int productId = Convert.ToInt32(ddlproduct.SelectedValue);
            decimal enteredQuantity = Convert.ToDecimal(txtquantity.Text);

            try
            {
                var productDetails = context.sp_GetSaleDetailsById(saleId).ToList();
                if (productDetails != null)
                {
                    var oneproductDetail = productDetails.Where(w => w.product_id == productId);
                    var SaleTaxGroup = (from ep in context.tbl_saleTaxGroup
                                        join e1 in context.tbl_saleTaxGroupDetailes on ep.SaleTaxGroupId equals e1.SaleTaxGroupId
                                        join t in context.tbl_taxtype on e1.type_id equals t.type_id
                                        where ep.sale_id == saleId && ep.product_id == productId
                                        select new
                                        {
                                            group_id = ep.group_id,
                                            group_name = ep.group_name,
                                            type_name = t.type_name,
                                            type_id = e1.type_id,
                                            tax_percentage = e1.tax_percentage,
                                            product_id = ep.product_id,
                                            totaltaxPercentage = ep.totalTaxPercentage
                                        }).ToList();
                    DataTable SaleTaxGroupDataTable = helper.LINQToDataTable(SaleTaxGroup);
                    if (!Convert.ToBoolean(ValidateQuantity(enteredQuantity, productId, saleId)[0]))
                    {
                        var saleDetails = (from sd in context.tbl_saledetails
                                           join sp in context.tbl_SalePaymentDetails on sd.sale_id equals sp.SaleId
                                           where sd.sale_id == saleId
                                           select new
                                           {
                                               quantity = sd.quantity
                                           }).ToList().FirstOrDefault();
                        decimal? quanity = saleDetails.quantity;
                        //decimal? adjustment = saleDetails.oth;
                        decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(oneproductDetail.FirstOrDefault().sale_rate);
                        decimal a = subTotal / 100;
                        decimal discount_percent = (Convert.ToDecimal(oneproductDetail.FirstOrDefault().dicount_amt) * 100) / Convert.ToDecimal(oneproductDetail.FirstOrDefault().amount);
                        decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                        decimal tax_amount = 0;//= a * Convert.ToDecimal(oneproductDetail.FirstOrDefault().tax_percentage);
                        decimal taxPercentage = 0;
                        decimal TotalOtherDisc = Convert.ToDecimal(lblOtherDiscountTextTotal.Text == "" ? "0" : lblOtherDiscountTextTotal.Text);
                        decimal OtherDiscPerProduct = TotalOtherDisc / quanity.Value;
                        decimal otherDiscForSelectedProds = OtherDiscPerProduct * Convert.ToDecimal(txtquantity.Text);
                        clr();

                        txtPaidAmt.Enabled = true;
                        DataTable dt2 = (DataTable)ViewState["TaxDetails"];
                        if (SaleTaxGroupDataTable.Rows.Count > 0)
                        {
                            for (int i = 0; i < SaleTaxGroupDataTable.Rows.Count; i++)
                            {
                                dt2.Rows.Add(
                                              SaleTaxGroupDataTable.Rows[i].Field<int>("product_id"),
                                               SaleTaxGroupDataTable.Rows[i].Field<int>("group_id"),
                                              SaleTaxGroupDataTable.Rows[i].Field<string>("group_name"),
                                              SaleTaxGroupDataTable.Rows[i].Field<string>("type_name"),
                                          SaleTaxGroupDataTable.Rows[i].Field<decimal>("tax_percentage"),
                                          SaleTaxGroupDataTable.Rows[i].Field<decimal>("totaltaxPercentage"),
                                              SaleTaxGroupDataTable.Rows[i].Field<int>("type_id")
                                              );
                                taxPercentage = SaleTaxGroupDataTable.Rows[i].Field<decimal>("totaltaxPercentage");
                            }
                        }
                        ViewState["TaxDetails"] = dt2;
                        this.BindTaxGrid();

                        tax_amount = taxPercentage * a;
                        DataTable tbl = (DataTable)ViewState["Details"];

                        tbl.Rows.Add(oneproductDetail.FirstOrDefault().saledetails_id
                                            , productId
                                            , oneproductDetail.FirstOrDefault().batch_id
                                            , oneproductDetail.FirstOrDefault().unit_id
                                            , oneproductDetail.FirstOrDefault().group_id
                                            , subTotal
                                            , discountamt
                                            , tax_amount
                                            , oneproductDetail.FirstOrDefault().sale_rate
                                            , enteredQuantity
                                            , oneproductDetail.FirstOrDefault().product_name
                                            , oneproductDetail.FirstOrDefault().unit_name
                                            , oneproductDetail.FirstOrDefault().batch_name
                                            , oneproductDetail.FirstOrDefault().tax_percentage
                            );
                        ViewState["Details"] = tbl;
                        this.BindGrid();
                        calculation(subTotal, tax_amount, discountamt, otherDiscForSelectedProds);
                        ddlproduct.Items.FindByValue(productId.ToString()).Enabled = false;

                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        [System.Web.Services.WebMethod]
        public static string[] ValidateQuantity(decimal enterdQuantity, int productid, int saleId)
        {
            string[] isfail = new string[2];
            isfail[0] = "false";
            isfail[1] = "";
            IMS_TESTEntities context = new IMS_TESTEntities();
            try
            {
                if (enterdQuantity != 0 && productid != 0)
                {
                    if (companyId != 0 && saleId != 0)
                    {
                        SqlHelper helper = new SqlHelper();

                        var returnQuantity = context.GetReturnQuantity(saleId, Constants.Sale, productid, companyId).FirstOrDefault();

                        if (enterdQuantity > returnQuantity)
                        {
                            isfail[0] = "true";
                            isfail[1] = "Only " + returnQuantity + " can be return for the selected product.";
                            return isfail;
                        }
                    }
                }
                else
                {
                    isfail[0] = "true";
                    isfail[1] = "Please select product or enter correct return quantity.";
                    return isfail;
                }
                //pass false as default if not true
                isfail[0] = "false";
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return isfail;
        }


        protected void gvsalesdetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int saleId = Convert.ToInt32(hdnSaleId.Value);
                GridViewRow grv = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer);

                decimal subTotal = Convert.ToDecimal(grv.Cells[5].Text) * Convert.ToDecimal(grv.Cells[6].Text);
                decimal a = subTotal / 100;
                decimal discount_percent = decimal.Parse(grv.Cells[7].Text) * 100 / decimal.Parse(grv.Cells[10].Text);
                decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                decimal tax_amount = a * decimal.Parse(grv.Cells[8].Text);
                decimal quantity = decimal.Parse(grv.Cells[5].Text);

                int productId = Convert.ToInt32(grv.Cells[2].Text.ToString());
                decimal TotalOtherDisc = Convert.ToDecimal(lblOtherDiscountTextTotal.Text == "" ? "0" : lblOtherDiscountTextTotal.Text);


                var saleDetails = (from sd in context.tbl_saledetails
                                   join sp in context.tbl_SalePaymentDetails on sd.sale_id equals sp.SaleId
                                   where sd.sale_id == saleId
                                   select new
                                   {
                                       quantity = sd.quantity
                                   }).ToList().FirstOrDefault();
                decimal? quanity = saleDetails.quantity;
                decimal OtherDiscPerProduct = TotalOtherDisc / quanity.Value;
                decimal otherDiscForSelectedProds = OtherDiscPerProduct * quantity;

                if (e.CommandName == "Delete row")
                {
                    int rowIndex = grv.RowIndex;
                    ViewState["id"] = rowIndex;
                    ddlproduct.Items.FindByValue(grv.Cells[2].Text).Enabled = true;
                    DataTable dt = ViewState["Details"] as DataTable;
                    dt.Rows[rowIndex].Delete();
                    ViewState["Details"] = dt;
                    DeleteCalculation(subTotal, tax_amount, discountamt, otherDiscForSelectedProds);
                    this.BindGrid();
                    //tax group implementation

                    DataTable dt2 = (DataTable)ViewState["TaxDetails"];

                    for (int i = dt2.Rows.Count - 1; i >= 0; i--)
                    {
                        DataRow dr = dt2.Rows[i];
                        if (dr.Field<string>("product_id") == productId.ToString())
                            dr.Delete();
                    }

                    ViewState["TaxDetails"] = dt;
                    this.BindTaxGrid();

                }
                else if (e.CommandName == "Update Row")
                {
                    if (!btnUpdate.Visible)
                    {
                        DataTable dt = ViewState["Details"] as DataTable;
                        ViewState["id"] = grv.RowIndex;
                        //int productId = Convert.ToInt32(grv.Cells[2].Text.ToString());
                        ddlproduct.SelectedValue = grv.Cells[2].Text.ToString();
                        ddlproduct.Items.FindByValue(grv.Cells[2].Text).Enabled = true;
                        txtquantity.Text = grv.Cells[5].Text.ToString();
                        btnUpdate.Visible = true;
                        btnAdd.Visible = false;
                        ddlproduct.Enabled = false;
                        DeleteCalculation(subTotal, tax_amount, discountamt, otherDiscForSelectedProds);

                        //tax group implementation

                        DataTable dt2 = (DataTable)ViewState["TaxDetails"];

                        for (int i = dt2.Rows.Count - 1; i >= 0; i--)
                        {
                            DataRow dr = dt2.Rows[i];
                            if (dr.Field<string>("product_id") == productId.ToString())
                                dr.Delete();
                        }

                        ViewState["TaxDetails"] = dt2;
                        this.BindTaxGrid();

                    }
                }

            }

            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        private void DeleteCalculation(decimal subTotal, decimal tax_amount, decimal discountamt, decimal otherDiscForSelectedProds)
        {

            //lblsubtotal.Text = Convert.ToString(Convert.ToDecimal(lblsubtotal.Text) + subTotal);//.ToString("0.##");
            //lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) + tax_amount).ToString("0.##");
            //lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) + discountamt).ToString("0.##");

            //lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");

            //txtBalanceAmt.Text = (Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text)).ToString("0.##");

            //txtPaidAmt.Text = "0.00";
            //if (Convert.ToDecimal(txtBalanceAmt.Text) < 0)
            //    btnPayBack.Visible = true;

            lblsubtotal.Text = (Convert.ToDecimal(lblsubtotal.Text) - subTotal).ToString("0.##");
            lblResultSubTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text) - Convert.ToDecimal(lblsubtotal.Text)).ToString("0.##");

            lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) - tax_amount).ToString("0.##");
            lblResultTotalTaxAmnt.Text = (Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTaxAmount.Text)).ToString("0.##");

            lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) - discountamt).ToString("0.##");
            lblResultTotalDiscount.Text = (Convert.ToDecimal(lblTotalDiscount.Text) - Convert.ToDecimal(lblDiscountAmt.Text) + otherDiscForSelectedProds).ToString("0.##");

            lblOtherDiscountText.Text = (Convert.ToDecimal(lblOtherDiscountText.Text) - otherDiscForSelectedProds).ToString("0.##");
            lblOtherDiscountTextResult.Text = (Convert.ToDecimal(lblOtherDiscountTextTotal.Text == "" ? "0" : lblOtherDiscountTextTotal.Text) + Convert.ToDecimal(lblOtherDiscountText.Text)).ToString("0.##");

            lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");
            lblOriginalGrndTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text) + Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTotalDiscount.Text) + Convert.ToDecimal(lblOtherDiscountTextTotal.Text == "" ? "0" : lblOtherDiscountTextTotal.Text)).ToString("0.##");

            lblResultGrndTotal.Text = (Convert.ToDecimal(lblOriginalGrndTotal.Text) - Convert.ToDecimal(lblGrandTotal.Text)).ToString("0.##");

            if (Convert.ToDecimal(lblGrandTotal.Text) > 0)
            {
                txtBalanceAmt.Text = (Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text)).ToString("0.##");
            }
            else
            {
                txtBalanceAmt.Text = "0.00";
            }
            if (Convert.ToDecimal(txtBalanceAmt.Text) < 0)
                btnPayBack.Visible = true;

        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int saleId = Convert.ToInt32(hdnSaleId.Value);
            lblcheckDoubleError.Text = string.Empty;
            DataTable dt = new DataTable();
            dt = (DataTable)ViewState["Details"];
            int productId = Convert.ToInt32(ddlproduct.SelectedValue);
            decimal enteredQuantity = Convert.ToDecimal(txtquantity.Text);
            try
            {
                if (!Convert.ToBoolean(ValidateQuantity(enteredQuantity, productId, saleId)[0]))
                {
                    DataRow dr = dt.Select("product_id=" + productId + "").FirstOrDefault();
                    if (dr != null)
                    {
                        decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(dr["sale_rate"]);
                        decimal a = subTotal / 100;
                        decimal discount_percent = (Convert.ToDecimal(dr["dicount_amt"]) * 100) / Convert.ToDecimal(dr["amount"]);
                        decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                        decimal tax_amount = a * Convert.ToDecimal(dr["tax_percentage"]);
                        decimal TotalOtherDisc = Convert.ToDecimal(lblOtherDiscountTextTotal.Text == "" ? "0" : lblOtherDiscountTextTotal.Text);

                        dr["quantity"] = txtquantity.Text;
                        dr["tax_amt"] = tax_amount;
                        dr["dicount_amt"] = discountamt;
                        dr["amount"] = subTotal;
                        var saleDetails = (from sd in context.tbl_saledetails
                                           join sp in context.tbl_SalePaymentDetails on sd.sale_id equals sp.SaleId
                                           where sd.sale_id == saleId
                                           select new
                                           {
                                               quantity = sd.quantity
                                           }).ToList().FirstOrDefault();
                        decimal? quanity = saleDetails.quantity;
                        decimal OtherDiscPerProduct = TotalOtherDisc / quanity.Value;
                        decimal otherDiscForSelectedProds = OtherDiscPerProduct * Convert.ToDecimal(txtquantity.Text);
                        clr();
                        calculation(subTotal, tax_amount, discountamt, otherDiscForSelectedProds);
                        txtPaidAmt.Enabled = true;
                        ViewState["Details"] = dt;
                        ddlproduct.Enabled = true;
                        this.BindGrid();
                        ddlproduct.Items.FindByValue(productId.ToString()).Enabled = false;
                        btnUpdate.Visible = false;
                        btnAdd.Visible = true;

                        var SaleTaxGroup = (from ep in context.tbl_saleTaxGroup
                                            join e1 in context.tbl_saleTaxGroupDetailes on ep.SaleTaxGroupId equals e1.SaleTaxGroupId
                                            join t in context.tbl_taxtype on e1.type_id equals t.type_id
                                            where ep.sale_id == saleId && ep.product_id == productId
                                            select new
                                            {
                                                group_id = ep.group_id,
                                                group_name = ep.group_name,
                                                type_name = t.type_name,
                                                type_id = e1.type_id,
                                                tax_percentage = e1.tax_percentage,
                                                product_id = ep.product_id,
                                                totaltaxPercentage = ep.totalTaxPercentage
                                            }).ToList();
                        DataTable SaleTaxGroupDataTable = helper.LINQToDataTable(SaleTaxGroup);

                        DataTable dt2 = (DataTable)ViewState["TaxDetails"];
                        if (SaleTaxGroupDataTable.Rows.Count > 0)
                        {
                            for (int i = 0; i < SaleTaxGroupDataTable.Rows.Count; i++)
                            {
                                dt2.Rows.Add(
                                               SaleTaxGroupDataTable.Rows[i].Field<int>("product_id"),
                                                SaleTaxGroupDataTable.Rows[i].Field<int>("group_id"),
                                               SaleTaxGroupDataTable.Rows[i].Field<string>("group_name"),
                                               SaleTaxGroupDataTable.Rows[i].Field<string>("type_name"),
                                           SaleTaxGroupDataTable.Rows[i].Field<decimal>("tax_percentage"),
                                           SaleTaxGroupDataTable.Rows[i].Field<decimal>("totaltaxPercentage"),
                                               SaleTaxGroupDataTable.Rows[i].Field<int>("type_id")
                                               );
                            }
                        }
                        ViewState["TaxDetails"] = dt2;
                        this.BindTaxGrid();



                    }
                }
                else
                {
                    lblcheckDoubleError.Text = ValidateQuantity(enteredQuantity, productId, saleId)[1];
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["total"] != null && ViewState["dis"] != null && ViewState["tax"] != null)
                {
                    updatecal();

                    if (ViewState["Details"] != null)
                    {

                        DataTable dt = ViewState["Details"] as DataTable;
                        int row = Convert.ToInt32(ViewState["id"]);
                        dt.Rows[row].Delete();
                        lblcheckDoubleError.Text = string.Empty;
                        gvsalesdetails.DataSource = dt;
                        gvsalesdetails.DataBind();
                    }


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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //savedcode();
            Save();
        }

        protected void GrdOriginalSale_DataBound(object sender, EventArgs e)
        {
            int firstRowSpan = 2;
            int secondRowSpan = 2;
            for (int i = GrdOriginalSale.Rows.Count - 2; i >= 0; i--)
            {
                GridViewRow currRow = GrdOriginalSale.Rows[i];
                GridViewRow prevRow = GrdOriginalSale.Rows[i + 1];
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

        protected void GrdOriginalSale_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Image img = (Image)e.Row.FindControl("image");

                    if (e.Row.Cells[1].Text == "Sale")
                    {
                        img.ImageUrl = "/Uploads/up.png";
                        img.Visible = true;
                    }
                    else if (e.Row.Cells[1].Text == "Return")
                    {
                        img.ImageUrl = "/Uploads/down.png";
                        img.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void btnPayBack_Click(object sender, EventArgs e)
        {
            string balanceAmnt = txtBalanceAmt.Text.Replace('-', ' ');
            decimal paidAmnt = txtPaidAmt.Text == "" ? 0 : Convert.ToDecimal(txtPaidAmt.Text);
            decimal remainingBalance = Convert.ToDecimal(lblResultGrndTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text);
            decimal amntTobeTaken = remainingBalance - (remainingBalance * 2);
            decimal ResultAmt = remainingBalance + paidAmnt;
            if (ResultAmt >= remainingBalance)
            {
                txtPaidAmt.Text = amntTobeTaken.ToString();
                // txtBalanceAmt.Text = "0";
            }
            else
            {
                txtBalanceAmt.Text = (ResultAmt).ToString();
                // btnGetRefund.Visible = true;
            }
            txtBalanceAmt.Text = "0";
            btnPayBack.Visible = false;

            //string balanceAmnt = txtBalanceAmt.Text.Replace('-', ' ');
            //txtPaidAmt.Text = balanceAmnt;
            //txtBalanceAmt.Text = "0";
            //btnPayBack.Visible = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("SalesReturn.aspx", false);
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void txtPaidAmt_TextChanged(object sender, EventArgs e)
        {
            try
            {

                decimal remainingBalance = Convert.ToDecimal(lblResultGrndTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text);

                decimal grandTotal = Convert.ToDecimal(lblGrandTotal.Text);
                decimal paidAmnt = Convert.ToDecimal(txtPaidAmt.Text);
                decimal Amnt = Convert.ToDecimal(txtBalanceAmt.Text);

                decimal amntTobeTaken = remainingBalance - (remainingBalance * 2);





                if (remainingBalance < paidAmnt)
                {
                    if (remainingBalance < 0)
                    {
                        decimal ResultAmt = remainingBalance + paidAmnt;
                        if (ResultAmt > amntTobeTaken)
                        {
                            txtPaidAmt.Text = amntTobeTaken.ToString();
                            txtBalanceAmt.Text = "0";
                        }
                        else if (ResultAmt < 0)
                        {
                            txtBalanceAmt.Text = (ResultAmt).ToString();
                        }
                        else
                        {

                            // btnGetRefund.Visible = true;
                            txtPaidAmt.Text = amntTobeTaken.ToString();
                            txtBalanceAmt.Text = "0";
                        }

                    }
                    else if (paidAmnt == amntTobeTaken)
                    {
                        txtPaidAmt.Text = amntTobeTaken.ToString();
                        txtBalanceAmt.Text = "0";
                    }
                    else
                    {
                        txtPaidAmt.Text = remainingBalance.ToString();
                        txtBalanceAmt.Text = "0";
                    }
                }
                else if (txtPaidAmt.Text == "0" || string.IsNullOrEmpty(txtPaidAmt.Text))
                {
                    btnPayBack.Visible = false;
                    txtBalanceAmt.Text = remainingBalance.ToString();
                    //return;
                }
                else if (remainingBalance > paidAmnt)
                {

                    if (paidAmnt > remainingBalance)
                    {
                        txtPaidAmt.Text = amntTobeTaken.ToString();
                        txtBalanceAmt.Text = "0";
                    }
                    else
                    {
                        remainingBalance = remainingBalance - paidAmnt;
                        txtBalanceAmt.Text = remainingBalance.ToString();
                    }
                }

                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        //--============File Attachment Code done by as Afroz for sale return =========================>
        public bool uploadfile(FileUpload _fileUpload, string _path, string _filename)
        {
            bool returnMsg = false;
            try
            {
                if (_fileUpload.HasFile)
                {
                    _filename = Path.GetFileName(_fileUpload.PostedFile.FileName);
                    _fileUpload.PostedFile.SaveAs(Server.MapPath(_path) + _filename);
                    returnMsg = true;
                }
            }
            catch (Exception ex)

            {
                ErrorLog.saveerror(ex);
            }
            return returnMsg;
        }
        #endregion
    }
}