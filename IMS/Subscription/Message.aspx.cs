using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IMSBLL.EntityModel;
using IMSBLL.DAL;
using System.Configuration;

namespace IMS.Subscription
{
    public partial class Message : System.Web.UI.Page
    {
        int success = 0;

        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (success == 1)
            {
                result();
                
            }
            else
            {
                failuerdiv.Visible = true;
                successdiv.Visible = false;
            }
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        private void result()
        {
            decimal paidamount = 0;
            int c_id = Convert.ToInt32(Session["company_id"]);
            int u_id = Convert.ToInt32(Session["UserID"]);
            int p_id = 0;
            int t_id = 0;
            DateTime s_date=DateTime.Now;

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "sp_Salesinsert";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandTimeout = 600000;
            con.Open();
            cmd.Parameters.AddWithValue("@company_id", c_id);
            cmd.Parameters.AddWithValue("@user_id", u_id);
            cmd.Parameters.AddWithValue("@plan_id", p_id);
            cmd.Parameters.AddWithValue("@transaction_id", t_id);
            cmd.Parameters.AddWithValue("@paidamount", paidamount);
            cmd.Parameters.AddWithValue("@start_date", s_date);
            cmd.ExecuteNonQuery();
        }
        #endregion
    }
}