<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="IMS.Setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("ddlCurrency").searchable({
                maxListSize: 200, // if list size are less than maxListSize, show them all
                maxMultiMatch: 300, // how many matching entries should be displayed
                exactMatch: false, // Exact matching on search
                wildcards: true, // Support for wildcard characters (*, ?)
                ignoreCase: true, // Ignore case sensitivity
                latency: 200, // how many millis to wait until starting search
                warnMultiMatch: 'top {0} matches ...',
                warnNoMatch: 'no matches ...',
                zIndex: 'auto'
            });
        });

    </script>
    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>Settings</h1>

        </div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#genralSetting">Genral Setting</a></li>
                <li><a data-toggle="tab" href="#AccountSetting">Account Setting</a></li>
                <li><a data-toggle="tab" href="#ReportSetting">Report Setting</a></li>
            </ul>
            <div class="tab-content">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 tab-pane fade in active" id="genralSetting" style="color: white">
                    <div class="col-md-6 ">
                        <div class="row">
                            <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20 ">
                                <div class="col-xs-8">
                                    <label class="control-label">Decimal Places</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Specify the number of digits after decimal for amounts.</label>
                                </div>
                                <div class="col-xs-4 " style="margin-top: 15px">
                                    <asp:TextBox ID="txtdecimalplaces" runat="server" CssClass="form-control" Text="2" Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20">
                                <div class="col-xs-8 ">
                                    <label class="control-label">Currency</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Specify the number of digits after decimal for amounts.</label>
                                </div>
                                <div class="col-xs-4 leftpadd0" style="margin-top: 15px">
                                    <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="adf" InitialValue="0" Display="Dynamic" runat="server" ErrorMessage="Select Currency" ControlToValidate="ddlCurrency" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20 ">
                                <div class="col-xs-8 ">
                                    <label class="control-label">Print Address</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Adress will display on bill</label>
                                </div>
                                <div class="col-xs-4 leftpadd0" style="margin-top: 15px">
                                    <asp:CheckBox ID="chbprintaddress" runat="server" CssClass="checkbox" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20">
                                <div class="col-xs-9 ">
                                    <label class="control-label">Invoice Wise Tax</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Tax will countable on the grand total of invoice </label>
                                </div>
                                <div class="col-xs-3 leftpadd0" style="margin-top: 15px">
                                    <asp:RadioButton runat="server" ID="rbinvoicetax" GroupName="tax" />
                                </div>
                                <div class="col-xs-9 ">
                                    <label class="control-label">Product wise tax</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Tax will countable on the product price</label>
                                </div>
                                <div class="col-xs-3 leftpadd0" style="margin-top: 15px">
                                    <asp:RadioButton runat="server" ID="rbproducttax" GroupName="tax" />
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20 ">
                                <div class="col-xs-8 ">
                                    <label class="control-label">Print Tin on Invoice</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Tin Number will display on bill</label>
                                </div>
                                <div class="col-xs-4 leftpadd0" style="margin-top: 15px">
                                    <asp:CheckBox ID="chbPrintTin" runat="server" CssClass="checkbox" />
                                </div>
                            </div>
                        </div>

                    </div>
                    <%-- <div class="col-md-6">
                        <div class="row">
                            <asp:RadioButtonList ID="imagetest" runat="server">
                                <asp:ListItem Text='<img src="../Reports/InvoiceTemplate/InvoiceReport - Copy.PNG" alt="img1" />' Value="1" Selected="True" />
                                <asp:ListItem Text='<img src="~/Reports/InvoiceTemplate/InvoiceReport - Copy.PNG" alt="img2" />' Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>--%>
                </div>
                <div id="AccountSetting" class="tab-pane fade">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="bludiv col-md-10 col-sm-12 col-xs-12  padd20 ">
                                    <div class="col-xs-10 text-center">
                                        <h4><a href="Company.aspx" class="awhite" id="a1">Edit Company</a></h4>
                                        <div class="padd20"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6" id="fydiv" runat="server" visible="false">

                                <div class="bludiv col-md-10 col-sm-12 col-xs-12  padd20 ">
                                    <div class="col-xs-10 text-center">
                                        <h4><a href="Masters/FinincialYear.aspx" class="awhite" id="a2">Finincial Year</a></h4>
                                        <div class="padd20"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="ReportSetting" class="tab-pane fade">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" style="color: white">
                        <div class="col-md-6 ">
                            <div class="row">
                                <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20">
                                    <div class="col-xs-6 ">
                                        <label class="control-label">Paper Size</label>
                                    </div>
                                    <div class="col-xs-6 leftpadd0">
                                        <asp:RadioButton runat="server" ID="rbA4" Text="A4" GroupName="paper" />
                                        <asp:RadioButton runat="server" ID="rbA5" Text="A5 (Half of A4)" GroupName="paper" />
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 ">
                                <div class="bludiv col-md-12 col-sm-12 col-xs-12  padd20">
                                    <label class="control-label">Select Report Sample</label>
                                </div>
                                <div class="col-md-4 col-sm-12 col-xs-12  padd20">
                                    <asp:RadioButton runat="server" ID="rbPurchaseSaleReturnReport1" Text='<img src="../Reports/InvoiceTemplate/InvoicReport1.PNG" alt="img1" />'  GroupName="Invoice" />
                                </div>
                                <div class="col-md-4 col-sm-12 col-xs-12  padd20">
                                    <asp:RadioButton runat="server" ID="rbPurchaseSaleReturnReport2" Text='<img src="../Reports/InvoiceTemplate/IvoiceReport2.PNG" alt="img1" />' GroupName="Invoice" />
                                </div>
                                <div class="col-md-4 col-sm-12 col-xs-12  padd20">
                                    <asp:RadioButton runat="server" ID="rbPurchaseSaleReturnReport3" Text='<img src="../Reports/InvoiceTemplate/InvoiceReport3.PNG" alt="img1" />' GroupName="Invoice" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" Text="Save" ValidationGroup="adf" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary " Text="Cancel" />
        </div>

    </div>
    <div class="row">
        <div class="alert alert-success" id="divalert" runat="server" visible="false">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label ID="lblAlert" runat="server"></asp:Label>
        </div>
    </div>
    <div>


        <a href="Settings.aspx" id="bMaster" runat="server" visible="false">
            <img src="assets/img/goback-5-w800.png" height="50" width="130" /></a>
        <iframe width="100%" height="1000" id="ifm" runat="server" frameborder="0" allowfullscreen="true" scrolling="yes" visible="false"></iframe>
    </div>
    <script>
        $(document).ready(function () {
            $("button").click(function () {
                $("p").toggle();
            });
        });
    </script>
</asp:Content>
