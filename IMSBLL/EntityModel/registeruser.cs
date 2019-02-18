using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public class Register1
    {

        public int country_id { get; set; }
        public int userid { get; set; }

        public string company_name { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string owner_emailid { get; set; }
        public string owner_mobileno { get; set; }
        public string pincode { get; set; }
        public string start_date { get; set; }
        public string end_date { get; set; }
        public string password { get; set; }
        public string created_by { get; set; }
        public DateTime created_date { get; set; }
        public string uniqueid { get; set; }
        public string username { get; set; }
        public string status { get; set; }
        public DateTime modifydate { get; set; }
        public int passverifyID { get; set; }
        SqlHelper helper = new SqlHelper();

        public DataTable activeuser(Register1 p)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@userid", userid);
                parameters.Add("@uniqueid", uniqueid);

                DataTable dt = helper.GetDataTableFromStoredProc(SP.ActiveUser, parameters);
                foreach (DataRow dr in dt.Rows)
                {
                    p.userid = Convert.ToInt32(dr["user_id"].ToString());
                    p.username = dr["USER_NAME"].ToString();
                    p.first_name = (dr["first_name"].ToString());
                    p.last_name = dr["last_name"].ToString();
                   

                }
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }
        public DataTable checkresetpwslink(Register1 p)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@userid", userid);
                parameters.Add("@uniqueid", uniqueid);
                parameters.Add("@pid", passverifyID);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.checkpwdlink, parameters);
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }
        public DataTable ResetRequest(Register1 p)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@email", owner_emailid);
                parameters.Add("@uniqueid", uniqueid);
                parameters.Add("@created_date", created_date);

                DataTable dt = helper.GetDataTableFromStoredProc(SP.ResetRequest, parameters);
                
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }
        public DataTable Insert(Register1 b)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@company_name",company_name );
            parameters.Add("@first_name", first_name);
            parameters.Add("@last_name", last_name);
            parameters.Add("@owner_emailid", owner_emailid);
            parameters.Add("@owner_mobileno", owner_mobileno);
            parameters.Add("@user_password", password);
            parameters.Add("@country_id", country_id);
            parameters.Add("@pincode", pincode);
            parameters.Add("@created_by", created_by);
            parameters.Add("@created_date", created_date);
            parameters.Add("@start_date", start_date);
            parameters.Add("@end_date", end_date);
            parameters.Add("@uniqueidentity", uniqueid);

            try
            {
                result = helper.GetDataTablebyProc(SP.Register, parameters);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                return result;
            }
            return result;
        }
        public DataTable updatepassword(Register1 b)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@userid", userid);
            parameters.Add("@uniqueid", uniqueid);
            parameters.Add("@modify_date", modifydate);
            parameters.Add("@newpwd", password);
            parameters.Add("@pid", passverifyID);
            try
            {
                result = helper.GetDataTablebyProc(SP.Updatepwd, parameters);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                return result;
            }
            return result;
        }

    }
}
