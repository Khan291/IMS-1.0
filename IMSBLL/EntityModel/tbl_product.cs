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
    
    public partial class tbl_product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_product()
        {
            this.tbl_ActualPurchaseTaxAndPrice = new HashSet<tbl_ActualPurchaseTaxAndPrice>();
            this.tbl_ActualSalesTaxAndPrice = new HashSet<tbl_ActualSalesTaxAndPrice>();
            this.tbl_productTaxGroup = new HashSet<tbl_productTaxGroup>();
            this.tbl_purchasedetails = new HashSet<tbl_purchasedetails>();
            this.tbl_purchasetaxgroup = new HashSet<tbl_purchasetaxgroup>();
            this.tbl_stock = new HashSet<tbl_stock>();
            this.tbl_stocktransaction = new HashSet<tbl_stocktransaction>();
            this.tbl_stock1 = new HashSet<tbl_stock>();
            this.tbl_purchasereturndetails = new HashSet<tbl_purchasereturndetails>();
            this.tbl_saledetails = new HashSet<tbl_saledetails>();
            this.tbl_salereturndetails = new HashSet<tbl_salereturndetails>();
            this.tbl_saleTaxGroup = new HashSet<tbl_saleTaxGroup>();
        }
    
        public int product_id { get; set; }
        public Nullable<int> company_id { get; set; }
        public Nullable<int> branch_id { get; set; }
        public Nullable<int> category_id { get; set; }
        public Nullable<int> unit_id { get; set; }
        public Nullable<int> godown_id { get; set; }
        public Nullable<int> rack_id { get; set; }
        public Nullable<decimal> purchas_price { get; set; }
        public Nullable<decimal> sales_price { get; set; }
        public Nullable<int> reorder_level { get; set; }
        public string product_name { get; set; }
        public string product_code { get; set; }
        public string hsn_code { get; set; }
        public Nullable<bool> status { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_ActualPurchaseTaxAndPrice> tbl_ActualPurchaseTaxAndPrice { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_ActualSalesTaxAndPrice> tbl_ActualSalesTaxAndPrice { get; set; }
        public virtual tbl_branch tbl_branch { get; set; }
        public virtual tbl_category tbl_category { get; set; }
        public virtual tbl_company tbl_company { get; set; }
        public virtual tbl_godown tbl_godown { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_productTaxGroup> tbl_productTaxGroup { get; set; }
        public virtual tbl_unit tbl_unit { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_purchasedetails> tbl_purchasedetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_purchasetaxgroup> tbl_purchasetaxgroup { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_stock> tbl_stock { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_stocktransaction> tbl_stocktransaction { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_stock> tbl_stock1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_purchasereturndetails> tbl_purchasereturndetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_saledetails> tbl_saledetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_salereturndetails> tbl_salereturndetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_saleTaxGroup> tbl_saleTaxGroup { get; set; }
    }
}
