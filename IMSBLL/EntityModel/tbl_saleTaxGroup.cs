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
    
    public partial class tbl_saleTaxGroup
    {
        public tbl_saleTaxGroup()
        {
            this.tbl_saleTaxGroupDetailes = new HashSet<tbl_saleTaxGroupDetailes>();
        }
    
        public int SaleTaxGroupId { get; set; }
        public string group_name { get; set; }
        public Nullable<int> product_id { get; set; }
        public Nullable<int> group_id { get; set; }
        public Nullable<int> sale_id { get; set; }
        public Nullable<decimal> totalTaxPercentage { get; set; }
    
        public virtual tbl_product tbl_product { get; set; }
        public virtual tbl_sale tbl_sale { get; set; }
        public virtual tbl_taxgroup tbl_taxgroup { get; set; }
        public virtual ICollection<tbl_saleTaxGroupDetailes> tbl_saleTaxGroupDetailes { get; set; }
    }
}
