using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IMSBLL.EntityModel;
using System.Web.Security;
using IMSBLL.DAL;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using System.Data.Entity.Core.Objects;

namespace IMS.Registration
{
    public partial class Login : System.Web.UI.Page
    {
        int us_ID;
        IMS_TESTEntities context = new IMS_TESTEntities();
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>


        //SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Request.Cookies["us_ID"] != null)

                    txtEmail.Text = Request.Cookies["us_ID"].Value;

                if (Request.Cookies["enPswd"] != null)

                    txtPassword.Attributes.Add("value", Request.Cookies["enPswd"].Value);
                if (Request.Cookies["us_ID"] != null && Request.Cookies["enPswd"] != null)
                    cbRemember.Checked = true;
            }
        }

        #region Methods
        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>


        public bool IsLogin(tbl_User _User)
        {
            try
            {
                bool returnvalue = false;
                if (_User != null)
                {
                     returnvalue = _User.Islogin.Value;
                }
                return returnvalue;
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                return true;
            }
        }

        public void UpdateIsLogin(int userid)
        {
            try
            {

                context.tbl_User.FirstOrDefault();

                var userdata = context.tbl_User.SingleOrDefault(u => u.user_id == userid);
                if (userdata !=null)
                {
                    userdata.Islogin = true;
                    context.SaveChanges();

                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        
        }


        public void login()
        {
            try
            {
                if (txtEmail.Text != "  " && txtPassword.Text != "")
                {
                    if (!AuthenticateUser())
                    {
                        us_ID = Convert.ToInt32(Session["UserID"]);
                       // UpdateIsLogin(us_ID);
                        if (us_ID > 0)
                        {
                            selectUserRole();
                            SqlCommand cmd = new SqlCommand();
                            cmd.CommandText = "sp_checklicense";
                            int c_id = Convert.ToInt32(Session["company_id"]);
                            ObjectParameter freeCount = new ObjectParameter("free_count", typeof(int));
                            ObjectParameter subscriptionCount = new ObjectParameter("Subscription_count", typeof(int));
                            var r = context.sp_checklicense(c_id, us_ID, freeCount, subscriptionCount);
                            if (Convert.ToInt32(subscriptionCount.Value) > 0)
                            {
                                if (Convert.ToInt32(freeCount.Value) > 0)
                                {

                                    string userData = string.Empty;
                                    string role = Convert.ToString(Session["Rolename"]);
                                    if (role == "Sales Manager")
                                    {
                                        userData = "Sales";
                                    }
                                    else if (role == "Purchase Manager")
                                    {
                                        userData = "Purchase";
                                    }
                                    else if (role == "Manager" || role == "")
                                    {
                                        userData = "Manager";
                                    }
                                    Session["UserRoleSession"] = userData;

                                    if (!string.IsNullOrEmpty(userData))
                                    {
                                        // create a new ticket used for authentication

                                        if (cbRemember.Checked == true)
                                        {
                                            Response.Cookies["us_ID"].Value = txtEmail.Text;
                                            Response.Cookies["enPswd"].Value = txtPassword.Text;
                                            Response.Cookies["us_ID"].Expires = DateTime.Now.AddDays(15);
                                            Response.Cookies["enPswd"].Expires = DateTime.Now.AddDays(15);
                                        }

                                        else
                                        {

                                            Response.Cookies["us_ID"].Expires = DateTime.Now.AddDays(-1);

                                            Response.Cookies["enPswd"].Expires = DateTime.Now.AddDays(-1);

                                        }
                                        FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, txtEmail.Text, DateTime.Now, DateTime.Now.AddMinutes(15), false, userData, FormsAuthentication.FormsCookiePath);
                                        var encryptedTicket = FormsAuthentication.Encrypt(ticket);
                                        if (cbRemember.Checked)
                                        {
                                            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                                            cookie.Expires = ticket.Expiration;
                                            HttpContext.Current.Response.Cookies.Set(cookie);
                                        }
                                        else
                                        {
                                            FormsAuthentication.SetAuthCookie(txtEmail.Text, false);
                                        }
                                    }
                                    string returnUrl = Request.QueryString["ReturnUrl"];
                                    if (role.Equals("Purchase Manager"))
                                    {
                                        returnUrl = "Purchases/Purchase.aspx";
                                    }
                                    else if (role == "Sales Manager")
                                    {
                                        returnUrl = "Sales/Sale.aspx";
                                    }
                                    else if (role == "Manager" || role == "")
                                    {
                                        returnUrl = "Home.aspx";
                                    }
                                    Response.Redirect(@"~/" + returnUrl, false);
                                }
                                else
                                {
                                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Your free count has over.');", true);
                                }
                            }
                            else
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Your subscription has been ended, Please Choose any Of Our Plan To Continue.');", true);
                            }
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('User Name Or Password Is Invalid');", true);
                        }
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('User Already Log In');", true);
                    }                    
                }
                else
                {
                    lblError.Visible = true;
                    lblError.Text = "Please Enter Your Email ID and Password";

                }

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        //private bool CheckActiveUser()
        //{
        //    string userId = Session["UserID"].ToString();
        //    var t = context.Tbl_EmailVerify.Where(g => g.user_id == userId).FirstOrDefault();
        //    if (t != null)
        //    {
        //        bool isActive = Convert.ToBoolean(t.status);
        //        if (t.status == true)
        //        {
        //            return true;
        //        }
        //    }
        //    return false;
        //}
        private bool AuthenticateUser()
        {
            //UserRol r = new UserRol();
            //r.user_name = txtEmail.Text;
            string enPswd = EncryptionHelper.GetSwcSHA1(txtPassword.Text);
            //r.password = enPswd;
            ////Shakeeb
            var r = context.tbl_User.Where(g => g.user_name == txtEmail.Text && g.password == enPswd && g.status == true).FirstOrDefault();
            // r.userID(r);

            Session["username"] = txtEmail.Text;
            if (r != null)
            {
                Session["UserID"] = r.user_id;
                if (!r.IsVerified.Value)
                {
                    Response.Redirect("USerVerification.aspx");
                }
            }
            return IsLogin(r);
        }

        public void selectUserRole()
        {
            //UserRol r = new UserRol();
            //r.user_id = Convert.ToInt32(Session["UserID"]);
            ////Shakeeb
            var r = context.spAuthenticateUserRole(Convert.ToInt32(Session["UserID"])).FirstOrDefault();
            //r.RoleName(r);           
            Session["Rolename"] = r.role_name;
            Session["company_id"] = r.company_id;
            Session["financialyear_id"] = context.tbl_financialyear.Where(w => w.company_id == r.company_id && w.status == true).Select(s => s.financialyear_id).FirstOrDefault();
            Session["branch_id"] = r.branch_id;
            Session["LoginuserName"] = r.Name;
        }
        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            login();
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("../Subscription/Pricing.aspx", false);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        #endregion
    }
}