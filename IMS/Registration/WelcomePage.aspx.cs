using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IMSBLL.EntityModel;
using System.Net.Mail;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;
using IMSBLL;
using IMSBLL.DAL;
using System.IO;

namespace IMS.Registration
{
    public partial class WelcomePage : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            activeuser();
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>
       
        #region Methods
        public void activeuser()
        {
            try
            {
                int userid = Convert.ToInt32(Request.QueryString["userid"].ToString());
                string uniqueid = Request.QueryString["uniqueid"].ToString();
                Register1 r = new Register1();
                r.userid = userid;
                r.uniqueid = uniqueid;
                r.activeuser(r);
                lblusername.Text = r.first_name.ToString() + " " + r.last_name.ToString();
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
        protected void btnloginclick_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Registration/Login.aspx", false);
        }
        #endregion




    }
}