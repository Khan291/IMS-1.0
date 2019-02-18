using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public  class tbl_sale2
    {
        //SqlHelper helper = new SqlHelper();
        public string party_name { get; set; }
        public string date { get; set; }
        public string startdate { get; set; }
        public string enddate { get; set; }
        public decimal balance { get; set; }
        public decimal given { get; set; }

        
        public DataTable SaleInvoice(tbl_sale p)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id", p.company_id);
                parameters.Add("@sale_id", p.sale_id);

                //DataTable dt = helper.GetDataTableFromStoredProc(SP.SelectSaleinvoice, parameters);
                //foreach (DataRow dr in dt.Rows)
                //{

                //    p.party_id = Convert.ToInt32(dr["party_id"].ToString());
                //    p.actual_amount = Convert.ToDecimal(dr["actual_amount"].ToString());
                //    p.date = (dr["Date"].ToString());
                //    p.total_discount = Convert.ToDecimal(dr["total_discount"].ToString());
                //    p.invoice_no = (dr["invoice_no"].ToString());
                //    p.grand_total = Convert.ToDecimal(dr["grand_total"]);
                //    p.total_tax = Convert.ToDecimal(dr["total_tax"]);
                //    p.party_name = (dr["party_name"].ToString());
                //    p.balance = Convert.ToDecimal(dr["balance_amt"].ToString());
                //    p.given = Convert.ToDecimal(dr["given_amt"].ToString());



                //}
                //programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }

      
     

    }

    
}
