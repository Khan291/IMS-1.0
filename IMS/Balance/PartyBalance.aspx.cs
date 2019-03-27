using IMSBLL.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMS.Balance
{
    public partial class PartyBalance : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                gridBind();
            }

        }

        public void gridBind()
        {
            try
            {
                int companyID = 0;
                int branchId = 0;
                if (Session["company_id"] != null && Session["branch_id"] != null)
                {
                    companyID = Convert.ToInt32(Session["company_id"]);
                    branchId = Convert.ToInt32(Session["branch_id"]);
                }

                var PartyDetails = (from s in context.tbl_party
                                    join p in context.tbl_purchase on s.party_id equals p.party_id
                                    join g in context.tbl_PurchasePaymentDetials on p.purchase_id equals g.PurchaseId
                                    where s.branch_id == branchId && s.company_id == companyID && s.status == true
                                    group s by new {s.party_name,s.contact_no,s.party_id,g.BalanceAmnt} into f
                                    select new
                                    {
                                        //s.party_id,
                                        //s.company_id,
                                        //s.party_name,
                                        //s.status,
                                        //s.branch_id,
                                        //f.Sum(d=>d.
                                        
                                    }).ToList();
                decimal balanceAmnt = 0;//Convert.ToDecimal(PartyDetails.Select(p=> p.BalanceAmnt).Sum());
                if (PartyDetails != null)
                {
                    gvPartyDetails.DataSource = PartyDetails;
                    gvPartyDetails.DataBind();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
    }
}