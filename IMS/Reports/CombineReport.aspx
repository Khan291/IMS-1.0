<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CombineReport.aspx.cs" Inherits="IMS.Reports.CombineReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMS</title>    
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />

    <!-- Core CSS - Include with every page -->
    <link href="~/assets/plugins/bootstrap/bootstrap.css" media="all" rel="stylesheet" />
    <link href="~/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <%--<link href="assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />--%>
    <link href="~/assets/css/style.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="~/assets/css/main-style.css" rel="stylesheet" />
    <link rel="stylesheet" media="all" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Page-Level CSS -->
    <link href="~/assets/plugins/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <%-- <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>--%>
    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="../assets/alert/alertify.js"></script>
    <script src="../assets/alert/alertify.min.js"></script>
    <link href="../assets/alert/css/alertify.css" rel="stylesheet" />
    <link href="../assets/alert/css/alertify.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.rtl.css" rel="stylesheet" />
    <link href="../assets/invoicedesign/styles/bauhaus.css" rel="stylesheet" />
    <link href="../assets/invoicedesign/styles/bauhaus_print.css" rel="stylesheet" />   
    <script type="text/javascript">
        function PrintPage() {
            $('#btnprint').hide();
            window.print();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="invoice" class="pagestyle">
                <asp:Panel ID="printpanel" runat="server">
                    <div id="invoice-header">
                        <asp:Image ID="imglogo" runat="server" Height="150" Width="300" />
                        <asp:Label ID="lblIms" runat="server" Font-Bold="true" Style="padding: 0; font-size: 55px;" Text="!MSB!ZZ" Visible="false"></asp:Label>
                        <div class="vcard" id="company-address">
                            <div class="fn org">
                                <h2>
                                    <strong>
                                        <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
                                    </strong>
                                </h2>
                            </div>
                            <div class="adr">
                                <div class="street-address">
                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                </div>
                                <div class="locality">Locality</div>
                                <div id="company-postcode">
                                    <asp:Label ID="lblzipcode" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="email">
                                <asp:Label ID="lblemail" runat="server"></asp:Label>
                            </div>

                        </div>
                    </div>

                    <div id="invoice-info">
                        <h2>Invoice <strong>
                            <asp:Label ID="lblinvoiceno" runat="server"></asp:Label></strong>
                        </h2>
                        <h3>
                            <asp:Label ID="lbldate" runat="server"></asp:Label>
                        </h3>
                    </div>

                    <div class="vcard" id="client-details">
                        <div class="fn">
                            <asp:Label ID="lblpartyname" runat="server"></asp:Label>
                        </div>
                        <div class="org">
                        </div>
                        <div class="adr">
                            <div class="street-address">
                                <asp:Label ID="lblpartyaddress" runat="server"></asp:Label>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px; margin-top: 10px">
                            <asp:GridView ID="grdreport" runat="server" HeaderStyle-BackColor="#151313" AutoGenerateColumns="false" CssClass="table  " BorderStyle="None" GridLines="Horizontal">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.No" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Type" HeaderText="Type"></asp:BoundField>                                   
                                    <asp:BoundField DataField="Product" HeaderText="Product"></asp:BoundField>
                                    <asp:BoundField DataField="Date" HeaderText="Date"></asp:BoundField>
                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity"></asp:BoundField>
                                    <asp:BoundField DataField="Batch" HeaderText="Batch"></asp:BoundField>
                                    <asp:BoundField DataField="PaymentMode" HeaderText="Payment Mode" Visible="false"></asp:BoundField>
                                    <asp:BoundField DataField="TaxAmnt" HeaderText="Tax"></asp:BoundField>
                                    <asp:BoundField DataField="DiscountAmnt" HeaderText="Discount"></asp:BoundField>
                                    <asp:BoundField DataField="ProductAmount" HeaderText="Total"></asp:BoundField>                                 
                                                                   </Columns>
                                <HeaderStyle BackColor="#151313" ForeColor="White" />
                            </asp:GridView>
                        </div>
                    </div>
                    <br />
                    <br />
                        <div class="row">
                            <div class="col-xs-6 pull-right">
                                <div class="col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-xs-10 leftpadd0">
                                            <label class="control-label col-sm-9">Sub Total</label>

                                        </div>
                                        <div class="col-xs-1 leftpadd0">
                                            <asp:Label ID="lblsubtotal" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-xs-10 leftpadd0">
                                            <label class="control-label col-xs-9">Tax Amount</label>

                                        </div>
                                        <div class="col-xs-1 leftpadd0">
                                            <asp:Label ID="lblTaxAmount" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class=" col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-xs-10 leftpadd0">
                                            <label class="control-label col-xs-9">Discount Amount</label>

                                        </div>
                                        <div class="col-xs-1 leftpadd0">
                                            <asp:Label ID="lblDiscountAmt" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class=" col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-xs-10 leftpadd0">
                                            <label class="control-label col-xs-9">Given Amount</label>

                                        </div>
                                        <div class="col-xs-1 leftpadd0">
                                            <asp:Label ID="lblGivenAmnt" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class=" col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-xs-10 leftpadd0">
                                            <label class="control-label col-xs-9">Balance Amount</label>

                                        </div>
                                        <div class="col-xs-1 leftpadd0">
                                            <asp:Label ID="lblBalanceAmnt" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class=" col-xs-6 pull-left">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6  pull-right">
                                <div style="border: 1px solid black; margin-top: 10px; margin-bottom: 10px;"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6  pull-right">
                                <div class="col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-xs-10 leftpadd0">
                                            <label class="control-label col-sm-9">Grand Total</label>
                                        </div>
                                        <div class="col-xs-1 leftpadd0">

                                            <asp:Label ID="lblGrandTotal" runat="server" CssClass="control-label" Text="0"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>                  
                </asp:Panel>
                <div class="row">
                    <input type="button" class="btn btn-danger" id="btnprint" value="print" onclick="javascript: PrintPage();" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
