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
using IMS.Reports;

namespace IMS
{
    public partial class ViewORPayBalancePurchase : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        static int companyId = 0, branchId = 0, financialYearId = 0;
        string user_id = string.Empty;
        bool viewOrPayBalance = false;
        int purchase_Id = 0;
        string connectionstring = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["ViewOrPayBalance"] != null && Request.QueryString["Id"] != null)
                {
                    viewOrPayBalance = Convert.ToBoolean(Request.QueryString["ViewOrPayBalance"]);
                    purchase_Id = Convert.ToInt32(Request.QueryString["Id"]);

                    if (viewOrPayBalance)
                    {
                        btnSave.Enabled = true;
                        txtPaidAmnt.Enabled = true;
                    }
                }

                SessionValue();
                if (!IsPostBack)
                {
                    if (purchase_Id != 0)
                    {
                        this.FetchData(purchase_Id);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        //Methods------------------

        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> GetPoNumbers(string prefixText, int count)
        {
            IMS_TESTEntities context = new IMS_TESTEntities();

              
                    int year = DateTime.Now.Year;
                    prefixText = year.ToString() + "P" + prefixText;
                    var result = context.tbl_purchase.Where(p => p.InvoiceNumber.Contains(prefixText) && p.company_id == companyId);
                    List<string> customers = new List<string>();
                    customers = result.Select(p => p.InvoiceNumber).ToList<string>();
                    return customers;
             
        }
        public void GetpurchaseDetails()
        {
            try
            {
                var purchase = context.tbl_purchase.Where(w => w.InvoiceNumber == txtSearchBox.Text && w.company_id == companyId && w.branch_id == branchId).FirstOrDefault();
                if (purchase == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Invoice does not exist, Please enter valid Invoice Number.','True');", true);
                    return;
                }
                hdnPurchaseId.Value = purchase.purchase_id.ToString();
                purchase_Id = purchase.purchase_id;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        private void FetchData(int purchaseId)
        {
           
                SqlParameter[] sqlParams = new SqlParameter[] {
                         new SqlParameter("@Id", purchaseId),
                         new SqlParameter("@FromTable","COMBINEPURCHASEANDRETURN")
                    };

                var ds = Common.FillDataSet(connectionstring, "PurchaseOrPurchaseReturnReport", sqlParams);

                if (ds.Tables["Table"] != null)
                {
                    decimal givenAmnt = 0, totalDiscount = 0, subTotal = 0, grandTotal = 0, totalTax = 0, balanceAmnt = 0;

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
                        balanceAmnt = Convert.ToDecimal(ds.Tables["Table"].Rows[i]["BalanceAmnt"]);
                    }
                    grandTotal = subTotal + totalTax - totalDiscount;


                    DataView dv = ds.Tables["Table"].DefaultView;
                    dv.Sort = "Date desc";
                    DataTable sortedDT = dv.ToTable();
                    DataRow dr = sortedDT.Select("Id=" + purchaseId + "").FirstOrDefault();
                    txtPaymentMode.Text = dr["PaymentMode"].ToString();
                    lblInvoice.Text = dr["InvoiceNumber"].ToString();
                    txtVendor.Text = dr["Party"].ToString();
                    txtPONo.Text = dr["PoNo"].ToString();
                    txtdate.Text = dr["Date"].ToString();

                    ////Get only Given and Balance Amnt and Calcualte Remainig as per Transaction
                    //DataRow drpurchase = ds.Tables["Table"].Select("Type='Purchase'").FirstOrDefault();
                    //DataRow drreturn = ds.Tables["Table"].Select("Type='Return'").FirstOrDefault();
                    var v = context.tbl_PurchasePaymentDetials.Where(s => s.PurchaseId == purchaseId).FirstOrDefault();
                    lblsubtotal.Text = v.SubTotal.ToString();
                    lblTaxAmount.Text = v.TaxAmount.ToString();
                    lblDiscountAmt.Text = v.DiscountAmount.ToString();
                    lblGrandTotal.Text = v.GrandTotal.ToString();
                    lblGivenAmnt.Text = v.GivenAmnt.ToString();

                    balanceAmnt = Convert.ToDecimal(v.BalanceAmnt);

                    if (balanceAmnt < 0)
                        btnGetRefund.Visible = true;

                    txtBalanceAmnt.Text = balanceAmnt.ToString();
                    lblBalanceAmnt.Text = balanceAmnt.ToString();


                    gvpurchasedetails.DataSource = ds.Tables["Table"];
                    gvpurchasedetails.DataBind();

                    if (balanceAmnt > 0)
                    {
                        btnSave.Enabled = true;
                        txtPaidAmnt.Enabled = true;
                    }

                }
            
        }

        protected void Update()
        {
            try
            {
                string userName = Session["username"].ToString();
                lblError.Text = string.Empty;
                if (ValidCalculation())
                {
                    purchase_Id = Convert.ToInt32(hdnPurchaseId.Value);
                    var purchasePaymentDetails = context.tbl_PurchasePaymentDetials.FirstOrDefault(w => w.PurchaseId == purchase_Id);

                    if (purchasePaymentDetails != null)
                    {
                        purchasePaymentDetails.PaidAmnt = Convert.ToDecimal(txtPaidAmnt.Text);
                        purchasePaymentDetails.GivenAmnt = Convert.ToDecimal(txtPaidAmnt.Text) + purchasePaymentDetails.GivenAmnt;
                        purchasePaymentDetails.BalanceAmnt = Convert.ToDecimal(txtBalanceAmnt.Text);
                        purchasePaymentDetails.FromTable = "Purchase Pay Balance";
                        purchasePaymentDetails.ModifiedDate = DateTime.Now;
                        purchasePaymentDetails.ModifiedBy = userName;
                    }

                
                    context.SaveChanges();
                    int? order = purchasePaymentDetails.PurchaseId;
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Saved successfully, Your order number is " + order + "');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Calculation doesn't match, please check calculation.');", true);
                    
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        private bool ValidCalculation()
        {
            bool valid = false;
            if (Convert.ToInt32(txtBalanceAmnt.Text) >= 0)
            {
                if (Convert.ToDecimal(lblGrandTotal.Text) >= (Convert.ToDecimal(lblGivenAmnt.Text) + Convert.ToDecimal(txtPaidAmnt.Text)))
                {
                    valid = true;
                }
                else
                {
                    valid = false;
                }
            }
            else
            {
                valid = true;
            }

            return valid;
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

        protected void gvpurchasedetails_RowDataBound(object sender, GridViewRowEventArgs e)
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

        protected void gvpurchasedetails_DataBound(object sender, EventArgs e)
        {
            int firstRowSpan = 2;
            int secondRowSpan = 2;
            for (int i = gvpurchasedetails.Rows.Count - 2; i >= 0; i--)
            {
                GridViewRow currRow = gvpurchasedetails.Rows[i];
                GridViewRow prevRow = gvpurchasedetails.Rows[i + 1];
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

        protected void btnGetRefund_Click(object sender, EventArgs e)
        {           
            string balanceAmnt = txtBalanceAmnt.Text.Replace('-', ' ');
            decimal paidAmnt = txtPaidAmnt.Text == "" ? 0 : Convert.ToDecimal(txtPaidAmnt.Text);
            txtPaidAmnt.Text = (Convert.ToDecimal(balanceAmnt) + paidAmnt).ToString();
            txtBalanceAmnt.Text = "0";
            btnGetRefund.Visible = false;
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            Update();
        }

        protected void txtGivenAmt_TextChanged(object sender, System.EventArgs e)
        {
            try
            {
               
                decimal remainingBalance = Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(lblGivenAmnt.Text);
                
                //if (remainingBalance < 0)
                //{
                //    btnGetRefund.Visible = true;
                //    txtBalanceAmnt.Text = (remainingBalance + Convert.ToDecimal(txtPaidAmnt.Text)).ToString();
                //}
                //else if (txtPaidAmnt.Text == "0" || string.IsNullOrEmpty(txtPaidAmnt.Text))
                //{
                //    btnGetRefund.Visible = false;
                //    txtBalanceAmnt.Text = remainingBalance.ToString();
                //    return;
                //}
                //else
                //{
                //    txtBalanceAmnt.Text = (remainingBalance - Convert.ToDecimal(txtPaidAmnt.Text)).ToString();
                //}
                decimal paidAmnt = Convert.ToDecimal(txtPaidAmnt.Text);
                if (remainingBalance < paidAmnt)
                {
                    txtPaidAmnt.Text = remainingBalance.ToString();
                    txtBalanceAmnt.Text = "0";
                }

                else if(paidAmnt!=0)
                {
                    txtBalanceAmnt.Text = (remainingBalance - paidAmnt).ToString();
                    //decimal c = Convert.ToDecimal(lblGrandTotal.Text)-(remainingBalance + Convert.ToDecimal(txtPaidAmnt.Text));
                    //txtBalanceAmnt.Text = c.ToString();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Paid amount should be greator then zero');", true);
                }
                UpdatePanel2.Update();
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            
            GetpurchaseDetails();
            //BindOrigianlPurchaseGrid();
            if (!string.IsNullOrEmpty(hdnPurchaseId.Value))
            {
                 purchase_Id = Convert.ToInt32(hdnPurchaseId.Value);
                FetchData(purchase_Id);
            }
        }
    }
}