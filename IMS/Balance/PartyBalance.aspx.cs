using IMSBLL.DAL;
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
            btnPay.Visible = false;
            if (!Page.IsPostBack)
            {
                gridBind("v");
            }
        }
        public void gridBind(string flage)
        {
            try
            {
                int companyID = 0;
                int branchId = 0;
                dynamic PartyDetails = "";
                if (Session["company_id"] != null && Session["branch_id"] != null)
                {
                    companyID = Convert.ToInt32(Session["company_id"]);
                    branchId = Convert.ToInt32(Session["branch_id"]);
                }
                if (flage == "v")
                {
                    PartyDetails = (from s in context.tbl_PurchasePaymentDetials
                                    join p in context.tbl_purchase on s.PurchaseId equals p.purchase_id
                                    join g in context.tbl_party on p.party_id equals g.party_id
                                    where g.branch_id == branchId && g.company_id == companyID && g.status == true && s.BalanceAmnt != 0
                                    group s by new { g.party_name, g.party_id, g.status, g.branch_id }
                                    into f
                                    select new clspd
                                    {
                                        party_id = f.Key.party_id,
                                        party_name = f.Key.party_name,
                                        branch_id = f.Key.branch_id,
                                        status = f.Key.status,
                                        BalanceAmnt = f.Sum(s => s.BalanceAmnt),
                                        message = (f.Sum(s => s.BalanceAmnt) > 0) ? "Amount to be Paid" : "Amount to be Received"
                                    }).ToList();
                }
                else
                {
                    PartyDetails = (from spd in context.tbl_SalePaymentDetails
                                    join s in context.tbl_sale on spd.SaleId equals s.sale_id
                                    join g in context.tbl_party on s.party_id equals g.party_id
                                    where g.branch_id == branchId && g.company_id == companyID && g.status == true && spd.BalanceAmnt != 0
                                    group spd by new { g.party_name, g.party_id, g.status, g.branch_id }
                                    into f
                                    select new clspd
                                    {
                                        party_id = f.Key.party_id,
                                        party_name = f.Key.party_name,
                                        branch_id = f.Key.branch_id,
                                        status = f.Key.status,
                                        BalanceAmnt = f.Sum(s => s.BalanceAmnt),
                                        message = (f.Sum(s => s.BalanceAmnt) > 0) ? "Amount to be Received" : "Amount to be Paid"
                                    }).ToList();
                }
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

        protected void gvPartyDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvPartyDetails_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvPartyDetails.Rows.Count > 0)
                {
                    gvPartyDetails.UseAccessibleHeader = false;
                    gvPartyDetails.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvPartyDetails.FooterRow.TableSection = TableRowSection.TableFooter;
                    int CellCount = gvPartyDetails.FooterRow.Cells.Count;
                    gvPartyDetails.FooterRow.Cells.Clear();
                    gvPartyDetails.FooterRow.Cells.Add(new TableCell());
                    gvPartyDetails.FooterRow.Cells[0].ColumnSpan = CellCount - 1;
                    gvPartyDetails.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                    gvPartyDetails.FooterRow.Cells.Add(new TableCell());

                    TableFooterRow tfr = new TableFooterRow();
                    for (int i = 0; i < CellCount; i++)
                    {
                        tfr.Cells.Add(new TableCell());
                    }
                    gvPartyDetails.FooterRow.Controls[1].Controls.Add(tfr);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
            
        }

        protected void gvPartyDetails_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvPartyDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewAll")
            {
                lblAmtToBePaid.Text = "0.00";
                dvpartyInvoiceDetails.Visible = true;
                int partyId = Convert.ToInt32(e.CommandArgument);
                dynamic PartyInvoiceDetails = "";
                if (rbtnVender.Checked == true)
                {
                    PartyInvoiceDetails = (from ppd in context.tbl_PurchasePaymentDetials
                                           join p in context.tbl_purchase on ppd.PurchaseId equals p.purchase_id
                                           where p.party_id == partyId && ppd.BalanceAmnt != 0
                                           select new clspd
                                           {
                                               Id = ppd.Id,
                                               ps_id = p.purchase_id,
                                               party_id = p.party_id,
                                               InvoiceNumber = p.InvoiceNumber,
                                               SubTotal = ppd.SubTotal,
                                               TaxAmount = ppd.TaxAmount,
                                               GrandTotal = ppd.GrandTotal,
                                               PaidAmnt = ppd.PaidAmnt,
                                               BalanceAmnt = ppd.BalanceAmnt,
                                               message = (ppd.BalanceAmnt > 0) ? "Amount to be Paid" : "Amount to be Received"
                                           }).ToList();

                    gridBind("v");
                }
                else
                {
                    PartyInvoiceDetails = (from spd in context.tbl_SalePaymentDetails
                                           join s in context.tbl_sale on spd.SaleId equals s.sale_id
                                           where s.party_id == partyId && spd.BalanceAmnt != 0
                                           select new clspd
                                           {
                                               Id = spd.Id,
                                               ps_id = s.sale_id,
                                               party_id = s.party_id,
                                               InvoiceNumber = s.InvoiceNumber,
                                               SubTotal = spd.SubTotal,
                                               TaxAmount = spd.TaxAmount,
                                               GrandTotal = spd.GrandTotal,
                                               PaidAmnt = spd.PaidAmnt,
                                               BalanceAmnt = spd.BalanceAmnt,
                                               message = (spd.BalanceAmnt > 0) ? "Amount to be Received" : "Amount to be Paid"
                                           }).ToList();
                    gridBind("c");
                }
               
                gvPartyInvoiceDetails.DataSource = PartyInvoiceDetails;
                gvPartyInvoiceDetails.DataBind();
                GridViewRow rowindex = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                lblPartyName.Text = rowindex.Cells[2].Text + "'s Invoice wise details of amount to be Paid/Received";
            }
        }

        protected void gvPartyInvoiceDetails_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvPartyInvoiceDetails.Rows.Count > 0)
                {
                    gvPartyInvoiceDetails.UseAccessibleHeader = false;
                    gvPartyInvoiceDetails.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvPartyInvoiceDetails.FooterRow.TableSection = TableRowSection.TableFooter;
                    int CellCount = gvPartyInvoiceDetails.FooterRow.Cells.Count;
                    gvPartyInvoiceDetails.FooterRow.Cells.Clear();
                    gvPartyInvoiceDetails.FooterRow.Cells.Add(new TableCell());
                    gvPartyInvoiceDetails.FooterRow.Cells[0].ColumnSpan = CellCount - 1;
                    gvPartyInvoiceDetails.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                    gvPartyInvoiceDetails.FooterRow.Cells.Add(new TableCell());

                    TableFooterRow tfr = new TableFooterRow();
                    for (int i = 0; i < CellCount; i++)
                    {
                        tfr.Cells.Add(new TableCell());
                    }
                    gvPartyInvoiceDetails.FooterRow.Controls[1].Controls.Add(tfr);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void gvPartyInvoiceDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            try
            {                
                string userName = Session["username"].ToString();
                foreach (GridViewRow row in gvPartyInvoiceDetails.Rows)
                {
                    var chb = row.FindControl("chbCheck") as CheckBox;
                    if (chb.Checked)
                    {
                        dynamic tblPaymentDetails = "";
                        var id = 0; 
                        if (rbtnVender.Checked == true)
                        {
                            id = Convert.ToInt32(row.Cells[2].Text);
                            tblPaymentDetails = (from ppd in context.tbl_PurchasePaymentDetials
                                                 join p in context.tbl_purchase on ppd.PurchaseId equals p.purchase_id
                                                 where p.purchase_id == id
                                                 select ppd).ToList().FirstOrDefault();
                            tblPaymentDetails.FromTable = Constants.VendorPayBalance;
                        }
                        else
                        {
                            id = Convert.ToInt32(row.Cells[2].Text);
                            tblPaymentDetails = (from spd in context.tbl_SalePaymentDetails
                                                 join s in context.tbl_sale on spd.SaleId equals s.sale_id
                                                 where s.sale_id == id
                                                 select spd).ToList().FirstOrDefault();
                            tblPaymentDetails.FromTable = Constants.CustomerPayBalance;
                        }
                        decimal BalAmnt = tblPaymentDetails.BalanceAmnt;
                        decimal GivenAmnt = tblPaymentDetails.GivenAmnt;
                        GivenAmnt = GivenAmnt + BalAmnt;
                        tblPaymentDetails.BalanceAmnt = 0;
                        tblPaymentDetails.GivenAmnt = GivenAmnt;
                        tblPaymentDetails.ModifiedDate = DateTime.Now;
                        tblPaymentDetails.ModifiedBy = userName;
                        context.SaveChanges();
                        dvpartyInvoiceDetails.Visible = false;
                        if(rbtnVender.Checked == true)
                        {
                            gridBind("v");
                        }
                        else
                        {
                            gridBind("c");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void chbCheck_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                var amntToBePaid = 0.00;
                btnPay.Visible = true;
                int rowCount = gvPartyInvoiceDetails.Rows.Count;
                int cbCount = 0;
                var CheckBox = gvPartyInvoiceDetails.HeaderRow.FindControl("checkAll") as CheckBox;
                foreach (GridViewRow row in gvPartyInvoiceDetails.Rows)
                {
                    var chb = row.FindControl("chbCheck") as CheckBox;
                    if (chb.Checked)
                    {
                        amntToBePaid += Convert.ToDouble(row.Cells[9].Text);
                        cbCount ++;
                    }
                    lblAmtToBePaid.Text = amntToBePaid.ToString();
                    if(cbCount == rowCount)
                    {
                        CheckBox.Checked = true;
                    }
                    else
                    {
                        CheckBox.Checked = false;
                    }
                }
                if (0 == Convert.ToInt32(lblAmtToBePaid.Text))
                {
                    btnPay.Visible = false;
                }
                else
                {
                    btnPay.Visible = true;
                }
                if (0 > Convert.ToInt32(lblAmtToBePaid.Text))
                {
                    btnPay.Text = "Get Refund";
                }
                else
                {
                    btnPay.Text = "Pay";
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void checkAll_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                var amntToBePaid = 0.00;
                btnPay.Visible = true;
                var chbAll = gvPartyInvoiceDetails.HeaderRow.FindControl("checkAll") as CheckBox;
                if (chbAll.Checked)
                {
                    foreach (GridViewRow row in gvPartyInvoiceDetails.Rows)
                    {
                        var chb = row.FindControl("chbCheck") as CheckBox;
                        chb.Checked = true;
                        amntToBePaid += Convert.ToDouble(row.Cells[9].Text);
                    }
                    lblAmtToBePaid.Text = amntToBePaid.ToString();
                }
                else
                {
                    btnPay.Visible = false;
                    foreach (GridViewRow row in gvPartyInvoiceDetails.Rows)
                    {
                        var chb = row.FindControl("chbCheck") as CheckBox;
                        chb.Checked = false;
                    }
                    lblAmtToBePaid.Text = amntToBePaid.ToString();
                }
                if (0 > Convert.ToInt32(lblAmtToBePaid.Text))
                {
                    btnPay.Text = "Get Refund";
                }
                else
                {
                    btnPay.Text = "Pay";
                }

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }

        protected void rbtnVender_CheckedChanged(object sender, EventArgs e)
        {
            dvpartyInvoiceDetails.Visible = false;
            gridBind("v");
        }

        protected void rbtnCustomer_CheckedChanged(object sender, EventArgs e)
        {
            dvpartyInvoiceDetails.Visible = false;
            gridBind("c");
        }
    }

    internal class clspd
    {
        public int? party_id { get; set; }
        public int product_id { get; set; }
        public string party_name { get; set; }
        public bool? status { get; set; }
        public int? branch_id { get; set; }
        public decimal? BalanceAmnt { get; set; }
        public string message { get; set; }


        public int? Id { get; set; }
        public int? ps_id { get; set; }
        public string InvoiceNumber { get; set; }
        public decimal? SubTotal { get; set; }
        public decimal? TaxAmount { get; set; }
        public decimal? GrandTotal { get; set; }
        public decimal? PaidAmnt { get; set; }

    }
}