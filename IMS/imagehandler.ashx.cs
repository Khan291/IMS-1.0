using IMSBLL.DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace IMS
{
    /// <summary>
    /// Summary description for imagehandler
    /// </summary>
    public class imagehandler : IHttpHandler ,System.Web.SessionState.IRequiresSessionState 
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        public void ProcessRequest(HttpContext context)
        {

            //SqlCommand cmd = new SqlCommand();
            //cmd.CommandText = "sp_selectcompanylogo";
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@company_id", Convert.ToInt32(context.Session["company_id"]));
            //try
            //{
            //    cmd.Connection = con;
            //    cmd.CommandTimeout = 600000;
            //    con.Open();
            //    byte[] bytes = (byte[])cmd.ExecuteScalar();
            //    context.Response.Clear();
            //    context.Response.BinaryWrite(bytes);
            //    context.Response.Flush();
            //    context.Response.Close();
              
            //}
            //catch (Exception ex)
            //{
            //    ErrorLog.saveerror(ex);
            //}
            //finally
            //{
            //    con.Close();
            //    con.Dispose();
            //}
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}