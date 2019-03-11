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

namespace IMS.Sales
{
    public partial class SalesReturn : System.Web.UI.Page
    {
        /// <summary>
        /// Objects That are used in coding
        /// </summary>
        IMS_TESTEntities context = new IMS_TESTEntities();
        string connectionstring =  ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        SqlHelper helper = new SqlHelper();
        static int companyId = 0, branchId = 0, financialYearId = 0; string user_id = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();
            if (!IsPostBack)
            {
                if (ViewState["Details"] == null)
                {
                    DataTable dataTable = new DataTable();

                    dataTable.Columns.Add("saledetails_id");
                    dataTable.Columns.Add("Product_id");
                    dataTable.Columns.Add("batch_id");
                    dataTable.Columns.Add("unit_id");
                    dataTable.Columns.Add("tax_id");
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
                
                if (ViewState["TaxDetails"] == null)
                {
                    DataTable dataTable2 = new DataTable();

                    dataTable2.Columns.Add("product_id");
                    dataTable2.Columns.Add("group_id");
                    dataTable2.Columns.Add("group_name");
                    dataTable2.Columns.Add("type_name");
                    dataTable2.Columns.Add("tax_percentage");
                    dataTable2.Columns.Add("type_id");
                    ViewState["TaxDetails"] = dataTable2;
                }
                this.BindTaxGrid();
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
                    prefixText = year.ToString() + "S" + prefixText;
                    var result = context.tbl_sale.Where(p => p.InvoiceNumber.Contains(prefixText) && p.company_id == companyId);
                    List<string> customers = new List<string>();
                    customers = result.Select(p => p.InvoiceNumber).ToList<string>();
                    return customers;
                }
            }
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
        //public void savedcode()
        //{
        //    SqlTransaction transaction;
        //    SqlCommand cmd = new SqlCommand();

        //    cmd.Connection = connectionstring;
        //    cmd.CommandTimeout = 600000;
        //    connectionstring.Open();
        //    transaction = connectionstring.BeginTransaction("Transaction");
        //    cmd.Transaction = transaction;
        //    try
        //    {
        //        string date = DateTime.Today.ToString();
        //        string user = Session["UserID"].ToString();
        //        int c_id = Convert.ToInt32(Session["company_id"]);
        //        int b_id = Convert.ToInt32(Session["branch_id"]);
        //        int count;
        //        int party_id;
        //        int a = Convert.ToInt32(txtSoNo.Text);
        //        if (a != null)
        //        {
        //            tbl_sale p = new tbl_sale();
        //            p.company_id = c_id;
        //            p.sale_id = a;
        //            // p.SaleInvoice(p);
        //            party_id = Convert.ToInt32(p.party_id);

        //        }
        //        else
        //        {
        //            ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Purchase No','False');", true);
        //            return;
        //        }


        //        int sale_id = Convert.ToInt32(txtSoNo.Text);
        //        if (sale_id != 0)
        //        {

        //            decimal tax_amount = Convert.ToDecimal(lblTaxAmount.Text);
        //            decimal sub_total = Convert.ToDecimal(lblsubtotal.Text);
        //            decimal discount = Convert.ToDecimal(lblDiscountAmt.Text);
        //            decimal grandtotal = Convert.ToDecimal(lblGrandTotal.Text);
        //            cmd.CommandText = "sp_insertsalreturnmain";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.AddWithValue("@sale_id", sale_id);
        //            cmd.Parameters.AddWithValue("@branch_id", b_id);
        //            cmd.Parameters.AddWithValue("@company_id", c_id);
        //            cmd.Parameters.AddWithValue("@total_tax", tax_amount);
        //            cmd.Parameters.AddWithValue("@actual_amount", sub_total);
        //            cmd.Parameters.AddWithValue("@grand_total", grandtotal);
        //            cmd.Parameters.AddWithValue("@total_discount", discount);
        //            cmd.Parameters.AddWithValue("@created_by", user);
        //            cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
        //            cmd.Parameters.Add("@salereturnmain_id", SqlDbType.Int);
        //            cmd.Parameters["@salereturnmain_id"].Direction = ParameterDirection.Output;
        //            cmd.ExecuteNonQuery();
        //            Session["prmid"] = Convert.ToInt32(cmd.Parameters["@salereturnmain_id"].Value);

