using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.ErrorPages
{
    public partial class DefaultError : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["ErrorId"]!= null)
            {
                lblErrorID.InnerText = Session["ErrorId"].ToString();
            }
        }
    }
}