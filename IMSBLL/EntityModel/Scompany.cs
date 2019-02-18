using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public class Scompany
    {
        public int company_id { get; set; }

        public string state_name { get; set; }
        public string country_name { get; set; }

        public string company_name { get; set; }
        public string company_address { get; set; }
        public int country_id { get; set; }
        public int state_id { get; set; }
        public string city { get; set; }
        public string pincode { get; set; }
        public string GSTIN { get; set; }
        public string telephone_no { get; set; }
        public string fax_no { get; set; }
        public string website { get; set; }
        public string first_name { get; set; }
        public string owner_emailid { get; set; }
        public string owner_mobileno { get; set; }






        SqlHelper helper = new SqlHelper();
        public DataTable All(Scompany p)
        {
            DataTable programs = new DataTable();
            try
            {
                UserRol s = new UserRol();
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id", p.company_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.SelectCompany, parameters);
                foreach (DataRow dr in dt.Rows)
                {
                    company_name = dr["company_name"].ToString();
                    company_address = dr["company_address"].ToString();
                    country_id = int.Parse(dr["country_id"].ToString());
                    //state_id = int.Parse(dr["state_id"].ToString());
                    city = dr["city"].ToString();
                    pincode = dr["pincode"].ToString();
                    GSTIN = dr["GSTIN"].ToString();
                    telephone_no = dr["telephone_no"].ToString();
                    fax_no = dr["fax_no"].ToString();
                    website = dr["website"].ToString();
                    first_name = dr["first_name"].ToString();
                    owner_emailid = dr["owner_emailid"].ToString();
                    owner_mobileno = dr["owner_mobileno"].ToString();
                    country_name = dr["country_name"].ToString();
                    state_name = dr["state_name"].ToString();


                }
                programs = dt;
            }
            catch (Exception ex)
            {

            }
            return programs;
        }
    }
}
