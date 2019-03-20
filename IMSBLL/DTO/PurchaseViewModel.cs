using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.DTO
{
    public class PurchaseViewModel
    {
        public int purchase_id { get; set; }
        public Nullable<int> party_id { get; set; }
        public Nullable<int> financialyear_id { get; set; }
        public string po_no { get; set; }
        public Nullable<bool> status { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
        public Nullable<System.DateTime> Po_Date { get; set; }
        public Nullable<int> company_id { get; set; }
        public Nullable<int> branch_id { get; set; }
        public string InvoiceNumber { get; set; }
        public Nullable<int> PaymentMode_id { get; set; }
        public string Note { get; set; }
        public Nullable<decimal> other_expenses { get; set; }

        //Payment Detail Properties
        public Nullable<int> PurchaseId { get; set; }
        public Nullable<decimal> SubTotal { get; set; }
        public Nullable<decimal> TaxAmount { get; set; }
        public Nullable<decimal> DiscountAmount { get; set; }
        public Nullable<decimal> GrandTotal { get; set; }
        public Nullable<decimal> PaidAmnt { get; set; }
        public Nullable<decimal> GivenAmnt { get; set; }
        public Nullable<decimal> BalanceAmnt { get; set; }
        public string FromTable { get; set; }


        ///Purchase Details Properties
        //public int purchasedetails_id { get; set; }
        //public Nullable<int> product_id { get; set; }
        //public Nullable<int> batch_id { get; set; }
        //public Nullable<int> tax_id { get; set; }
        //public Nullable<int> unit_id { get; set; }
        //public Nullable<decimal> tax_amt { get; set; }
        //public Nullable<decimal> dicount_amt { get; set; }
        //public Nullable<decimal> quantity { get; set; }
        //public Nullable<decimal> amount { get; set; }

        //public virtual tbl_batch tbl_batch { get; set; }
        //public virtual tbl_product tbl_product { get; set; }
        //public virtual tbl_purchase tbl_purchase { get; set; }
        //public virtual tbl_tax tbl_tax { get; set; }
        //public virtual tbl_unit tbl_unit { get; set; }







        public virtual ICollection<tbl_ActualPurchaseTaxAndPrice> tbl_ActualPurchaseTaxAndPrice { get; set; }
        public virtual tbl_branch tbl_branch { get; set; }
        public virtual tbl_branch tbl_branch1 { get; set; }
        public virtual tbl_company tbl_company { get; set; }
        public virtual tbl_company tbl_company1 { get; set; }
        public virtual tbl_financialyear tbl_financialyear { get; set; }
        public virtual tbl_financialyear tbl_financialyear1 { get; set; }
        public virtual tbl_party tbl_party { get; set; }
        public virtual tbl_party tbl_party1 { get; set; }
        public virtual tbl_paymentmode tbl_paymentmode { get; set; }
        public virtual ICollection<tbl_purchasetaxgroup> tbl_purchasetaxgroup { get; set; }
        public virtual ICollection<tbl_purchasedetails> tbl_purchasedetails { get; set; }
        public virtual ICollection<tbl_purchasereturn> tbl_purchasereturn { get; set; }
    }
}
