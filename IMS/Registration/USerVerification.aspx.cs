using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IMSBLL.EntityModel;

namespace IMS.Registration
{
    public partial class USerVerification : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (!Page.IsPostBack)
            {
                lblWrongOTP.InnerText = "";
                btnOTP.Text = "Re-Generate OTP";
                SendOtp();
                otpDiv.Style.Add("display", "normal");
            }
        }

        protected void btnOTP_Click(object sender, EventArgs e)
        {
            SendOtp();
            otpDiv.Style.Add("display", "normal");
            btnOTP.Text = "Re-Generate OTP";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string otp = string.Empty;
            if (txtOtp.Value == null || txtOtp.Value == "")
            {
                lblWrongOTP.InnerText = "Please enter OTP";
                return;
            }
            else
            {
                lblWrongOTP.InnerText = "";
            }
            var userdata = context.tbl_User.Where(u => u.user_id == userId).FirstOrDefault();
            if(txtOtp.Value == userdata.OTP)
            {
                lblWrongOTP.InnerText = "";
                userdata.IsVerified = true;
                context.SaveChanges();
                Response.Redirect("~/Registration/Login.aspx");
            }
            else
            {
                lblWrongOTP.InnerText = "Wrong OTP";
                return;
            }
        }
        
        public void SendOtp()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            var tblUser = context.tbl_User.Where(u => u.user_id == userId).FirstOrDefault();
            string MobileNo = tblUser.user_mobieno;
            if(MobileNo.Length == 10) //condition added because 91 is required for sending message from API
            {
                MobileNo = "91" + MobileNo;
            }
            VerifyUser verifyUser = new VerifyUser();
            verifyUser.Source = "";
            verifyUser.Username = "";
            verifyUser.Password = "";
            verifyUser.OTP = verifyUser.GenerateRandomOTP(4);
            verifyUser.Dmobile = MobileNo;
            verifyUser.Message = "Your OTP verification code for IMSBIZZ is " + verifyUser.OTP + ".";
            verifyUser.Message = HttpUtility.UrlEncode(verifyUser.Message);

            string res = verifyUser.SendSMSTL();

            //Update otp to DB;
            tblUser.OTP = verifyUser.OTP;
            context.SaveChanges();
        }

    }
}