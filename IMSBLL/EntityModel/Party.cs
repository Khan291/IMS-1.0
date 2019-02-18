using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public  class tbl_party1
    {
        SqlHelper helper = new SqlHelper();
        public DataTable All3(tbl_party p)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id ", p.company_id);
                parameters.Add("@branch_id", p.branch_id);
                parameters.Add("@party_id", p.party_id);
                parameters.Add("@party_type", p.party_type);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.partyprint, parameters);
                foreach (DataRow dr in dt.Rows)
                {

                    p.party_name = (dr["party_name"].ToString());
                    p.party_address = (dr["party_address"].ToString());
                    p.contact_no = (dr["contact_no"].ToString());


                }
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }
        public DataTable Insert(tbl_party r)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", r.company_id);
            parameters.Add("@branch_id", r.branch_id);
            parameters.Add("@party_name", r.party_name);
            parameters.Add("@party_address", r.party_address);
            parameters.Add("@contact_no", r.contact_no);
            parameters.Add("@gstin_no", r.gstin_no);
            parameters.Add("@party_type", r.party_type);
            parameters.Add("@status", r.status);
            parameters.Add("@created_by", r.created_by);
            parameters.Add("@created_date", r.created_date);
            parameters.Add("@state_id", r.state_id);

            try
            {
                result = helper.GetDataTablebyProc(SP.PartyInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }

    }
}
