﻿using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.DAL
{
    public static class ErrorLog
    {
        
        public static string CONNECTION_STRING = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        public static void saveerror(Exception ex)
        {
            IMS_TESTEntities context = new IMS_TESTEntities();
            string message = "";
            message += Environment.NewLine;
            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            message += string.Format("Message: {0}", ex.Message);
            message += Environment.NewLine;
            System.Diagnostics.StackTrace trace = new System.Diagnostics.StackTrace(ex, true);
            //Console.WriteLine("Line: " + trace.GetFrame(0).GetFileLineNumber());
            message += string.Format("StackTrace: {0}", trace.GetFrame(0).GetFileLineNumber());
            message += Environment.NewLine;
            message += string.Format("Source: {0}", ex.Source);
            message += Environment.NewLine;
            message += string.Format("TargetSite: {0}", ex.TargetSite.ToString());
            message += Environment.NewLine;
            message += string.Format("Error Url: {0}", ex.ToString());
            message += Environment.NewLine;
            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            
           
            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {

                    cmd.CommandText = "sp_saveerror";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@company_id", 1);
                    cmd.Parameters.AddWithValue("@branch_id", 1);
                    cmd.Parameters.AddWithValue("@error_type", ex.GetType().Name.ToString());
                    cmd.Parameters.AddWithValue("@error_msg", message.ToString());
                    cmd.Parameters.AddWithValue("@created_by", "Admin");
                    cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
                    con.Open();
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            //tbl_error_log tbl_error_log = new tbl_error_log();
            //tbl_error_log.company_id = 1;
            //tbl_error_log.branch_id = 1;
            //tbl_error_log.error_type = ex.GetType().Name.ToString();
            //tbl_error_log.error_msg = message.ToString();
            //tbl_error_log.created_by = "Admin";
            //tbl_error_log.created_date = DateTime.Now;
            //context.tbl_error_log.Add(tbl_error_log);
            //context.SaveChanges();
        }
    }
}
