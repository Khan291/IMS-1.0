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
        function openalert(msg, val) {
            alertify.alert('Success', msg).setting({
                'onok': function () {
                    if (val == 'True') {
                        window.location.href = "Login.aspx";
                    }

                }
            });
        }

        var app = angular.module("bavApp", ["bootstrap.angular.validation", "ui.bootstrap"]);

        app.config(['bsValidationConfigProvider', function (bsValidationConfigProvider) {
            bsValidationConfigProvider.global.setValidateFieldsOn('display');
            bsValidationConfigProvider.global.setDisplayErrorsAs('tooltip');
            bsValidationConfigProvider.global.tooltipAppendToBody = true;
            bsValidationConfigProvider.global.errorMessagePrefix = '<span class="glyphicon glyphicon-warning-sign"></span> &nbsp;';
        }]);

        $('.show-pass').hover(function () {
            $('.password').attr('type', 'text');
        }, function () {
            $('.password').attr('type', 'password');
        });


        function openModal() {
            alert("save sucessesfully");
        }

        function validation() {
            debugger;
            var password = $("#<%= password.ClientID %>").val(),
                confirmPassword = $("#<%= Cpassword.ClientID %>").val();
            if (password != confirmPassword) {
                alert("Password does not match.");
                return false;
            }
            if (password.length < 6) {
                alert("Password does not match with the given format.");
                return false;
            }
            return true;
        }
        $(function () {
            $("#<%=chkpassword.ClientID%>").bind("click", function () {
                var txtPassword = $("#<%=password.ClientID%>");
                if ($(this).is(":checked")) {
                    $(txtPassword).attr('type', 'text');
                } else {
                    $(txtPassword).attr('type', 'password');
                }
            });
        });
        function PasswordChanged(txt) {
            $(txt).prev().val($(txt).val());
        }

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

        function validatePassword(val) {
            debugger
            var password = $("#<%= password.ClientID %>").val(),
                confirm_password = $("#<%= Cpassword.ClientID %>").val();
            if (val == 'first') {
                confirm_password = "";
                if (password.length < 6) {
                    $("#passLengthError").html("Password does not match with the given format");
                }
                else {
                    $("#passLengthError").html("");
                }
            }
            else {
                if (password != confirm_password) {
                    $("#passError").html("Password does not match");
                    //confirm_password.setCustomValidity("Passwords Don't Match");
                } else {
                    $("#passError").html("");
                }
            }
        }

    </script>

    <style>
        .modalBackground {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 60%;
            height: 90%;
            overflow-y: scroll;
        }

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

                                                <input type="email" name="txtEmail" onchange="CheckDouble()" class="form-control" runat="server" id="email" autocomplete="off" placeholder="Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
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

                                                <input type="password" class="form-control" id="password" runat="server" required="required" autocomplete="off" onkeypress="handleSpace(event)" placeholder="Password"
                                                    onchange="validatePassword('first')" />
                                                <span style="color: red" id="passLengthError"></span>
                                                (Password must contain atleast 6 characters)
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
                                                    onchange="validatePassword('second')" onkeyup="validatePassword('second')"
                                                    title="Confirm Password" />
                                                <span style="color: red" id="passError"></span>
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
                                                <input type="text" name="txtMobileNo" runat="server" onchange="CheckMobileDouble()" id="txtmobile" maxlength="10" onkeypress="return /\d/.test(String.fromCharCode(((event||w
                                                    ow.event).which||(event||window.event).which)));"
                                                    class="form-control" required="required" autocomplete="off" placeholder="Mobile No" pattern="^[0-9 ]{10}$"
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

                                    <br />
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <br />
                                                <label for="MobileNo" class="control-label">Reference Mobile No : +91</label>
                                                <input type="text" name="txtRefMobileNo" runat="server" id="txtRefMobNum" maxlength="10" onkeypress="return /\d/.test(String.fromCharCode(((event||window.event).which||(event||window.event).which)));" class="form-control" required="required" autocomplete="off" placeholder=" Reference Mobile No" pattern="^[0-9 ]{10}$"
                                                    title="Please enter ten digit mobile number" />
                                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                    <br />
                                    <center>
                                    <div class="input-group div2">
                                        <div class="col-lg-12 text-center">
                                           
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" OnClientClick="return validation();" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="Update" />
                                             <button type="reset" class="btn btn-primary">
                                                Clear</button>
                                        </div>
                                        
                                    </div>

                                    </center>
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

        <asp:HiddenField ID="hidForModel" runat="server" />
        <ajaxToolkit:ModalPopupExtender ID="mpeTermsConditions" runat="server" PopupControlID="Panel1"
            CancelControlID="btnAgree" TargetControlID="hidForModel" BackgroundCssClass="modalBackground">
        </ajaxToolkit:ModalPopupExtender>
        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none">

            <div class="modal-body">
                <table>
                    <tr>
                        <td class="content">
                            <center>
                                <h1>Privacy Policy</h1>
                            </center>
                            <h4 style="color: blueviolet">By using IMS BIZZ you are agreeing to be bound by the following terms and conditions (Terms of Service).</h4>
                            <p>
                                IMS BIZZ reserves right to update and change the terms of service from time to time without prior notice. Any new features that augment or enhance in current Service, shall be subject to the “Terms of Service”. Continued use of Service after any such changes shall constitute your consent to such changes. You can review the most current version of “terms of service” at any time at: Contact Us.
                            </p>
                            <p>
                                You must provide your legal full name, a valid email address, and any other information requested in order to complete the signup process. Your login may only be used by one person – a single login shared by multiple people is not permitted. You may create separate logins for as many people as required. You are responsible for maintaining security of your account and password. IMS BIZZ cannot and will not be liable for any loss or damage from your failure to comply with this security obligation.
                            </p>
                            <p>
                                You are responsible for all Content posted and activity that occurs under your account (even when Content is posted by others who have accounts under your account). You acknowledge that IMS BIZZ has no control over and no duty to take any action regarding what Content you access via the Services; what affects the Content may have on you; how you may interpret or use the Content; or what actions you may take as a result of having been exposed to the Content. You release IMS BIZZ from all liability for you having acquired or not acquired Content through the Services.
                            </p>
                            <p>
                                We may, but have no obligation to, remove Content and Accounts containing Content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms of Service. One person or legal entity may not maintain more than one free account. You may not use the Service for any illegal or unauthorized purpose. You must not, in use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).
                            </p>
                            <h4 style="color: blueviolet">Organization Accounts and Account Administrators
                            </h4>
                            <p>
                                When you sign up for an account for your organization you may specify one or more administrators. The administrators will have the right to configure the Services based on your requirements and manage end users in your organization account. If your organization account is created and configured on your behalf by a third party, it is likely that such third party has assumed administrator role for your organization. Make sure that you enter into a suitable agreement with such third party specifying such party’s roles and restrictions as an administrator of your organization account.
                            </p>
                            <p>
                                You are responsible for it. I) ensuring confidentiality of your organization account password, ii) appointing competent individuals as administrators for managing your organization account, and iii) ensuring that all activities that occur in connection with your organization account comply with this Agreement. You understand that IMS BIZZ is not responsible for account administration and internal management of the Services for you.
                            </p>
                            <h4 style="color: blueviolet">Account Data
                            </h4>
                            <p>
                                You and your End Users may choose to provide, post, input, submit, or otherwise make accessible to IMS BIZZ, data or information about you, your employees, customers, or any third party (“Data“), and IMS BIZZ may store such Data on your behalf, all in connection with your use of the Service. You hereby provide IMS BIZZ a limited non-exclusive, non-transferable license to use, upload, and store Data solely in connection with providing the Service.
                            </p>
                            <p>
                                You represent and warrant that (I) you own all Data or have all rights that are necessary to grant IMS BIZZ the licensed rights in Data under these Terms; (ii) your collection of Data has and will be in compliance with all applicable laws and regulations, including without limitation those concerning data or information privacy; and (ii) neither the Data, nor the inclusion of Data in or use of Data in connection with the Service, will infringe, misappropriate or violate any Intellectual Property Rights, or violate the privacy rights, of any third party, or result in the violation of any applicable law or regulation, including without limitation those concerning data or information privacy. As between you and IMS BIZZ, you retain exclusive ownership of the Data. You acknowledge and agree that you remain solely responsible and liable for the Data. You may download your Data at any time during the Term, or as otherwise set forth herein, provided you comply with these Terms and IMS BIZZ security requirements.
                            </p>
                            <h4 style="color: blueviolet">Warranty Disclaimer
                            </h4>
                            <p>
                                IMS BIZZ has no special relationship with or fiduciary duty to you. The Services, Content and Website are provided on an “as is” and “as available” basis, without warranties of any kind, either express or implied. IMS BIZZ does not warrant that (I) the service will meet your specific requirements, (ii) the service will be uninterrupted, timely, secure, or error-free, (iii) the results that may be obtained from the use of the service will be accurate or reliable, (iv) the quality of any products, services, information, or other material purchased or obtained by you through the service will meet your expectations, and (v) any errors in the Service will be corrected.
                            </p>
                            <h4 style="color: blueviolet">Personal Data
                            </h4>
                            <p>
                                For information regarding IMS BIZZ treatment of personally identifiable information, please review IMS BIZZ current Privacy Policy, which is hereby incorporated by reference; your acceptance of this Agreement constitutes your acceptance and agreement to be bound by Company’s Privacy Policy.
                            </p>
                            <h4 style="color: blueviolet">Communications from IMSBIZZ
                            </h4>
                            <p>
                                The Service may include certain communications from IMS BIZZ, such as service announcements, administrative messages and newsletters. You understand that these communications shall be considered part of using the Services. As part of our policy to provide you total privacy, we also provide you the option of opting out from receiving newsletters from us. However, you will not be able to opt-out from receiving service announcements and administrative messages.
                            </p>
                            <h4 style="color: blueviolet">Indemnity
                            </h4>
                            <p>
                                You will indemnify and hold IMS BIZZ, its parents, subsidiaries, affiliates, officers, and employees harmless (including, without limitation, from all damages, liabilities, settlements, costs and attorneys’ fees) from any claim or demand made by any third party due to or arising out of your access to the Services, use of the Services, your violation of this Agreement, or the infringement by you of any intellectual property or other right of any person or entity.
                            </p>
                            <h4 style="color: blueviolet">Payment, Refunds, Upgrading and Downgrading Terms
                            </h4>
                            <p>
                                A valid credit card is required for paying accounts. Trial accounts are not required to provide a credit card number. If you initially sign up for a paid account, and you don't cancel that account within the trial number of days. If you cancel prior to the processing of your first invoice, you will not be charged. If you subscribe to paid plan during your free trial you will be charged at the end of the trial period to ensure that you have the first 90 days i.e. the duration of the trial period, free of cost. You will be billed for your first month or year upon completion of the trial period. The Service is billed in advance, per your choosing, on a monthly or yearly basis and is non-refundable under any circumstances. There will be no refunds or credits for partial months of service, upgrade/downgrade refunds, or refunds for months unused with an open account. All fees are exclusive of all taxes, levies, or duties imposed by taxing authorities, and you shall be responsible for payment of all such taxes, levies, or duties, excluding only (state) taxes. For any upgrade or downgrade in plan level, your credit card that you provided will automatically be charged the new rate on your next billing cycle. Downgrading your Service may cause the loss of Content, features, or capacity of your Account. IMS BIZZ does not accept any liability for such loss.
                            </p>
                            <h4 style="color: blueviolet">Cancellation and Termination
                            </h4>
                            <p>
                                You are solely responsible for properly canceling your account. An email or phone request to cancel your account is not considered cancellation. You can cancel your account at any time by clicking on the Settings link in the global navigation bar at the top of the screen. The Billing screen provides a simple cancellation/close account link. Please note that account data is not automatically removed upon cancellation as many of our customers re-activate their accounts after cancellation. We store all data permanently. In case you want your account data to be completely removed from the system, please email support@imsbizz.com with the request and we will have the account data removed. This information cannot be recovered once deleted.
                                If you cancel the Service before end of your current paid up month, your cancellation will take effect immediately and you will not be charged again. IMS BIZZ, in its sole discretion, has the right to suspend or terminate your account and refuse any and all current or future use of the Service, or any other IMS BIZZ service, for any reason at any time. Such termination of the Service will result in the deactivation or deletion of your Account or your access to your Account, and the forfeiture and relinquishment of all content in your Account. IMS BIZZ reserves the right to refuse service to anyone for any reason at any time.
                            </p>
                            <h4 style="color: blueviolet">Modifications to the Service and Prices
                            </h4>
                            <p>
                                IMS BIZZ reserves the right at any time and from time to time to modify or discontinue, temporarily or permanently, the Service (or any part thereof) with or without notice. Prices of all Services, including but not limited to monthly subscription plan fees to the Service, are subject to change upon 30 days’ notice from us. Such notice may be provided at any time by emailing the changes and updating the pricing plan page on our website. IMS BIZZ shall not be liable to you or to any third party for any modification, price change, suspension or discontinuance of the Service.
                            </p>
                            <h4 style="color: blueviolet">Copyright and Content Ownership
                            </h4>
                            <p>
                                All content posted on the Service must comply with copyright law. We claim no intellectual property rights over the material you provide to the Service. Your profile and materials uploaded remain yours. However, by setting your pages to be shared publicly, you agree to allow others to view and share your Content. IMS BIZZ does not pre-screen Content, but IMS BIZZ and its designee have the right (but not the obligation) in their sole discretion to refuse or remove any Content that is available via the Service.
                            </p>
                            <h4 style="color: blueviolet">General Conditions
                            </h4>
                            <p>
                                Technical support is only available via email. You understand that IMS BIZZ uses third party vendors and hosting partners to provide necessary software, networking, Cloud storage, and related technology required to run the Service. You must not modify, adapt or hack the Service or modify another website so as to falsely imply that it is associated with the Service, IMS BIZZ or any other IMS BIZZ service. You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service without the express written permission by IMS BIZZ
                            </p>
                            <p>
                                You understand that the technical processing and transmission of the Service, including your Content, may be transferred unencrypted and involve (a) submissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. You must not upload, post, host, or transmit unsolicited email, SMSs, or “spam” messages. You must not transmit any worms or viruses or any code of a destructive nature. If your bandwidth significantly exceeds the average bandwidth usage (as determined solely by IMS BIZZ) of other customers, we reserve the right to immediately disable your account or throttle your file hosting until you can reduce your bandwidth consumption. IMS BIZZ may use your Company Names and Logos in case studies, promotional materials, or other write-ups, unless you request otherwise. You expressly understand and agree that IMS BIZZ shall not be liable for any direct, indirect, incidental, special, consequential or exemplary damages, including but not limited to, damages for loss of profits, goodwill, use, data or other intangible losses (even if IMS BIZZ has been advised of the possibility of such damages), resulting from: (I) the use or the inability to use the service; (ii) the cost of procurement of substitute goods and services resulting from any goods, data, information or services purchased or obtained or messages received or transactions entered into through or from the service; (iii) unauthorized access to or alteration of your transmissions or data; (iv) statements or conduct of any third party on the service; (v) or any other matter relating to the service. The failure of IMS BIZZ to exercise or enforce any right or provision of the Terms of Service shall not constitute a waiver of such right or provision. The Terms of Service and the Privacy Policy shall constitute the entire agreement between you and IMS BIZZ and govern your use of the Service, superseding any prior agreements between you and IMS BIZZ (including, but not limited to, any prior versions of the Terms of Service and Privacy Policy). Questions about the Terms of Service should be sent to support@imsbizz.com
                            </p>
                            <p style="color: blueviolet">
                                Disclaimer: All the Legal Rights Judicial Officers Protection Act, 1850 jurisdiction only in Aurangabad.
                            </p>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnAgree" CssClass="btn btn-primary" runat="server" Text="Agree" OnClick="btnAgree_Click" />
            </div>
        </asp:Panel>

        <%--Old Modal--%>
        <div class="modal fade" id="myModalOld" role="dialog">
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
                        <button type="button" class="btn btn-default" data-dismiss="modal">Reject</button>
                        <asp:Button CssClass="btn btn-default" ID="btnsubmitWithTC" runat="server" Text="Agree" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
