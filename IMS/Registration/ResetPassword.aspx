<%@ Page Title="" Language="C#" MasterPageFile="~/Registration/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="IMS.Registration.ResetPassword" %>

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
    <script type="text/javascript">
        $(function () {
            $("#<%=chkpassword.ClientID%>").bind("click", function () {
                var txtPassword = $("#<%=password.ClientID%>");
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

        function openalert(msg, val) {
            alertify.alert('Success', msg).setting({
                'onok': function () {
                    if (val == 'True') {
                        window.location.href = "Login.aspx";
                    }

                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="divresetpassword" runat="server">
        <div class="containr">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><b>Reset Password</b></h3>
                        </div>
                        <div class="panel-body">
                            <div role="form">
                                <fieldset>
                                    <div class="form-group">
                                        <label class="sr-only" for="form-about-yourself">Passowrd</label>
                                        <i class="fa fa-key"></i>

                                        <input type="password" class="form-control" id="password" runat="server" required="required" autocomplete="off" onkeypress="handleSpace(event)" placeholder="Enter Password"
                                            title="Please enter your password" onchange="validatePassword('first')" onkeyup="validatePassword('first')" />
                                        (Password must contain atleast 6 characters)<br />
                                                <br />
                                        <input type="checkbox" id="chkpassword" runat="server" />Show Password
                                    </div>
                                    <div class="form-group">
                                        <label class="sr-only" for="form-about-yourself">Passowrd</label>
                                        <input type="password" name="txtCpassword" class="form-control" required="required" runat="server" id="Cpassword" autocomplete="off" placeholder="Confirm Password......"
                                            title="Confirm Password" onchange="validatePassword('first')" onkeyup="validatePassword('first')" />
                                        <span style="color: red" id="passError"></span>
                                    </div>
                                    <!-- Change this to a button or input when using this as a form -->
                                    <asp:Button ID="btnSubmit" CssClass="btn btn-info btn-lg" runat="server" Text="Confirm" OnClick="btnSubmit_Click" />
                                </fieldset>
                            </div>
                        </div>
                        <div class="panel-footer">
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <div id="divclickhere" class="col-md-4 col-md-offset-4" runat="server">
        <center>
        <h3>Click Below Button to Login</h3>
        <a href="Login.aspx" class="btn btn-primary">Login</a>
        </center>
    </div>
    <br /><br />
</asp:Content>
