<%@ Page Title="" Language="C#" MasterPageFile="~/Registration/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IMS.Registration.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Core CSS - Include with every page -->
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

    <script>
        function openalert(msg) {
            alertify.alert('Alert', msg).setting({
                'onok': function () { window.location.href = "Login.aspx"; }
            });
            //$("#myModal").modal({ backdrop: "static" });
            //$('#myModal').modal('show');


            //alertify.confirm('Alert', 'Your Plan Is End Please Choose any Of Our Plan To Continue',
            //    function () { window.location = "../Subscription/Pricing.aspx"; ('Ok') }
            //     , function () { window.location = "../index.html"; ('Cancel') });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="containr">

        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><b>Please Sign In</b></h3>
                    </div>
                    <div class="panel-body">
                        <div role="form">
                            <fieldset>
                                <div class="form-group">
                                    <label class="sr-only" for="form-about-yourself">Passowrd</label>
                                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Email..." CssClass="form-last-name form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-about-yourself">Passowrd</label>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter Password..." CssClass="form-last-name form-control "></asp:TextBox>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="cbRemember" runat="server" />Remember Me
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-lg btn-success btn-block" OnClick="btnLogin_Click" />
                                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

                            </fieldset>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <a href="Register.aspx">Don't Have An Account? Register</a>
                        <a href="Forgot.aspx" style="float: right">Forgot Password</a>
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
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">
                    <p>Some text in the modal.</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnOk" runat="server" Text="Ok" CssClass="btn btn-primary"  OnClick="btnOk_Click" />
                    
                </div>
            </div>
        </div>
    </div>
    <!-- Core Scripts - Include with every page -->
    <%--   <script src="assets/plugins/jquery-1.10.2.js"></script>
    <script src="assets/plugins/bootstrap/bootstrap.min.js"></script>
    <script src="assets/plugins/metisMenu/jquery.metisMenu.js"></script>--%>
</asp:Content>
