using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.EntityModel
{
    public partial class UserRol
    {
        public int userbranch_id { get; set; }
        
        public int user_id { get; set; }
        public int company_id { get; set; }
        public int branch_id { get; set; }
        public int role_id { get; set; }

        public string first_name { get; set; }
        public string last_name { get; set; }
        public string user_name { get; set; }
        public string role_name { get; set; }
        public string branch_name { get; set; }
        public string user_Emai { get; set; }
        public string user_mobieno { get; set; }
        public string password { get; set; }
        public bool status { get; set; }
        public string created_by { get; set; }
        public DateTime created_date { get; set; }
        public string modified_by { get; set; }
        public DateTime modified_date { get; set; }

        public string loginUsername { get; set; }

        public string company_name { get; set; }
        

    }
}
