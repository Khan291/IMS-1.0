<%@ Page Title="" Language="C#" MasterPageFile="~/Registration/Site.Master" AutoEventWireup="true" CodeBehind="Forgot.aspx.cs" Inherits="IMS.Registration.form_1.Forgot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
       <script src="../assets/alert/alertify.js"></script>
    <script src="../assets/alert/alertify.min.js"></script>
    <link href="../assets/alert/css/alertify.css" rel="stylesheet" />
    <link href="../assets/alert/css/alertify.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.rtl.css" rel="stylesheet" />
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">

        <div class="col-md-4 col-md-offset-4">
            <div>
            <div class="radio-inline">
            </div>
           
            </div>
            <div class="login-panel panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><b>Forgot Password</b></h3>
                </div>
                <div class="panel-body">
                    <div role="form">
                        <fieldset>
                            <div class="form-group">
                                <label class="sr-only" for="form-email">Email</label>
                                <input type="email" name="txtEmail"  class="form-control" runat="server" required="required" id="email" autocomplete="off" placeholder="Please Enter Register Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
                                                    title="Please enter your Email" />
                            </div>
                           

                            <!-- Change this to a button or input when using this as a form -->
                            <div class="col-sm-6">
                                <asp:Button ID="btnsendmail" runat="server" CssClass="btn btn-lg btn-success btn-block" Text="Send Email" OnClick="btnsendmail_Click" />
                            </div>
                            <div class="col-sm-6">
                                <a href="Login.aspx" class="btn btn-lg btn-success btn-block">Cancel</a>
                            </div>
                        </fieldset>
                    </div>
                </div>
                <div class="panel-footer">
                </div>
            </div>
        </div>

    </div>
</asp:Content>
