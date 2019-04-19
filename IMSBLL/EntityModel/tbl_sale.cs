//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace IMSBLL.EntityModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbl_sale
    {
        public tbl_sale()
        {
            this.tbl_ActualSalesTaxAndPrice = new HashSet<tbl_ActualSalesTaxAndPrice>();
            this.tbl_saledetails = new HashSet<tbl_saledetails>();
            this.tbl_SalePaymentDetails = new HashSet<tbl_SalePaymentDetails>();
            this.tbl_salereturn = new HashSet<tbl_salereturn>();
            this.tbl_saleTaxGroup = new HashSet<tbl_saleTaxGroup>();
        }
    
        public int sale_id { get; set; }
        public Nullable<int> party_id { get; set; }
        public Nullable<int> financialyear_id { get; set; }
        public Nullable<bool> status { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
        public Nullable<int> company_id { get; set; }
        public Nullable<int> branch_id { get; set; }
        public string InvoiceNumber { get; set; }
        public Nullable<int> paymentmode_id { get; set; }
        public Nullable<System.DateTime> sale_date { get; set; }
        public string Note { get; set; }
        public string OtherExpLabel { get; set; }
        public Nullable<decimal> other_expenses { get; set; }
        public string attachmentUrl { get; set; }
    
        public virtual ICollection<tbl_ActualSalesTaxAndPrice> tbl_ActualSalesTaxAndPrice { get; set; }
        public virtual tbl_branch tbl_branch { get; set; }
        public virtual tbl_company tbl_company { get; set; }
        public virtual tbl_financialyear tbl_financialyear { get; set; }
        public virtual tbl_party tbl_party { get; set; }
        public virtual tbl_paymentmode tbl_paymentmode { get; set; }
        public virtual ICollection<tbl_saledetails> tbl_saledetails { get; set; }
        public virtual ICollection<tbl_SalePaymentDetails> tbl_SalePaymentDetails { get; set; }
        public virtual ICollection<tbl_salereturn> tbl_salereturn { get; set; }
        public virtual ICollection<tbl_saleTaxGroup> tbl_saleTaxGroup { get; set; }
    }
}
