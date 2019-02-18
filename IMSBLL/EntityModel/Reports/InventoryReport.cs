using IMSBLL.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.EntityModel.Reports
{
    public class InventoryReport
    {
        SqlHelper helper = new SqlHelper();
        public DataTable GetProduct(tbl_product p, tbl_stock s) 
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id ", p.company_id);
                parameters.Add("@branch_id", p.branch_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.productwithquantity, parameters);
                foreach (DataRow dr in dt.Rows)
                {

                    p.product_id = Convert.ToInt32(dr["product_id"].ToString());
                    p.product_name = (dr["product_name"].ToString());
                   
                    p.product_code = (dr["product_code"].ToString());
                    p.purchas_price = Convert.ToDecimal(dr["purchas_price"].ToString());
                    p.sales_price = Convert.ToDecimal(dr["sales_price"].ToString());
                    s.qty = Convert.ToInt32(dr["qty"].ToString());
                    p.reorder_level = Convert.ToInt32(dr["reorder_level"].ToString());
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
