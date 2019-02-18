using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public  class tbl_expense1
    {

        SqlHelper helper = new SqlHelper();

        public DataTable Insert(tbl_expense e)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", e.company_id);
            parameters.Add("@branch_id", e.branch_id);
            parameters.Add("@expense_name", e.expense_name);
            parameters.Add("@status", e.status);
            parameters.Add("@created_by", e.created_by);
            parameters.Add("@created_date", e.created_date);
            parameters.Add("@modified_by", e.modified_by);
            parameters.Add("@modified_date", e.modified_by);

            try
            {
                result = helper.GetDataTablebyProc(SP.ExpenseInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }
    }
}
