using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public  class tbl_batch1
    {
        SqlHelper helper = new SqlHelper();

        public DataTable Insert(tbl_batch b)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", b.company_id);
            parameters.Add("@branch_id", b.branch_id);
            parameters.Add("@batch_name", b.batch_name);
            parameters.Add("@status", b.status);
            parameters.Add("@created_by", b.created_by);
            parameters.Add("@created_date", b.created_date);
            parameters.Add("@modified_by", b.modified_by);
            parameters.Add("@modified_date", b.modified_by);

            try
            {
                result = helper.GetDataTablebyProc(SP.BatchInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }
    }
}
