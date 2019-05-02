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
    
    public partial class sp_purchaseTransationHistory_Result
    {
        public Nullable<int> Id { get; set; }
        public string Batch { get; set; }
        public string Company { get; set; }
        public string CompanyAddress { get; set; }
        public string Party { get; set; }
        public string PartyAddress { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string InvoiceNumber { get; set; }
        public string PoNo { get; set; }
        public string Product { get; set; }
        public Nullable<decimal> PurchaseRate { get; set; }
        public Nullable<decimal> SaleRate { get; set; }
        public Nullable<decimal> Quantity { get; set; }
        public Nullable<decimal> TaxAmnt { get; set; }
        public decimal DiscountAmnt { get; set; }
        public Nullable<decimal> ProductAmount { get; set; }
        public Nullable<decimal> TotalTax { get; set; }
        public Nullable<decimal> TotalDiscount { get; set; }
        public Nullable<decimal> TotalAmount { get; set; }
        public Nullable<decimal> GrandTotal { get; set; }
        public Nullable<decimal> GivenAmnt { get; set; }
        public Nullable<decimal> BalanceAmnt { get; set; }
        public Nullable<System.DateTime> Date { get; set; }
        public string Type { get; set; }
    }
}
