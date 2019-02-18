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

namespace IMS.Sales
{
    public partial class printsale : System.Web.UI.Page
    {
        /// <summary>
        /// Objects That are used in coding
        /// </summary>
        SqlHelper helper = new SqlHelper();
        IMS_TESTEntities context = new IMS_TESTEntities();
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
        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>
        #region Methods
        public void bindgrid()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sp_Selectsaleproduct";
            cmd.Parameters.AddWithValue("@sale_id", a);

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
        //    SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.CommandText = "sp_selectcompanylogo";
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@company_id", Convert.ToInt32(Session["company_id"]));
        //    cmd.Connection = con1;
            try
            {
                //cmd.CommandTimeout = 600000;
                //con1.Open();
                //byte[] bytes = (byte[])cmd.ExecuteScalar();
                //string strBase64 = Convert.ToBase64String(bytes);
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
                } //"data:Image/png;base64," + strBase64;
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
            var sale = (from p in context.tbl_sale
                        join sd in context.tbl_SalePaymentDetails on p.sale_id equals sd.SaleId
                        join c in context.tbl_party on p.party_id equals c.party_id
                            join company in context.tbl_company on p.company_id equals company.company_id
                        where p.sale_id == a && p.company_id == companyId && p.status == true && c.party_type == "Customer"
                            select new
                            {
                                PartyId = p.party_id,
                                actualamount = sd.SubTotal,
                                createdate = p.created_date,
                                discount = sd.DiscountAmount,
                                po_no = p.sale_id,
                                total = sd.GrandTotal,
                                totalTax = sd.TaxAmount,
                                name = c.party_name,
                                balanceamt = sd.BalanceAmnt,
                                givenamt = sd.GivenAmnt,
                                companyName = company.company_name,
                                address = company.company_address,
                                partyaddress = c.party_address,
                                partyname = c.party_name,
                                owneremail = company.owner_emailid,
                                pincode = company.pincode
                            }).SingleOrDefault();
            //tbl_sale p = new tbl_sale();
            //p.company_id = c_id;
            //p.sale_id = a;
            ////Shakeeb
            ////p.All3(p);
            //Scompany c = new Scompany();
            //c.company_id = Convert.ToInt32(Session["company_id"]);
            //c.All(c);
            lblAddress.Text = sale.address;
            lblemail.Text = sale.owneremail;
            lblzipcode.Text = sale.pincode;
            //int p_id = Convert.ToInt32(p.party_id);
            //tbl_party pa = new tbl_party();
            //pa.company_id = c_id;
            //pa.branch_id = b_id;
            //pa.party_id = p_id;
            //pa.party_type = "Customer";
            /////Shakeeb 
            ////pa.All3(pa);
            ////lbldate.Text = p.date;
            lblpartyname.Text = sale.partyname;
            lblpartyaddress.Text = sale.partyaddress;
            
            lblinvoiceno.Text = sale.po_no.ToString();
            lblsubtotal.Text = sale.actualamount.ToString();
            lblTaxAmount.Text = sale.totalTax.ToString();
            lblDiscountAmt.Text = sale.discount.ToString();
            lblCompanyName.Text = sale.companyName;
            lblGrandTotal.Text = sale.total.ToString();

        }
        #endregion
    }
}