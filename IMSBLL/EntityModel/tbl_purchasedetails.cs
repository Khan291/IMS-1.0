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
    
    public partial class tbl_purchasedetails
    {
        public int purchasedetails_id { get; set; }
        public Nullable<int> purchase_id { get; set; }
        public Nullable<int> product_id { get; set; }
        public Nullable<int> batch_id { get; set; }
        public Nullable<int> tax_id { get; set; }
        public Nullable<int> unit_id { get; set; }
        public Nullable<decimal> tax_amt { get; set; }
        public Nullable<decimal> dicount_amt { get; set; }
        public Nullable<decimal> quantity { get; set; }
        public Nullable<decimal> amount { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public Nullable<bool> status { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
    
        public virtual tbl_batch tbl_batch { get; set; }
        public virtual tbl_product tbl_product { get; set; }
        public virtual tbl_purchase tbl_purchase { get; set; }
        public virtual tbl_tax tbl_tax { get; set; }
        public virtual tbl_unit tbl_unit { get; set; }
    }
}
