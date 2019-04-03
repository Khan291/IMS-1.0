using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IMSBLL.EntityModel;
using System.Data.SqlClient;
using System.Data;


namespace IMSBLL.DAL
{
   public class Common
    {
     static IMS_TESTEntities context = new IMS_TESTEntities();

       public static string GenerateInvoicenumber( int companyId,int branchId,string invoiceNumberFor)
       {
           string invoiceNumber=string.Empty;

           InvoiceViewModel invoiceViewModel = new InvoiceViewModel();
           if (invoiceNumberFor == Constants.Purchase)
           {
               invoiceViewModel = (from s in context.tbl_purchase
                                   join f in context.tbl_financialyear on s.company_id equals f.company_id
                                   where s.company_id == companyId && s.status == true && f.status == true
                                   orderby s.purchase_id descending
                                   select new InvoiceViewModel
                                   {
                                       InvoiceNumber = s.InvoiceNumber,
                                       StartDate = f.start_date,
                                       EndDate = f.end_date
                                   }).Take(1).FirstOrDefault();
           }
           else if (invoiceNumberFor == Constants.Sale)
           {
               invoiceViewModel = (from s in context.tbl_sale
                                   join f in context.tbl_financialyear on s.company_id equals f.company_id
                                   where s.company_id == companyId && s.status == true && f.status == true
                                   orderby s.sale_id descending
                                   select new InvoiceViewModel
                                   {
                                       InvoiceNumber = s.InvoiceNumber,
                                       StartDate = f.start_date,
                                       EndDate = f.end_date
                                   }).Take(1).FirstOrDefault();
           }          

            if (invoiceViewModel!=null)
            {
                int number=0 ;
                if (Convert.ToDateTime(invoiceViewModel.StartDate) != DateTime.Now)
                {
                    number = Convert.ToInt32(invoiceViewModel.InvoiceNumber.Substring(5));
                }
               
                invoiceNumber = string.Format("{0}{1}{2:0000}", DateTime.Now.Year, invoiceNumberFor[0], ++number);

            }
            else
            {
                invoiceNumber = string.Format("{0}{1}{2:0000}", DateTime.Now.Year, invoiceNumberFor[0], 1);               
            }
            return invoiceNumber;
       }


        public static DataSet FillDataSet(String connectionstring, string storeProcedureName, SqlParameter[] parameter)
        {
            using (SqlConnection con = new SqlConnection(connectionstring))
            {
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = storeProcedureName;
                if (parameter != null)
                {
                    com.Parameters.AddRange(parameter);
                }
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(ds);

                return ds;
            }
        }
        }

   public class InvoiceViewModel
   {
       public string InvoiceNumber { get; set; }
       public string StartDate { get; set; }
       public string EndDate { get; set; }
   }

   


}
