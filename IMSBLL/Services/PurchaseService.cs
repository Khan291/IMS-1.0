using IMSBLL.DAL;
using IMSBLL.DTO;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.Services
{
    public class PurchaseService
    {
        IMS_TESTEntities context = new IMS_TESTEntities();

        public  void SavePurchase(PurchaseViewModel purchaseViewModel)
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
    }
}
