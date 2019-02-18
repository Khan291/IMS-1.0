using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public  class tbl_product1
    {
        SqlHelper helper = new SqlHelper();

        public DataTable Insert(tbl_product p)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_id", p.company_id);
            parameters.Add("@branch_id", p.branch_id);
            parameters.Add("@category_id", p.category_id);
            parameters.Add("@unit_id", p.unit_id);
            parameters.Add("@godown_id", p.godown_id);
            parameters.Add("@rack_id", p.rack_id);
           // parameters.Add("@tax_id", p.tax_id);
            parameters.Add("@product_name", p.product_name);
            parameters.Add("@product_code", p.product_code);
            parameters.Add("@hsn_code", p.hsn_code);
            parameters.Add("@reorder_level", p.reorder_level);
            parameters.Add("@purchas_price", p.purchas_price);
            parameters.Add("@sales_price", p.sales_price);
            parameters.Add("@status", p.status);
            parameters.Add("@created_by", p.created_by);
            parameters.Add("@created_date", p.created_date);
            parameters.Add("@modified_by", p.modified_by);
            parameters.Add("@modified_date", p.modified_by);

            try
            {
                result = helper.GetDataTablebyProc(SP.ProductInsert, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }

        public DataTable All(tbl_product p)
        {
            DataTable programs = new DataTable();
            try
            {

                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id", p.company_id);
                parameters.Add("@product_id", p.product_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.SelectPrice, parameters);
                foreach (DataRow dr in dt.Rows)
                {
                    p.sales_price = Convert.ToDecimal(dr["sales_price"]);
                    p.purchas_price = Convert.ToDecimal(dr["purchas_price"]);

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
