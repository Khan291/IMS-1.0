<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="IMS.Setting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>Settings</h1>

        </div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#genralSetting">Genral Setting</a></li>
                <li><a data-toggle="tab" href="#AccountSetting">Account Setting</a></li>
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
                                    <asp:TextBox ID="txtdecimalplaces" runat="server" CssClass="form-control" Text="2"></asp:TextBox>
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
                                    <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20">
                                <div class="col-xs-8 ">
                                    <label class="control-label">Enable Invoice Tax Billing</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Tax will countable on the bill </label>
                                </div>
                                <div class="col-xs-4 leftpadd0" style="margin-top: 15px">
                                    <asp:CheckBox ID="chbEnableInvoiceTax" runat="server" CssClass="checkbox" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="bludiv col-md-8 col-sm-12 col-xs-12  padd20 ">
                                <div class="col-xs-8 ">
                                    <label class="control-label">Print Tin on Invoice</label>
                                    <label class="" style="font-size: 12px; font-weight: lighter">Specify the number of digits after decimal for amounts.</label>
                                </div>
                                <div class="col-xs-4 leftpadd0" style="margin-top: 15px">
                                    <asp:CheckBox ID="CheckBox1" runat="server" CssClass="checkbox" />
                                </div>
                            </div>
                        </div>
                    </div>
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
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false"/>
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary " Text="Cancel" />
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
