using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IMSBLL.DAL;
using System.Data;

namespace IMSBLL.EntityModel
{
    public class tbl_godown1
    {

        SqlHelper helper = new SqlHelper();
        public DataTable AddGodown(tbl_godown g)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", g.company_id);
            parameters.Add("@branch_id", g.branch_id);
            parameters.Add("@godown_name", g.godown_name);
            parameters.Add("@godown_address", g.godown_address);
            parameters.Add("@contact_no", g.contact_no);
            parameters.Add("@contact_person", g.contact_person);
            parameters.Add("@status", g.status);
            parameters.Add("@created_by", g.created_by);
            parameters.Add("@created_date", g.created_date);
            parameters.Add("@modified_by", g.modified_by);
            parameters.Add("@modified_date", g.modified_date);

            try
            {
                result = helper.GetDataTablebyProc(SP.GodownInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }
    }
}
