using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using IMSBLL.EntityModel;
using IMSBLL.DAL;



namespace IMS
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            try
            {
                if (HttpContext.Current.User != null)
                {
                    if (HttpContext.Current.User.Identity.IsAuthenticated)
                    {
                        if (HttpContext.Current.User.Identity is FormsIdentity)
                        {
                            FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
                            FormsAuthenticationTicket ticket = id.Ticket;

                            string userData = ticket.UserData;
                            string[] roles = userData.Split(',');
                            HttpContext.Current.User = new GenericPrincipal(id, roles);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            try
            {
                if (Server.GetLastError() != null)
                {
                    ErrorLog.saveerror(Server.GetLastError());
                    Server.ClearError();
                    Response.Redirect("../Registration/Login.aspx");
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a new session is started  
            if (Session["UserID"] == null)
            {
                //Redirect to Welcome Page if Session is not null  
               // Response.Redirect("../Registration/Login.aspx");

            }           
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}