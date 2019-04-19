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
    
    public partial class tbl_purchasereturn
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_purchasereturn()
        {
            this.tbl_PurchasePaymentDetials = new HashSet<tbl_PurchasePaymentDetials>();
            this.tbl_purchasereturndetails = new HashSet<tbl_purchasereturndetails>();
        }
    
        public int purchasereturn_id { get; set; }
        public Nullable<int> company_id { get; set; }
        public Nullable<int> branch_id { get; set; }
        public Nullable<int> purchase_id { get; set; }
        public Nullable<int> financialyear_id { get; set; }
        public Nullable<bool> status { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
        public Nullable<int> party_id { get; set; }
        public string InvoiceNumber { get; set; }
        public Nullable<int> paymentmode_id { get; set; }
        public string attachmentUrl { get; set; }
        public string Note { get; set; }
    
        public virtual tbl_branch tbl_branch { get; set; }
        public virtual tbl_company tbl_company { get; set; }
        public virtual tbl_financialyear tbl_financialyear { get; set; }
        public virtual tbl_party tbl_party { get; set; }
        public virtual tbl_paymentmode tbl_paymentmode { get; set; }
        public virtual tbl_purchase tbl_purchase { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_PurchasePaymentDetials> tbl_PurchasePaymentDetials { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_purchasereturndetails> tbl_purchasereturndetails { get; set; }
    }
}
