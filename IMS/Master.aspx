<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Master.aspx.cs" Inherits="IMS.Master" %>

<%--<%@ MasterType VirtualPath="~/Main.Master" %>--%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="padd20">
    </div>
    <div>
        <div class="panel" id="main" runat="server">
            <div class="panel-heading">
                <h1>Masters</h1>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="Blue text-center padd20" id="div1" runat="server">
                            <b class="font30 ">Category</b>
                            <br />
                            <i class="fa fa fa-tag fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btncategory" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btncategory_Click" />
                            <br />
                        </div>
                    </div>
                    <div class="col-md-4" id="div2" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Unit</b>
                            <br />
                            <i class="fa fa fa-balance-scale fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btnumit" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnumit_Click" />
                            <br />
                        </div>
                    </div>
                    <div class="col-md-4" id="div3" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">GoDown</b>
                            <br />
                            <i class="fa fa fa-industry fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btngodown" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btngodown_Click" />
                            <br />
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col-md-4" id="div4" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Racks</b>
                            <br />
                            <i class="fa fa fa-server fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btnrack" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnrack_Click" />
                            <br />
                        </div>
                    </div>
                    <div class="col-md-4" id="div5" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Tax </b>
                            <br />
                            <i class="fa fa fa-percent fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btntax" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btntax_Click" />
                            <br />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Add Users</b>
                            <br />

                            <i class="fa fa fa-building-o fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btnUser" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnUser_Click" />
                            <br />
                        </div>
                    </div>
                    <%--<div class="col-md-4" id="div6" runat="server">
                    <div class="Blue text-center padd20">
                        <b class="font30 ">Financial year</b>
                        <br />
                        <i class="fa fa fa-calendar-o fa-3x padd20"></i>
                        <br />
                          <asp:Button ID="btnfinancialyear" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnfinancialyear_Click"/>
                        <br />
                    </div>
                </div>--%>
                </div>
                <div class="row ">
                    <div class="col-md-4" id="div7" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Parties</b>
                            <br />
                            <i class="fa fa fa-user-circle fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btnparties" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnparties_Click" />
                            <br />
                        </div>
                    </div>
                    <div class="col-md-4" id="div8" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Expense</b>
                            <br />
                            <i class="fa fa fa-money fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btnexpenses" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnexpenses_Click" />
                            <br />
                        </div>
                    </div>
                    <div class="col-md-4" id="div9" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Product</b>
                            <br />
                            <i class="fa fa fa-product-hunt fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="Button1_Click" />
                            <br />
                        </div>
                    </div>

                </div>
                <div class="row ">
                    <div class="col-md-4" id="div10" runat="server">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Batch</b>
                            <br />
                            <i class="fa fa fa-calendar fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btnbatch" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnbatch_Click" />
                            <br />
                        </div>
                    </div>
                     <div class="col-md-4" id="div11" runat="server" >
                    <div class="Blue text-center padd20">
                        <b class="font30 ">Tax Group</b>
                        <br />

                        <i class="fa fa fa-cc-visa fa-3x padd20"></i>
                        <br />
                          <asp:Button ID="btnTaxGroup" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnTaxGroup_Click"/>
                        <br />
                    </div>
                </div>
                    <div class="col-md-4">
                        <div class="Blue text-center padd20">
                            <b class="font30 ">Company Branches</b>
                            <br />

                            <i class="fa fa fa-building-o fa-3x padd20"></i>
                            <br />
                            <asp:Button ID="btnBranch" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnBranch_Click" />
                            <br />
                        </div>
                    </div>

                </div>
                <div class="row">
                </div>
            </div>
        </div>
        <div>

            <asp:LinkButton ID="lnk1" runat="server" Style="display: none"></asp:LinkButton>
            <cc1:ModalPopupExtender ID="mymodel1" runat="server" PopupControlID="pnl1" TargetControlID="lnk1" CancelControlID="btnclose">
            </cc1:ModalPopupExtender>

            <asp:Panel runat="server" ID="pnl1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Master</h4>
                        </div>
                        <div class="modal-body">
                            <div id="div12" runat="server" class="marg20" style="margin-top: 50px">
                                <iframe id="ifrm1" runat="server" frameborder="0" allowfullscreen="true" width="860px" height="400px"></iframe>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="btnclose" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <div class="modal fade" id="unitModel" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Maste</h4>
                        </div>
                        <div class="modal-body">
                            <div id="divUnit" runat="server" class="marg20">
                                <iframe width="120" height="700" frameborder="0" allowfullscreen></iframe>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <a href="Master.aspx" id="bMaster" runat="server" visible="false">
                <img src="assets/img/goback-5-w800.png" height="50" width="130" /></a>
            <iframe width="100%" height="1000" id="ifm" runat="server" frameborder="0" allowfullscreen="true" scrolling="yes" visible="false"></iframe>
        </div>
    </div>


   <%-- <script src="../assets/plugins/jquery-1.10.2.js"></script>
    <script src="../assets/plugins/bootstrap/bootstrap.min.js"></script>
    <script src="../assets/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="../assets/plugins/pace/pace.js"></script>
    <script src="../assets/scripts/siminta.js"></script>
    <!-- Page-Level Plugin Scripts-->
    <script src="../assets/plugins/morris/raphael-2.1.0.min.js"></script>
    <script src="../assets/plugins/morris/morris.js"></script>
    <script src="../assets/scripts/dashboard-demo.js"></script>--%>

</asp:Content>
