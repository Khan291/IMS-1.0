using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.Registration
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                divclickhere.Visible = false;
                divresetpassword.Visible = false;
                checklink();
            }
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        public bool checklink()
        {
            try
            {
                int pid = Convert.ToInt32(Request.QueryString["pid"].ToString());
                var data = context.Tbl_VerifyResetPass.Where(p => p.Passverify_ID == pid).FirstOrDefault();
                if (data != null)
                {
                    DateTime createDate = Convert.ToDateTime(data.created_date).AddHours(1);
                    bool? status = data.status;
                    if (createDate < DateTime.Now || !status.Value)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('This link has been Expired','False');", true);
                        divclickhere.Visible = true;
                        return false;
                    }
                    else
                    {
                        divresetpassword.Visible = true;
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return true;
        }
        public void updatepassword()
        {
            try
            {
                if (password.Value != Cpassword.Value)
                {
                    Response.Write("<script>alert('Password and confirm password does not match')</script>");
                    return;
                }
                Register1 r = new Register1();
                int pid = Convert.ToInt32(Request.QueryString["pid"].ToString());
                var data = context.Tbl_VerifyResetPass.Where(p => p.Passverify_ID == pid).FirstOrDefault();
                if (data != null)
                {
                    string enPswd = EncryptionHelper.GetSwcSHA1(password.Value);
                    r.userid = Convert.ToInt32(data.user_id);
                    r.password = enPswd;
                    r.modifydate = DateTime.Now;
                    r.uniqueid = data.uniqueidentifier;
                    r.passverifyID = data.Passverify_ID;
                    DataTable dt = new DataTable();
                    dt = r.updatepassword(r);
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Password has been changed successfully','True');", true);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }     
        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (checklink())
                {
                    updatepassword();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        #endregion
    }
}