        //            cmd.Parameters.Clear();
        //        }


        //        int mcid = Convert.ToInt32(Session["prmid"]);


        //        foreach (GridViewRow row in gvsalesdetails.Rows)
        //        {
        //            int salesedetail_id = Convert.ToInt32(row.Cells[9].Text);
        //            if (salesedetail_id != 0)
        //            {
        //                cmd.CommandText = "sp_salereturn";
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@sale_id", sale_id);
        //                cmd.Parameters.AddWithValue("@saledetails_id", salesedetail_id);
        //                cmd.Parameters.AddWithValue("@product_id", Convert.ToInt32(row.Cells[2].Text));
        //                cmd.Parameters.AddWithValue("@batch_id", Convert.ToInt32(row.Cells[10].Text));
        //                cmd.Parameters.AddWithValue("@tax_amt", Convert.ToDecimal(row.Cells[7].Text));
        //                cmd.Parameters.AddWithValue("@dicount_amt", Convert.ToDecimal(row.Cells[5].Text));
        //                cmd.Parameters.AddWithValue("@quantity", Convert.ToDecimal(row.Cells[3].Text));
        //                cmd.Parameters.AddWithValue("@amount", Convert.ToDecimal(row.Cells[8].Text));
        //                cmd.Parameters.AddWithValue("@price", Convert.ToDecimal(row.Cells[4].Text));
        //                cmd.Parameters.AddWithValue("@created_by", user);
        //                cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
        //                cmd.Connection = con;
        //                cmd.CommandTimeout = 600000;
        //                cmd.ExecuteNonQuery();
        //                cmd.Parameters.Clear();

