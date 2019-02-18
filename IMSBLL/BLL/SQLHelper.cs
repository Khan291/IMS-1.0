using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace IMSBLL.BLL
{
    class SQLHelper
    {
        public string CONNECTION_STRING = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;
        public DataTable GetDataTablebyProc(string procName, Dictionary<string, object> @params)
        {
            DataTable dt = new DataTable("table0");
            try
            {
                using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
                {
                    using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                    {
                        cmd.CommandText = procName;
                        cmd.CommandType = CommandType.StoredProcedure;
                        foreach (KeyValuePair<string, object> kvp in @params)
                        {
                            if (kvp.Value != null)
                            {
                                cmd.Parameters.AddWithValue(kvp.Key, kvp.Value);
                            }
                            else
                            {
                                System.Data.SqlClient.SqlParameter param = new System.Data.SqlClient.SqlParameter();
                                param.ParameterName = kvp.Key;
                                param.Value = DBNull.Value;
                                cmd.Parameters.Add(param);
                            }
                        }
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return dt;
        }
    }
}
