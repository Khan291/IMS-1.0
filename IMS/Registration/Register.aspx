<%@ Page Title="" Language="C#" MasterPageFile="~/Registration/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="IMS.Registration.WebForm2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="../assets/alert/alertify.js"></script>
    <script src="../assets/alert/alertify.min.js"></script>
    <link href="../assets/alert/css/alertify.css" rel="stylesheet" />
  
    <link href="../assets/alert/css/alertify.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.rtl.css" rel="stylesheet" />

    <script src="../assets/plugins/bootstrap/jquery-validate.bootstrap-tooltip.min.js"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.5.8/angular.min.js"></script>

    <script src="https://rawgit.com/angular-ui/bootstrap/gh-pages/ui-bootstrap-tpls-1.3.3.min.js"></script>

    <script src="https://cdn.rawgit.com/sagrawal14/bootstrap-angular-validation/v1.0.4/dist/bootstrap-angular-validation-all.min.js"></script>
    <script type='text/javascript'>


        function openalert(msg, val)
        {
            alertify.alert('Success', msg).setting({
                'onok': function ()
                {
                    if (val == 'True')
                    {
                        window.location.href = "Login.aspx";
                    }
                    
                }
            });

        }

    </script>
    <script type="text/javascript">

        var app = angular.module("bavApp", ["bootstrap.angular.validation", "ui.bootstrap"]);

        app.config(['bsValidationConfigProvider', function (bsValidationConfigProvider) {
            bsValidationConfigProvider.global.setValidateFieldsOn('display');
            bsValidationConfigProvider.global.setDisplayErrorsAs('tooltip');
            bsValidationConfigProvider.global.tooltipAppendToBody = true;
            bsValidationConfigProvider.global.errorMessagePrefix = '<span class="glyphicon glyphicon-warning-sign"></span> &nbsp;';
        }]);

        //$(document).ready(function () {
        //    $("#ContentPlaceHolder1_txtName").tooltip({ title: "Please Enter First Name !", placement: "right" });
        //    $("#ContentPlaceHolder1_txtName").validate({
        //        rules: {
        //            example4: { email: true, required: true },
        //            example5: { required: true }
        //        },
        //        messages: {

        //        },
        //        tooltip_options: {
        //            example4: { trigger: 'focus' },
        //            example5: { placement: 'right', html: true }
        //        },
        //    });
        //});
        //function myFunction() {
        //    document.getElementById("demo").innerHTML = "Hello World";
        //}

        $('.show-pass').hover(function () {
            $('.password').attr('type', 'text');
        }, function () {
            $('.password').attr('type', 'password');
        });


    </script>



    <script type='text/javascript'>
        function openModal() {
            alert("save sucessesfully");
        }
    </script>

    <script type="text/javascript">
        $(function () {
            $("#<%=chkpassword.ClientID%>").bind("click", function () {
                var txtPassword = $("#<%=myInput.ClientID%>");
                if ($(this).is(":checked")) {
                    txtPassword.after('<input onchange = "PasswordChanged(this);" id = "txt_' + txtPassword.attr("id") + '" type = "text" class="form-control" value = "' + txtPassword.val() + '" />');
                    txtPassword.hide();
                } else {
                    txtPassword.val(txtPassword.next().val());
                    txtPassword.next().remove();
                    txtPassword.show();
                }
            });
        });
        function PasswordChanged(txt) {
            $(txt).prev().val($(txt).val());
        }
    </script>
    <script>
        function handleSpace(event) {
            //handling ie and other browser keycode 
            var keyPressed = event.which || event.keyCode;

            //Handling whitespace
            //keycode of space is 32
            if (keyPressed == 32) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
        //function mouseoverPass(obj) {
        //    var obj = document.getElementById('txtpassword1');
        //    obj.type = "text";
        //}
        //function mouseoutPass(obj) {
        //    var obj = document.getElementById('txtpassword1');
        //    obj.type = "password";
        //}


        //function myFunction() {
        //    var x = document.getElementById("txtpassword");

        //    if (x.type != "password") {
        //        x.type = " password";
        //    } else {
        //        x.type = "text";
        //    }
        //}
        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Registration/Register.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=email.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccess(response) {
            var msg = $("#<%=lblcheckDoubleError.ClientID%>")[0];
            var hd1 = $("#<%=hd.ClientID%>")[0];
            switch (response.d) {
                case "true":

                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This email already Exists";
                    hd1.value = "true";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = "false";
                    break;
            }
        }
        function CheckMobileDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Registration/Register.aspx/CheckMobileDouble") %>', // this for calling the web method function in cs code.  
                data: '{mobileno: "' + $("#<%=txtmobile.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess1,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccess1(response) {
            var msg = $("#<%=lblmobilemsg.ClientID%>")[0];
            switch (response.d) {
                case "true":

                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This Mobile Number already Exists";
                    break;
                case "false":
                    msg.style.display = "none";
                    break;
            }
        }
        function clearcategory() {
            cleartextboxes();
            $("#<%=email.ClientID%>").focus();
        }


        $(function () {
            $("#<%= startdate.ClientID %>").datepicker({
                numberOfMonths: 2,
                onSelect: function (selected) {
                    var dt = new Date(selected);
                    dt.setDate(dt.getDate() + 30);
                    $("#<%= enddate.ClientID %>").datepicker("option", "minDate", dt);
                }
            });
            $("#<%= enddate.ClientID %>").datepicker({
                numberOfMonths: 2,
                onSelect: function (selected) {
                    var dt = new Date(selected);
                    dt.setDate(dt.getDate() - 30);
                    $("#<%= startdate.ClientID %>").datepicker("option", "maxDate", dt);
                }
            });
        });

       <%-- function validateBothPswd(){
            var password = document.getElementById("password"),
            confirm_password = document.getElementById("Cpassword");
            if (password.value != confirm_password.value) {
                $("#<%= checkSamePswd.ClientID %>").value = "false";
                return false;
            } else {
                $("#<%= checkSamePswd.ClientID %>").value = "true";
                return true;
            }
        }--%>



        function validatePassword() {
            var password = document.getElementById("password"),
               confirm_password = document.getElementById("Cpassword");
            if (password.value != confirm_password.value) {
                alert("Passwords Don't Match");
                confirm_password.setCustomValidity("Passwords Don't Match");
            } else {
                confirm_password.setCustomValidity("");
            }
        }

        password.onchange = validatePassword;
        confirm_password.onkeyup = validatePassword;

    </script>

    <style>
        .body {
            background-color: #ff6a00;
        }

        .container {
            padding: 20px;
        }

        .tooltip.has-error .tooltip-arrow {
            left: 10px !important;
            border-bottom-color: #00ff21;
        }

        .tooltip.has-error .tooltip-inner {
            background: #ff0000;
            max-width: 100%;
        }

        .form-group {
            margin-bottom: 20px;
        }



        .div2 {
            padding-bottom: 20px;
            text-align: right;
            padding-top: 10px;
        }

        .div3 {
            margin-top: -75px;
        }

        .span1 {
            padding-left: 11px;
            padding-right: 11px;
        }

        .spa1 {
            padding-left: 6px;
            padding-right: 6px;
        }

        .sp {
            padding-left: 14px;
            padding-right: 14px;
        }

        /*.show-pass {
            position: absolute;
            top: 17px;
            right: -30px;
        }*/
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <div class="containr">
            <%--<asp:HiddenField ID="checkSamePswd" runat="server" />--%>
            <div class="row div3">
                <div class="col-md-3"></div>
                <div class="col-md-6 ">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h2 class="text-center"><b>Registration Form </b></h2>

                        </div>
                        <div class="panel-body">
                            <div role="form">
                                <fieldset>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="firstName" class="control-label">First Name :</label>
                                                <i class="fa fa-user"></i>
                                                <input type="text" name="FirstName" runat="server" id="txtfirstname" class="form-control" required="required" autocomplete="off" placeholder="First Name" pattern="^[a-zA-Z ]{2,30}$"
                                                    title="Please enter First name" />

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="lastName" class="control-label">Last Name :</label>
                                                <i class="fa fa-user"></i>
                                                <input type="text" name="LastName" id="txtlastname" runat="server" class="form-control" required="required" autocomplete="off" placeholder="Last Name" pattern="^[a-zA-Z ]{2,30}$"
                                                    title="Please enter Last name" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="CompanyName" class="control-label">Company Name :</label>
                                                <i class="fa fa-building"></i>
                                                <input type="text" name="CName" class="form-control" id="txtcompanyname" runat="server" required="required" autocomplete="off" placeholder="Company Name" pattern="^[a-zA-Z-_\. ]{2,30}$"
                                                    title="Please enter Company name" />
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="email" class="control-label">Email :</label>
                                                <i class="fa fa-envelope"></i>

                                                <input type="email" name="txtEmail" onchange="CheckDouble()" class="form-control" runat="server" required="required" id="email" autocomplete="off" placeholder="Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
                                                    title="Please enter your Email" />
                                                <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hd" runat="server" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form -group">
                                                <label for="password" class="control-label">Password :</label>
                                                <i class="fa fa-key"></i>
                                                
                                                    <input type="password" class="form-control" id="myInput" runat="server" required="required" autocomplete="off" onkeypress="handleSpace(event)" placeholder="Password"
                                                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="Please enter your password e.g:Password@123" />
                                                
                                             
                                                (Password must contain atleast 8 characters,One upper case,One number,One special symbol)
                                                <br />
                                                <input type="checkbox" id="chkpassword" runat="server" />Show Password
                                           
                                            </div>
                                        </div>
                                    </div>
                                    <br />

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="Cpassword" class="control-label">Confirm Password :</label>
                                                <i class="fa fa-key"></i>
                                                <input type="password" name="txtCpassword" class="form-control" required="required" runat="server" id="Cpassword" autocomplete="off" placeholder="Confirm Password"
                                                    pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
                                                    title="Confirm Password" onchange="validatePassword()" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <label class="col-sm-12 ">
                                            Country : <i class="fa fa-globe"></i>
                                        </label>

                                        <div class="col-sm-12">
                                            <div class="input-group">
                                                <span class="input-group-addon span1"><i class="fa fa-list"></i></span>
                                                <asp:DropDownList ID="ddlcountry" runat="server" CssClass="form-control " Width="100%"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>

                                    <br />

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="MobileNo" class="control-label">Mobile No : +91</label>
                                                <input type="text" name="txtMobileNo" runat="server" onchange="CheckMobileDouble()" id="txtmobile" maxlength="10" onkeypress="return /\d/.test(String.fromCharCode(((event||window.event).which||(event||window.event).which)));" class="form-control" required="required" autocomplete="off" placeholder="Mobile No" pattern="^[0-9 ]{10}$"
                                                    title="Please enter ten digit mobile number" />
                                                <asp:Label ID="lblmobilemsg" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="zipcode" class="control-label">Zip Code :</label>
                                                <i class="fa fa-map-marker"></i>
                                                <input type="text" name="txtpincode" maxlength="6" id="txtzip" runat="server" onkeypress="return /\d/.test(String.fromCharCode(((event||window.event).which||(event||window.event).which)));" class="form-control" required="required" autocomplete="off" placeholder="Zip Code" pattern="^[0-9 ]{6}$"
                                                    title="Please enter Zip Code" />
                                            </div>
                                        </div>
                                    </div>
                                    <label for="Financial year" class="control-label">Financial Year </label>


                                    <div class="row col-sm-12">
                                        <div class="col-sm-6">

                                            <label>Start Date :</label>
                                            <div class="input-group">
                                                <input id="startdate" name="txtStartDate" class="form-control" runat="server" required="required" />
                                                <span class="input-group-addon span1"><i class="fa fa-calendar"></i></span>
                                                <%-- pattern="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d"/>--%>
                                            </div>
                                        </div>

                                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red" ErrorMessage="Start Date Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>--%>


                                        <label>&nbsp; &nbsp;   End Date : </label>


                                        <div class="col-sm-6">
                                            <div class="input-group">
                                                <input id="enddate" name="txtEndDate" class="form-control" runat="server" required="required" />
                                                <span class="input-group-addon span1"><i class="fa fa-calendar"></i></span>
                                                <%-- pattern="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d" /> --%>
                                            </div>
                                        </div>
                                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red" ErrorMessage="RequiredFieldValidator" ValidationGroup="Update"
                                            ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    </div>
                                    <br />



                                    <%--<div class="form-group div2">
                                        <label class="col-lg-3 control-label">
                                            First Name
                                           
                                        </label>
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                                <span class="input-group-addon span1"><i class="fa fa-user"></i></span>
                                                <asp:TextBox runat="server" required="required" placeholder="First Name..."CssClass="form-control"></asp:TextBox>
                                            </div>

                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="First Name Is Required" ValidationGroup="Update"
                                            ControlToValidate="FirstName"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic"
                                            ControlToValidate="txtName" ErrorMessage="Only alphabets are allowed"
                                            ForeColor="Red" ValidationExpression="^[a-zA-Z ]+$"></asp:RegularExpressionValidator>

                                        <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="RequiredFieldValidator1">
                        </asp:ValidatorCalloutExtender>

                                    </div>--%>



                                    <%--<div class="row">
                                        <label class="col-sm-12 ">
                                            Passowrd :
                                     <i class="fa fa-key"></i>
                                        </label>

                                        <div class="col-sm-12">
                                            <div class="input-group ">
                                                <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" placeholder="Password..." CssClass="form-control"></asp:TextBox>

                                                <span class="input-group-addon">
                                                    <input id="cbShowHidePassword" type="checkbox" onclick="ShowHidePassw = ord();" /></span>
                                            </div>
                                        </div>

                                    </div>
                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ForeColor="Red" ControlToValidate="txtPassword" ErrorMessage="Password should have atleast 8 characters, preferably atleast one number,one upper case and one special character" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red" ErrorMessage="Password Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtPassword" Display="Dynamic"></asp:RequiredFieldValidator>

                                    <br />

                                    <div class="row">
                                        <label class="col-sm-12">
                                            Confirm Password : <i class="fa fa-key"></i>

                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ForeColor="Red"
                                                ControlToValidate="repeatPassword"
                                                ControlToCompare="txtPassword"
                                                ErrorMessage="No Match"
                                                Display="Dynamic"
                                                ToolTip="Password must be the same"></asp:CompareValidator>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                ErrorMessage="Confirm Password Is Required"
                                                ControlToValidate="repeatPassword"
                                                CssClass="ValidationError"
                                                ToolTip="Compare Password is a REQUIRED field"
                                                Display="Dynamic"></asp:RequiredFieldValidator>

                                        </label>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="input-group">

                                                <asp:TextBox ID="repeatPassword" TextMode="Password" runat="server" placeholder="Confirm Password..." CssClass="form-control"></asp:TextBox>
                                                <span class="input-group-addon">
                                                    <input id="cbShowHidePassword1" type="checkbox" onclick="ShowHidePassword();" /></span>
                                            </div>
                                        </div>
                                    </div>--%>








                                    <%-- <div class="form-group div2">
                                        <label class="col-lg-3 control-label">
                                            Last Name
                                            
                                        </label>
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                                <span class="input-group-addon span1"><i class="fa fa-user"></i></span>
                                                <asp:TextBox ID="txtLname" runat="server" placeholder="Last Name..." CssClass="form-control"></asp:TextBox>


                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" ErrorMessage="Last Name Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtLname" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server"
                                            ControlToValidate="txtLname" ErrorMessage="Only alphabets are allowed" Display="none"
                                            ForeColor="Red" ValidationExpression="^[a-zA-Z ]+$"></asp:RegularExpressionValidator>--%>
                                    <%--    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" TargetControlID="RegularExpressionValidator5">
                                        </ajaxToolkit:ValidatorCalloutExtender>--%>

                                    <%--</div>--%>
                                    <%-- <div class="form-group div2">
                                        <label class="col-lg-3 control-label">
                                            Company Name
                                            
                                        </label>
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                                <span class="input-group-addon span1"><i class="fa fa-building"></i></span>
                                                <asp:TextBox ID="txtCname" runat="server" placeholder="Company Name..." CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server"
                                            ControlToValidate="txtCname" ErrorMessage="Only alphabets are allowed" Display="Dynamic"
                                            ForeColor="Red" ValidationExpression="^[a-zA-Z ]+$"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ErrorMessage="Company Name Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtCname" Display="Dynamic"></asp:RequiredFieldValidator>

                                    </div>--%>
                                    <%--<div class="form-group div2">
                                        <label class="col-lg-3 control-label">
                                            Email
                                            
                                        </label>
                                        <div class="col-lg-6 ">
                                            <div class="input-group">
                                                <span class="input-group-addon span1"><i class="fa fa-envelope"></i></span>
                                                <asp:TextBox ID="txtEmail" TextMode="Email" runat="server" placeholder="Email..." CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ForeColor="Red" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" ErrorMessage="Invalid Email Format" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" ErrorMessage="Email Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtEmail" Display="Dynamic"></asp:RequiredFieldValidator>


                                    </div>--%>






                                    <%-- <div class="form-group div2">
                                        <label class="col-lg-3 control-label">
                                            Mobile No
                                             
                                        </label>
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                                <span class="input-group-addon spa1">+91</span>
                                                <asp:TextBox ID="txtMobileNo" runat="server" placeholder="Mobile Number..." CssClass=" form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ForeColor="Red" ControlToValidate="txtMobileNo" ErrorMessage="Mobile No Should be 10 digits only" ValidationExpression="^[0-9]{10,10}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red" ErrorMessage="Mobile No Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtMobileNo" Display="Dynamic"></asp:RequiredFieldValidator>


                                    </div>--%>
                                    <%--<div class="form-group div2">
                                        <label class="col-lg-3 control-label">
                                            Zip Code
                                            
                                        </label>
                                        <div class="col-lg-6">
                                            <div class="input-group date txtDate">
                                                <span class="input-group-addon sp"><i class="fa fa-map-marker"></i></span>
                                                <asp:TextBox ID="txtpincode" runat="server" CssClass="form-control" placeholder="Zip Code..."></asp:TextBox>
                                            </div>
                                        </div>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ForeColor="Red" ControlToValidate="txtpincode" ErrorMessage="Zip Code Should be 6 digits only" ValidationExpression="^[0-9]{6,}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red" ErrorMessage="Zip Code Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtpincode" Display="Dynamic"></asp:RequiredFieldValidator>


                                    </div>--%>


                                    <%-- <div class="row col-sm-12">
                                        <div class="col-sm-6">

                                            <label>Start Date : <i class="fa fa-calendar"></i></label>

                                            <div class="input-group">

                                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" placeholder="Finicial year Start Date..."></asp:TextBox>
                                            </div>
                                        </div>

                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red" ErrorMessage="Start Date Is Required" ValidationGroup="Update"
                                            ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>




                                        <label>
                                            End Date : <i class="fa fa-calendar"></i>

                                        </label>
                                        <div class="col-sm-6">
                                            <div class="input-group">

                                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" placeholder="Finicial year End Date..."></asp:TextBox>
                                            </div>
                                        </div>

                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red" ErrorMessage="RequiredFieldValidator" ValidationGroup="Update"
                                            ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>--%>

                                    <br />
                                    <center>
                                    <div class="input-group div2">
                                        <div class="col-lg-12 text-center">
                                           
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="Update" />
                                             <button type="reset" class="btn btn-primary">
                                                Clear</button>
                                        </div>
                                        
                                    </div>
                                        </center>

                                    <div class="col-lg-12">

                                        <%-- function ShowHidePassword() {
            var txt = $('#<%=txtPassword.ClientID%>');
              if (txt.prop("type") == "password") {
                  txt.prop("type", "text");
                  $("label[for='cbShowHidePassword']").text("Hide Password");
              }
              else {
                  txt.prop("type", "password");
                  $("label[for='cbShowHidePassword']").text("Show Password");
              }
          }

          function ShowHidePassword() {
              var txt = $('#<%=repeatPassword.ClientID%>');
              if (txt.prop("type") == "password") {
                  txt.prop("type", "text");
                  $("label[for='cbShowHidePassword1']").text("Hide Password");
              }
              else {
                  txt.prop("type", "password");
                  $("label[for='cbShowHidePassword1']").text("Show Password");
              }
          }  --%>
                                        <%--<asp:ValidationSummary ID="ValidationSummary1" ForeColor="Red" ValidationGroup="Update" runat="server" HeaderText="Error" />--%>
                                    </div>

                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <a href="Login.aspx">Already Have An Account? Login</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3"></div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog" runat="server">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Success</h4>
                    </div>
                    <div class="modal-body">
                        <p>Thank you for Registration </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <%-- <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </div>
        </div>--%>
    </div>


</asp:Content>
