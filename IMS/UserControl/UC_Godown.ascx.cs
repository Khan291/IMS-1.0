using IMSBLL.DAL;
using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.UserControl
{
    public partial class UC_Godown : System.Web.UI.UserControl
    {

        #region properties
        // declaration of properties for taking category name and ID from category.aspx for update functionality
        public string godownID
        {
            set { hdgodownid.Value = value; }
        }
        public string godownname
        {
            get { return txtGodownName.Text; }
            set
            {
                txtGodownName.Text = value;
                if (txtGodownName.Text != "")
                {
                    btngodwnUpdate.Visible = true;
                    btngodwnSave.Visible = false;
                }
                else
                {
                    btngodwnSave.Visible = true;
                    btngodwnUpdate.Visible = false;
                }
            }

        }
        public string godownaddress
        {
            set { txtGodownAddress.Text = value; }
        }
        public string contactno
        {
            set { txtContactNo.Text = value; }
        }
        public string contactperson
        {
            set { txtContactPerson.Text = value; }
        }
        #endregion
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        int companyId;
        int branchId;
        #endregion

        #region Methods


        public void clr()
        {
            txtContactNo.Text = string.Empty;
            txtContactPerson.Text = string.Empty;
            txtGodownAddress.Text = string.Empty;
            txtGodownName.Text = string.Empty;
        }
        [System.Web.Services.WebMethod]
        public static string CheckDouble(string useroremail)
        {
            try
            {
                if (HttpContext.Current.Session["company_id"] != null)
                {
                    SqlHelper helper = new SqlHelper();
                    DataTable data = helper.CheckDoubleValues(Convert.ToInt32(HttpContext.Current.Session["company_id"]), Convert.ToInt32(HttpContext.Current.Session["branch_id"]), "tbl_godown", "godown_name", useroremail);
                    if (data.Rows.Count > 0)
                    {
                        return "true";
                    }
                    else
                    {
                        return "false";
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            return "true";
        }

        private string CheckDoubleFromDb(string ValueToCheck)
        {
            return "";
        }
        public void savedlogic()
        {
            string User_id = Convert.ToString(Session["UserID"]);
            try
            {
                if (CheckDouble(txtGodownName.Text) == "false")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    tbl_godown g = new tbl_godown();
                    g.company_id = companyId;
                    g.branch_id = branchId;
                    g.godown_name = txtGodownName.Text;
                    g.godown_address = txtGodownAddress.Text;
                    g.contact_no = txtContactNo.Text;
                    g.contact_person = txtContactPerson.Text;
                    //g.created_by = "admin";
                    g.created_by = User_id;
                    g.created_date = DateTime.Today;
                    g.status = true;
                    g.modified_by = "";
                    g.modified_date = null;
                    ////Shakeeb
                    ////g.AddGodown(g);
                    //Entity Framework Saving Awais
                    context.tbl_godown.Add(g);
                    context.SaveChanges();
                    clr();
                    divalert.Visible = true;
                    lblAlert.Text = "Godown Saved Successfully";
                    ((Godown)this.Page).loadDataTable();
                    List<tbl_godown> gd = context.tbl_godown.Where(x => x.status == true && x.company_id == companyId).ToList();
                 
                    UC_Rack r = new UC_Rack();
                    r.fillgodown(gd);
                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Godown name already Exists";
                    return;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        public void updatelogic()
        {
            try
            {
                if (hd.Value != "true")
                {
                    lblcheckDoubleError.Text = String.Empty;
                    int godown_id = Convert.ToInt32(hdgodownid.Value);
                    context.sp_UpdateGodown(companyId, branchId, godown_id, txtGodownName.Text, txtGodownAddress.Text, txtContactNo.Text, txtContactPerson.Text, Convert.ToString(Session["UserID"]), DateTime.Today);
                    clr();
                    divalert.Visible = true;
                    lblAlert.Text = "Godown Updated Successfully";
                    ((Godown)this.Page).loadDataTable();                  

                }
                else
                {
                    divalert.Visible = false;
                    lblcheckDoubleError.ForeColor = System.Drawing.Color.Red;
                    lblcheckDoubleError.Text = "This Godown name already Exists";
                    return;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        #endregion

        #region events

        protected void Page_Load(object sender, EventArgs e)
        {
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }
        
        protected void btngodwnSave_Click(object sender, EventArgs e)
        {
            savedlogic();
        }

        protected void btngodwnUpdate_Click(object sender, EventArgs e)
        {
            updatelogic();
        }
        #endregion
    }
}