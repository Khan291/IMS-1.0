<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="IMS._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <!-- Theme Made By www.w3schools.com - No Copyright -->
    <title>IMS Bizz</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css"/>
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body {
            font: 400 15px Lato, sans-serif;
            line-height: 1.8;
            color: #818181;
        }

        h2 {
            font-size: 24px;
            text-transform: uppercase;
            color: #303030;
            font-weight: 600;
            margin-bottom: 30px;
        }

        h4 {
            font-size: 19px;
            line-height: 1.375em;
            color: #303030;
            font-weight: 400;
            margin-bottom: 30px;
        }

        .jumbotron1 {
            height: 650px;
            background-image: url(../assets/img/backgroundbanner.png);
            background-size: cover;
            color: #fff;
            padding: 100px 25px;
            font-family: Montserrat, sans-serif;
        }

        div.a {
    font-size: 50px;
     }

        /*.tooltip {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    
    /* Position the tooltip */
    /*position: absolute;
    z-index: 1;
    top: 100%;
    left: 50%;
    margin-left: -60px;
}

.tooltip:hover .tooltiptext {
    visibility: visible;
}*/


        .container-fluid {
            padding: 60px 50px;
        }

        .bg-grey {
            background-color: #f6f6f6;
        }

        .logo-small {
            color: #090e63;
            font-size: 50px;
        }

        .logo {
            color: #090e63;
            font-size: 200px;
        }

        .thumbnail {
            padding: 0 0 15px 0;
            border: none;
            border-radius: 0;
        }

            .thumbnail img {
                width: 100%;
                height: 100%;
                margin-bottom: 10px;
            }

        .carousel-control.right, .carousel-control.left {
            background-image: none;
            color: #f4511e;
        }

        .carousel-indicators li {
            border-color: #f4511e;
        }

            .carousel-indicators li.active {
                background-color: #f4511e;
            }

        .item h4 {
            font-size: 19px;
            line-height: 1.375em;
            font-weight: 400;
            font-style: italic;
            margin: 70px 0;
        }

        .item span {
            font-style: normal;
        }

        .panel {
            border: 1px solid #090e63;
            border-radius: 0 !important;
            transition: box-shadow 0.5s;
        }

            .panel:hover {
                box-shadow: 5px 0px 40px rgba(0,0,0, .2);
            }

        .panel-footer .btn:hover {
            border: 1px solid #090e63;
            background-color: #fff !important;
            color: #f4511e;
        }

        .panel-heading {
            color: #fff !important;
            background-color: #090e63 !important;
            padding: 25px;
            border-bottom: 1px solid transparent;
            border-top-left-radius: 0px;
            border-top-right-radius: 0px;
            border-bottom-left-radius: 0px;
            border-bottom-right-radius: 0px;
        }

        .panel-footer {
            background-color: white !important;
        }

            .panel-footer h3 {
                font-size: 32px;
            }

            .panel-footer h4 {
                color: #aaa;
                font-size: 14px;
            }

            .panel-footer .btn {
                margin: 15px 0;
                background-color: green;
                color: #fff;
            }

        .navbar {
            margin-bottom: 0;
            background-color: #090e63;
            z-index: 9999;
            border: 0;
            font-size: 12px !important;
            line-height: 1.42857143 !important;
            letter-spacing: 4px;
            border-radius: 0;
            font-family: Montserrat, sans-serif;
        }

            .navbar li a, .navbar .navbar-brand {
                color: #fff !important;
            }

        .navbar-nav li a:hover, .navbar-nav li.active a {
            color: #f4511e !important;
            background-color: #fff !important;
        }

        .navbar-default .navbar-toggle {
            border-color: transparent;
            color: #fff !important;
        }

        footer .glyphicon {
            font-size: 20px;
            margin-bottom: 20px;
            color: #f4511e;
        }

        .slideanim {
            visibility: hidden;
        }

        .slide {
            animation-name: slide;
            -webkit-animation-name: slide;
            animation-duration: 1s;
            -webkit-animation-duration: 1s;
            visibility: visible;
        }

        @keyframes slide {
            0% {
                opacity: 0;
                transform: translateY(70%);
            }

            100% {
                opacity: 1;
                transform: translateY(0%);
            }
        }

        @-webkit-keyframes slide {
            0% {
                opacity: 0;
                -webkit-transform: translateY(70%);
            }

            100% {
                opacity: 1;
                -webkit-transform: translateY(0%);
            }
        }

        @media screen and (max-width: 768px) {
            .col-sm-4 {
                text-align: center;
                margin: 25px 0;
            }

            .btn-lg {
                width: 100%;
                margin-bottom: 35px;
            }
        }

        @media screen and (max-width: 480px) {
            .logo {
                font-size: 150px;
            }
        }
    </style>
    <script>
        function myFunction1() {
            var x = document.getElementById("setup");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction2() {
            var x = document.getElementById("warehouse");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction3() {
            var x = document.getElementById("purchase");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction4() {
            var x = document.getElementById("sales");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction5() {
            var x = document.getElementById("userrights");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction6() {
            var x = document.getElementById("recording");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction7() {
            var x = document.getElementById("barcode");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction8() {
            var x = document.getElementById("itemcost");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction9() {
            var x = document.getElementById("imp_exp");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction10() {
            var x = document.getElementById("dashboard");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }

        function myFunction11() {
            var x = document.getElementById("payment");
            var x1 = document.getElementById("features");
            if (x.style.display === "none") {
                x1.style.display = "none";
                x.style.display = "block";
            } else {
                x.style.display = "none";

                x1.style.display = "block";
                x12.style.display = "block";
            }
        }
    </script>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
    <form id="form1" runat="server">
    <div>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#myPage">!MS B!ZZ</a>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
               
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#about">ABOUT</a></li>
                    <li><a href="#services">FEATURES</a></li>
                    <li><a href="#portfolio">GET STARTED</a></li>
                    <li><a href="#pricing">PRICING</a></li>
                    <li><a href="#contact">CONTACT</a></li>
                    <li><a href="Login.aspx">Login</a></li>
                    <!--<button style=" border: 1px solid green; background-color:green" type="button" class="btn btn-danger">Log In</button>-->
               </ul>
                
            </div>
        </div>
    </nav>

    <div class="jumbotron1 text-center">
        <div class="a">MANAGE YOUR INVENTORY IN THE CLOUD WITH IMS BIZZ</div>
        <h1 style="color:yellow">Start Today</h1>
        <h3 style="color:yellow">Free Trial For 15 Days </h3>
        
        <button style=" border: 1px solid green; background-color:green" type="button" class="btn btn-danger">Free Trial</button>

        <!--<p>We specialize in blablabla</p>-->
        <form>
            <!--<div class="input-group">
                <input type="email" class="form-control" size="50" placeholder="Email Address" required>
                <div class="input-group-btn">
                    <button type="button" class="btn btn-danger">Subscribe</button>
                </div>
            </div>-->
        </form>
    </div>

    <!-- Container (About Section) -->
    <div id="about" class="container-fluid">
        <div class="row">
            <div class="col-sm-8">
                <h2>About IMS BIZZ</h2><br>
                <h4>IMS is a cloud-based inventory management solution that gives businesses the ability to manage their inventory on any device and from any location. Create and manage sales orders, purchase orders, and other essential items to get orders flowing in and out of your warehouses.</h4><br>
                <!--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>-->
                <!--<br><button class="btn btn-default btn-lg">Get in Touch</button>-->
            </div>
            <div class="col-sm-4">
                <span class="glyphicon glyphicon-signal logo"></span>
            </div>
        </div>
    </div>

    <!--<div class="container-fluid bg-grey">
        <div class="row">
            <div class="col-sm-4">
                <span class="glyphicon glyphicon-globe logo slideanim"></span>
            </div>
            <div class="col-sm-8" >
                <h2>Features</h2><br>
                <h4>MANAGE YOUR INVENTORY IN THE CLOUD WITH IMS BIZZ</h4>
                <p>
                    IMS has numerous features and capabilities to help with inventory management:
                    <ul>
                        <li>•	Simple Setup and Accessibility.</li>
                        <li>•	Multiple Warehouses.</li>
                        <li>•	Purchase Orders.</li>
                        <li>•	Purchase Return.</li>
                        <li>•	Sales Orders.</li>
                        <li>•	Sale Return.</li>
                        <li>•	User Rights.</li>
                        <li>•	Barcode.</li>
                        <li>•	Reordering.</li>
                        <li>•	Item Cost Tracking</li>
                        <li>•	Attractive Dashboard.</li>
                        <li>•	Data Imports and Exports.</li>
                        <li>•	Payments.</li>

                    </ul>
                </p>

                <h3>Simple Setup and Accessibility:</h3>
                <p>
                    With IMS there is no software to download. All you do is open a Web browser on any device connected
                    to the Internet, then log into your IMS account and you have access to all of its features. The data you
                    record is saved to a secure offsite server, so you don’t have to worry about computer crashes or server
                    maintenance. Your data is always safe and accessible to the right people. Securely manage sales orders, purchasing,
                    receiving, and picking anytime from anywhere.
                </p>
                <h3>Multiple Warehouses:</h3>
                <p>
                    IMS lets you track your inventory in as many warehouses and sub-locations as you need. Check inventory counts
                    by location, so if you ever run low on products at one you can quickly transfer some from another. You can easily
                    find where your parts and products are supposed to be by their rack numbers and you can also organize your warehouses
                    to maximize efficiency in receiving, storing, and picking.
                </p>

                <h3>Purchase Orders:</h3>
                <p>  IMS’s purchasing module lets you keep track of many important areas pertaining to ordering. Create and track purchase orders, generate PO reports to stay on top of trends, and print receiving tickets to ensure every part and product that arrives at your warehouse matches up with what you ordered. This module also helps you track vendor’s performance. It’s important to compare vendors and see which ones are consistently on time and give you the best price.</p>

                <h3>   Sales Orders:</h3>
                <p> IMS Sales module helps you monitor customers and sales orders. Add tax rates and assign discounts on a per-customer basis, and then print invoices, pick tickets, and much more with this handy module. Sales orders are flexible and can be changed from bids or quotes to a status of accepted and fulfilled. Sales order line items allow you to record a number of important details, including sales, miscellaneous sales, miscellaneous credits, notes, and discounts.</p>

                <h3> User Rights:</h3>
                <p>  User rights allow you to control who sees what in your IMS account. You can limit access to only those modules that your employees need in order to do their jobs. That way, you avoid data breaches and confusing employees with unnecessary options. For example, if a Purchase worker only needs access to the modules associated with receiving and ordering inventory, you can grant them access to those modules while denying them access to reports, settings, and locations that are irrelevant to their duties.</p>

                <h3> Item Cost Tracking:</h3>
                <p> Want to know the total value of your inventory at all times? IMS gives you this information. Every step of the way, from initial order to final delivery to customers, IMS tracks item costs to ensure you have a clear picture of your inventory’s value in real time.</p>

                <h3> Data Imports and Exports:</h3>
                <p> It’s a simple process to import and export data in IMS. You can download data into CSV files and also upload data into IMS via the same means. The data you can give and receive covers a wide variety of things, such as cycle counts, orders, customers, vendors, products, locations, reports, and more.</p>

                <h3>Attractive Dashboard:</h3>
                <h4>Top selling Items</h4>  <p>or Products for this month</p>
                <h4>Inventory Summary</h4>  <p>displays the total quantity of items you have on hand and the total quantity of ordered items that are yet to reach your warehouse.</p>
                <h4>Product Details</h4>  <p>this section lets you know the number of items that are below their reorder points (Low Stock items), total number of item groups and the total number of items in your inventory. This section will also let you know the percentage of active items on your inventory and 7 top selling items by volume (top selling items alone can be viewed for a time period of your choice).</p>
                <h4>Purchase Order</h4>  <p>this section with tell you the total quantity of items ordered from vendors and their value.</p>
                <h4>Sales Orders</h4>  <p>this section will list the number of sales orders from direct sales and each of your e-commerce channels for a time period of your choice.</p>
                <h4>Sales Order Summary graph</h4>  <p>this section will display a graph that displays the value of sales across different channels for a time period of your choice.</p>

                <h3> Reordering:</h3>
                <p>You can set up automatic minimum, maximum, and alert-level reorder points on a per-location basis for each inventory item’s quantity. You can also create SMS and email notifications for alert and minimum levels (limit 1 phone number and 3 email addresses).</p>

                <h3> Payments:</h3>
                <p>Accept payments via customers’ debit and credit cards, cash, and/or checks in IMS Bizz Sales Order module.</p>


            </div>
        </div>
    </div>-->

    <!-- Container (Services Section) -->
    <div id="services" class="container-fluid text-center" >
        <h2>FEATURES</h2>
        <br />
        <div id="setup" style="display:none;text-align:justify">
            <h2 class="text-center">Simple Setup and Accessibility</h2>
            <p>
                With IMS there is no software to download. All you do is open a Web browser on any device connected
                to the Internet, then log into your IMS account and you have access to all of its features. The data you
                record is saved to a secure offsite server, so you don’t have to worry about computer crashes or server
                maintenance. Your data is always safe and accessible to the right people. Securely manage sales orders, purchasing,
                receiving, and picking anytime from anywhere.
            </p>
            <button onclick="myFunction1()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="warehouse" style="display:none;text-align:justify">
            <h2 class="text-center">ware house</h2>
            <p>
                IMS lets you track your inventory in as many warehouses and sub-locations as you need. Check inventory counts
                by location, so if you ever run low on products at one you can quickly transfer some from another. You can easily
                find where your parts and products are supposed to be by their rack numbers and you can also organize your warehouses
                to maximize efficiency in receiving, storing, and picking.
            </p>
            <button onclick="myFunction2()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="purchase" style="display:none;text-align:justify">
            <h2 class="text-center">ware house</h2>
            <p>
                IMS’s purchasing module lets you keep track of many important areas pertaining to ordering. 
                Create and track purchase orders, generate PO reports to stay on top of trends, and print receiving tickets to ensure 
                every part and product that arrives at your warehouse matches up with what you ordered. This module also helps you track vendor’s
                 performance. It’s important to compare vendors and see which ones are consistently on time and give you the best price.
            </p>
            <button onclick="myFunction3()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="sales" style="display:none;text-align:justify">
            <h2 class="text-center">ware house</h2>
            <p>
                IMS Sales module helps you monitor customers and sales orders. Add tax rates and assign discounts on a 
                per-customer basis, and then print invoices, pick tickets, and much more with this handy module.
                 Sales orders are flexible and can be changed from bids or quotes to a status of accepted and fulfilled.
                 Sales order line items allow you to record a number of important details, including sales, miscellaneous sales, 
                miscellaneous credits, notes, and discounts.
            </p>
            <button onclick="myFunction4()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="userrights" style="display:none;text-align:justify">
            <h2 class="text-center">User Rights</h2>
            <p>
                User rights allow you to control who sees what in your IMS account. You can limit access to only those
                 modules that your employees need in order to do their jobs. That way, you avoid data breaches and confusing
                 employees with unnecessary options. For example, if a Purchase worker only needs access to the modules associated
                 with receiving and ordering inventory, you can grant them access to those modules while denying them access to reports,
                 settings, and locations that are irrelevant to their duties.
            </p>
            <button onclick="myFunction5()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="recording" style="display:none;text-align:justify">
            <h2 class="text-center">Recording</h2>
            <p>
                You can set up automatic minimum, maximum, and alert-level reorder points on a per-location basis for 
                each inventory item’s quantity. You can also create SMS and email notifications for alert and minimum levels 
                (limit 1 phone number and 3 email addresses). 
            </p>
            <button onclick="myFunction6()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="barcode" style="display:none;text-align:justify">
            <h2 class="text-center">Barcode</h2>
            <p>
                You can set up automatic minimum, maximum, and alert-level reorder points on a per-location basis for
                each inventory item’s quantity. You can also create SMS and email notifications for alert and minimum levels
                (limit 1 phone number and 3 email addresses).
            </p>
            <button onclick="myFunction7()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="itemcost" style="display:none;text-align:justify">
            <h2 class="text-center">Item Cost Tracking</h2>
            <p>
                Want to know the total value of your inventory at all times? IMS gives you this information. Every step of the way, 
                from initial order to final delivery to customers, IMS tracks item costs to ensure you have a clear picture of your 
                inventory’s value in real time.
            </p>
            <button onclick="myFunction8()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="imp_exp" style="display:none;text-align:justify">
            <h2 class="text-center">Data Imports and Exports</h2>
            <p>
                It’s a simple process to import and export data in IMS. You can download data into CSV files 
                and also upload data into IMS via the same means. The data you can give and receive covers a 
                wide variety of things, such as cycle counts, orders, customers, vendors, products, locations, reports, and more
            </p>
            <button onclick="myFunction9()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="dashboard" style="display:none;text-align:justify">
            <h2 class="text-center"> Dashboard</h2>
            
            <h4>Top selling Items</h4>  <p>or Products for this month</p>
            <br />
            <h4>Inventory Summary</h4>  <p>displays the total quantity of items you have on hand and the total quantity of ordered items that are yet to reach your warehouse.</p>
            <br />
            <h4>Product Details</h4>  <p>this section lets you know the number of items that are below their reorder points (Low Stock items), total number of item groups and the total number of items in your inventory. This section will also let you know the percentage of active items on your inventory and 7 top selling items by volume (top selling items alone can be viewed for a time period of your choice).</p>
            <br />
            <h4>Purchase Order</h4>  <p>this section with tell you the total quantity of items ordered from vendors and their value.</p>
            <br />
            <h4>Sales Orders</h4>  <p>this section will list the number of sales orders from direct sales and each of your e-commerce channels for a time period of your choice.</p>
            <br />
            <h4>Sales Order Summary graph</h4>  <p>this section will display a graph that displays the value of sales across different channels for a time period of your choice.</p>

            
            <button onclick="myFunction10()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>

        <div id="payment" style="display:none;text-align:justify">
            <h2 class="text-center">Payments</h2>
            <p>
                Accept payments via customers’ debit and credit cards, cash, and/or checks in IMS Bizz Sales Order module.
            </p>
            <button onclick="myFunction11()" style=" border: 1px solid green; background-color:green" class="btn btn-primary text-center"> Show less</button>
        </div>
        <br>
       <div id="features">
           <div class="row slideanim">

               <div class="col-sm-4" id="setup_main">
                   <span class=" fa fa-cogs logo-small"></span>
                   <h4>Simple Setup and Accessibility</h4>
                   <button onclick="myFunction1()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>

               <div class="col-sm-4" id="warehouse_main">
                   <span class="fa fa-industry  logo-small"></span>
                   <h4>Multiple Warehouses</h4>
                   <button onclick="myFunction2()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>

               <div class="col-sm-4" id="po_main">
                   <span class="glyphicon glyphicon-shopping-cart logo-small"></span>
                   <h4>Purchase Orders & Return</h4>
                   <button onclick="myFunction3()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>
           </div>
           <br><br>
           <div class="row slideanim">
               
               <div class="col-sm-4" id="so_main">
                   <span class="glyphicon glyphicon-certificate logo-small"></span>
                   <h4>Sales Orders & Return</h4>
                   <button onclick="myFunction4()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>

               <div class="col-sm-4" id="ur_main">
                   <span class="fa fa-user logo-small"></span>
                   <h4>User Rights</h4>
                   <button onclick="myFunction5()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>

               <div class="col-sm-4" id="ro_main">
                   <span class="glyphicon glyphicon-record logo-small"></span>
                   <h4 style="color:#303030;">Reordring</h4>
                   <button onclick="myFunction6()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>
           </div>
           <br><br>
           <div class="row slideanim">               
               <div class="col-sm-4" id="barcode_main">
                   <span class="glyphicon glyphicon-barcode logo-small"></span>
                   <h4>Barcode</h4>
                   <button onclick="myFunction7()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>

               <div class="col-sm-4" id="ic_main">
                   <span class="fa fa-line-chart logo-small"></span>
                   <h4>Item Cost Tracking</h4>
                   <button onclick="myFunction8()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>

               <div class="col-sm-4" id="import_main">
                   <span class="glyphicon glyphicon-sort logo-small"></span>
                   <h4 style="color:#303030;">Data Imports and Exports</h4>
                   <button onclick="myFunction9()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>
              
           </div>
           <br><br>
           <div class="row slideanim">
              
               <div class="col-sm-4" id="adb_main">
                   <span class="glyphicon glyphicon-dashboard logo-small"></span>
                   <h4>Attractive Dashboard</h4>
                   <button onclick="myFunction10()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>

               <div class="col-sm-4" id="import_main">
                   <span class="glyphicon glyphicon-usd logo-small"></span>
                   <h4 style="color:#303030;">Payments</h4>
                   <button onclick="myFunction11()" style=" border: 1px solid green; background-color:green" class="btn btn-primary"> Show More</button>
               </div>
           </div>
       </div>
    </div>

    <!-- Container (Portfolio Section) -->
    <div id="portfolio" class="container-fluid text-center bg-grey">
        <h2>GET STARTED</h2><br>
        <h4>Get Started with IMS:</h4>
        <p> IMS continues to add new features. These are just a taste of what IMS is continuing to evolve into. See this cloud based inventory management solution in action by signing up for a free trial: </p>
        <div class="row text-center slideanim">
            <div class="col-sm-6">
                <h3>Already have an accont </h3>
                <button style=" border: 1px solid green; background-color:green" type="button" class="btn btn-danger">Click Here</button>

                <!--<div class="thumbnail">
                    <img src="paris.jpg" alt="Paris" width="400" height="300">
                    <p><strong>Paris</strong></p>
                    <p>Yes, we built Paris</p>
                </div>-->
            </div>
            <!--<div class="col-sm-4">
                <div class="thumbnail">
                    <img src="newyork.jpg" alt="New York" width="400" height="300">
                    <p><strong>New York</strong></p>
                    <p>We built New York</p>
                </div>
            </div>-->
            <div class="col-sm-6">

                <h3>Free trial for 15 days</h3>
                <button style=" border: 1px solid green; background-color:green"  type="button" class="btn btn-danger">Click Here</button>
                <!--<div class="thumbnail">
                    <img src="sanfran.jpg" alt="San Francisco" width="400" height="300">
                    <p><strong>San Francisco</strong></p>
                    <p>Yes, San Fran is ours</p>
                </div>-->
            </div>
        </div><br>

        <!--<h2>What our customers say</h2>
        <div id="myCarousel" class="carousel slide text-center" data-ride="carousel">-->
            <!-- Indicators -->
            <!--<ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>-->

            <!-- Wrapper for slides -->
            <!--<div class="carousel-inner" role="listbox">
                <div class="item active">
                    <h4>"This company is the best. I am so happy with the result!"<br><span>Michael Roe, Vice President, Comment Box</span></h4>
                </div>
                <div class="item">
                    <h4>"One word... WOW!!"<br><span>John Doe, Salesman, Rep Inc</span></h4>
                </div>
                <div class="item">
                    <h4>"Could I... BE any more happy with this company?"<br><span>Chandler Bing, Actor, FriendsAlot</span></h4>
                </div>
            </div>-->

            <!-- Left and right controls -->
            <!--<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>-->
    </div>

    <!-- Container (Pricing Section) -->
    <div id="pricing" class="container-fluid">
        <div class="text-center">
            <h2>Pricing</h2>
            <h4>Choose a payment plan that works for you</h4>
        </div>
        <div class="row slideanim">
            <div class="col-sm-4 col-xs-12">
                <div class="panel panel-default text-center">
                    <div class="panel-heading">
                        <h1>3 Month</h1>
                    </div>
                    <div class="panel-body">
                        
                    </div>
                    <div class="panel-footer">
                        <h3>$19</h3>
                        
                        <button class="btn btn-lg">Sign Up</button>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 col-xs-12">
                <div class="panel panel-default text-center">
                    <div class="panel-heading">
                        <h1>6 Month</h1>
                    </div>
                    <div class="panel-body">
                        
                      
                    </div>
                    <div class="panel-footer">
                        <h3>$29</h3>
                        
                        <button class="btn btn-lg">Sign Up</button>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 col-xs-12">
                <div class="panel panel-default text-center">
                    <div class="panel-heading">
                        <h1>1 Year</h1>
                    </div>
                    <div class="panel-body">
                        
                    </div>
                    <div class="panel-footer">
                        <h3>$49</h3>
                        
                        <button class="btn btn-lg">Sign Up</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Container (Contact Section) -->
    <div id="contact" class="container-fluid bg-grey">
        <h2 class="text-center">CONTACT</h2>
        <div class="row">
            <div class="col-sm-5">
                <h3>VISIT US</h3>
                <p><span class="glyphicon glyphicon-map-marker"></span>V.T.Technologies, Himayat Bagh, Beside Vidyalankar School Aurangabad, Maharashtra.</p>
                <!--<p><span class="glyphicon glyphicon-map-marker"></span> Chicago, US</p>-->
                <p><span class="glyphicon glyphicon-phone"></span> +91 9960969887</p>
                <p><span class="glyphicon glyphicon-envelope"></span> imsbizz@gmail.com</p>
            </div>
            <div class="col-sm-7 slideanim">
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <input class="form-control" id="name" name="name" placeholder="Name" type="text" required>
                    </div>
                    <div class="col-sm-6 form-group">
                        <input class="form-control" id="email" name="email" placeholder="Email" type="email" required>
                    </div>
                </div>
                <textarea class="form-control" id="comments" name="comments" placeholder="Comment" rows="5"></textarea><br>
                <div class="row">
                    <div class="col-sm-12 form-group">
                        <button class="btn btn-default pull-right" type="submit">Send</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Google Maps -->
    <!--<div id="googleMap" style="height:400px;width:100%;"></div>
    <script>
function myMap() {
var myCenter = new google.maps.LatLng(41.878114, -87.629798);
var mapProp = {center:myCenter, zoom:12, scrollwheel:false, draggable:false, mapTypeId:google.maps.MapTypeId.ROADMAP};
var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
var marker = new google.maps.Marker({position:myCenter});
marker.setMap(map);
}
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBu-916DdpKAjTmJNIgngS6HL_kDIKU0aU&callback=myMap"></script>-->
    <!--
    To use this code on your website, get a free API key from Google.
    Read more at: https://www.w3schools.com/graphics/google_maps_basic.asp
    -->

    <footer class="container-fluid text-center">
        <a href="#myPage" title="To Top">
            <span class="glyphicon glyphicon-chevron-up"></span>
        </a>
        <!--<p>Bootstrap Theme Made By <a href="https://www.w3schools.com" title="Visit w3schools">www.w3schools.com</a></p>-->
    </footer>

    <script>
        $(document).ready(function () {
            // Add smooth scrolling to all links in navbar + footer link
            $(".navbar a, footer a[href='#myPage']").on('click', function (event) {
                // Make sure this.hash has a value before overriding default behavior
                if (this.hash !== "") {
                    // Prevent default anchor click behavior
                    event.preventDefault();

                    // Store hash
                    var hash = this.hash;

                    // Using jQuery's animate() method to add smooth page scroll
                    // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top
                    }, 900, function () {

                        // Add hash (#) to URL when done scrolling (default click behavior)
                        window.location.hash = hash;
                    });
                } // End if
            });

            $(window).scroll(function () {
                $(".slideanim").each(function () {
                    var pos = $(this).offset().top;

                    var winTop = $(window).scrollTop();
                    if (pos < winTop + 600) {
                        $(this).addClass("slide");
                    }
                });
            });
        })
    </script>
    </div>
    </form>
</body>
</html>
