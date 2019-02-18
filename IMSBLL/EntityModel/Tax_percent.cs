using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;


namespace IMSBLL.EntityModel
{
    public class Tax_percent
    {
        public int company_id { get; set; }
        public int product_id { get; set; }

        public int tax_id { get; set; }
        public int unit_id { get; set; }

        public int batch_id { get; set; }
        public string batch_name { get; set; }
        public string unit_name { get; set; }
        public string tax_percentage { get; set; }

        SqlHelper helper = new SqlHelper();
        public DataTable All(Tax_percent p)
        {
            DataTable programs = new DataTable();
            try
            {

                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id", p.company_id);
                parameters.Add("@product_id", p.product_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.SelectTaxpercent, parameters);
                foreach (DataRow dr in dt.Rows)
                {
                    
                    tax_percentage = dr["tax_percentage"].ToString();
                    tax_id = Convert.ToInt32(dr["tax_id"].ToString());
                    unit_id = Convert.ToInt32(dr["unit_id"].ToString());
                    unit_name = dr["unit_name"].ToString();
                    batch_name = dr["batch_name"].ToString();
                    batch_id = Convert.ToInt32(dr["batch_id"].ToString());

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
