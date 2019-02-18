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

namespace IMS
{
    public partial class SalesReturn : System.Web.UI.Page
    {
        IMS_TESTEntities context = new IMS_TESTEntities();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TestDBConnection"].ConnectionString);

        int a;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    if (Session["deletdata"] == null)
                    {
                        DataTable deletedata = new DataTable();
                        deletedata.Columns.Add("sale_id");
                        deletedata.Columns.Add("row");
                        deletedata.Columns.Add("product_id");
                        deletedata.Columns.Add("batch_id");
                        deletedata.Columns.Add("tax_amt");
                        deletedata.Columns.Add("dicount_amt");
                        deletedata.Columns.Add("quantity");
                        deletedata.Columns.Add("amount");
                        deletedata.Columns.Add("price");
                        Session["deletdata"] = deletedata;
                    }

                    if (Request.QueryString["id"] != null)
                    {
                        a = Convert.ToInt32(Request.QueryString["id"]);
                    }

                    ddlVendorbind();
                    ddlproductbind();
                    ddlpaymentmodebind();
                    gridbind();
                    pagebind();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        public void ddlVendorbind()
        {
            int c_id = Convert.ToInt32(Session["company_id"]);

            List<tbl_party> cd = context.tbl_party.Where(x => x.status == true && x.company_id == c_id && x.party_type == "Customer").ToList();
            ddlVendor.DataTextField = "party_name";
            ddlVendor.DataValueField = "party_id";
            ddlVendor.DataSource = cd;
            ddlVendor.DataBind();
            ddlVendor.Items.Insert(0, new ListItem("--Select Vendor--", "0"));
        }

        public void ddlproductbind()
        {
            int c_id = Convert.ToInt32(Session["company_id"]);

            int b_id = Convert.ToInt32(Session["branch_id"]);
            List<tbl_product> cd = context.tbl_product.Where(x => x.status == true && x.company_id == c_id && x.branch_id == b_id).ToList();
            ddlproduct.DataTextField = "product_name";
            ddlproduct.DataValueField = "product_id";
            ddlproduct.DataSource = cd;
            ddlproduct.DataBind();
            ddlproduct.Items.Insert(0, new ListItem("--Select Product--", "0"));
        }


        public void ddlpaymentmodebind()
        {
            List<tbl_paymentmode> cd = context.tbl_paymentmode.Where(x => x.status == true).ToList();
            ddlPaymentMode.DataTextField = "paymentmode_name";
            ddlPaymentMode.DataValueField = "paymentode_id";
            ddlPaymentMode.DataSource = cd;
            ddlPaymentMode.DataBind();
            //ddlPaymentMode.Items.Insert(0, new ListItem("Select Payment Mode", "0"));
        }

