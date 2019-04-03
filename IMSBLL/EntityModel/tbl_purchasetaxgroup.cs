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
    
    public partial class tbl_purchasetaxgroup
    {
        public tbl_purchasetaxgroup()
        {
            this.tbl_purchasetaxgroupdetails = new HashSet<tbl_purchasetaxgroupdetails>();
        }
    
        public int purchasetaxgroup_id { get; set; }
        public string group_name { get; set; }
        public Nullable<int> product_id { get; set; }
        public Nullable<int> group_id { get; set; }
        public Nullable<int> purchaseId { get; set; }
        public Nullable<decimal> totalTaxPercentage { get; set; }
        public Nullable<int> batchId { get; set; }
    
        public virtual tbl_batch tbl_batch { get; set; }
        public virtual tbl_product tbl_product { get; set; }
        public virtual tbl_purchase tbl_purchase { get; set; }
        public virtual tbl_taxgroup tbl_taxgroup { get; set; }
        public virtual ICollection<tbl_purchasetaxgroupdetails> tbl_purchasetaxgroupdetails { get; set; }
    }
}
