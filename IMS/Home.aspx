<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="IMS.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pointer {
            cursor: pointer;
        }
    </style>

    <script>
        function openalert() {
            var hd1 = $("#<%=hd.ClientID%>").val;
            if (hd1 == 1) {
                alertify.alert('Success', 'Add New F Year')
            }
        }


        function openModal() {
            $("#myModal").modal({ backdrop: "static" });
            $('#myModal').modal('show');
        }

        function openModaldetails() {
            $("#OrderModel").modal({ backdrop: "static" });
            $('#OrderModel').modal('show');
        }
        $(function () {
            $(".gvorderDeatils").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
            <%--$("#<%=gvorderDeatils.ClientID%>").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                "responsive": true,
                "sPaginationType": "full_numbers"
            });--%>
        });

        //function loadorderlist(flag) {

        //    $('#datatable').DataTable({
        //        columns: [
        //            { 'data': 'ID' },
        //            { 'data': 'InvoiceNumber' },
        //            { 'data': 'PartyName' },
        //            { 'data': 'totalDiscount' },
        //            { 'data': 'totalAmount' },
        //            { 'data': 'grandTotal' },
        //            { 'data': 'Date' }
        //        ],
        //        bServerSide: true, "#<%=gvorderDeatils.ClientID%>"
        //        sAjaxSource: '~/Home.aspx/OrderDetails?orderTypeFlag=' + flag

        //    });

        //}
    </script>

 <%--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>--%>
<script type="text/javascript">
    google.load("visualization", "1", { packages: ["corechart"] });
    google.setOnLoadCallback(drawChart);
    function drawChart() {
        var options = {
            title: 'Top Selling Products',
            width: 600,
            height: 400,
            bar: { groupWidth: "95%" },
            legend: { position: "none" },
            isStacked: true
        };
        $.ajax({
            type: "POST",
            url: "Home.aspx/GetChartData",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                var data = google.visualization.arrayToDataTable(r.d);
                var chart = new google.visualization.ColumnChart($("#chart")[0]);
                chart.draw(data, options);
            },
            failure: function (r) {
                alert(r.d);
            },
            error: function (r) {
                alert(r.d);
            }
        });
    }
