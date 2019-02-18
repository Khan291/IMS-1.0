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
using System.IO;

namespace IMS
{
    public partial class PrintPurchase : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlHelper helper = new SqlHelper();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        int a;
        int companyId;
        int branchId;
        string User_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionValue();
            if (!IsPostBack)
            {
            if (Request.QueryString["id"] != null)
            {
                a = Convert.ToInt32(Request.QueryString["id"]);
            }
              
            bindgrid();
            pagebind();
            logo();
        }
        }

        private void SessionValue()
        {
            User_id = Convert.ToString(Session["UserID"]);
            companyId = Convert.ToInt32(Session["company_id"]);
            branchId = Convert.ToInt32(Session["branch_id"]);
        }
        public void bindgrid()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_SelectProductbyid";
            cmd.Parameters.AddWithValue("@purchsae_id", a);

            cmd.Connection = con;

            try
            {

                con.Open();
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                Session["table"] = ds.Tables[0]; ;
                GridView1.DataSource = (DataTable)Session["table"];
                GridView1.DataBind();
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
        }

        public void logo()
        {
            var logo=context.tbl_company.Where(w=> w.company_id==companyId).SingleOrDefault();
          
            try
            {
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
                //con1.Close();
                //con1.Dispose();
            }
        }
        public void pagebind()
        {
          
            ////Shakeeb
            ////p.All2(p);
            var purchase= (from p in  context.tbl_purchase
            join c in  context.tbl_party on p.party_id equals c.party_id
                           join pd in context.tbl_PurchasePaymentDetials on p.purchase_id equals pd.PurchaseId
                           join company in context.tbl_company on p.company_id equals company.company_id
                           where p.purchase_id == a && p.company_id == companyId && p.status == true && c.party_type == "Vendor"
                          select new { PartyId = p.party_id, actualamount = pd.SubTotal, createdate = p.created_date, discount = pd.DiscountAmount, po_no = p.po_no
                          ,
                                       total = pd.GrandTotal,
                                       totalTax = pd.TaxAmount,
                                       name = c.party_name,
                                       balanceamt = pd.BalanceAmnt,
                                       givenamt = pd.GivenAmnt,
                                       companyName=company.company_name,
                                       address=company.company_address,
                                       partyaddress=c.party_address,
                                       partyname=c.party_name,
                                       owneremail=company.owner_emailid,
                                       pincode=company.pincode,
                                       invoiceNumber=p.InvoiceNumber
                          }).SingleOrDefault();

            if (purchase != null)
            {
                lblCompanyName.Text = purchase.companyName;
                lblAddress.Text = purchase.address;
                lblemail.Text = purchase.owneremail;
                lblzipcode.Text = purchase.pincode;
                int p_id = Convert.ToInt32(purchase.PartyId);

                lbldate.Text = purchase.createdate.ToString();
                lblpartyname.Text = purchase.partyname;
                lblpartyaddress.Text = purchase.partyaddress;

                lblinvoiceno.Text = purchase.invoiceNumber.ToString();
                lblsubtotal.Text = purchase.actualamount.ToString();
                lblTaxAmount.Text = purchase.totalTax.ToString();
                lblDiscountAmt.Text = purchase.discount.ToString();
                lblGrandTotal.Text = purchase.total.ToString();
            }
                                                                                                                   
        }
    }
}