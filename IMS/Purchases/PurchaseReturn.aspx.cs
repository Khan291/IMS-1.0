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
    public partial class PurchaseReturn : System.Web.UI.Page
    {
        /// <summary>
        /// Objects That are used in coding
        /// </summary>
        static int companyId = 0, branchId = 0, financialYearId = 0;
        string user_id = string.Empty;
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlHelper helper = new SqlHelper();
        string connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();
            if (!IsPostBack)
            {

                //btnimg_update.Attributes.Add("onclick", "this.disabled = 'true';"
                //                + ClientScript.GetPostBackEventReference(btnimg_update, null)
                //                + ";this.src = 'Images/wait.png';");
                if (ViewState["Details"] == null)
                {
                    DataTable dataTable = new DataTable();

                    dataTable.Columns.Add("purchasedetails_id");
                    dataTable.Columns.Add("Product_id");
                    dataTable.Columns.Add("batch_id");
                    dataTable.Columns.Add("unit_id");
                    dataTable.Columns.Add("tax_id");
                    dataTable.Columns.Add("amount");
                    dataTable.Columns.Add("dicount_amt");
                    dataTable.Columns.Add("tax_amt");
                    dataTable.Columns.Add("purchase_rate");
                    dataTable.Columns.Add("quantity");
                    dataTable.Columns.Add("product_name");
                    dataTable.Columns.Add("unit_name");
                    dataTable.Columns.Add("batch_name");
                    dataTable.Columns.Add("tax_percentage");
                    ViewState["Details"] = dataTable;
                }
                this.BindGrid();
                ddlpaymentmodebind();
            }
        }
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> GetPoNumbers(string prefixText, int count)
        {
            IMS_TESTEntities context = new IMS_TESTEntities();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    int year = DateTime.Now.Year;
                    prefixText = year.ToString() + "P" + prefixText;
                    var result = context.tbl_purchase.Where(p => p.InvoiceNumber.Contains(prefixText) && p.company_id == companyId);
                    List<string> customers = new List<string>();
                    customers = result.Select(p => p.InvoiceNumber).ToList<string>();
                    return customers;
                }
            }
        }
        //end ather code
        /// <summary>
        /// All The Methods
        /// </summary>

        #region Methods
        [System.Web.Services.WebMethod]
        public static string[] ValidateQuantity(decimal enterdQuantity, int productid, int purchaseId)
        {
            string[] isfail = new string[2];
            isfail[0] = "false";
            isfail[1] = "";
            IMS_TESTEntities context = new IMS_TESTEntities();
            // int purchaseId = Convert.ToInt32(hdnPurchaseId.Value);
            try
            {
                if (enterdQuantity != 0 && productid != 0)
                {
                    if (companyId != 0 && purchaseId != 0)
                    {
                        SqlHelper helper = new SqlHelper();
                        var stockQuantity = context.tbl_stock.Where(s => s.company_id == companyId && s.product_id == productid).FirstOrDefault();

                        var returnQuantity = context.GetReturnQuantity(purchaseId, Constants.Purchase, productid, companyId).FirstOrDefault();
                        if (enterdQuantity <= returnQuantity)
                        {
                            if (stockQuantity.qty < Convert.ToDecimal(enterdQuantity))
                            {
                                isfail[0] = "true";
                                //lblcheckDoubleError.Visible = true;
                                isfail[1] = "Insufficient stock quantity.";
                                return isfail;
                            }
                        }
                        else
                        {
                            if (stockQuantity.qty <= returnQuantity)
                            {
                                isfail[0] = "true";
                                //lblcheckDoubleError.Visible = true;
                                isfail[1] = "Only " + stockQuantity.qty + " can be return for the selected product, Since some of item sold.";
                                return isfail;
                            }
                            else {
                                isfail[0] = "true";
                                //lblcheckDoubleError.Visible = true;
                                isfail[1] = "Only " + returnQuantity + " can be return for the selected product.";
                                return isfail;
                            }
                        }
                    }
                }
                else
                {
                    isfail[0] = "true";
                    //lblcheckDoubleError.Visible = true;
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

        public bool productvalid(int productid, decimal enterdQuantity, int count)
        {
            decimal totalqty = 0;
            decimal availableqty = 0;

            decimal stockQuantity = Convert.ToDecimal(Session["quant"]);
            for (int i = 0; i <= gvpurchasedetails.Rows.Count - 1; i++)
            {
                int pid = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[2].Text);
                decimal gridQty = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[5].Text);

                if (pid == productid)
                {
                    if (count == 0)
                    {
                        ddlproduct.Items.Remove(ddlproduct.Items.FindByValue(pid.ToString()));                       
                    }

                }
            }

            if (stockQuantity < totalqty || stockQuantity < enterdQuantity)
            {
                lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                lblcheckDoubleError.Text = "Out Of Stock";
                return false;
            }

            else
            {
                availableqty = stockQuantity - enterdQuantity;
                lblcheckDoubleError.ForeColor = System.Drawing.Color.Green;
                lblcheckDoubleError.Text = "Avialable Quantity In Stock " + availableqty;
                return true;
            }
            // if(total > avali)

        }
        public void ddlpaymentmodebind()
        {
            int c_id = Convert.ToInt32(Session["company_id"]);
            List<tbl_paymentmode> cd = context.tbl_paymentmode.Where(x => x.status == true).ToList();
            ddlPaymentMode.DataTextField = "paymentmode_name";
            ddlPaymentMode.DataValueField = "paymentode_id";
            ddlPaymentMode.DataSource = cd;
            ddlPaymentMode.DataBind();
        }
        //private void BindOrigianlPurchaseGrid()
        //{
        //    try
        //    {
        //        int purchaseId = Convert.ToInt32(hdnPurchaseId.Value);
        //        var purcahseDetails= context.sp_GetPurchaseDetailsById(purchaseId).ToList();
        //        if(purcahseDetails!=null)
        //        {
        //            lblBalanceAmnt.Text = purcahseDetails.FirstOrDefault().balance_amnt.ToString();
        //            lblGivenAmnt.Text = purcahseDetails.FirstOrDefault().given_amnt.ToString();
        //            lblTotalAmnt.Text = purcahseDetails.FirstOrDefault().total_amnt.ToString();
        //            lblTotalTax.Text = purcahseDetails.FirstOrDefault().total_tax.ToString();
        //            lblTotalDiscount.Text = purcahseDetails.FirstOrDefault().total_discount.ToString();
        //            lblGrndTotal.Text = purcahseDetails.FirstOrDefault().grand_total.ToString();
        //        }

        //        GrdOriginalPurchase.DataSource = purcahseDetails;
        //        GrdOriginalPurchase.DataBind();
        //    }
        //    catch (Exception ex)
        //    {

        //        ErrorLog.saveerror(ex);
        //    }
        //}

        private void FetchData(int purchaseId)
        {

            SqlParameter[] sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", purchaseId),
                         new SqlParameter("@FromTable","COMBINEPURCHASEANDRETURN")
                    };

            var ds = Common.FillDataSet(connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams);

            if (ds.Tables["Table"] != null)
            {
                decimal givenAmnt=0, totalDiscount = 0, subTotal = 0, grandTotal = 0, totalTax = 0;

                for (int i = 0; i < ds.Tables["Table"].Rows.Count; i++)
                {
                    if (ds.Tables["Table"].Rows[i]["Type"].ToString() == "Purchase")
                    {
                        totalTax = totalTax + Convert.ToDecimal(ds.Tables["Table"].Rows[i]["TaxAmnt"]);
                        totalDiscount = totalDiscount + Convert.ToDecimal(ds.Tables["Table"].Rows[i]["DiscountAmnt"]);
                        subTotal = subTotal + Convert.ToDecimal(ds.Tables["Table"].Rows[i]["ProductAmount"]);
                       
                    }
                    else if (ds.Tables["Table"].Rows[i]["Type"].ToString() == "Return")
                    {   
                        totalTax = totalTax - Convert.ToDecimal(ds.Tables["Table"].Rows[i]["TaxAmnt"]);
                        totalDiscount = totalDiscount - Convert.ToDecimal(ds.Tables["Table"].Rows[i]["DiscountAmnt"]);
                        subTotal = subTotal - Convert.ToDecimal(ds.Tables["Table"].Rows[i]["ProductAmount"]);
                        
                    }
                    givenAmnt = Convert.ToDecimal(ds.Tables["Table"].Rows[i]["GivenAmnt"]);
                }
                grandTotal = subTotal + totalTax - totalDiscount;

                //DataRow dr = ds.Tables["Table"].Select("Id=" + purchaseId + "").FirstOrDefault();

                //assign it to the the current return screen as well as the original purchase field
                lblGivenAmnt.Text = givenAmnt.ToString();
                lblTotalAmnt.Text = subTotal.ToString();
                lblTotalTax.Text = totalTax.ToString(); 
                lblTotalDiscount.Text = totalDiscount.ToString();
                lblOriginalGrndTotal.Text = grandTotal.ToString();              

                GrdOriginalPurchase.DataSource = ds.Tables["Table"];
                GrdOriginalPurchase.DataBind();
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
                //Do Logging
            }
        }
        public void GetpurchaseDetails()
        {
            try
            {
                var purchase = context.tbl_purchase.Where(w => w.InvoiceNumber == txtPoNo.Text && w.company_id == companyId && w.branch_id == branchId).FirstOrDefault();
                if (purchase == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Invoice does not exist, Please enter valid Invoice Number.','True');", true);
                    return;
                }
                hdnPurchaseId.Value = purchase.purchase_id.ToString();

                var products = context.tbl_purchasedetails.Join(context.tbl_product, pd => pd.product_id, p => p.product_id, (pd, p) => new { pd.purchase_id, pd.product_id, p.product_name }).Where(w => w.purchase_id == purchase.purchase_id).ToList();

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
        public void calculation(decimal sub_Total, decimal total_tax, decimal total_discount)
        {
            lblsubtotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + sub_Total).ToString("0.##");
            lblResultSubTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text) - Convert.ToDecimal(lblsubtotal.Text)).ToString("0.##");

            lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) + total_tax).ToString("0.##");
            lblResultTotalTaxAmnt.Text= (Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTaxAmount.Text)).ToString("0.##");

            lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) + total_discount).ToString("0.##");
            lblResultTotalDiscount.Text = (Convert.ToDecimal(lblTotalDiscount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");

            lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");
            lblOriginalGrndTotal.Text= (Convert.ToDecimal(lblTotalAmnt.Text) + Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTotalDiscount.Text)).ToString("0.##");

            lblResultGrndTotal.Text = (Convert.ToDecimal(lblOriginalGrndTotal.Text) - Convert.ToDecimal(lblGrandTotal.Text)).ToString("0.##");


            txtBalanceAmt.Text = (Convert.ToDecimal(lblResultGrndTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text)).ToString("0.##");
            if (Convert.ToDecimal(txtBalanceAmt.Text) < 0)
            {
                btnGetRefund.Visible = true;
            }
            else
            {
                btnGetRefund.Visible = false;
            }
            //lblsubtotal.Text = (Convert.ToDecimal(lblsubtotal.Text) - sub_Total).ToString("0.##");
            //lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) - total_tax).ToString("0.##");
            //lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) - total_discount).ToString("0.##");

            //lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");
            //txtBalanceAmt.Text = (Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text)).ToString("0.##");
            //if (Convert.ToDecimal(txtBalanceAmt.Text) < 0)
            //    btnGetRefund.Visible = true;
        }

        public void clr()
        {
            ddlproduct.SelectedIndex = 0;
            txtquantity.Text = string.Empty;
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

        protected void Save()
        {
            try
            {
                int purchaseId = Convert.ToInt32(hdnPurchaseId.Value);
                if (purchaseId == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Purchase No','False');", true);
                    return;
                }
                //Get Origianl Purchase Details
                tbl_purchase purchase = new tbl_purchase();
                purchase = context.tbl_purchase.Where(pd => pd.purchase_id == purchaseId && pd.company_id == companyId && pd.branch_id == branchId).FirstOrDefault();

                tbl_purchasereturn purchaseReturn = new tbl_purchasereturn();
                purchaseReturn.purchase_id = purchaseId;
                purchaseReturn.company_id = companyId;
                purchaseReturn.branch_id = branchId;
                purchaseReturn.financialyear_id = financialYearId;
                purchaseReturn.InvoiceNumber = txtPoNo.Text;               
                purchaseReturn.paymentmode_id = Convert.ToInt32(ddlPaymentMode.SelectedValue);
                purchaseReturn.status = true;
                purchaseReturn.party_id = Convert.ToInt32(purchase.party_id);              
                purchaseReturn.created_by = user_id;
                purchaseReturn.created_date = DateTime.Now;

                //Update into Purchase Payment Details 
                tbl_PurchasePaymentDetials purchasePaymentDetail = context.tbl_PurchasePaymentDetials.Where(w => w.PurchaseId == purchaseId).FirstOrDefault();
                purchasePaymentDetail.PaidAmnt = Convert.ToDecimal(txtPaidAmt.Text);
                purchasePaymentDetail.GivenAmnt = Convert.ToDecimal(lblGivenAmnt.Text) - Convert.ToDecimal(txtPaidAmt.Text);
                purchasePaymentDetail.BalanceAmnt = Convert.ToDecimal(txtBalanceAmt.Text);
                purchasePaymentDetail.TaxAmount = Convert.ToDecimal(lblResultTotalTaxAmnt.Text);
                purchasePaymentDetail.DiscountAmount = Convert.ToDecimal(lblResultTotalDiscount.Text);
                purchasePaymentDetail.SubTotal = Convert.ToDecimal(lblResultSubTotal.Text);
                purchasePaymentDetail.GrandTotal = Convert.ToDecimal(lblResultGrndTotal.Text);
                purchasePaymentDetail.FromTable = "Return";
                purchase.tbl_PurchasePaymentDetials.Add(purchasePaymentDetail);

                for (int i = 0; i <= gvpurchasedetails.Rows.Count - 1; i++)
                {
                    int productId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[2].Text);
                    int batchId = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[4].Text);
                    tbl_product product = context.tbl_product.Where(w => w.product_id == productId).FirstOrDefault();

                    tbl_purchasereturndetails purchaseReturnDetails = new tbl_purchasereturndetails();
                    purchaseReturnDetails.product_id = productId;
                    purchaseReturnDetails.batch_id = batchId;
                   // purchaseReturnDetails.tax_id = product.tax_id;
                    purchaseReturnDetails.unit_id = product.unit_id;
                    purchaseReturnDetails.discount_amnt = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[7].Text);
                    purchaseReturnDetails.tax_amt = gvpurchasedetails.Rows[i].Cells[9].Text;
                    purchaseReturnDetails.quantity = Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                    purchaseReturnDetails.amount = Convert.ToDecimal(gvpurchasedetails.Rows[i].Cells[10].Text);
                    purchaseReturnDetails.created_by = Convert.ToString(user_id);
                    purchaseReturnDetails.created_date = Convert.ToDateTime(DateTime.Now);
                    purchaseReturnDetails.status = true;

                    tbl_stock stock = new tbl_stock();
                    stock = context.tbl_stock.Where(w => w.company_id == companyId && w.branch_id == branchId && w.product_id == productId && w.batch_id == batchId).FirstOrDefault();
                    stock.qty = stock.qty - Convert.ToInt32(gvpurchasedetails.Rows[i].Cells[5].Text);
                    stock.modified_by = Convert.ToString(user_id);
                    stock.modified_date = Convert.ToDateTime(DateTime.Now);

                    purchaseReturn.tbl_purchasereturndetails.Add(purchaseReturnDetails);
                }

                context.tbl_purchasereturn.Add(purchaseReturn);
                context.SaveChanges();
                string invoiceNumber = purchaseReturn.InvoiceNumber;
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('saved Successfully, You order number is " + invoiceNumber + "','True');", true);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        #endregion


        /// <summary>
        /// All The Events That are used in this page
        /// </summary>

        #region Events
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            OriginalPurchaseDetails.Visible = true;
            ddlproduct.Items.Clear();
            GetpurchaseDetails();
            //BindOrigianlPurchaseGrid();
            if (!string.IsNullOrEmpty(hdnPurchaseId.Value))
            {
                int purchaseId = Convert.ToInt32(hdnPurchaseId.Value);
                FetchData(purchaseId);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int purchaseId = Convert.ToInt32(hdnPurchaseId.Value);
            //lblcheckDoubleError.Text = string.Empty;
            int productId = Convert.ToInt32(ddlproduct.SelectedValue);
            decimal enteredQuantity = Convert.ToDecimal(txtquantity.Text);

            try
            {
                //Get Original price, Tax and discount happened during Purchase
                var productDetails = context.sp_GetPurchaseDetailsById(purchaseId);
                if (productDetails != null)
                {
                    var oneproductDetail = productDetails.Where(w => w.product_id == productId);
                    if (!Convert.ToBoolean(ValidateQuantity(enteredQuantity, productId, purchaseId)[0]))
                    {
                        decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(oneproductDetail.FirstOrDefault().purchase_rate);
                        decimal a = subTotal / 100;
                        decimal discount_percent = (Convert.ToDecimal(oneproductDetail.FirstOrDefault().dicount_amt) * 100) / Convert.ToDecimal(oneproductDetail.FirstOrDefault().amount);
                        decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                        decimal tax_amount = a * Convert.ToDecimal(oneproductDetail.FirstOrDefault().tax_percentage);

                        clr();
                        calculation(subTotal, tax_amount, discountamt);
                        txtPaidAmt.Enabled = true;

                        DataTable tbl = (DataTable)ViewState["Details"];

                        tbl.Rows.Add(oneproductDetail.FirstOrDefault().purchasedetails_id, productId, oneproductDetail.FirstOrDefault().batch_id, oneproductDetail.FirstOrDefault().unit_id,
                            oneproductDetail.FirstOrDefault().tax_id, subTotal, discountamt, tax_amount, oneproductDetail.FirstOrDefault().purchase_rate, enteredQuantity,
                            oneproductDetail.FirstOrDefault().product_name, oneproductDetail.FirstOrDefault().unit_name, oneproductDetail.FirstOrDefault().batch_name,
                            oneproductDetail.FirstOrDefault().tax_percentage);
                        ViewState["Details"] = tbl;
                        this.BindGrid();
                        ddlproduct.Items.FindByValue(productId.ToString()).Enabled = false;

                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }

        //private void SaveLogic()
        //{
        //    SqlTransaction transaction;
        //    SqlCommand cmd = new SqlCommand();

        //    cmd.Connection = con;
        //    cmd.CommandTimeout = 600000;
        //    con.Open();
        //    transaction = con.BeginTransaction("Transaction");
        //    cmd.Transaction = transaction;
        //    try
        //    {
        //        string date = DateTime.Today.ToString();
        //        string user = Session["UserID"].ToString();
        //        int c_id = Convert.ToInt32(Session["company_id"]);
        //        int b_id = Convert.ToInt32(Session["branch_id"]);
        //        int party_id = 0;
        //        int a = Convert.ToInt32(hdnPurchaseId.Value);
        //        if (a != 0)
        //        {
        //            //tbl_purchase p = new tbl_purchase();
        //            //p.company_id = c_id;
        //            //p.purchase_id = a;
        //            //// p.All2(p);
        //            var purchase = context.tbl_purchase.Where(pd => pd.purchase_id == a && pd.company_id == c_id).FirstOrDefault();
        //            party_id = Convert.ToInt32(purchase.party_id);

        //        }
        //        else
        //        {
        //            ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Purchase No','False');", true);
        //            return;
        //        }


        //        int Purchase_id = Convert.ToInt32(a);
        //        if (Purchase_id != 0)
        //        {

        //            decimal tax_amount = Convert.ToDecimal(lblTaxAmount.Text);
        //            decimal sub_total = Convert.ToDecimal(lblsubtotal.Text);
        //            decimal discount = Convert.ToDecimal(lblDiscountAmt.Text);
        //            decimal grandtotal = Convert.ToDecimal(lblGrandTotal.Text);

        //            //Purchase Return Main Table Insertion Code
        //            cmd.CommandText = "sp_insertpurchasereturnmain";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.AddWithValue("@Purchase_id", Purchase_id);
        //            cmd.Parameters.AddWithValue("@branch_id", b_id);
        //            cmd.Parameters.AddWithValue("@company_id", c_id);
        //            cmd.Parameters.AddWithValue("@total_tax", tax_amount);
        //            cmd.Parameters.AddWithValue("@actual_amount", sub_total);
        //            cmd.Parameters.AddWithValue("@grand_total", grandtotal);
        //            cmd.Parameters.AddWithValue("@total_discount ", discount);
        //            cmd.Parameters.AddWithValue("@created_by", user);
        //            cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
        //            cmd.Parameters.Add("@purchasereturnmain_id", SqlDbType.Int);
        //            cmd.Parameters["@purchasereturnmain_id"].Direction = ParameterDirection.Output;
        //            cmd.ExecuteNonQuery();
        //            Session["prmid"] = Convert.ToInt32(cmd.Parameters["@purchasereturnmain_id"].Value);
        //            cmd.Parameters.Clear();
        //        }


        //        int mcid = Convert.ToInt32(Session["prmid"]);

        //        for (int i = 0; i <= gvpurchasedetails.Rows.Count - 1; i++)
        //        {
        //            GridViewRow row = gvpurchasedetails.Rows[i];
        //            //Purchase Details Saving Code Start Here
        //            int salesedetail_id = Convert.ToInt32(row.Cells[12].Text);
        //            if (salesedetail_id != 0)
        //            {
        //                cmd.CommandText = "sp_insert_purchase_return";
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@purchasereturnmain_id", mcid);
        //                cmd.Parameters.AddWithValue("@purchasedetails_id", salesedetail_id);
        //                cmd.Parameters.AddWithValue("@product_id", Convert.ToInt32(row.Cells[2].Text));
        //                cmd.Parameters.AddWithValue("@batch_id", Convert.ToInt32(row.Cells[4].Text));
        //                cmd.Parameters.AddWithValue("@tax_amt", Convert.ToDecimal(row.Cells[9].Text));
        //                cmd.Parameters.AddWithValue("@quantity", Convert.ToDecimal(row.Cells[5].Text));
        //                cmd.Parameters.AddWithValue("@amount", Convert.ToDecimal(row.Cells[10].Text));
        //                cmd.Parameters.AddWithValue("@created_by", user);
        //                cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
        //                cmd.Connection = con;
        //                cmd.CommandTimeout = 600000;
        //                cmd.ExecuteNonQuery();
        //                cmd.Parameters.Clear();
        //            }

        //            // Stock & Stock Transaction Data Saving Code end

        //        }




        //        cmd.Parameters.Clear();

        //        cmd.CommandText = "sp_InsertMonyTransaction";
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@company_id", c_id);
        //        cmd.Parameters.AddWithValue("@branch_id", b_id);
        //        cmd.Parameters.AddWithValue("@party_id", party_id);
        //        cmd.Parameters.AddWithValue("@given_amt", txtPaidAmt.Text);
        //        cmd.Parameters.AddWithValue("@grand_total", lblGrandTotal.Text);
        //        cmd.Parameters.AddWithValue("@balance_amt", txtBalanceAmt.Text);
        //        cmd.Parameters.AddWithValue("@in_out", "In");
        //        cmd.Parameters.AddWithValue("@paymentmode_id", ddlPaymentMode.SelectedValue);
        //        cmd.Parameters.AddWithValue("@transaction_typ", "Purchase Return");
        //        cmd.Parameters.AddWithValue("@transactio_type_id", mcid);
        //        cmd.Parameters.AddWithValue("@created_by", user);
        //        cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
        //        cmd.Connection = con;
        //        cmd.CommandTimeout = 600000;
        //        cmd.ExecuteNonQuery();
        //        transaction.Commit();
        //        con.Close();

        //        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Saved successfully','True');", true);


        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }
        //    finally
        //    {
        //        if (con != null && con.State != ConnectionState.Closed)
        //        {
        //            con.Close();
        //        }
        //    }
        //}
        //protected void ddlproduct_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        int purchaseId = Convert.ToInt32(hdnPurchaseId.Value);
        //        lblcheckDoubleError.Text = string.Empty;
        //        int productId = Convert.ToInt32(ddlproduct.SelectedValue);
        //        var stockQuantity = context.tbl_stock.Where(s => s.company_id == companyId && s.product_id == productId).FirstOrDefault();
        //        var returnQuantity = context.GetReturnQuantity(purchaseId, Constants.Purchase, productId).FirstOrDefault().Value;
        //        //int data = helper.GetStockQuantity(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(p_id));
        //        Session["quant"] = stockQuantity.qty;
        //        txtAvailableQuantity.Text = returnQuantity.ToString();
        //        //lblcheckDoubleError.ForeColor = System.Drawing.Color.Green;
        //        //lblcheckDoubleError.Text = "Avialable Quantity In Stock " + stockQuantity.qty;
        //        UpdatePanel1.Update();
        //    }
        //    catch (Exception ex)
        //    {

        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }
        //}




        protected void gvpurchasedetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow grv = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer);

                decimal subTotal = Convert.ToDecimal(grv.Cells[5].Text) * Convert.ToDecimal(grv.Cells[6].Text);
                decimal a = subTotal / 100;
                decimal discount_percent = decimal.Parse(grv.Cells[7].Text) * 100 / decimal.Parse(grv.Cells[10].Text);
                decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                decimal tax_amount = a * decimal.Parse(grv.Cells[8].Text);
                

                if (e.CommandName == "Delete row")
                {
                    int rowIndex = grv.RowIndex;
                    ViewState["id"] = rowIndex;
                    ddlproduct.Items.FindByValue(grv.Cells[2].Text).Enabled = true;
                    DataTable dt = ViewState["Details"] as DataTable;
                    dt.Rows[rowIndex].Delete();
                    ViewState["Details"] = dt;
                    DeleteCalculation(subTotal, tax_amount, discountamt);
                    this.BindGrid();

                }
                else if (e.CommandName == "Update Row")
                {
                    if (!btnUpdate.Visible)
                    {

                        ViewState["id"] = grv.RowIndex;
                        ddlproduct.SelectedValue = grv.Cells[2].Text.ToString();
                        
                        ddlproduct.Items.FindByValue(grv.Cells[2].Text).Enabled = true;
                        txtquantity.Text = grv.Cells[5].Text.ToString();
                        btnUpdate.Visible = true;
                        btnAdd.Visible = false;
                        ddlproduct.Enabled = false;
                        DeleteCalculation(subTotal, tax_amount, discountamt);
                        //grv.Cells[12].Enabled = false;
                        
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        private void DeleteCalculation(decimal sub_Total, decimal tax_amount, decimal discountamt)
        {

            lblsubtotal.Text = (Convert.ToDecimal(lblsubtotal.Text) - sub_Total).ToString("0.##");
            lblResultSubTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text) - Convert.ToDecimal(lblsubtotal.Text)).ToString("0.##");

            lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) - tax_amount).ToString("0.##");
            lblResultTotalTaxAmnt.Text = (Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTaxAmount.Text)).ToString("0.##");

            lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) - discountamt).ToString("0.##");
            lblResultTotalDiscount.Text = (Convert.ToDecimal(lblTotalDiscount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");

            lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");
            lblOriginalGrndTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text) + Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTotalDiscount.Text)).ToString("0.##");

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
                btnGetRefund.Visible = true;


            //lblsubtotal.Text = Convert.ToString(Convert.ToDecimal(lblsubtotal.Text) + sub_Total);//.ToString("0.##");
            //lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) + tax_amount).ToString("0.##");
            //lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) + discountamt).ToString("0.##");

            //lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");

            //txtBalanceAmt.Text = (Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text)).ToString("0.##");

            //txtPaidAmt.Text = "0.00";
            //if (Convert.ToDecimal(txtBalanceAmt.Text) < 0)
            //    btnGetRefund.Visible = true;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int purchaseId = Convert.ToInt32(hdnPurchaseId.Value);
            lblcheckDoubleError.Text = string.Empty;
            DataTable dt = new DataTable();
            dt = (DataTable)ViewState["Details"];
            int productId = Convert.ToInt32(ddlproduct.SelectedValue);
            decimal enteredQuantity = Convert.ToDecimal(txtquantity.Text);
            try
            {
                if (!Convert.ToBoolean(ValidateQuantity(enteredQuantity, productId, purchaseId)[0]))
                {
                    DataRow dr = dt.Select("product_id=" + productId + "").FirstOrDefault();
                    if (dr != null)
                    {
                        decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(dr["purchase_rate"]);
                        decimal a = subTotal / 100;
                        decimal discount_percent = (Convert.ToDecimal(dr["dicount_amt"]) * 100) / Convert.ToDecimal(dr["amount"]);
                        decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                        decimal tax_amount = a * Convert.ToDecimal(dr["tax_percentage"]);

                        dr["quantity"] = txtquantity.Text;
                        dr["tax_amt"] = tax_amount;
                        dr["dicount_amt"] = discountamt;
                        dr["amount"] = subTotal;

                        clr();
                        calculation(subTotal, tax_amount, discountamt);                       
                        txtPaidAmt.Enabled = true;
                        ViewState["Details"] = dt;
                        ddlproduct.Enabled = true;
                        this.BindGrid();
                        ddlproduct.Items.FindByValue(productId.ToString()).Enabled = false;
                        btnUpdate.Visible = false;
                        btnAdd.Visible = true;
                    }
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
                        gvpurchasedetails.DataSource = dt;
                        gvpurchasedetails.DataBind();
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

        protected void GrdOriginalPurchase_DataBound(object sender, EventArgs e)
        {
            try
            {
                int firstRowSpan = 2;
            int secondRowSpan = 2;
            for (int i = GrdOriginalPurchase.Rows.Count - 2; i >= 0; i--)
            {
                GridViewRow currRow = GrdOriginalPurchase.Rows[i];
                GridViewRow prevRow = GrdOriginalPurchase.Rows[i + 1];
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
                //Do Logging
            }
        }

        protected void GrdOriginalPurchase_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Image img = (Image)e.Row.FindControl("image");

                    if (e.Row.Cells[1].Text == "Purchase")
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

        protected void btnGetRefund_Click(object sender, EventArgs e)
        {
            string balanceAmnt = txtBalanceAmt.Text.Replace('-', ' ');
            decimal paidAmnt = txtPaidAmt.Text=="" ? 0 : Convert.ToDecimal(txtPaidAmt.Text);
            txtPaidAmt.Text = (Convert.ToDecimal(balanceAmnt) + paidAmnt).ToString() ;
            txtBalanceAmt.Text = "0";
            btnGetRefund.Visible = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("PurchaseReturn.aspx", false);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void txtGivenAmt_TextChanged(object sender, EventArgs e)
        {
            try
            {
                decimal remainingBalance = Convert.ToDecimal(lblResultGrndTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text);                           

                //if (remainingBalance < 0)
                //{
                //    btnGetRefund.Visible = true;
                //    txtBalanceAmt.Text = (remainingBalance + Convert.ToDecimal(txtPaidAmt.Text)).ToString();
                //}
                //else if (txtPaidAmt.Text == "0" || string.IsNullOrEmpty(txtPaidAmt.Text))
                //{
                //    btnGetRefund.Visible = false;
                //    txtBalanceAmt.Text = remainingBalance.ToString();
                //    return;
                //}
                //else
                //{
                //    txtBalanceAmt.Text = (remainingBalance - Convert.ToDecimal(txtPaidAmt.Text)).ToString();
                //}                
                decimal a = Convert.ToDecimal(lblGrandTotal.Text);
                decimal b = Convert.ToDecimal(txtPaidAmt.Text);
                if (remainingBalance < b)
                {
                    txtPaidAmt.Text = remainingBalance.ToString();
                    txtBalanceAmt.Text = "0";
                }
                else if (txtPaidAmt.Text == "0" || string.IsNullOrEmpty(txtPaidAmt.Text))
                {
                    btnGetRefund.Visible = false;
                    txtBalanceAmt.Text = remainingBalance.ToString();
                    //return;
                }
                else
                {
                    decimal c = Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(txtPaidAmt.Text);
                    txtBalanceAmt.Text = c.ToString();
                } 
                UpdatePanel1.Update();
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