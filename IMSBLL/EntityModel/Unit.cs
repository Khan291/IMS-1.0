using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IMSBLL.DAL;
using System.Data;
using System.ComponentModel.DataAnnotations;

namespace IMSBLL.EntityModel
{
    public  class tbl_unit1
    {
        SqlHelper helper = new SqlHelper();

        public DataTable AddUnit(tbl_unit u)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", u.company_id);
            parameters.Add("@branch_id", u.branch_id);
            parameters.Add("@unit_name", u.unit_name);
            parameters.Add("@status", u.status);
            parameters.Add("@created_by", u.created_by);
            parameters.Add("@created_date", u.created_date);
            parameters.Add("@modified_by", u.modified_by);
            parameters.Add("@modified_date", u.modified_date);

            try
            {
                result = helper.GetDataTablebyProc(SP.UnitInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;

        }

    }
}
