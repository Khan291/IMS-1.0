<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="IMS.Reports" %>
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
                        <b class="font30 ">Purchase Report</b>
                        <br />
                        <i class="fa fa fa-tag fa-3x padd20"></i>
                        <br />
                        <asp:Button ID="btnPurchase" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnPurchase_Click" />
                        <br />
                    </div>
                </div>
                <div class="col-md-4" id="div2" runat="server">
                    <div class="Blue text-center padd20">
                        <b class="font30 ">Sale Report</b>
                        <br />
                        <i class="fa fa fa-balance-scale fa-3x padd20"></i>
                        <br />
                        <asp:Button ID="btnSale" runat="server" CssClass="btn btn-info marg20" Text="Open" OnClick="btnSale_Click"/>
                        <br />
                    </div>
                </div>
             
            </div>
        </div>
    </div>
    <div>

       
        
        <a href="Reports.aspx" id="bMaster" runat="server" visible="false"><img src="assets/img/goback-5-w800.png" height="50" width="130"   /></a>
         <iframe width="100%" height="1000" id="ifm" runat="server"  frameborder="0" allowfullscreen="true" scrolling="yes" visible="false">

    </iframe>
    </div>
   </div>


        <script src="assets/plugins/jquery-1.10.2.js"></script>
        <script src="assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="assets/plugins/pace/pace.js"></script>
        <script src="assets/scripts/siminta.js"></script>
        <!-- Page-Level Plugin Scripts-->
        <script src="assets/plugins/dataTables/jquery.dataTables.js"></script>
        <script src="assets/plugins/dataTables/dataTables.bootstrap.js"></script>
</asp:Content>
