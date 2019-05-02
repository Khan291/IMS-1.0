<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ViewORPayBalancePurchase.aspx.cs" Inherits="IMS.ViewORPayBalancePurchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type='text/javascript'>
        function OnlyNumericEntry(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode > 31
                && (charCode < 48 || charCode > 57))
                return false;

            return true;

        }
        function openalert(msg) {
            debugger;
            alertify.alert('Success', msg).setting({
                'onok': function () { window.location.href = "ViewORPayBalancePurchase.aspx"; }
            });
        }

        function keypress() {
            var balance = $('#<%=lblGrandTotal.ClientID%>').value() - ($('#<%=lblGivenAmnt.ClientID%>').value() + $('#<%=txtPaidAmnt.ClientID%>').value())
            $('#<%=txtBalanceAmnt.ClientID%>').value(balance);


            if ($('#<%=txtPaidAmnt.ClientID%>').value() > $('#<%=txtBalanceAmnt.ClientID%>').value()) {
                var paidAmnt = $('#<%=txtBalanceAmnt.ClientID%>').value();
                $('#<%=txtPaidAmnt.ClientID%>').value(paidAmnt);
                $('#<%=txtBalanceAmnt.ClientID%>').value(0);
            }
        }

        function keypres() {

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>View / Pay Balance</h1>
        </div>
        <div class="panel-body">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <div class="row">
                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="form-horizontal Fhorizontal">
                            <div class="col-sm-10 leftpadd0">
                                <asp:HiddenField ID="hdnPurchaseId" runat="server" />
                                <label class="control-label">
                                    Enter Invoice No.
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSearchBox" ErrorMessage="*" ForeColor="Red" ValidationGroup="searchvalidation"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="txtSearchBox" runat="server" CssClass="form-control" ValidationGroup="searchvalidation"></asp:TextBox>
                                <div id="listPlacement" style="height: 100px; overflow-y: scroll;"></div>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                                    ServiceMethod="GetPoNumbers"
                                    MinimumPrefixLength="2"
                                    CompletionInterval="100"
                                    EnableCaching="false"
                                    CompletionSetCount="10"
                                    TargetControlID="txtSearchBox"
                                    CompletionListElementID="listPlacement"
                                    FirstRowSelected="false">
                                </ajaxToolkit:AutoCompleteExtender>
                            </div>

                        </div>

                    </div>
                    <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-top: 27px">
                        <div class="form-horizontal Fhorizontal">
                            <div class="col-sm-10 leftpadd0">
                                <%--<asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" Text="Add" Width="100px" />--%>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" Width="100px" OnClick="btnSearch_Click" ValidationGroup="searchvalidation" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-top: 27px">
                        <div class="text-center">
                            <asp:Label ID="lblInvoice" runat="server" Font-Bold="true" Font-Size="23px" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                </div>
                <br />
                <br />
                <div class="row">



                    <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="form-horizontal Fhorizontal">
                            <div class="col-sm-10 leftpadd0">
                                <label class="control-label">
                                    Vendor                                     
                                </label>
                                <asp:TextBox ID="txtVendor" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="col-sm-10 leftpadd0">
                            <label class="control-label">
                                Receipt No.
                            </label>
                            <asp:TextBox ID="txtPONo" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>

                        </div>

                    </div>
                    <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-10 leftpadd0">
                                <label class="control-label">
                                    Date                                            
                                </label>
                                <asp:TextBox ID="txtdate" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="form-group">
                            <div class="col-sm-12 leftpadd0">
                                <label class="control-label">Payment Mode</label>
                                <asp:TextBox ID="txtPaymentMode" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                                <br />
                <br />
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px; margin-top: 10px">
                        <asp:GridView ID="gvpurchasedetails" runat="server" CssClass="table table-bordered " Font-Size="Small" AutoGenerateColumns="false" OnDataBound="gvpurchasedetails_DataBound" BorderStyle="None" GridLines="Horizontal" OnRowDataBound="gvpurchasedetails_RowDataBound">
                              <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Image ID="image" Visible="false" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Type" HeaderText="Type"></asp:BoundField>
                                  <%--  <asp:BoundField DataField="Product" HeaderText="Product"></asp:BoundField>
                                    <asp:BoundField DataField="Batch" HeaderText="Batch" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>--%>
                                    <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                   <%-- <asp:BoundField DataField="Quantity" HeaderText="Quantity"></asp:BoundField>--%>
                                  <%--  <asp:BoundField DataField="SaleRate" HeaderText="Sale Price" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>--%>
                                    <asp:BoundField DataField="TotalDiscount" HeaderText="Discount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                    <asp:BoundField DataField="TotalTax" HeaderText="Tax" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                     <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                     <asp:BoundField DataField="GivenAmnt" HeaderText="Given Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                     <asp:BoundField DataField="BalanceAmnt" HeaderText="Balance Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                    <asp:BoundField DataField="GrandTotal" HeaderText="Grand Total" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
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
                                <asp:GridView ID="gvTaxDetails" runat="server" CssClass="table " BorderStyle="None" GridLines="Horizontal">

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
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Given Amount</label>
                                            <asp:Label ID="lblGivenAmnt" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <br />
                        <br />
                        <br />

                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 ">
                            </div>
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group pull-right">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9"></label>
                                            <asp:Button ID="btnGetRefund" Text="Get Refund" runat="server" CssClass="btn btn-primary" Visible="false" OnClick="btnGetRefund_Click"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">
                                                Amount to Paid                                         
                                            </label>
                                            <asp:TextBox ID="txtPaidAmnt" runat="server" CssClass="form-control" OnTextChanged="txtGivenAmt_TextChanged" AutoPostBack="true" Enabled="false" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red" ControlToValidate="txtPaidAmnt" ErrorMessage="Please Enter Paid Amount" ValidationGroup="savesale"></asp:RequiredFieldValidator>
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
                                            <label class="control-label col-sm-9">
                                                Balance Amount                                      
                                            </label>
                                            <asp:Label ID="lblBalanceAmnt" runat="server" Font-Size="Large" Visible="false"></asp:Label>
                                            <asp:TextBox ID="txtBalanceAmnt" Font-Bold="true" Font-Size="Large" Enabled="false" CssClass="form-control" runat="server">                                                                                     
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="panel-footer ">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " ValidationGroup="savesale" Text="Save" Enabled="false" OnClick="btnSave_Click" OnClientClick="DisableOnSave(this,'savesale');" UseSubmitBehavior="false" />
        </div>

    </div>
</asp:Content>
