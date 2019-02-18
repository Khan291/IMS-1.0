using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IMSBLL.EntityModel;
using System.Net.Mail;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;
using IMSBLL;
using IMSBLL.DAL;
using System.IO;
using System.Net;

namespace IMS.Subscription
{
    public partial class Pricing : System.Web.UI.Page
    {

        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlHelper helper = new SqlHelper();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                getplan();
            }
            catch(Exception c)
            {
                ErrorLog.saveerror(c);
            }
        }
        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        public void getplan()
        {
            DataTable dt = new DataTable();
            var result = context.sp_planall();
            dt = helper.LINQToDataTable(result);
            DataRow row1 = dt.Rows[0];
            string rowValue = row1["plan_name"].ToString();
            string rowValue4 = row1["price"].ToString();
            string rowValue7 = row1["duration"].ToString();

            DataRow row2 = dt.Rows[1];
            string rowValue2 = row2["plan_name"].ToString();
            string rowValue5 = row2["price"].ToString();
            string rowValue8 = row2["duration"].ToString();

            DataRow row3 = dt.Rows[2];
            string rowValue3 = row3["plan_name"].ToString();
            string rowValue6 = row3["price"].ToString();
            string rowValue9 = row3["duration"].ToString();
            

            lblName1.Text = rowValue;
            lblName2.Text = rowValue2;
            lblName3.Text = rowValue3;

            lblPrice1.Text = rowValue4;
            lblPrice2.Text = rowValue5;
            lblPrice3.Text = rowValue6;

            lblDuration1.Text = rowValue7;
            lblDuration2.Text = rowValue8;
            lblDuration3.Text = rowValue9;

        }
        #endregion
    }
}