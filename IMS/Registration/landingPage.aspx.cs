using IMSBLL.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.Registration
{
    public partial class landingPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

    
        protected void SendMail()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = (DataTable)Session["userdetails"];
                MailMessage mail = new MailMessage();
                //SmtpClient SmtpServer = new SmtpClient("relay-hosting.secureserver.net");
                System.Net.Mail.SmtpClient SmtpServer = new SmtpClient("webmail.imsbizz.com", 25);
                StringBuilder sb = new StringBuilder();
                mail.From = new MailAddress("no-replay@imsbizz.com", "IMS Bizz");
                mail.To.Add("contact@vttechnologies.co");
                mail.Subject = "Message from Main Contact form";
                //string body = string.Empty;
                //using (StreamReader reader = new StreamReader(Server.MapPath("~/Registration/EmailVerification.html")))
                //{
                //    body = reader.ReadToEnd();
                //}
                //body = body.Replace( name.Value );
                //body = body.Replace("{id}", message.Value);
                //body = body.Replace("{uid}", dt.Rows[0]["uniqueidentifier"].ToString());
                mail.Body = "Mail From:  " + name.Value + "<br/> Email Of Sender:  " + message.Value + "<br/>  Message :   "+message.Value+"";
                mail.IsBodyHtml = true;
                NetworkCredential NetCrd = new NetworkCredential("no-replay@imsbizz.com", "Temp@1234");
                SmtpServer.EnableSsl = false;
                SmtpServer.UseDefaultCredentials = false;
                SmtpServer.Credentials = NetCrd;
                SmtpServer.Timeout = 20000;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            SendMail();
        }
    }
}