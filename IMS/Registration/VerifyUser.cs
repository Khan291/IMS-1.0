using System;
using System.Collections.Specialized;
using System.Configuration;
using System.Net;
using System.Web;

namespace IMS.Registration
{
    internal class VerifyUser
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Source { get; set; }
        public string Dmobile { get; set; }
        public string Message { get; set; }
        public string OTP { get; set; }

        string[] saAllowedCharacters = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };

        public string GenerateRandomOTP(int iOTPLength)
        {
            string sOTP = string.Empty;
            string sTempChars = string.Empty;
            Random rand = new Random();
            for (int i = 0; i < iOTPLength; i++)
            {
                int p = rand.Next(0, saAllowedCharacters.Length);
                sTempChars = saAllowedCharacters[rand.Next(0, saAllowedCharacters.Length)];
                sOTP += sTempChars;
            }
            return sOTP;
        }
        public string SendOtp()
        {
            string response = string.Empty;
            //string otp = GenerateRandomOTP(4);
            string urlTransactional = "https://www.txtguru.in/imobile/api.php?username=" + Username + "&password=" + Password + "&source=" + Source + "&dmobile=" + Dmobile + "&message=" + Message;
            HttpWebRequest myHttpWebRequest = (HttpWebRequest)WebRequest.Create(urlTransactional);
            HttpWebResponse myHttpWebResponse = (HttpWebResponse)myHttpWebRequest.GetResponse();

            if (myHttpWebResponse.StatusCode == HttpStatusCode.OK)
            {
                response = "OTP Sent";
            }
            else
            {
                response = "Some error occured please try again";
            }
            return response;
        }
        public string SendSMSTL()
        {
            string apikey = ConfigurationManager.AppSettings["TLapikey"];
            string senderId = ConfigurationManager.AppSettings["senderId"];
            //String message = HttpUtility.UrlEncode("Test Message from ather TL Account");
            using (var wb = new WebClient())
            {
                byte[] response = wb.UploadValues("https://api.textlocal.in/send/", new NameValueCollection()
                {
                {"apikey" , apikey},
                {"numbers" , Dmobile},
                {"message" , Message},
                {"sender" , senderId}
                });
                string result = System.Text.Encoding.UTF8.GetString(response);
                return result;
            }
        }
    }

}