using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IMSBLL.EntityModel;
using System.IO;
using IMSBLL.DAL;
using System.Configuration;
using System.Data.Entity;

namespace IMS
{
    public partial class Company : System.Web.UI.Page
    {
        /// <summary>
        /// All The objects That are used in coding
        /// </summary>
        #region object
        IMS_TESTEntities context = new IMS_TESTEntities();
        //initialize service object
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    cntrybind();
                    statebind();
                    binddata();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        /// <summary>
        /// All The Methods That are used in coding
        /// </summary>

        #region Methods
        public void cntrybind()
        {
            List<tbl_country> gd = context.tbl_country.Where(x => x.status == true).ToList();
            ddlcountry.DataTextField = "country_name";
            ddlcountry.DataValueField = "country_id";
            ddlcountry.DataSource = gd;
            ddlcountry.DataBind();
            ddlcountry.Items.Insert(0, new ListItem("--Select Country--", "0"));
        }
        public void statebind()
        {
            List<tbl_state> gd = context.tbl_state.Where(x => x.status == true).ToList();
            ddlState.DataTextField = "state_name";
            ddlState.DataValueField = "state_id";
            ddlState.DataSource = gd;
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
        }
        public void binddata()
        {
            try
            {
                Scompany c = new Scompany();
                c.company_id = Convert.ToInt32(Session["company_id"]);
                c.All(c);

               
                txtName.Text = c.company_name;
                txtAddress.Text = c.company_address;
                ddlcountry.SelectedValue = c.country_name;
                ddlState.SelectedValue = c.state_name;
                txtCity.Text = c.city;
                txttelephoneno.Text = c.telephone_no;
                txtpincode.Text = c.pincode;
                txtGSTIN.Text = c.GSTIN;
                txtFaxno.Text = c.fax_no;
                txtwebsite.Text = c.website;
                txtOwnername.Text = c.first_name;
                txtOwnerEmail.Text = c.owner_emailid;
                txtownermobileno.Text = c.owner_mobileno;

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        public void savedlogic()
        {
            try
            {

                int a = Convert.ToInt32(Session["company_id"]);
                int s = Convert.ToInt32(ddlState.SelectedValue);
                string user = Session["UserID"].ToString();
                SqlCommand cmd = new SqlCommand();

                if (fileuplogo.HasFile)
                {
                    HttpPostedFile postedFile = fileuplogo.PostedFile;
                    string filename = Path.GetFileName(postedFile.FileName);
                    string fileExtension = Path.GetExtension(filename);
                    int fileSize = postedFile.ContentLength;

                    if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png")
                    {
                        //Stream stream = postedFile.InputStream;
                        //BinaryReader binaryReader = new BinaryReader(stream);
                        //Byte[] bytes = binaryReader.ReadBytes((int)stream.Length);

                         fileuplogo.SaveAs(Server.MapPath("~/Uploads/" + filename));
                         string imagepath = "~/Uploads/" + filename;

                        tbl_company company = new tbl_company();
                        company.company_id = a;
                        company.company_name = txtName.Text;
                        company.company_address = txtAddress.Text;
                        company.state_id = s;
                        company.city = txtCity.Text;
                        company.telephone_no = txttelephoneno.Text;
                        company.fax_no = txtFaxno.Text;
                        company.website = txtwebsite.Text;
                        company.logo = imagepath;
                        company.logo_name = filename;
                        company.GSTIN = txtGSTIN.Text;
                        company.modified_by = user;
                        company.modified_date = DateTime.Now;


                        context.Entry(company).State = EntityState.Modified;
                        context.SaveChanges();

                        //context.tbl_company.(company);
                        //context.SaveChanges();

                    }
                }

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        #endregion

        /// <summary>
        /// All The Events That are used in coding
        /// </summary>

        #region Events
        protected void btnSave_Click(object sender, EventArgs e)
        {
            savedlogic();
        }
        #endregion
    }
}