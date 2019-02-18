using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using IMSBLL.EntityModel;
using System.Security.Cryptography;
using System.Text;

namespace IMSAPI.Controllers
{
     [RoutePrefix("api/Workflow")]
    public class LoginController : ApiController
    {
        IMS_TESTEntities context = new IMS_TESTEntities();


       

        [HttpGet]
        [Route("Validate/{userName}/{password}")]
        public HttpResponseMessage ValidatedUser(int userName, string password)
        {
            string enPswd = GetSwcSHA1(password);
            var authenticate = context.tbl_User.Where(g => g.user_id == userName && g.password == enPswd && g.status == true).FirstOrDefault();
            var role = context.spAuthenticateUserRole(authenticate.user_id).FirstOrDefault();
            //return Request.CreateResponse(HttpStatusCode.OK, "Request send successfully.");
            if (authenticate != null)
            {
                if (authenticate.user_id != 0)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, authenticate.user_id);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound, "User Name or Password is not corroect.");
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden, "You are not having access to the application, Please contact to administrator.");
            }
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
    }
}