        //            }

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
        //        cmd.Parameters.AddWithValue("@in_out", "out");
        //        cmd.Parameters.AddWithValue("@paymentmode_id", ddlPaymentMode.SelectedValue);
        //        cmd.Parameters.AddWithValue("@transaction_typ", "Sale Return");
        //        cmd.Parameters.AddWithValue("@transactio_type_id", mcid);
        //        cmd.Parameters.AddWithValue("@created_by", Session["UserID"].ToString());
        //        cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
        //        cmd.Connection = con;
        //        cmd.CommandTimeout = 600000;
        //        cmd.ExecuteNonQuery();
        //        transaction.Commit();
        //        con.Close();
        //        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Saved Successfully','True');", true);
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
        public void calculation(decimal sub_Total, decimal total_tax, decimal total_discount)
        {
            //lblsubtotal.Text = Convert.ToString(Convert.ToDecimal(lblsubtotal.Text) - sub_Total);//.ToString("0.##");
            //lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) - total_tax).ToString("0.##");
            //lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) - total_discount).ToString("0.##");

            //lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");
            //txtBalanceAmt.Text = (Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text)).ToString("0.##");
            //if (Convert.ToDecimal(txtBalanceAmt.Text) < 0)
            //    btnPayBack.Visible = true;

            lblsubtotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + sub_Total).ToString("0.##");
            lblResultSubTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text) - Convert.ToDecimal(lblsubtotal.Text)).ToString("0.##");

            lblTaxAmount.Text = (Convert.ToDecimal(lblTaxAmount.Text) + total_tax).ToString("0.##");
            lblResultTotalTaxAmnt.Text = (Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTaxAmount.Text)).ToString("0.##");

            lblDiscountAmt.Text = (Convert.ToDecimal(lblDiscountAmt.Text) + total_discount).ToString("0.##");
            lblResultTotalDiscount.Text = (Convert.ToDecimal(lblTotalDiscount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");

            lblGrandTotal.Text = (Convert.ToDecimal(lblsubtotal.Text) + Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text)).ToString("0.##");
            lblOriginalGrndTotal.Text = (Convert.ToDecimal(lblTotalAmnt.Text) + Convert.ToDecimal(lblTotalTax.Text) - Convert.ToDecimal(lblTotalDiscount.Text)).ToString("0.##");

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

                var sale = context.tbl_sale.Where(pd => pd.sale_id == saleId && pd.company_id == companyId && pd.branch_id == branchId).FirstOrDefault();
                tbl_salereturn saleReturn = new tbl_salereturn();
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

                //Update into Sale Payment Details 
                tbl_SalePaymentDetails salePaymentDetails = context.tbl_SalePaymentDetails.Where(w => w.SaleId == saleId).FirstOrDefault();
                salePaymentDetails.PaidAmnt = Convert.ToDecimal(txtPaidAmt.Text);
                salePaymentDetails.TaxAmount = Convert.ToDecimal(lblResultTotalTaxAmnt.Text);
                salePaymentDetails.DiscountAmount = Convert.ToDecimal(lblResultTotalDiscount.Text);
                salePaymentDetails.SubTotal = Convert.ToDecimal(lblResultSubTotal.Text);
                salePaymentDetails.GrandTotal = Convert.ToDecimal(lblResultGrndTotal.Text);
                salePaymentDetails.GivenAmnt = Convert.ToDecimal(lblGivenAmnt.Text) - Convert.ToDecimal(txtPaidAmt.Text);
                salePaymentDetails.BalanceAmnt = Convert.ToDecimal(txtBalanceAmt.Text);
                salePaymentDetails.FromTable = "Return";
                sale.tbl_SalePaymentDetails.Add(salePaymentDetails);

                for (int i = 0; i <= gvsalesdetails.Rows.Count - 1; i++)
                {
                    int productId = Convert.ToInt32(gvsalesdetails.Rows[i].Cells[2].Text);
                    int batchId = Convert.ToInt32(gvsalesdetails.Rows[i].Cells[4].Text);
                    tbl_product product = context.tbl_product.Where(w => w.product_id == productId).FirstOrDefault();

                    tbl_salereturndetails saleeReturnDetails = new tbl_salereturndetails();
                    saleeReturnDetails.product_id = productId;
                    saleeReturnDetails.batch_id = batchId;
                   // saleeReturnDetails.tax_id = product.tax_id;
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
        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>
        #region Events
        protected void btnSearch_Click(object sender, EventArgs e)
        {
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

            var ds = Common.FillDataSet(connectionstring, "SaleOrSaleReturnReport", sqlParams);

            if (ds.Tables["Table"] != null)
            {
                decimal givenAmnt = 0, totalDiscount = 0, subTotal = 0, grandTotal = 0, totalTax = 0;

                for (int i = 0; i < ds.Tables["Table"].Rows.Count; i++)
                {
                    if (ds.Tables["Table"].Rows[i]["Type"].ToString() == "Sale")
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

                //DataRow dr = ds.Tables["Table"].Select("Id=" + saleId + "").FirstOrDefault();

                lblGivenAmnt.Text = givenAmnt.ToString();
                //lblBalanceAmnt.Text = dr["BalanceAmnt"].ToString();

                //assign it to the the current return screen as well as the original purchase field
                lblGivenAmnt.Text = givenAmnt.ToString();
                lblTotalAmnt.Text = subTotal.ToString();
                lblTotalTax.Text = totalTax.ToString();
                lblTotalDiscount.Text = totalDiscount.ToString();
                lblOriginalGrndTotal.Text = grandTotal.ToString();
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
                //var productDetails = context.sp_GetSaleDetailsById(saleId).ToList();
                //if (productDetails != null)
                //{
                //    var oneproductDetail = productDetails.Where(w => w.product_id == productId);
                //    if (!Convert.ToBoolean(ValidateQuantity(enteredQuantity, productId, saleId)[0]))
                //    {
                //        decimal subTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(oneproductDetail.FirstOrDefault().sale_rate);
                //        decimal a = subTotal / 100;
                //        decimal discount_percent = (Convert.ToDecimal(oneproductDetail.FirstOrDefault().dicount_amt) * 100) / Convert.ToDecimal(oneproductDetail.FirstOrDefault().amount);
                //        decimal discountamt = a * Convert.ToDecimal(discount_percent.ToString("0.##"));
                //        decimal tax_amount = a * Convert.ToDecimal(oneproductDetail.FirstOrDefault().tax_percentage);

                //        clr();
                //        calculation(subTotal, tax_amount, discountamt);                        
                //        txtPaidAmt.Enabled = true;

                //        DataTable tbl = (DataTable)ViewState["Details"];

                //        tbl.Rows.Add(oneproductDetail.FirstOrDefault().saledetails_id, productId, oneproductDetail.FirstOrDefault().batch_id, oneproductDetail.FirstOrDefault().unit_id,
                //            oneproductDetail.FirstOrDefault().tax_id, subTotal, discountamt, tax_amount, oneproductDetail.FirstOrDefault().sale_rate, enteredQuantity,
                //            oneproductDetail.FirstOrDefault().product_name, oneproductDetail.FirstOrDefault().unit_name, oneproductDetail.FirstOrDefault().batch_name,
                //            oneproductDetail.FirstOrDefault().tax_percentage);
                //        ViewState["Details"] = tbl;
                //        this.BindGrid();
                //        ddlproduct.Items.FindByValue(productId.ToString()).Enabled = false;

                //    }                    
                //}
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

        //protected void ddlproduct_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        lblcheckDoubleError.Text = string.Empty;
        //        int c_id = Convert.ToInt32(Session["company_id"]);
        //        int p_id = Convert.ToInt32(ddlproduct.SelectedValue);
        //        int data = helper.GetStockQuantity(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(p_id));
        //        Session["quant"] = data;

        //        lblcheckDoubleError.ForeColor = System.Drawing.Color.Green;
        //        lblcheckDoubleError.Text = "Avialable Quantity In Stock " + data;
        //        UpdatePanel1.Update();
        //    }
        //    catch (Exception ex)
        //    {

        //        ErrorLog.saveerror(ex);
        //        //Do Logging
        //    }
        //}

        protected void gvsalesdetails_RowCommand(object sender, GridViewCommandEventArgs e)
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
            txtPaidAmt.Text = (Convert.ToDecimal(balanceAmnt) + paidAmnt).ToString();
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
                //decimal remainingBalance = Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text);

                //if (txtPaidAmt.Text == "0" || string.IsNullOrEmpty(txtPaidAmt.Text))
                //{
                //    txtBalanceAmt.Text = remainingBalance.ToString();
                //    return;
                //}

                //if(remainingBalance<0)
                //{
                //    txtBalanceAmt.Text = (remainingBalance + Convert.ToDecimal(txtPaidAmt.Text)).ToString();
                //}
                //else
                //{
                //    txtBalanceAmt.Text = (remainingBalance - Convert.ToDecimal(txtPaidAmt.Text)).ToString();
                //}
                decimal remainingBalance = Convert.ToDecimal(lblResultGrndTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text);

                //if (remainingBalance < 0)
                //{
                //    btnPayBack.Visible = true;
                //    txtBalanceAmt.Text = (remainingBalance + Convert.ToDecimal(txtPaidAmt.Text)).ToString();
                //}
                //else if (txtPaidAmt.Text == "0" || string.IsNullOrEmpty(txtPaidAmt.Text))
                //{
                //    btnPayBack.Visible = false;
                //    txtBalanceAmt.Text = remainingBalance.ToString();
                //    return;
                //}
                //else
                //{
                //    txtBalanceAmt.Text = (remainingBalance - Convert.ToDecimal(txtPaidAmt.Text)).ToString();
                //}

                decimal a = Convert.ToDecimal(lblGrandTotal.Text);
                decimal b = Convert.ToDecimal(txtPaidAmt.Text);
                if (txtPaidAmt.Text == "0" || string.IsNullOrEmpty(txtPaidAmt.Text))
                {
                    btnPayBack.Visible = false;
                    txtBalanceAmt.Text = remainingBalance.ToString();
                    return;
                }

                else if (remainingBalance < b)
                {
                    txtPaidAmt.Text = remainingBalance.ToString();
                    txtBalanceAmt.Text = "0";
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