<%@ Page Language="C#" MasterPageFile="~/Registration/Site.Master" AutoEventWireup="true" CodeBehind="USerVerification.aspx.cs" Inherits="IMS.Registration.USerVerification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<html xmlns="http://www.w3.org/1999/xhtml">--%>

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />

    <script src="../assets/alert/alertify.js"></script>
    <script src="../assets/alert/alertify.min.js"></script>
    <link href="../assets/alert/css/alertify.css" rel="stylesheet" />
    <link href="../assets/alert/css/alertify.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.rtl.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containr">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><b>OTP Verification</b></h3>
                    </div>

                    <div class="panel-body">
                            <div role="form">
                                <fieldset>
                                    <div class="form-group">
                                        <label style="font-size:small">Your mobile no. is not verified yet please verify it before login</label>
                                    </div>
                                    <div class="form-group">
                                        <div runat="server">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <label>Enter OTP: </label>
                                                </div>
                                                <div class="col-md-4">
                                                    <input id="txtOtp" runat="server" type="number" class="form-control" />
                                                    <label id="lblWrongOTP" runat="server" style="color:red"></label>
                                                </div>
                                                <div class="col-md-2">
                                                    <asp:Button runat="server" CssClass="btn btn-primary" ID="btnOTP" OnClick="btnOTP_Click"></asp:Button>
                                                </div>
                                            </div>

                                            <div class="row" runat="server" style="display: none;" id="otpDiv">
                                                <div class="col-md-4 col-md-offset-3">
                                                    <asp:Button runat="server" Text="Submit" CssClass="btn btn-primary"
                                                        ID="btnSubmit" OnClick="btnSubmit_Click"></asp:Button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Change this to a button or input when using this as a form -->

                                </fieldset>
                            </div>
                    </div>
                    <div class="panel-footer">
                        <%--<a href="Register.aspx">Don't Have An Account? Register</a>
                            <a href="Forgot.aspx" style="float: right">Forgot Password</a>--%>
                    </div>
                </div>
            </div>


        </div>
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $("#btnOTP1").text("Generate OTP");

            $("#btnOTP1").on("click", function () {

            });

            $("#btnOTP1").on("click", function () {
                debugger;
                $.ajax({
                    url: "/WorkFlow/SendOtp",
                    type: "GET",
                    contentType: "application/json",
                    success: (function (response) {
                        debugger;
                        $("#otpDiv").show();
                        $("#btnGenOTP").text('Re-Generate OTP');
                        //alert(resp);
                    }),
                    failure: (function (response) {
                        alert('Try again Failed!');
                        return false;
                    }),
                    error: (function (xhr, textStatus, errorThrown) {
                        if (textStatus != "error") {
                        }
                        else if (xhr.status === 401 || xhr.status === 403) {
                        }
                    })
                });
            });

        });
    </script>
</asp:Content>
