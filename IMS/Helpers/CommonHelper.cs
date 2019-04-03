using IMS.Reports;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace IMS.Helpers
{
    public class CommonHelper
    {
        public static void CreateReport(String connectionstring, string storeProcedureName, SqlParameter[] parameter, ref Microsoft.Reporting.WebForms.ReportViewer reportViewer, string reportDataSource, string tableName)
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
                CommonDataSet ds = new CommonDataSet();
                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(ds, tableName);
                ReportDataSource datasource = new ReportDataSource(reportDataSource, ds.Tables[tableName]);
                //if (ds.Tables[tableName].Rows.Count > 0)
                //{
                //reportViewer.LocalReport.DataSources.Clear();
                reportViewer.LocalReport.DataSources.Add(datasource);
                //}
            }
        }
    }
}