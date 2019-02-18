using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IMSBLL.EntityModel;
using IMSBLL.DAL;
using System.Text;
using System.Drawing;
using System.Web.Security;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;

namespace IMS
{
    public partial class PurchaseManger : System.Web.UI.MasterPage
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        int companyId;
        int branchId;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                companyId = Convert.ToInt32(Session["company_id"]);
                branchId = Convert.ToInt32(Session["branch_id"]); 
                if (!IsPostBack)
                {
                    selected();
                    companyname();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

       
        public void companyname()
        {
            //UserRol r = new UserRol();
            //r.user_id = Convert.ToInt32(Session["UserID"]);
            //////Shakeeb
            //////r.All2(r);

            //tbl_company c = new tbl_company();
            //c.company_id = Convert.ToInt32(Session["company_id"]);
            //////c.All12(c);
            var logo = context.tbl_company.Where(w => w.company_id == companyId).SingleOrDefault();
            string role = Convert.ToString(Session["Rolename"]);
            try
            {
                if (Session["LoginuserName"] != null)
                {
                    lblusername.Text = Session["LoginuserName"].ToString();
                }
                if (role == "Manager")
                {
                    lidashboard.Visible = true;
                    li2.Visible = true;
                }
                if (logo.logo != null )
                {
                    if (File.Exists(Server.MapPath(logo.logo)))
                    {
                        imglogo.ImageUrl = logo.logo;
                    }
                    else
                    {
                        imglogo.Visible = false;
                        lblIms.Visible = true;
                    }
                }
                else
                {
                    imglogo.Visible = false;
                    lblIms.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            //lblHeading.Text=
        }

        public void selected()
        {
            String activepage = Request.RawUrl;
           if (activepage.Contains("Purchase.aspx"))
            {
                lipurchase.Attributes["class"] = "selected";
            }
            else if (activepage.Contains("PurchaseReport.aspx"))
            {
                li1.Attributes["class"] = "selected";
            }
            else if (activepage.Contains("PurchaseReturn.aspx"))
            {
                lipurchasereturn.Attributes["class"] = "selected";
            }
          
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            try
            {
                FormsAuthentication.SignOut();
                FormsAuthentication.RedirectToLoginPage();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
    }
}