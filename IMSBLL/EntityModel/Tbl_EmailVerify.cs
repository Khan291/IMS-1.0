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
    
    public partial class Tbl_EmailVerify
    {
        public int emailverify_ID { get; set; }
        public string user_id { get; set; }
        public string uniqueidentifier { get; set; }
        public Nullable<bool> status { get; set; }
        public Nullable<System.DateTime> created_date { get; set; }
    }
}
