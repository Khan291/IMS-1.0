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

namespace IMS.Subscription
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        int us_ID;

        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods

        private void loginmethode()
        {
            try
            {
                if (txtEmail.Text != "  " && txtPassword.Text != "")
                {
                    AuthenticateUser();
                    us_ID = Convert.ToInt32(Session["UserID"]);

                    if (us_ID > 0)
                    {
                        selectUserRole();
                        string userData = "";
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
                        Response.Redirect("Pricing.aspx", false);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Invalid User Name or Password');", true);
                        //lblError.Visible = true;
                        //lblError.Text = "Invalid User Name or Password";

                    }

                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Please Enter Your Email ID and Password');", true);
                    //lblError.Visible = true;
                    //lblError.Text = "Please Enter Your Email ID and Password";

                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        private int AuthenticateUser()
        {
            UserRol r = new UserRol();
            r.user_name = txtEmail.Text;
            string enPswd = GetSwcSHA1(txtPassword.Text);
            r.password = enPswd;
            r.userID(r);
            Session["UserID"] = r.user_id;
            Session["username"] = txtEmail.Text;
            return us_ID;
        }

        public void selectUserRole()
        {
            UserRol r = new UserRol();
            r.user_id = Convert.ToInt32(Session["UserID"]);
            r.RoleName(r);
            Session["Rolename"] = r.role_name;
            Session["company_id"] = r.company_id;
            Session["branch_id"] = r.branch_id;
            Session["LoginuserName"] = r.loginUsername;
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
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            loginmethode();
        }

        #endregion

       
    }
}