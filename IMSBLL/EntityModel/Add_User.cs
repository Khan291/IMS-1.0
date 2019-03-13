using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using IMSBLL.DAL;

namespace IMSBLL.EntityModel
{
    public partial class UserRol
    {
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        #endregion

        SqlHelper helper = new SqlHelper();
        public void Insert(UserRol userRole)
        {
            tbl_User _userRole = new tbl_User();
            _userRole.user_name = userRole.user_name;
            _userRole.status = userRole.status;
            _userRole.created_by = userRole.created_by;
            _userRole.user_Emai = userRole.user_Emai;
            _userRole.user_mobieno = userRole.user_mobieno;
            _userRole.password = userRole.password;
            _userRole.first_name = userRole.first_name;
            _userRole.last_name = userRole.last_name;

            tbl_userbranch userBranch = new tbl_userbranch();
            userBranch.role_id = userRole.role_id;
            userBranch.user_id = userRole.user_id;
            userBranch.branch_id = userRole.branch_id ;
            userBranch.status = userRole.status; 
            userBranch.created_by = userRole.created_by; 
            userBranch.created_date = userRole.created_date;
            userBranch.company_id = userRole.company_id;

            _userRole.tbl_userbranch.Add(userBranch);



            try
            {
                context.tbl_User.Add(_userRole);
                context.SaveChanges();
                //result = helper.GetDataTablebyProc(SP.AddUser, parameters);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
          //  return result;
        }


        public DataTable Update(UserRol userRole)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@userbranch_id", userRole.userbranch_id);
            parameters.Add("@user_id", userRole.user_id);
            parameters.Add("@user_name", userRole.user_name);
            parameters.Add("@user_emailid", userRole.user_Emai);
            parameters.Add("@user_mobileno", userRole.user_mobieno);
            parameters.Add("@role_id", userRole.role_id);
            parameters.Add("@branch_id", userRole.branch_id);
            parameters.Add("@company_id", userRole.company_id);
            parameters.Add("@status", userRole.status);
            parameters.Add("@modified_by", userRole.modified_by);
            parameters.Add("@modified_date", userRole.modified_date);

            parameters.Add("@first_name", userRole.first_name);
            parameters.Add("@last_name", userRole.last_name);
            
           
           
            
            

            try
            {
                result = helper.GetDataTablebyProc(SP.SUpdateUser, parameters);
            }
            catch (Exception ex)
            {
                return result;
            }
            return result;
        }




        public DataTable Delete(UserRol userRole)
        {
            DataTable result = null;
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@userbranch_id", userRole.userbranch_id);
            parameters.Add("@user_id", userRole.user_id);
            parameters.Add("@branch_id", userRole.branch_id);
            parameters.Add("@company_id", userRole.company_id);


            try
            {
                result = helper.GetDataTablebyProc(SP.DeleteUser, parameters);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return result;
        }


        public DataTable userID(UserRol userRole)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@user_name", userRole.user_name);
                parameters.Add("@password", userRole.password);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.AuthenticateUser, parameters);
                foreach (DataRow dr in dt.Rows)
                {

                    
                    userRole.user_id = int.Parse(dr["user_id"].ToString());



                }
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }

        public DataTable RoleName(UserRol userRole)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@user_id", userRole.user_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.AuthenticateUserRole, parameters);
                foreach (DataRow dr in dt.Rows)
                {

                    userRole.company_id = Convert.ToInt32(dr["company_id"]);
                    userRole.role_name = dr["role_name"].ToString();
                    userRole.branch_id = Convert.ToInt32(dr["branch_id"]);
                    userRole.loginUsername = dr["Name"].ToString();



                }
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }



        public DataTable All2(UserRol userRole)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@user_id", userRole.user_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.SelectCompany_name, parameters);
                foreach (DataRow dr in dt.Rows)
                {

                    userRole.company_name = (dr["company_name"].ToString());


                }
                programs = dt;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return programs;
        }

      
        
        
        public DataTable All(UserRol userRole)
        {
            DataTable programs = new DataTable();
            try
            {
                Dictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("@company_id", userRole.company_id);
                DataTable dt = helper.GetDataTableFromStoredProc(SP.AddUserRole, parameters);
                foreach (DataRow dr in dt.Rows)
                {
                    
                    userRole.userbranch_id = int.Parse(dr["userbranch_id"].ToString());
                    userRole.first_name = dr["first_name"].ToString();
                    userRole.last_name = dr["last_name"].ToString();
                    userRole.user_Emai = dr["user_Emai"].ToString();
                    userRole.user_mobieno = dr["user_mobieno"].ToString();
                    userRole.password = dr["password"].ToString();
                    userRole.role_name = dr["role_name"].ToString();
                    userRole.branch_name = dr["branch_name"].ToString();
                    userRole.user_id = int.Parse(dr["user_id"].ToString());
                    userRole.role_id = int.Parse(dr["role_id"].ToString());

                   
                    
                }
                programs = dt;
            }
            catch (Exception ex)
            {

            }
            return programs;
        }
    }
}
