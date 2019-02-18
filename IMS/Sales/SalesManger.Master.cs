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

namespace IMS.Sales
{
    public partial class SalesManger : System.Web.UI.MasterPage
    {
        /// <summary>
        /// All The Objects That are used in coding
        /// </summary>
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        int companyId;
        int branchId;
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();
            if (!IsPostBack)
            {
               
                selected();
                companyname();
            }
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>
        #region
        private void SessionValue()
        {
           // User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }
        public void companyname()
        {
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
                if (logo.logo != null)
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
            if (activepage.Contains("Sale.aspx"))
            {
                lisale.Attributes["class"] = "selected";
            }
            else if (activepage.Contains("SalesReport.aspx"))
            {
                lisalesreport.Attributes["class"] = "selected";
            }
            else if (activepage.Contains("salesReturn.aspx"))
            {
                lisalereturn.Attributes["class"] = "selected";
            }

        }

        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>
        #region
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
        #endregion
    }
}