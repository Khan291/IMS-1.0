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
    
    public partial class tbl_monytransaction
    {
        public int monytransaction_id { get; set; }
        public Nullable<int> company_id { get; set; }
        public Nullable<int> branch_id { get; set; }
        public Nullable<int> transaction_typ_id { get; set; }
        public string transaction_typ { get; set; }
        public Nullable<int> paymentmode_id { get; set; }
        public Nullable<decimal> total_bil_amt { get; set; }
        public Nullable<decimal> given_amt { get; set; }
        public Nullable<decimal> balance_amt { get; set; }
        public string in_out { get; set; }
        public Nullable<bool> status { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
        public Nullable<int> party_id { get; set; }
        public Nullable<int> transactio_type_id { get; set; }
    
        public virtual tbl_branch tbl_branch { get; set; }
        public virtual tbl_company tbl_company { get; set; }
        public virtual tbl_party tbl_party { get; set; }
        public virtual tbl_paymentmode tbl_paymentmode { get; set; }
    }
}
