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
using System.Collections;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;

namespace IMS
{
    public partial class Main : System.Web.UI.MasterPage
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                selected();
                companyname();
                F_yearcheck();
                Role();
            }
        }
        //public void Test(string PageName)
        //{
        //    try
        //    {
        //        if (PageName == "Product")
        //        {
        //            ifm.Attributes.Add("src", "../Masters/Product.aspx");
        //        }
        //        ifm.Visible = true;
        //        //ifm.Attributes.Add("src", "../Masters/Product.aspx");
        //        //main.Visible = false;
        //        bMaster.Visible = true;
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLog.saveerror(ex);
        //    }

        //}
        public void F_yearcheck()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "sp_last15daysf_year";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandTimeout = 600000;
            con.Open();
            var mcid = 0;
            int end_days = 0;
            int days_flag = 0;
            int c_id = Convert.ToInt32(Session["company_id"]);
            try
            {
                if (c_id != 0)
                {
                    cmd.Parameters.AddWithValue("@company_id", c_id);
                    cmd.Parameters.Add("@days_flag", SqlDbType.Int);
                    cmd.Parameters["@days_flag"].Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("@enddays_flag", SqlDbType.Int);
                    cmd.Parameters["@enddays_flag"].Direction = ParameterDirection.Output;
                    cmd.Parameters.AddWithValue("@s_date", "2018-05-15 18:47:00");
                    cmd.Parameters.Add("@days_left", SqlDbType.Int);
                    cmd.Parameters["@days_left"].Direction = ParameterDirection.Output;
                    cmd.ExecuteNonQuery();                    
                    if (!(cmd.Parameters["@days_left"].Value is DBNull))
                        mcid = Convert.ToInt32(cmd.Parameters["@days_left"].Value);                   
                    if (!(cmd.Parameters["@enddays_flag"].Value is DBNull))
                        end_days = Convert.ToInt32(cmd.Parameters["@enddays_flag"].Value);                   
                    if (!(cmd.Parameters["@days_flag"].Value is DBNull))
                        days_flag = Convert.ToInt32(cmd.Parameters["@days_flag"].Value);
                    if (days_flag == 1)
                    {                    
                        Session["mcid"] = 1;
                        Session["days"] = mcid;
                        //msg.Visible = true;
                        //notify.Visible = true;
                        //lblnotification.Text = "1";
                       // lblF_year.Text = "Your Current Financial Year Is Ending In "  + mcid+ " Day's";
                        //ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert('Your Current Financial Year Is Ending In  Days','False');", true);
                    }
                   
                }


            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            finally
            {
                if (con != null && con.State != ConnectionState.Closed)
                {
                    con.Close();
                }
            }
        }
        public void companyname()
        {
            tbl_company r = new tbl_company();
            var company_id=Convert.ToInt32(Session["company_id"]);
            r = context.tbl_company.Where(w => w.company_id == company_id).SingleOrDefault();
            try
            {
                if (Session["LoginuserName"] != null)
                {
                    lblusername.Text = Session["LoginuserName"].ToString();
                }
                if (r.logo != null)
                {
                    if (File.Exists(Server.MapPath(r.logo)))
                    {
                        imglogo.ImageUrl = r.logo;
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
           if (activepage.Contains("Index.aspx"))
           {
               liindex.Attributes["class"] = "selected";
           }
           //else if (activepage.Contains("Company.aspx"))
           //{
           //    licompany.Attributes["class"] = "selected";
           //}
           //else if (activepage.Contains("Branch.aspx"))
           //{
           //    libranch.Attributes["class"] = "selected";
           //}
           else if (activepage.Contains("Master.aspx"))
           {
               limaster.Attributes["class"] = "selected";
           }
           else if (activepage.Contains("Sale.aspx"))
           {
               lisale.Attributes["class"] = "selected";
           }
           else if (activepage.Contains("Purchase.aspx"))
           {
               lipurchase.Attributes["class"] = "selected";
           }
           else if (activepage.Contains("PurchaseReturn.aspx"))
           {
               lipurchasereturn.Attributes["class"] = "selected";
           }
           else if (activepage.Contains("salesReturn.aspx"))
           {
               lisalereturn.Attributes["class"] = "selected";
           }
        }

        public void Role()
        {
            if (Session["Rolename"] != null)
            {
                string role = string.Empty;
                role = Convert.ToString(Session["Rolename"]);

                if (role =="Sales Manager")
                {
                    limaster.Visible = false;
                    lipurchase.Visible = false;
                    lipurchaseReport.Visible = false;
                    lipurchasereturn.Visible = false;
                    liindex.Visible = false;
                    li1.Visible = false;
                }
                else if (role == "Purchase Manager")
                {
                    limaster.Visible = false;
                    lisale.Visible = false;
                    lisaleReport.Visible = false;
                    lisalereturn.Visible = false;
                    liindex.Visible = false;
                    li1.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            try
            {
                int user_id = Convert.ToInt32(Session["UserID"]);
                UpdateIsLogin(user_id);
                FormsAuthentication.SignOut();
                FormsAuthentication.RedirectToLoginPage();
                Session.Clear();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        public void UpdateIsLogin(int userid)
        {
            try
            {
                context.tbl_User.FirstOrDefault();
                var userdata = context.tbl_User.SingleOrDefault(u => u.user_id == userid);
                if (userdata != null)
                {
                    userdata.Islogin = false;
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }



    }
}