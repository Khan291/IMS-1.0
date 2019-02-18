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
    public  class tbl_category1
    {
        SqlHelper helper = new SqlHelper();
                
        public DataTable AddCat(tbl_category c)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", c.company_id);
            parameters.Add("@branch_id", c.branch_id);
            parameters.Add("@category_name", c.category_name);
            parameters.Add("@status", c.status);
            parameters.Add("@created_by", c.created_by);
            parameters.Add("@created_date", c.created_date);
            parameters.Add("@modified_by", c.modified_by);
            parameters.Add("@modified_date", c.modified_date);

            try
            {
                result = helper.GetDataTablebyProc(SP.CategoryInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;

        }
    }
}
