using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public  class tbl_financialyear1
    {
        SqlHelper helper = new SqlHelper();

        public DataTable Insert(tbl_financialyear r)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", r.company_id);
            parameters.Add("@branch_id", r.branch_id);
            parameters.Add("@start_date", r.start_date);
            parameters.Add("@end_date", r.end_date);
            parameters.Add("@created_by", r.created_by);
            parameters.Add("@created_date", r.created_date);

            try
            {
                result = helper.GetDataTablebyProc(SP.FyInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }
    }
}
