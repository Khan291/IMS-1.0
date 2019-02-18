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
using System.Net;


namespace IMS.Registration.form_1
{
    public partial class Forgot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }
        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        protected void SendMail()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = (DataTable)Session["userdetails"];
                MailMessage mail = new MailMessage();
                //SmtpClient SmtpServer = new SmtpClient("relay-hosting.secureserver.net");
                SmtpClient SmtpServer = new SmtpClient("webmail.imsbizz.com", 25);
                StringBuilder sb = new StringBuilder();
                mail.From = new MailAddress("no-reply@imsbizz.com", "IMS Bizz");
                mail.To.Add(email.Value);
                mail.Subject =  dt.Rows[0]["username"].ToString()+" here's the link to reset your password";
                string body = string.Empty;
                using (StreamReader reader = new StreamReader(Server.MapPath("~/Registration/Forgotpassword.html")))
                {
                    body = reader.ReadToEnd();
                }
                body = body.Replace("{UserName}", dt.Rows[0]["username"].ToString());
                body = body.Replace("{id}", dt.Rows[0]["user_id"].ToString());
                body = body.Replace("{uid}", dt.Rows[0]["uniqueidentifier"].ToString());
                body = body.Replace("{pid}", dt.Rows[0]["Passverify_ID"].ToString());
                mail.Body = body;
                mail.IsBodyHtml = true;
                NetworkCredential NetCrd = new NetworkCredential("no-reply@imsbizz.com", "Vtt@!123");
                SmtpServer.EnableSsl = false;
                //SmtpServer.UseDefaultCredentials = true;
                SmtpServer.UseDefaultCredentials = false;
                SmtpServer.Credentials = NetCrd;
                SmtpServer.Timeout = 200000000;

                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        public bool ResetRequest()
        {
            try
            {
                DataTable dt = new DataTable();
                Guid uniqueid = Guid.NewGuid();
                Register1 r = new Register1();
                r.owner_emailid = email.Value;
                r.uniqueid = uniqueid.ToString();
                r.created_date = DateTime.Now;
                 dt = r.ResetRequest(r);
                 if (dt.Rows[0][0].ToString() == "This Email is not register with IMSbizz")
                 {
                     ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('This Email is not register with IMSbizz','False');", true);
                     return false;
                 }
                 else
                 {
                     ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Check Your Email To Reset Your Password','False');", true);
                     Session["userdetails"] = dt;
                     return true;
                 }
                 
            }
            catch (Exception ex)
            {
               ErrorLog.saveerror(ex);
            }
            return true;
        }
        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnsendmail_Click(object sender, EventArgs e)
        {
            try
            {
                if (ResetRequest())
                {
                    SendMail();
                    email.Value = "";
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