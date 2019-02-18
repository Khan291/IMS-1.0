<%@ Page Title="" Language="C#" MasterPageFile="~/SalesFolder/SalesManger.Master" AutoEventWireup="true" CodeBehind="SalesRtrn.aspx.cs" Inherits="IMS.SalesReturn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



    <%--<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>--%>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="../assets/alert/alertify.js"></script>
    <script src="../assets/alert/alertify.min.js"></script>
    <link href="../assets/alert/css/alertify.css" rel="stylesheet" />
    <link href="../assets/alert/css/alertify.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.rtl.css" rel="stylesheet" />

    <script type='text/javascript'>

        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }

        function openalert() {
            alertify.alert('Success', 'Saved Successfully').setting({
                'onok': function () { window.location.href = "SalesReport.aspx"; }
            });

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>Sales Return</h1>
        </div>
        <div class="panel-body">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <div class="row">
                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="form-horizontal Fhorizontal">
                            <div class="col-sm-10 leftpadd0">
                                <label class="control-label">Select Customer</label>
                                <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="col-sm-10 leftpadd0">
                            <label class="control-label">Invoice No.</label>
                            <asp:TextBox ID="txtSONo" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>

                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-10 leftpadd0">
                                <label class="control-label">Date</label>
                                <asp:TextBox ID="txtdate" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                    </div>



                </div>
                <div style="border: 1px solid black; margin-top: 10px; margin-bottom: 10px;"></div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="row">

                            <%--  <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="col-sm-10 leftpadd0">
                            <label class="control-label">Barcode</label>
                            <asp:TextBox ID="txtBarcode" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>--%>
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                                <div class="col-sm-10 leftpadd0">
                                    <label class="control-label">Select Product</label>
                                    <asp:DropDownList ID="ddlproduct" runat="server" CssClass="form-control" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged">
                                        <asp:ListItem Text="Choose Product" />
                                    </asp:DropDownList>
                                </div>

                            </div>

                            <div class="col-md-4 col-lg-2 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                                <div class="col-sm-10 leftpadd0">
                                    <label class="control-label">
                                        Quantity
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtquantity" ErrorMessage="*" ForeColor="Red" ValidationGroup="salevalidtion"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox ID="txtquantity" runat="server" CssClass="form-control" onchange="CheckDouble()"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d{1,5})?\s*$" runat="server" ValidationGroup="adf" Display="Dynamic" ForeColor="Red" ControlToValidate="txtquantity" ErrorMessage="Quantity should b greater then 0"></asp:RegularExpressionValidator>
                                    <%--<asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hd" runat="server" />--%>
                                </div>
                            </div>
                            <div class="col-md-4 col-lg-2 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                                <div class="col-sm-10 leftpadd0">
                                    <label class="control-label">
                                        Price
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtprice" ErrorMessage="*" ForeColor="Red" ValidationGroup="salevalidtion"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox ID="txtprice" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d{1,5})?\s*$" runat="server" ValidationGroup="adf" Display="Dynamic" ForeColor="Red" ControlToValidate="txtprice" ErrorMessage="Price should b greater then 0"></asp:RegularExpressionValidator>

                                </div>
                            </div>
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                                <div class="col-sm-10 leftpadd0">
                                    <label class="control-label">
                                        Discount %
                                        
                                    </label>
                                    <asp:TextBox ID="txtdiscount" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ValidationExpression="^\s*(?=.*[0-9])\d*(?:\.\d{1,5})?\s*$" runat="server" ValidationGroup="adf" Display="Dynamic" ForeColor="Red" ControlToValidate="txtdiscount" ErrorMessage="Discount should b greater then 0"></asp:RegularExpressionValidator>

                                </div>
                            </div>

                        </div>
                    </ContentTemplate>

                </asp:UpdatePanel>
                <div class="row">

                    <div class="col-md-4 col-lg-2 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-top: 20px">
                        <div class="col-sm-10 leftpadd0">
                            <%--                            <asp:Button ID="btnAdd" runat="server" ValidationGroup="adf" CssClass="btn btn-primary" Text="Add" Width="100px" OnClick="btnAdd_Click" />--%>
                            <asp:Button ID="btnUpdate" runat="server" ValidationGroup="adf" CssClass="btn btn-primary" Visible="false" Text="Update" Width="100px" OnClick="btnUpdate_Click" />
                        </div>
                    </div>


                </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px; margin-top: 10px">
                        <asp:GridView ID="gvSalesdetails" runat="server"  CssClass="table"  AutoGenerateColumns="false" BorderStyle="None" GridLines="Horizontal" OnRowCommand="gvSalesdetails_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" >
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkRow" runat="server"  />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SR.No" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="product_name" HeaderText="Product" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="Product_id" HeaderText="Product id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="Price" HeaderText="Price" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="dicount_amt" HeaderText="Discount Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="tax_percentage" HeaderText="Tax" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="tax_amt" HeaderText="Tax Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="amount" HeaderText="Total" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="saledetails_id" HeaderText="saledetails_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="Update Row" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="Delete row" ID="btnimg_Remove" runat="server" ImageUrl="~/assets/img/remove.png" data-toggle="modal" href="#myModal" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Sub Total</label>
                                            <asp:Label ID="lblsubtotal" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Tax Amount</label>
                                            <asp:Label ID="lblTaxAmount" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Discount Amount</label>
                                            <asp:Label ID="lblDiscountAmt" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class=" col-md-4 pull-left">
                                <asp:GridView ID="GridView1" runat="server" CssClass="table " BorderStyle="None" GridLines="Horizontal">

                                    <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div style="border: 1px solid black; margin-top: 10px; margin-bottom: 10px;"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Grand Total</label>
                                            <asp:Label ID="lblGrandTotal" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Payment Mode</label>
                                            <asp:DropDownList ID="ddlPaymentMode" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Given Amount</label>
                                            <asp:TextBox ID="txtGivenAmt" runat="server" CssClass="form-control" OnTextChanged="txtGivenAmt_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ForeColor="Red" ControlToValidate="txtGivenAmt" ErrorMessage="Given Amount Should be digits only" ValidationGroup="savesale" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d{1,5})?\s*$" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Balance Amount</label>
                                            <asp:TextBox ID="txtBalanceAmt" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ForeColor="Red" ControlToValidate="txtBalanceAmt" ErrorMessage="Balance Amount Should be digits only" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d{1,5})?\s*$" Display="Dynamic" ValidationGroup="savesale">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <asp:Label ID="lblmsg" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
            <%--<div style="border:1px solid black"></div>--%>
        </div>
        <div class="panel-footer leftpadd0">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" ValidationGroup="savesale" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary " Text="Cancel" OnClick="btnCancel_Click" />
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog" runat="server">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Alert</h4>
                </div>
                <div class="modal-body">
                    <p>Are You Sure You want to delete it ?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnOk" runat="server" Text="Ok" CssClass="btn btn-primary" OnClick="btnOk_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
