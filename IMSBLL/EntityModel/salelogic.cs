using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public class tbl_sale1
    {
        SqlHelper helper = new SqlHelper();

        public string quantity { get; set; }
    
        public DataTable All(tbl_sale p)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
              

                DataTable dt = helper.GetDataTableFromStoredProc(SP.Selectsaleid, parameters);
                foreach (DataRow dr in dt.Rows)
                {

                    p.sale_id = Convert.ToInt32(dr["order_id"].ToString());
                   




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
