using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
     public class tbl_company1
    {
        SqlHelper helper = new SqlHelper();

        public DataTable Insert(tbl_company r)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_name", r.company_name);
            parameters.Add("@first_name", r.first_name);
            parameters.Add("@last_name", r.last_name);
            parameters.Add("@owner_emailid", r.owner_emailid);
            parameters.Add("@owner_mobileno", r.owner_mobileno);
            parameters.Add("@country_id", r.country_id);
            parameters.Add("@company_zip", r.pincode);
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
        public DataTable All12(tbl_company p)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id", p.company_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.selectcompanylogo, parameters);
                foreach (DataRow dr in dt.Rows)
                {
                    string logoimg = (dr["logo"].ToString());                  

                    p.logo = (logoimg).ToString();

                }
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }
        
    }
}
