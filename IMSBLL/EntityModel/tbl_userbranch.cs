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
    
    public partial class tbl_userbranch
    {
        public int userbranch_id { get; set; }
        public Nullable<int> role_id { get; set; }
        public Nullable<int> user_id { get; set; }
        public Nullable<int> branch_id { get; set; }
        public Nullable<bool> status { get; set; }
        public string created_by { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
        public string modified_by { get; set; }
        public Nullable<System.DateTime> modified_date { get; set; }
        public Nullable<int> company_id { get; set; }
    
        public virtual tbl_branch tbl_branch { get; set; }
        public virtual tbl_company tbl_company { get; set; }
        public virtual tbl_role tbl_role { get; set; }
        public virtual tbl_User tbl_User { get; set; }
    }
}