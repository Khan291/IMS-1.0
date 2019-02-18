<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IMS.Subscription.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMS Bizz</title>

    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />
    
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="../assets/alert/alertify.js"></script>
    <script src="../assets/alert/alertify.min.js"></script>
    <link href="../assets/alert/css/alertify.css" rel="stylesheet" />
    <link href="../assets/alert/css/alertify.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.min.css" rel="stylesheet" />
    <link href="../assets/alert/css/themes/default.rtl.css" rel="stylesheet" />
    <script>
        function openalert(msg) {
            alertify.error(msg);

        }
       
    </script>
    <style>
        body {
            background-image: url("../assets/img/background.jpg");
            background-repeat: no-repeat;
        }

        a:link, a:visited {
            color: white;
            text-decoration: underline;
            display: inline-block;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div style="padding-top: 10%"></div>
            </div>
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <p style="color: white; font-size: 43px; font-family: cursive;">Please Login First</p>
                    <div class="input-group ">
                        <span class="input-group-addon" style="background-color: transparent;color:white"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email.." BackColor="Transparent" CssClass="form-control input-lg" Style="width: 100%"></asp:TextBox>

                    </div>
                    <br />
                    <div class="input-group ">
                        <span class="input-group-addon " style="background-color: transparent;color:white"><i class="fa fa-key" aria-hidden="true"></i>
                        </span>
                        <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" placeholder="Password.." CssClass="form-control input-lg" BackColor="Transparent" Style="width: 100%"></asp:TextBox>

                    </div>
                    <br />
                    <br />
                    <div class="col-md-5">
                        <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" CssClass="btn btn-primary btn-lg btn-block" />
                    </div>
                    <div class="col-md-7">
                       <p style="color: white;font-size: 16px;padding-top: 10px;"><a href="../Registration/Register.aspx">Register New Account <i class="fa fa-arrow-right"></i> </a></p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
