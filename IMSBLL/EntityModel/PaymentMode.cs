using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public class tbl_paymentmode1
    {
        SqlHelper helper = new SqlHelper();

        public DataTable Insert(tbl_paymentmode py)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", py.company_id);
            parameters.Add("@branch_id", py.branch_id);
            parameters.Add("@paymentmode_name", py.paymentmode_name);
            parameters.Add("@status", py.status);
            parameters.Add("@created_by", py.created_by);
            parameters.Add("@created_date", py.created_date);
            parameters.Add("@modified_by", py.modified_by);
            parameters.Add("@modified_date", py.modified_by);

            try
            {
                result = helper.GetDataTablebyProc(SP.PaymentModeInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }
    }
}
