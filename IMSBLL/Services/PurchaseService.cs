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

                //Purchase purchase = new Purchase();
                //int CompanyId = Convert.ToInt32(purchaseViewModel.CompanyId);
                //int BranchId = Convert.ToInt32(purchaseViewModel.BranchId);


                //purchase.CompanyId = CompanyId;
                //purchase.BranchId = BranchId;
                //purchase.FinancialyearId = purchaseViewModel.FinancialYearId;
                //purchase.InvoiceNumber = purchaseViewModel.InvoiceNumber;

                //purchase.PaymentModeId = purchaseViewModel.PaymentModeId;
                //purchase.PartyId = purchaseViewModel.PartyId;
                //purchase.PoDate = purchaseViewModel.PODate;
                //purchase.PoNo = purchaseViewModel.PONo;
                //purchase.Note = purchaseViewModel.Note;
                //purchase.OtherExpenses = purchaseViewModel.OtherExpenses;

                //purchase.CreatedBy = purchaseViewModel.CreatedBy;
                //purchase.CreatedOn = purchaseViewModel.CreatedDate;

                ////insert into Purchase Payment Details 
                //PurchasePaymentDetial purchasePaymentDetail = new PurchasePaymentDetial();
                //purchasePaymentDetail.TaxAmount = purchaseViewModel.TaxAmount;
                //purchasePaymentDetail.DiscountAmount = purchaseViewModel.DiscountAmount;
                //purchasePaymentDetail.SubTotal = purchaseViewModel.SubTotal;
                //purchasePaymentDetail.GrandTotal = purchaseViewModel.GrandTotal;
                //purchasePaymentDetail.PaidAmnt = purchaseViewModel.PaidAmnt;
                //purchasePaymentDetail.GivenAmnt = purchaseViewModel.GivenAmnt;
                //purchasePaymentDetail.BalanceAmnt = purchaseViewModel.BalanceAmnt;
                //purchasePaymentDetail.FromTable = purchaseViewModel.FromTable;
                //purchase.PurchasePaymentDetials.Add(purchasePaymentDetail);

                //foreach (var purchaseDetail in purchaseViewModel.tbl_purchasedetails)
                //{
                //    int productId = Convert.ToInt32(purchaseDetail.ProductId);
                //    int batchId = Convert.ToInt32(purchaseDetail.BatchId);

                //    var qty = purchaseDetail.quantity;
                //    //Add into Purchase Details table for each product
                //    tbl_purchasedetails purchaseDetails = new tbl_purchasedetails();
                //    purchaseDetails.ProductId = productId;
                //    purchaseDetails.BatchId = batchId;
                //    purchaseDetails.UnitId = purchaseDetail.UnitId;
                //    purchaseDetails.TaxAmnt = purchaseDetail.TaxAmnt;
                //    purchaseDetails.DicountAmnt = purchaseDetail.DiscountAmnt;
                //    purchaseDetails.Quantity = qty;
                //    purchaseDetails.Amount = purchaseDetail.Amount;
                //    purchaseDetails.PurchaseRate = purchaseDetail.PurchaseRate;
                //    purchaseDetails.SaleRate = purchaseDetail.SaleRate;
                //    purchaseDetails.Amount = purchaseDetail.Amount;
                //    purchaseDetails.DiscountPercent = purchaseDetail.DiscountPercentage;
                //    purchaseDetails.TaxPercent = purchaseDetail.TotalTaxPercentage;

                //    var groupId = purchaseDetail.GroupId;
                //    //insert into tax group purchase
                //    PurchaseTaxGroup purchaseTaxGroup = new PurchaseTaxGroup();
                //    purchaseTaxGroup.TaxGroupId = groupId;
                //    purchaseTaxGroup.ProductId = productId;

                //    foreach (var taxType in purchaseDetail.TaxGroupDetailsViewModel)
                //    {
                //        PurchaseTaxgroupDetail purchaseTaxDetails = new PurchaseTaxgroupDetail();
                //        purchaseTaxDetails.TypeId = taxType.TypeId;
                //        purchaseTaxDetails.TaxPercentage = taxType.TaxPercentage;
                //        purchaseTaxGroup.PurchaseTaxgroupDetails.Add(purchaseTaxDetails);
                //    }
                //    purchase.PurchaseTaxGroups.Add(purchaseTaxGroup);
                //    purchase.PurchaseDetails.Add(purchaseDetails);
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
