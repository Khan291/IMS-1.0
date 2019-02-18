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

namespace IMS.Registration
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        /// <summary>  
        /// All The objects That are used in coding
        /// </summary>
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    List<tbl_country> gd = context.tbl_country.Where(x => x.status == true).ToList();

                    ddlcountry.DataTextField = "country_name";
                    ddlcountry.DataValueField = "country_id";
                    ddlcountry.DataSource = gd;
                    ddlcountry.DataBind();
                    if (ddlcountry.Items.Count > 0)
                    {
                        ddlcountry.SelectedItem.Text = "India";
                        ddlcountry.Enabled = false;
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
          [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.checkregisteremail(useroremail);
                    if (data.Rows.Count > 0)
                    {
                        return "true";
                    }
                    else
                    {
                        return "false";
                    }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return "true";
        }
          [System.Web.Services.WebMethod]
          public static string CheckMobileDouble(string mobileno)
          {
              try
              {
                  SqlHelper helper = new SqlHelper();
                  DataTable data = helper.checkregistermobileno(mobileno);
                  if (data.Rows.Count > 0)
                  {
                      return "true";
                  }
                  else
                  {
                      return "false";
                  }
              }
              catch (Exception ex)
              {
                  ErrorLog.saveerror(ex);
              }
              return "true";
          }
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
                mail.Subject = "Test Mail";
                string body = string.Empty;
                using (StreamReader reader = new StreamReader(Server.MapPath("~/Registration/EmailVerification.html")))
                {
                    body = reader.ReadToEnd();
                }
                body = body.Replace("{UserName}", txtfirstname.Value + " " + txtlastname.Value);
                body = body.Replace("{id}", dt.Rows[0]["user_id"].ToString());
                body = body.Replace("{uid}", dt.Rows[0]["uniqueidentifier"].ToString());
                mail.Body = body;
                mail.IsBodyHtml = true;
                NetworkCredential NetCrd = new NetworkCredential("no-reply@imsbizz.com", "Vtt@!123");
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

        public bool validationss()
        {
            ////Shakeeb
            Validationss v = new Validationss();
            if (v.mobilevations(txtmobile.Value) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Proper Mobile Number','False');", true);
                return false;
            }
            if (v.emialvalidation(email.Value) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Proper Email','False');", true);
                return false;
            }
            string[] array = new string[] { txtfirstname.Value, txtlastname.Value, txtcompanyname.Value, txtzip.Value, txtmobile.Value };
            if (v.emtystringvalidtion(array) == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('All fields are Required','False');", true);
                return false;
            }
            string emailID = CheckDouble(email.Value);
            if (emailID == "true")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Email ID is already Exist','False');", true);
                return false;
            }
            string mobile = CheckMobileDouble(txtmobile.Value);
            if (mobile == "true")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Mobile Number is already Exist','False');", true);
                return false;
            }
            return true;
        }
        public static string GetSwcSHA1(string value)
        {
            SHA1 algorithm = SHA1.Create();
            byte[] data = algorithm.ComputeHash(Encoding.UTF8.GetBytes(value));
            string sh1 = "";
            for (int i = 0; i < data.Length; i++)
            {
                sh1 += data[i].ToString("x2").ToUpperInvariant();
            }
            return sh1;
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
                if (validationss())
                {
                    Guid uniqueid = Guid.NewGuid();
                    Register1 r = new Register1();
                    r.first_name = txtfirstname.Value;
                    r.last_name = txtlastname.Value;
                    r.country_id = Int32.Parse(ddlcountry.SelectedValue);
                    r.company_name = txtcompanyname.Value;
                    r.owner_emailid = email.Value;
                    r.owner_mobileno = txtmobile.Value;
                    string enPswd = GetSwcSHA1(myInput.Value);
                    r.password = enPswd;
                    r.pincode = txtzip.Value;
                    r.created_by = txtfirstname.Value;
                    r.created_date = DateTime.Now;
                    r.start_date = startdate.Value;
                    r.end_date = enddate.Value; 
                    r.uniqueid = uniqueid.ToString();

                    //context.sp_Register(company_name,)
                    DataTable dt = new DataTable();
                    dt = r.Insert(r);
                    Session["userdetails"] = dt;
                    SendMail();
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Thank you for signing up please confirm your E-mail','True');", true);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

      

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("~/Registration/Register.aspx", false);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        #endregion



        //public void validation()
        //{
        //    try
        //    {
        //        String password = txtPassword.Text; // Substitute with the user input string
        //        Utilities.PasswordScore passwordStrengthScore = Utilities.CheckStrength(password);

        //        switch (passwordStrengthScore)
        //        {
        //            case Utilities.PasswordScore.Blank:
        //            case Utilities.PasswordScore.VeryWeak:
        //            case Utilities.PasswordScore.Weak:
        //                lblPswdCheck.Text = "Password should have atleast 8 characters, preferably atleast one upper case and one special character";
        //                lblPswdCheck.Visible = true;
        //                break;
        //            case Utilities.PasswordScore.Medium:
        //            case Utilities.PasswordScore.Strong:
        //            case Utilities.PasswordScore.VeryStrong:
        //                // Password deemed strong enough, allow user to be added to database etc
        //                lblPswdCheck.Visible = false;
        //                break;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLog.saveerror(ex);
        //    }
        //}

       

    }
}