using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Reflection;

namespace IMSBLL.DAL
{
    public class SqlHelper
    {

        public string CONNECTION_STRING = ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString;

        public DataTable GetDataTablebyProc(string procName, Dictionary<string, object> @params)
        {
            DataTable dt = new DataTable("table0");
            SqlTransaction transaction;

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandTimeout = 600000;
                    con.Open();
                    cmd.CommandText = procName;
                    cmd.CommandType = CommandType.StoredProcedure;
                    transaction = con.BeginTransaction("InsertTransactoin");
                    cmd.Transaction = transaction;
                    try
                    {                        
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

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            dt.Load(reader);
                        }

                        transaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if(con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }                        
                    }
                }
            }          

            return dt;
        }
        public DataTable GetDataTableFromStoredProc(string procName, Dictionary<string, object> @params)
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

        public DataSet GetDataSetFromStoredProc(string procName, Dictionary<string, object> @params)
        {
            DataSet ds = new DataSet();
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
                        using (System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter())
                        {
                            da.SelectCommand = cmd;

                            da.Fill(ds, "table");
                        }
                    }
                }



            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }

            return ds;
        }

        public DataTable GetDataTableFromStoredProc(string procName)
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

        public DataTable CheckDoubleValues(int companyID, int branchId, string tableName, string columnName, string Value)
        {
            DataTable dt = new DataTable();            

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = SP.CheckDoubleValues;
                    cmd.CommandType = CommandType.StoredProcedure;                                        
                    try
                    {
                        cmd.Parameters.AddWithValue("@companyid", companyID);
                        cmd.Parameters.AddWithValue("@branch_id", branchId);
                        cmd.Parameters.AddWithValue("@tableName", tableName);
                        cmd.Parameters.AddWithValue("@columnName", columnName);
                        cmd.Parameters.AddWithValue("@ValueToCheck", Value);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);
                        }                        
                    }
                    catch (Exception ex)
                    {                        
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }
                }
            }
            return dt;
        }

        public DataTable checkusersdata(string Value)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = SP.checkuser;
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.AddWithValue("@user_Emai", Value);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);


                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }
                }
            }
            return dt;
        }
        public DataTable checkrackingodwon(string Value , int godwon_id,int companyid)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = SP.checkrackingodown;
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.AddWithValue("@company_id", companyid);
                        cmd.Parameters.AddWithValue("@godown_id", godwon_id);
                        cmd.Parameters.AddWithValue("@value", Value);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);


                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }
                }
            }
            return dt;
        }

        public DataTable sp_GetSaleDetailsById(int saleId)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = SP.checkusermobul;
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.AddWithValue("@saleId", saleId);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);
                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }
                }
            }
            return dt;
        }
        
        public DataTable checkusersdata2(string Value)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = SP.checkusermobul;
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.AddWithValue("@user_mobieno", Value);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);


                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }
                }
            }
            return dt;
        }

        public int GetStockQuantity(int companyId,int productId)
        {

            int dt = 0;

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = "sp_Selectquantity";
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.AddWithValue("@company_id", companyId);
                        cmd.Parameters.AddWithValue("@product_id", productId);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {

                            if (reader.Read())
                            {
                                dt = Convert.ToInt32(reader["qty"].ToString());
                            }
                                

                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }

                    return dt;
                }
            }
            
        }
        public int checkproductqty(int batch_id, int productID)
        {

            int dt = 0;

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = "sp_selectbatchwisequantity";
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.AddWithValue("@batch_id", batch_id);
                        cmd.Parameters.AddWithValue("@product_id", productID);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {

                            if (reader.Read())
                            {
                                dt = Convert.ToInt32(reader["StockAvl"].ToString());
                            }


                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }

                    return dt;
                }
            }

        }
        public DataTable checkbranch_name(int companyID, string Value)
        {
            DataTable dt = new DataTable(); 

            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = "sp_SelectBranchName";
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.AddWithValue("@company_id", companyID);
                        cmd.Parameters.AddWithValue("@value", Value);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);
                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }

                    return dt;
                }
            }

        }

        public DataTable checkregistermobileno(string Value)
        {
            DataTable dt = new DataTable();


            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = "SpGetExistsMobile";
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {

                        cmd.Parameters.AddWithValue("@mobileno", Value);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);
                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }

                    return dt;
                }
            }

        }
        public DataTable checkregisteremail(string Value)
        {
            DataTable dt = new DataTable();


            using (SqlConnection con = new SqlConnection(CONNECTION_STRING))
            {
                using (SqlCommand cmd = new System.Data.SqlClient.SqlCommand())
                {
                    cmd.CommandText = "SpGetExistsEmail";
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {

                        cmd.Parameters.AddWithValue("@email", Value);
                        cmd.Connection = con;
                        cmd.CommandTimeout = 600000;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                        {
                            dt.Load(reader);
                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.saveerror(ex);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }

                    return dt;
                }
            }

        }
        public DataTable LINQToDataTable<T>(IEnumerable<T> varlist)
        {
            DataTable dtReturn = new DataTable();


            // column names
            PropertyInfo[] oProps = null;


            if (varlist == null) return dtReturn;


            foreach (T rec in varlist)
            {
                // Use reflection to get property names, to create table, Only first time, others will follow
                if (oProps == null)
                {
                    oProps = ((Type)rec.GetType()).GetProperties();
                    foreach (PropertyInfo pi in oProps)
                    {
                        Type colType = pi.PropertyType;


                        if ((colType.IsGenericType) && (colType.GetGenericTypeDefinition() == typeof(Nullable<>)))
                        {
                            colType = colType.GetGenericArguments()[0];
                        }


                        dtReturn.Columns.Add(new DataColumn(pi.Name, colType));
                    }
                }


                DataRow dr = dtReturn.NewRow();


                foreach (PropertyInfo pi in oProps)
                {
                    dr[pi.Name] = pi.GetValue(rec, null) == null ? DBNull.Value : pi.GetValue
                    (rec, null);
                }


                dtReturn.Rows.Add(dr);
            }
            return dtReturn;
        }
    }
}