</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>

        <div class="row">
            <!-- Page Header -->
            <div class="col-lg-12">
               <!--<h1 class="page-header">Dashboard</h1>-->
            </div>
            <!--End Page Header -->
        </div><br />

        <div class="row">
            <!-- Welcome -->
            <div class="col-lg-12">
                <div class="alert alert-info">
                    <i class="fa fa-folder-open"></i><b>&nbsp;Hello ! </b>Welcome Back <b runat="server" id="ownername"></b>.                   
                </div>
            </div>
            <!--end  Welcome -->
        </div>
        <!---=====================This block is for purchase and scale today and monthly collection =========================-->
        <div class="row">
            <!--quick info section -->
            <div class="col-lg-3 pointer">
                <asp:Button ID="PurchaseOrderList" Class="purchase" runat="server" OnClick="PurchaseOrderList_Click" Style="display: none; cursor: pointer"></asp:Button>
                <div class="alert alert-danger col-lg-12 col-md-12 col-sm-12 col-xs-12" style="background-color:#da8c10;" id="1" onclick="document.getElementById('<%= PurchaseOrderList.ClientID %>').click()">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 text-center" style="color:white;">
                        <i class="fa fa-calendar fa-3x"></i><b>
                            <%--<button type="button" ID="PurchaseOrderList" runat="server" class="btn btn-info btn-lg" data-toggle="modal" data-target="#OrderModel" onclick="loadorderlist('Purchase')"></button>--%>
                            <asp:Label ID="po" runat="server" ForeColor="White"></asp:Label>
                        </b>
                    </div>
                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12" style="color:white;">
                        Purchase order in last 30 Days
                    </div>
                </div>
            </div>


            <div class="col-lg-3 pointer">
                <asp:Button ID="SalesOrderList" runat="server" OnClick="SalesOrderList_Click" Style="display: none"></asp:Button>

                <div class="alert  col-lg-12 col-md-12 col-sm-12 col-xs-12" style="background-color:#dd4b39;"  onclick="document.getElementById('<%= SalesOrderList.ClientID %>').click()">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 text-center">
                        <i class="fa fa-address-card fa-3x" style="color:white;"></i><b>
                            <asp:Label ID="lblsalorder" runat="server" ForeColor="White"></asp:Label>
                        </b>
                    </div>
                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12" style="color:white"; >
                        Sales order in last 30 Days
                    </div>
                </div>
            </div>
            <!--===================================This block is for today sale and monthly sale====================================-->
            <div class="col-lg-3">

                <div class="alert col-lg-12 col-md-12 col-sm-12 col-xs-12" style="background-color: #00a65a">
                    <nav>
                        <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" style="text-decoration: none; color:white;" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Today's</a>
                            <a class="nav-item nav-link " style="text-decoration: none;color:white;" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">This Month </a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent" style="max-height: 38px; min-height: 38px">
                        <div class="" style="color:white;" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <br />

                            Total Sale Rs
                                    <asp:Label ID="lbldailysale" runat="server"></asp:Label>

                        </div>
                        <div class="tab-pane fade" style="color:white;" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                            <br />
                            Total Sale Rs
                                    <asp:Label ID="lblMonthlySale" runat="server"></asp:Label>

                        </div>

                    </div>


                    <%--<nav class="nav justify-content-center">
                        <a href="#home">Home</a>
                        <a  href="#menu1">One</a>
                     </nav>--%>
                </div>
            </div>

            <!--===================================This block is for today Purchase and monthly Purchase====================================-->
            <div class="col-lg-3">

                <div class="alert  col-lg-12 col-md-12 col-sm-12 col-xs-12" style="background-color: #00c0ef">
                    <nav>
                        <div class="nav nav-tabs nav-fill" id="nav-tab-one" role="tablist">
                            <a class="nav-item nav-link active" style="text-decoration: none; color:white;" id="nav-purch-today" data-toggle="tab" href="#divpurchlbltoday" role="tab" aria-controls="nav-home" aria-selected="true">Today's</a>
                            <a class="nav-item nav-link " style="text-decoration: none; color:white;" id="nav-purch-month" data-toggle="tab" href="#divpuchaselblmonth" role="tab" aria-controls="nav-profile" aria-selected="false">This Month </a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent-one" style="max-height: 38px; min-height: 38px">
                        <div class="" style="color:white;"  id="divpurchlbltoday" role="tabpanel" aria-labelledby="nav-purch-today">
                            <br />

                            Total Purchase Rs
                                    <asp:Label ID="lblDailyPurchase" runat="server"></asp:Label>

                        </div>
                        <div class="tab-pane fade" style="color:white;" id="divpuchaselblmonth" role="tabpanel" aria-labelledby="nav-purch-month">
                            <br />
                            Total Purchase Rs
                                    <asp:Label ID="lblMonthlyPurchase" runat="server"></asp:Label>

                        </div>

                    </div>


                    <%--<nav class="nav justify-content-center">
                        <a href="#home">Home</a>
                        <a  href="#menu1">One</a>
                     </nav>--%>
                </div>
            </div>






            <!--<div class="col-lg-3">
                <div class="alert alert-info col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 text-center">
                        <i class="fa fa-address-card fa-3x"></i><b>
                            <asp:Label ID="lblpurchaseamount" runat="server"></asp:Label>
                        </b>
                    </div>
                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                        Purchase amount of last 30 days
                    </div>
                </div>
            </div>-->


            <!--<div class="col-lg-3">
                <div class="alert alert-warning col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 text-center">
                        <i class="fa fa-address-card fa-3x"></i><b>
                            <asp:Label ID="lblsalesamount" runat="server"></asp:Label>
                        </b>
                    </div>
                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                        Sales amount of last 30 days
                    </div>
                </div>
            </div>-->
            <!--end quick info section -->
        </div>

        <div class="row">
            <div class="col-lg-8">



                <!--Area chart example -->
                <div class="panel panel-primary" style="display: none">
                    <div class="panel-heading">
                        <i class="fa fa-bar-chart-o fa-fw"></i>Low Stock Products
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                        Actions
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                        <li><a href="#">Action</a>
                                        </li>
                                        <li><a href="#">Another action</a>
                                        </li>
                                        <li><a href="#">Something else here</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li><a href="#">Separated link</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="table-responsive">
                                    <table class='table table-bordered table-hover table-striped'>
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Product Name</th>
                                                <th>Reorder Level</th>
                                                <th>Aavailable Qty</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>2</td>
                                                <td style='width: 300px;'><a href='#'>Watchs</a></td>
                                                <td style='color: green; font-size: 15px'>100</td>
                                                <td style='color: red; font-size: 15px'>-2003</td>

                                            </tr>
                                            <tr>
                                                <td>3</td>
                                                <td style='width: 300px;'>
                                                    <a href='#'>Watchs</a>

                                                </td>
                                                <td style='color: green; font-size: 15px'>100</td>
                                                <td style='color: red; font-size: 15px'>-2003</td>

                                            </tr>
                                            <tr>
                                                <td>4</td>
                                                <td style='width: 300px;'><a href='#'>Watchs</a></td>
                                                <td style='color: green; font-size: 15px'>100</td>
                                                <td style='color: red; font-size: 15px'>-2018</td>

                                            </tr>
                                            <tr>
                                                <td>5</td>
                                                <td style='width: 300px;'>
                                                    <a href='#'>Helmet</a></td>
                                                <td style='color: green; font-size: 15px'>57</td>
                                                <td style='color: red; font-size: 15px'>-3</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <%-- <asp:GridView ID="grvlowstockproducts" runat="server" Visible="false"
                                        AutoGenerateColumns="false" CssClass="table" AllowPaging="True" GridLines="none">
                                        <Columns>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblstock_id" runat="server" Text='<%# Eval("stock_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Product" HeaderStyle-ForeColor="Black" ItemStyle-Width="350px" HeaderStyle-Width="350px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblhsn_code" runat="server" Text='<%# Eval("hsn_code") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproduct_code" runat="server" Text='<%# Eval("product_code") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reorder Level">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReorderlevel" runat="server" Text='<%# Eval("Reorderlevel") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Available Quantity">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblquantity" ForeColor="Red" Font-Bold="true" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>--%>
                                </div>
                            </div>
                        </div>
                        <%--<div id="morris-area-chart"></div>--%>
                    </div>

                </div>
                <!--End area chart example -->
                <!--Simple table example -->
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="fa fa-bar-chart-o fa-fw"></i>Low Stock Products
                            <div class="pull-right">
                                <div class="btn-group">
                                </div>
                            </div>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="table-responsive">
                                    <asp:GridView ID="grvlowstockproducts" runat="server"
                                        AutoGenerateColumns="false" CssClass="table" AllowPaging="True" GridLines="none">
                                        <Columns>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblstock_id" runat="server" Text='<%# Eval("stock_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Product" HeaderStyle-ForeColor="Black" ItemStyle-Width="250px" HeaderStyle-Width="250px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Batch" HeaderStyle-ForeColor="Black" ItemStyle-Width="100px" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblbatch_name" runat="server" Text='<%# Eval("batch_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblhsn_code" runat="server" Text='<%# Eval("hsn_code") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproduct_code" runat="server" Text='<%# Eval("product_code") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reorder Level" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReorderlevel" runat="server" Text='<%# Eval("Reorderlevel") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Available Quantity" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblquantity" ForeColor="Red" Font-Bold="true" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <%-- <div id="div_lowstockproduct" runat="server">
                                    </div>--%>
                                </div>

                            </div>

                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!--End simple table example -->

            </div>

            <div class="col-lg-4">
                <div class="panel panel-primary text-center no-boder">
                    <div class="panel-body yellow">
                        <i class="fa fa-bar-chart-o fa-3x"></i>
                        <h3>
                            <asp:Label ID="lblcustomers" runat="server"></asp:Label></h3>
                    </div>
                    <div class="panel-footer">
                        <span class="panel-eyecandy-title" id="customers" runat="server">Total Customers
                        </span>
                    </div>
                </div>
                <%--<div class="panel panel-primary text-center no-boder">
                    <div class="panel-body blue">
                        <i class="fa fa-pencil-square-o fa-3x"></i>
                        <h3>
                            <asp:Label ID="lblVendors" runat="server"></asp:Label></h3>
                    </div>
                    <div class="panel-footer">
                        <span class="panel-eyecandy-title">Total Vendors
                        </span>
                    </div>
                </div>
                <div class="panel panel-primary text-center no-boder">
                    <div class="panel-body green">
                        <i class="fa fa fa-floppy-o fa-3x"></i>
                        <h3>20 GB</h3>
                    </div>
                    <div class="panel-footer">
                        <span class="panel-eyecandy-title">New Data Uploaded
                        </span>
                    </div>
                </div>
                <div class="panel panel-primary text-center no-boder">
                    <div class="panel-body red">
                        <i class="fa fa-thumbs-up fa-3x"></i>
                        <h3>2,700 </h3>
                    </div>
                    <div class="panel-footer">
                        <span class="panel-eyecandy-title">New User Registered
                        </span>
                    </div>
                </div>--%>
            </div>

        </div>
        <div class="row">
            <div id="chart" style="width: 900px; height: 500px;"></div>
        </div>
        <%--<div class="row">
            <div class="col-lg-4">
                <!-- Notifications-->
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i>Notifications Panel
                    </div>

                    <div class="panel-body">
                        <div class="list-group">
                            <a href="#" class="list-group-item">
                                <i class="fa fa-comment fa-fw"></i>New Comment
                                    <span class="pull-right text-muted small"><em>4 minutes ago</em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-twitter fa-fw"></i>3 New Followers
                                    <span class="pull-right text-muted small"><em>12 minutes ago</em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-envelope fa-fw"></i>Message Sent
                                    <span class="pull-right text-muted small"><em>27 minutes ago</em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-tasks fa-fw"></i>New Task
                                    <span class="pull-right text-muted small"><em>43 minutes ago</em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-upload fa-fw"></i>Server Rebooted
                                    <span class="pull-right text-muted small"><em>11:32 AM</em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-bolt fa-fw"></i>Server Crashed!
                                    <span class="pull-right text-muted small"><em>11:13 AM</em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-warning fa-fw"></i>Server Not Responding
                                    <span class="pull-right text-muted small"><em>10:57 AM</em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-shopping-cart fa-fw"></i>New Order Placed
                                    <span class="pull-right text-muted small"><em>9:49 AM</em>
                                    </span>
                            </a>

                        </div>
                        <!-- /.list-group -->
                        <a href="#" class="btn btn-default btn-block">View All Alerts</a>
                    </div>

                </div>
                <!--End Notifications-->
            </div>
            <div class="col-lg-4">
                <!-- Donut Example-->
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <i class="fa fa-bar-chart-o fa-fw"></i>Donut Chart Example
                    </div>
                    <div class="panel-body">
                        <div id="morris-donut-chart"></div>
                        <a href="#" class="btn btn-default btn-block">View Details</a>
                    </div>

                </div>
                <!--End Donut Example-->
            </div>
            <div class="col-lg-4">
                <!-- Chat Panel Example-->
                <div class="chat-panel panel panel-primary">
                    <div class="panel-heading">
                        <i class="fa fa-comments fa-fw"></i>
                        Chat
                            <div class="btn-group pull-right">
                                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-chevron-down"></i>
                                </button>
                                <ul class="dropdown-menu slidedown">
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-refresh fa-fw"></i>Refresh
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-check-circle fa-fw"></i>Available
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-times fa-fw"></i>Busy
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-clock-o fa-fw"></i>Away
                                        </a>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-sign-out fa-fw"></i>Sign Out
                                        </a>
                                    </li>
                                </ul>
                            </div>
                    </div>

                    <div class="panel-body">
                        <ul class="chat">
                            <li class="left clearfix">
                                <span class="chat-img pull-left">
                                    <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />
                                </span>
                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <strong class="primary-font">Jack Sparrow</strong>
                                        <small class="pull-right text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i>12 mins ago
                                        </small>
                                    </div>
                                    <p>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                                    </p>
                                </div>
                            </li>
                            <li class="right clearfix">
                                <span class="chat-img pull-right">
                                    <img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar" class="img-circle" />
                                </span>
                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <small class=" text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i>13 mins ago</small>
                                        <strong class="pull-right primary-font">Bhaumik Patel</strong>
                                    </div>
                                    <p>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                                    </p>
                                </div>
                            </li>
                            <li class="left clearfix">
                                <span class="chat-img pull-left">
                                    <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />
                                </span>
                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <strong class="primary-font">Jack Sparrow</strong>
                                        <small class="pull-right text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i>14 mins ago</small>
                                    </div>
                                    <p>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                                    </p>
                                </div>
                            </li>
                            <li class="right clearfix">
                                <span class="chat-img pull-right">
                                    <img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar" class="img-circle" />
                                </span>
                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <small class=" text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i>15 mins ago</small>
                                        <strong class="pull-right primary-font">Bhaumik Patel</strong>
                                    </div>
                                    <p>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <div class="panel-footer">
                        <div class="input-group">
                            <input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />
                            <span class="input-group-btn">
                                <button class="btn btn-warning btn-sm" id="btn-chat">
                                    Send
                                </button>
                            </span>
                        </div>
                    </div>

                </div>
                <!--End Chat Panel Example-->
            </div>
        </div>--%>
        <!-- Modal -->
        <div class="modal fade" id="OrderModel" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <asp:Label ID="lblModelHeader" runat="server"></asp:Label></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px; margin-top: 10px">

                                <%--    <table class="table table-hover table-dark" id="datatable">
                                    <thead>
                                        <tr>
                                            <th scope="col">Sr.No</th>
                                            <th scope="col">Invice No</th>
                                            <th scope="col">Customer Name</th>
                                            <th scope="col" class="hidden">ID</th>
                                            <th scope="col">Discount</th>
                                            <th scope="col">Amount</th>
                                            <th scope="col">Total</th>
                                            <th scope="col">Date</th>
                                        </tr>
                                    </thead>
                                   
                                </table>--%>

                                <asp:GridView ID="gvorderDeatils" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" BorderStyle="None" GridLines="Horizontal"
                                    AllowPaging="true" OnPageIndexChanging="gvorderDeatils_PageIndexChanging" PageSize="10">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr.No">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="InvoiceNumber" HeaderText="Invice No"></asp:BoundField>
                                        <asp:BoundField DataField="PartyName" HeaderText="Customer Name"></asp:BoundField>
                                        <asp:BoundField DataField="ID" HeaderText="id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                        <asp:BoundField DataField="TotalDiscount" HeaderText="Total Discount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="TotalTax" HeaderText="Total Tax" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="GrandTotal" HeaderText="GrandTotal" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="GivenAmnt" HeaderText="Given Amnt" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="BalanceAmnt" HeaderText="Balance Amnt" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                    </Columns>
                                    <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                                    <PagerStyle CssClass="pagination-ys" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="Button2" runat="server" Text="Export To Excel" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>

            <asp:HiddenField ID="HiddenField1" runat="server" />
        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <%--<button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modal Header</h4>--%>
                    </div>
                    <div class="modal-body">
                        <div id="div12" runat="server" class="marg20" style="margin-top: 50px">
                            <div id="div1" runat="server" class="marg20" style="margin-top: 50px">
                                <iframe id="ifrm1" runat="server" frameborder="0" allowfullscreen="true" width="860px" height="400px"></iframe>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="Button1" runat="server" Text="Logout" CssClass="btn-circle btn-danger" OnClick="Button1_Click" />
                    </div>
                </div>
            </div>

            <asp:HiddenField ID="hd" runat="server" />
        </div>
    </div>


    <script>

        //This  query is for Sale on daily and month collection tab.
           $(function () {
               $("#nav-home-tab").click(function () {
                   // remove classes from all
                   $("#nav-home-tab").addClass("active");
                   // add class to the one we clicked
                   $("#nav-profile-tab").removeClass("active");
               });
               $("#nav-profile-tab").click(function () {
                   // remove classes from all
                   $("#nav-profile-tab").addClass("active");
                   // add class to the one we clicked
                   $("#nav-home").addClass("tab-pane fade");
                   $("#nav-home-tab").removeClass("active");
               });
           });

       //This query is for Purchase on daily and month collection tab.


       $(function () {
           $("#nav-purch-today").click(function () {
               // remove classes from all
               $("#nav-purch-today").addClass("active");
               // add class to the one we clicked
               $("#nav-purch-month").removeClass("active");
           });
           $("#nav-purch-month").click(function () {
               // remove classes from all
               $("#nav-purch-month").addClass("active");
               // add class to the one we clicked
               $("#divpurchlbltoday").addClass("tab-pane fade");
               $("#nav-purch-today").removeClass("active");
           });
       });


    </script >

</asp:Content>

