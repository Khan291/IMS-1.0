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
    
    public partial class tbl_purchasereturndetails
    {
        public int purchasereturndetails_id { get; set; }
        public Nullable<int> batch_id { get; set; }
        public Nullable<int> product_id { get; set; }
        public Nullable<int> unit_id { get; set; }
        public string tax_amt { get; set; }
        public Nullable<decimal> quantity { get; set; }
        public Nullable<decimal> amount { get; set; }
        public Nullable<bool> status { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
        public Nullable<int> purchasereturn_id { get; set; }
        public Nullable<decimal> discount_amnt { get; set; }
        public Nullable<int> Purchase_taxGroupId { get; set; }
    
        public virtual tbl_batch tbl_batch { get; set; }
        public virtual tbl_product tbl_product { get; set; }
        public virtual tbl_purchasereturn tbl_purchasereturn { get; set; }
        public virtual tbl_unit tbl_unit { get; set; }
    }
}