        public void calculation(decimal amt, decimal tax, decimal dis)
        {
            decimal tot = 0;
            decimal tottax = 0;
            decimal dec = 0;
            decimal gtot = 0;
            tot = Convert.ToDecimal(lblsubtotal.Text) + amt;
            lblsubtotal.Text = tot.ToString();
            tottax = Convert.ToDecimal(lblTaxAmount.Text) + tax;
            lblTaxAmount.Text = tottax.ToString();
            dec = Convert.ToDecimal(lblDiscountAmt.Text) + dis;
            lblDiscountAmt.Text = dec.ToString();

            gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text));
            lblGrandTotal.Text = gtot.ToString();


        }

        public void updatecal()
        {
            decimal a1 = Convert.ToDecimal(lblsubtotal.Text) - Convert.ToDecimal(ViewState["subtot"]);
            decimal b1 = Convert.ToDecimal(lblDiscountAmt.Text) - Convert.ToDecimal(ViewState["dis"]);
            decimal c = Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(ViewState["taxamount"]);
            lblsubtotal.Text = a1.ToString();
            lblDiscountAmt.Text = b1.ToString();
            lblTaxAmount.Text = c.ToString();
            decimal d = (a1 + c) - b1;
            lblGrandTotal.Text = d.ToString();
        }
        public void clr()
        {
            ddlproduct.SelectedIndex = 0;
            txtprice.Text = string.Empty;
            txtquantity.Text = string.Empty;
            txtdiscount.Text = "0";
        }

        public void lblmsgwork()
        {
            if (ViewState["balanceamt"] != null)
            {
                if (Convert.ToDecimal(ViewState["balanceamt"]) > Convert.ToDecimal(lblGrandTotal.Text))
                {
                    lblmsg.Visible = true;
                    decimal amount = Convert.ToDecimal(ViewState["balanceamt"]) - Convert.ToDecimal(txtGivenAmt.Text);
                    lblmsg.Text = "Payable Amount to Customer is  " + amount.ToString();
                    txtBalanceAmt.Text = amount.ToString();
                }

                else
                {
                    lblmsg.Visible = true;
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    decimal amount = (Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(ViewState["balanceamt"])) - Convert.ToDecimal(txtGivenAmt.Text);
                    lblmsg.Text = "Receivable Amount from Customer is  " + amount.ToString();
                    txtBalanceAmt.Text = amount.ToString();
                }
            }
        }
        protected void txtGivenAmt_TextChanged(object sender, System.EventArgs e)
        {
            try
            {
                decimal a = Convert.ToDecimal(lblGrandTotal.Text) - Convert.ToDecimal(txtGivenAmt.Text);
                lblmsgwork();

                UpdatePanel2.Update();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }

        }
        protected void ddlproduct_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            try
            {
                int c_id = Convert.ToInt32(Session["company_id"]);
                int b_id = Convert.ToInt32(Session["branch_id"]);
                int p_id = Convert.ToInt32(ddlproduct.SelectedIndex);
                tbl_product p = new tbl_product();
                p.company_id = c_id;
                p.branch_id = b_id;
                p.product_id = p_id;
                ////Shakeeb
                ////p.All(p);
                txtprice.Text = Convert.ToString(p.sales_price);
                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                int c_id = Convert.ToInt32(Session["company_id"]);
                string vendor = ddlVendor.SelectedItem.Text.Trim();
                string SON = txtSONo.Text.Trim();
                string date = txtdate.Text.Trim();
                string pname = ddlproduct.SelectedItem.Text.Trim();
                string quantity = txtquantity.Text.Trim();
                string price = txtprice.Text.Trim();
                string discount = txtdiscount.Text.Trim();
                int p_id = Convert.ToInt32(ddlproduct.SelectedValue);
                Tax_percent t = new Tax_percent();
                t.company_id = c_id;
                t.product_id = p_id;
                t.All(t);
                int tax_id = t.tax_id;
                int unit_id = t.unit_id;
                string unit_name = t.unit_name;
                string tax_percentage = t.tax_percentage;
                int batch_id = t.batch_id;
                ViewState["b_id"] = batch_id;
                string batch_name = t.batch_name;
                int product_id = Convert.ToInt32(ddlproduct.SelectedValue);
                decimal SubTotal = Convert.ToInt32(txtquantity.Text) * Convert.ToInt32(txtprice.Text);
                decimal a = SubTotal / 100;
                decimal discountamt = a * decimal.Parse(discount);
                decimal tax_amount = a * decimal.Parse(tax_percentage);
                DataTable dt = (DataTable)Session["table"];
                dt.Rows.Add(1, p_id, batch_id, unit_id, tax_id, SubTotal, discountamt, tax_amount, price, quantity, pname, unit_name, batch_name, tax_percentage);
                Session["table"] = dt;
                gvSalesdetails.DataSource = dt;
                gvSalesdetails.DataBind();
                clr();
                txtBalanceAmt.Enabled = true;
                txtGivenAmt.Enabled = true;
                calculation(SubTotal, tax_amount, discountamt);

            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        public void pagebind()
        {
            int c_id = Convert.ToInt32(Session["company_id"]);
            tbl_sale p = new tbl_sale();
            p.company_id = c_id;
            p.sale_id = a;
//<<<<<<< .mine
//            p.SaleInvoice(p);
//            txtdate.Text = p.date;
//=======
            ////Shakeeb
            ////p.All3(p);
            ////txtdate.Text = p.date;
//>>>>>>> .r195
            //ddlVendor.SelectedValue = p.party_id.ToString();
            //txtSONo.Text = p.invoice_no;
            //lblsubtotal.Text = p.actual_amount.ToString();
            //lblTaxAmount.Text = p.total_tax.ToString();
            //lblDiscountAmt.Text = p.total_discount.ToString();
            //lblGrandTotal.Text = p.grand_total.ToString();
            ////txtBalanceAmt.Text = p.balance.ToString();
            ////ViewState["balanceamt"] = txtGivenAmt.Text = p.given.ToString();

        }
        public void gridbind()
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
                gvSalesdetails.DataSource = (DataTable)Session["table"];
                gvSalesdetails.DataBind();
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
        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            try
            {
                
                int c_id = Convert.ToInt32(Session["company_id"]);
                string vendor = ddlVendor.SelectedItem.Text.Trim();
                string SON = txtSONo.Text.Trim();
                string date = txtdate.Text.Trim();
                string pname = ddlproduct.SelectedItem.Text.Trim();
                string quantity = txtquantity.Text.Trim();
                string price = txtprice.Text.Trim();
                string discount = txtdiscount.Text.Trim();
                int p_id = Convert.ToInt32(ddlproduct.SelectedValue);
                if (discount == "" || discount == null)
                {
                    discount = "0";
                }
                Tax_percent t = new Tax_percent();
                t.company_id = c_id;
                t.product_id = p_id;
                t.All(t);
                int tax_id = t.tax_id;
                int unit_id = t.unit_id;
                string unit_name = t.unit_name;
                string tax_percentage = t.tax_percentage;
                int batch_id = t.batch_id;
                string batch_name = t.batch_name;
                int product_id = Convert.ToInt32(ddlproduct.SelectedValue);
                decimal SubTotal = Convert.ToDecimal(txtquantity.Text) * Convert.ToDecimal(txtprice.Text);
                decimal a = SubTotal / 100;
                decimal discountamt = a * Convert.ToDecimal(discount);
                decimal tax_amount = a * Convert.ToDecimal(tax_percentage);

                decimal subtot = Convert.ToDecimal(ViewState["subtot"]) - SubTotal;
                decimal taxamount = Convert.ToDecimal(ViewState["taxamount"]) - Convert.ToDecimal(tax_amount);
                decimal discount_amount = Convert.ToDecimal(ViewState["dis"]) - discountamt;
                decimal qty = Convert.ToDecimal(ViewState["qtybefore"]) - Convert.ToDecimal(txtquantity.Text);
                DataTable dt = Session["table"] as DataTable;
                if (ViewState["id2"] != null)
                {
                    int row = Convert.ToInt32(ViewState["id"]);
                    dt.Rows[row][0] = ViewState["id2"];
                    dt.Rows[row][1] = ViewState["id2"];
                    dt.Rows[row][2] = ddlproduct.SelectedValue;
                    dt.Rows[row][3] = batch_id;
                    dt.Rows[row][4] = unit_id;
                    dt.Rows[row][5] = tax_id;
                    dt.Rows[row][6] = subtot;
                    dt.Rows[row][7] = discount_amount;
                    dt.Rows[row][8] = taxamount;
                    dt.Rows[row][9] = txtprice.Text.Trim();
                    dt.Rows[row][10] = qty;
                    dt.Rows[row][11] = pname;
                    dt.Rows[row][12] = unit_name;
                    dt.Rows[row][13] = batch_name;
                    dt.Rows[row][14] = tax_percentage;
                }
                gvSalesdetails.DataSource = dt;
                gvSalesdetails.DataBind();
                clr();
                updatecal();
                calculation(subtot, taxamount, discount_amount);
                //btnAdd.Visible = true;
                btnUpdate.Visible = false;
                giventotalcal(Convert.ToDecimal(lblGrandTotal.Text), Convert.ToDecimal(txtGivenAmt.Text));
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
            }
        }
        public void giventotalcal(decimal gtot, decimal gamt)
        {
            if (gamt != 0)
            {
                decimal gttot = gamt - gtot;
                decimal tott = Convert.ToDecimal(txtGivenAmt.Text) - gttot;
                txtGivenAmt.Text = tott.ToString();
                txtBalanceAmt.Text = gttot.ToString();
                UpdatePanel2.Update();
            }
        }
        protected void gvSalesdetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int c_id = Convert.ToInt32(Session["company_id"]);
                if (e.CommandName == "Delete row")
                {

                    GridViewRow grv = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer);
                    ViewState["total"] = grv.Cells[9].Text.ToString();
                    ViewState["dis"] = grv.Cells[6].Text.ToString();
                    ViewState["tax"] = grv.Cells[8].Text.ToString();
                    int rowIndex = grv.RowIndex;
                    ViewState["index"] = rowIndex;
                    ViewState["id"] = grv.Cells[10].Text.ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                }
                else if (e.CommandName == "Update Row")
                {
                    GridViewRow grv = ((GridViewRow)((ImageButton)e.CommandSource).NamingContainer);
                    ViewState["id"] = grv.RowIndex;
                    ddlproduct.SelectedValue = grv.Cells[3].Text.ToString();
                    txtquantity.Text = grv.Cells[4].Text.ToString();
                    txtprice.Text = grv.Cells[5].Text.ToString();
                    ViewState["id2"] = grv.Cells[10].Text.ToString(); ;
                    //txtdiscount.Text = grv.Cells[8].Text.ToString();
                    btnUpdate.Visible = true;
                    //btnAdd.Visible = false;
                    ViewState["subtot"] = (grv.Cells[9].Text);
                    ViewState["dis"] = Convert.ToDecimal(grv.Cells[6].Text) * 100 / Convert.ToDecimal(grv.Cells[9].Text);
                    ViewState["taxamount"] = (grv.Cells[8].Text);
                    txtdiscount.Text = ViewState["dis"].ToString();
                    UpdatePanel1.Update();
                }
            }
            catch (Exception ex)
            {

                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["total"] != "" && ViewState["dis"] != "" && ViewState["tax"] != "")
                {
                    decimal t = Convert.ToDecimal(lblsubtotal.Text) - Convert.ToDecimal(ViewState["total"]);
                    decimal tx = Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(ViewState["tax"]);
                    decimal d = Convert.ToDecimal(lblDiscountAmt.Text) - Convert.ToDecimal(ViewState["dis"]);
                    lblsubtotal.Text = t.ToString();
                    lblTaxAmount.Text = tx.ToString();
                    lblDiscountAmt.Text = d.ToString();
                    if (Session["table"] != "")
                    {
                        DataTable dt = Session["table"] as DataTable;
                        if (ViewState["id"] == null)
                        {
                            int row = Convert.ToInt32(ViewState["index"]);
                            dt.Rows.RemoveAt(row);
                        }
                        else
                        {
                            int purchase_id = Convert.ToInt32(Request.QueryString["id"]);
                            if (purchase_id != 0)
                            {
                                int row = Convert.ToInt32(ViewState["id"]);
                                DataTable dttt = (DataTable)Session["deletdata"];
                                dttt.Rows.Add(purchase_id, row);
                                Session["deletdata"] = dttt;
                                int row1 = Convert.ToInt32(ViewState["index"]);
                                dt.Rows.RemoveAt(row1);
                                //int row = Convert.ToInt32(ViewState["id"]);
                                //context.sp_DeletePurchasedetailbyreutrn(purchase_id, row);
                                //int row1 = Convert.ToInt32(ViewState["index"]);
                                //dt.Rows[row1].Delete();
                                //context.sp_salereturn(purchase_id, row, Session["UserID"].ToString(), (DateTime.Today).ToString());
                            }
                        }
                        gvSalesdetails.DataSource = dt;
                        gvSalesdetails.DataBind();
                    }
                    decimal gtot = Convert.ToDecimal(lblsubtotal.Text) + (Convert.ToDecimal(lblTaxAmount.Text) - Convert.ToDecimal(lblDiscountAmt.Text));
                    lblGrandTotal.Text = gtot.ToString();
                    txtBalanceAmt.Text = lblGrandTotal.Text;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
        }

        protected void getdeleterow(string u)
        {
          
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {

            SqlTransaction transaction;
            SqlCommand cmd = new SqlCommand();

            cmd.Connection = con;
            cmd.CommandTimeout = 600000;
            con.Open();
            transaction = con.BeginTransaction("Transaction");
            cmd.Transaction = transaction;
            try
            {
                string date = DateTime.Today.ToString();
                string user = Session["UserID"].ToString();
                int c_id = Convert.ToInt32(Session["company_id"]);
                int b_id = Convert.ToInt32(Session["branch_id"]);
                int count;

                DataTable dt = (DataTable)Session["deletdata"];
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    int saleid = Convert.ToInt32(dt.Rows[i][0].ToString());
                    int row = Convert.ToInt32(dt.Rows[i][1].ToString());
                    cmd.CommandText = "sp_salereturn";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@sale_id", saleid);
                    cmd.Parameters.AddWithValue("@saledetails_id", row);
                    cmd.Parameters.AddWithValue("@product_id", Convert.ToInt32(dt.Rows[i][2].ToString()));
                    cmd.Parameters.AddWithValue("@batch_id", 1);
                    cmd.Parameters.AddWithValue("@tax_amt", Convert.ToDecimal(dt.Rows[i][4].ToString()));
                    cmd.Parameters.AddWithValue("@dicount_amt", Convert.ToDecimal(dt.Rows[i][5].ToString()));
                    cmd.Parameters.AddWithValue("@quantity", Convert.ToDecimal(dt.Rows[i][6].ToString()));
                    cmd.Parameters.AddWithValue("@amount", Convert.ToDecimal(dt.Rows[i][7].ToString()));
                    cmd.Parameters.AddWithValue("@price", Convert.ToDecimal(dt.Rows[i][8].ToString()));
                    cmd.Parameters.AddWithValue("@created_by", user);
                    cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
                    cmd.Connection = con;
                    cmd.CommandTimeout = 600000;
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();

                    cmd.CommandText = "sp_deleteSladetail";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@sale_id", saleid);
                    cmd.Parameters.AddWithValue("@saledetails_id", row);
                    cmd.Connection = con;
                    cmd.CommandTimeout = 600000;
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                }

                if (gvSalesdetails.Rows.Count == 0)
                {
                    count = 0;
                }
                else
                {
                    count = 1;
                }

                int sale_id = Convert.ToInt32(Request.QueryString["id"]);
                if (sale_id != 0)
                {

                    decimal tax_amount = Convert.ToDecimal(lblTaxAmount.Text);
                    decimal sub_total = Convert.ToDecimal(lblsubtotal.Text);
                    decimal discount = Convert.ToDecimal(lblDiscountAmt.Text);
                    decimal grandtotal = Convert.ToDecimal(lblGrandTotal.Text);
                    cmd.CommandText = "sp_UpdateSale";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@sale_id", sale_id);
                    cmd.Parameters.AddWithValue("@count", count);
                    cmd.Parameters.AddWithValue("@company_id", c_id);
                    cmd.Parameters.AddWithValue("@party_id", Convert.ToInt32(ddlVendor.SelectedValue));
                    cmd.Parameters.AddWithValue("@invoice_no", txtSONo.Text);
                    cmd.Parameters.AddWithValue("@total_tax", tax_amount);
                    cmd.Parameters.AddWithValue("@actual_amount", sub_total);
                    cmd.Parameters.AddWithValue("@grand_total", grandtotal);
                    cmd.Parameters.AddWithValue("@discount", discount);
                    cmd.Parameters.AddWithValue("@modified_by", user);
                    cmd.Parameters.AddWithValue("@modifie_date", DateTime.Now);
                    cmd.Connection = con;
                    cmd.CommandTimeout = 600000;
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    // context.sp_UpdatePurhase(Purchase_id, count, c_id, Convert.ToInt32(ddlVendor.SelectedValue), txtSONo.Text, tax_amount, sub_total, grandtotal, discount, user, date);
                    //sp_UpdatePurchase();
                }


                int mcid = sale_id;


                foreach (GridViewRow row in gvSalesdetails.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                        if (chkRow.Checked)
                        {
                             int salesedetail_id = Convert.ToInt32(row.Cells[9].Text);
                             if (salesedetail_id != 0)
                             {
                                 cmd.CommandText = "sp_salereturn";
                                 cmd.CommandType = CommandType.StoredProcedure;
                                 cmd.Parameters.AddWithValue("@sale_id", sale_id);
                                 cmd.Parameters.AddWithValue("@saledetails_id", salesedetail_id);
                                 cmd.Parameters.AddWithValue("@product_id", Convert.ToInt32(row.Cells[3].Text));
                                 cmd.Parameters.AddWithValue("@batch_id", 1);
                                 cmd.Parameters.AddWithValue("@tax_amt", Convert.ToDecimal(row.Cells[8].Text));
                                 cmd.Parameters.AddWithValue("@dicount_amt", Convert.ToDecimal(row.Cells[6].Text));
                                 cmd.Parameters.AddWithValue("@quantity", Convert.ToDecimal(row.Cells[4].Text));
                                 cmd.Parameters.AddWithValue("@amount", Convert.ToDecimal(row.Cells[9].Text));
                                 cmd.Parameters.AddWithValue("@price", Convert.ToDecimal(row.Cells[5].Text));
                                 cmd.Parameters.AddWithValue("@created_by", user);
                                 cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
                                 cmd.Connection = con;
                                 cmd.CommandTimeout = 600000;
                                 cmd.ExecuteNonQuery();
                                 cmd.Parameters.Clear();

                                 cmd.CommandText = "sp_Updatesaledetail";
                                 cmd.CommandType = CommandType.StoredProcedure;
                                 cmd.Parameters.AddWithValue("@saledetails_id", Convert.ToInt32(row.Cells[10].Text));
                                 cmd.Parameters.AddWithValue("@product_id", Convert.ToInt32(row.Cells[3].Text));
                                 cmd.Parameters.AddWithValue("@sale_id", sale_id);
                                 cmd.Parameters.AddWithValue("@batch_id", 1);
                                 cmd.Parameters.AddWithValue("@tax_amt", Convert.ToDecimal(row.Cells[8].Text));
                                 cmd.Parameters.AddWithValue("@dicount_amt", Convert.ToDecimal(row.Cells[6].Text));
                                 cmd.Parameters.AddWithValue("@quantity", Convert.ToDecimal(row.Cells[4].Text));
                                 cmd.Parameters.AddWithValue("@amount", Convert.ToDecimal(row.Cells[9].Text));
                                 cmd.Parameters.AddWithValue("@price", Convert.ToDecimal(row.Cells[5].Text));
                                 cmd.Parameters.AddWithValue("@modified_by", user);
                                 cmd.Parameters.AddWithValue("@modifie_date", DateTime.Now);
                                 cmd.Connection = con;
                                 cmd.CommandTimeout = 600000;
                                 cmd.ExecuteNonQuery();
                                 cmd.Parameters.Clear();
                                 //context.sp_salereturn(sale_id, salesedetail_id, user, (DateTime.Today).ToString());
                             }
                        }
                    }
                }

                //GridViewRow row = gvpurchasedetails.Rows[rowIndex];
              ///  for (int i = 0; i <= gvSalesdetails.Rows.Count - 1; i++)
              //  {

                   // int salesedetail_id = Convert.ToInt32(gvSalesdetails.Rows[i].Cells[9].Text);
                   // if (salesedetail_id != 0)
                   // {
                        //cmd.CommandText = "sp_Updatesaledetail";
                        //cmd.CommandType = CommandType.StoredProcedure;
                        //cmd.Parameters.AddWithValue("@saledetails_id", Convert.ToInt32(gvSalesdetails.Rows[i].Cells[9].Text));
                        //cmd.Parameters.AddWithValue("@product_id", Convert.ToInt32(gvSalesdetails.Rows[i].Cells[2].Text));
                        //cmd.Parameters.AddWithValue("@sale_id", sale_id);
                        //cmd.Parameters.AddWithValue("@batch_id", 1);
                        //cmd.Parameters.AddWithValue("@tax_amt", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[7].Text));
                        //cmd.Parameters.AddWithValue("@dicount_amt", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[5].Text));
                        //cmd.Parameters.AddWithValue("@quantity", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[3].Text));
                        //cmd.Parameters.AddWithValue("@amount", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[8].Text));
                        //cmd.Parameters.AddWithValue("@price", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[4].Text));
                        //cmd.Parameters.AddWithValue("@modified_by", user);
                        //cmd.Parameters.AddWithValue("@modifie_date", DateTime.Now);
                        //cmd.Connection = con;
                        //cmd.CommandTimeout = 600000;
                        //cmd.ExecuteNonQuery();
                        //cmd.Parameters.Clear();

                       // context.sp_salereturn(sale_id, Convert.ToInt32(gvSalesdetails.Rows[i].Cells[9].Text), user, (DateTime.Today).ToString());
                        //context.sp_UpdatePurchasedetails(purchasedetail_id, Convert.ToInt32(gvSalesdetails.Rows[i].Cells[2].Text)
                        //    , mcid, Convert.ToInt32(gvSalesdetails.Rows[i].Cells[4].Text), Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[10].Text)
                        //    , Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[8].Text), Convert.ToInt32(gvSalesdetails.Rows[i].Cells[5].Text)
                        //    , Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[11].Text), Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[6].Text)
                        //    , Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[7].Text), user, date);
                   // }

                    //else
                    //{
                    //    //Purchase Details Saving Code Start Here

                    //    cmd.CommandText = "sp_SalesDetailinsert";
                    //    cmd.CommandType = CommandType.StoredProcedure;
                    //    cmd.Parameters.AddWithValue("@product_id", gvSalesdetails.Rows[i].Cells[2].Text);
                    //    cmd.Parameters.AddWithValue("@sale_id", mcid);
                    //    cmd.Parameters.AddWithValue("@batch_id", 1);
                    //    cmd.Parameters.AddWithValue("@tax_amt", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[7].Text));
                    //    cmd.Parameters.AddWithValue("@dicount_amt", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[5].Text));
                    //    cmd.Parameters.AddWithValue("@quantity", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[3].Text));
                    //    cmd.Parameters.AddWithValue("@amount", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[8].Text));
                    //    cmd.Parameters.AddWithValue("@price", Convert.ToDecimal(gvSalesdetails.Rows[i].Cells[4].Text));
                    //    cmd.Connection = con;
                    //    cmd.CommandTimeout = 600000;
                    //    cmd.ExecuteNonQuery();
                    //    cmd.Parameters.Clear();
                    //    // Purchase Details Code End

                    //    // Stock & Stock Transaction Data Saving Code Starts Here
                    //    cmd.CommandText = "sp_InsertSaleTransaction";
                    //    cmd.CommandType = CommandType.StoredProcedure;

                    //    // code are here

                    //    cmd.Parameters.AddWithValue("@company_id", c_id);
                    //    cmd.Parameters.AddWithValue("@branch_id", b_id);
                    //    cmd.Parameters.AddWithValue("@product_id", gvSalesdetails.Rows[i].Cells[2].Text);
                    //    cmd.Parameters.AddWithValue("@bacth_id",1);
                    //    cmd.Parameters.AddWithValue("@in_out", "Out");
                    //    cmd.Parameters.AddWithValue("@qty", gvSalesdetails.Rows[i].Cells[3].Text);
                    //    cmd.Parameters.AddWithValue("@transactio_type_id", mcid);
                    //    cmd.Parameters.AddWithValue("@stocktransaction_typ", "Sales");
                    //    cmd.Parameters.AddWithValue("@created_by", user);
                    //    cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
                    //    cmd.Connection = con;
                    //    cmd.CommandTimeout = 600000;
                    //    // end

                    //    cmd.ExecuteNonQuery();
                    //    cmd.Parameters.Clear();
                    //    // Stock & Stock Transaction Data Saving Code end
                    //}
               // }
                cmd.Parameters.Clear();

                cmd.CommandText = "sp_InsertMonyTransaction";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@company_id", c_id);
                cmd.Parameters.AddWithValue("@branch_id", b_id);
                cmd.Parameters.AddWithValue("@party_id", ddlVendor.SelectedValue);
                cmd.Parameters.AddWithValue("@given_amt", txtGivenAmt.Text);
                cmd.Parameters.AddWithValue("@grand_total", lblGrandTotal.Text);
                cmd.Parameters.AddWithValue("@balance_amt", txtBalanceAmt.Text);
                cmd.Parameters.AddWithValue("@in_out", "out");
                cmd.Parameters.AddWithValue("@paymentmode_id", ddlPaymentMode.SelectedValue);
                cmd.Parameters.AddWithValue("@transaction_typ", "Sale Return");
                cmd.Parameters.AddWithValue("@transactio_type_id", mcid);
                cmd.Parameters.AddWithValue("@created_by", Session["UserID"].ToString());
                cmd.Parameters.AddWithValue("@created_date", DateTime.Today);
                cmd.Connection = con;
                cmd.CommandTimeout = 600000;
                cmd.ExecuteNonQuery();
                transaction.Commit();
                con.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openalert();", true);
            }
            catch (Exception ex)
            {
                ErrorLog.saveerror(ex);
                //Do Logging
            }
            finally
            {
                if (con != null && con.State != ConnectionState.Closed)
                {
                    con.Close();
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("../SalesFolder/SalesReturn.aspx", false);
        }



        
    }
}