using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public  class tbl_rack1
    {
        SqlHelper helper = new SqlHelper();

        public DataTable Insert(tbl_rack r)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", r.company_id);
            parameters.Add("@branch_id", r.branch_id);
            parameters.Add("@godown_id", r.godown_id);
            parameters.Add("@rack_name", r.rack_name);
            parameters.Add("@status", r.status);
            parameters.Add("@created_by", r.created_by);
            parameters.Add("@created_date", r.created_date);
            parameters.Add("@modified_by", r.modified_by);
            parameters.Add("@modified_date", r.modified_by);

            try
            {
                result = helper.GetDataTablebyProc(SP.RackInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }
    }
}
