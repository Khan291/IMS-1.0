<%@ Page Title="" Language="C#" MasterPageFile="~/Subscription/Subscription.Master" AutoEventWireup="true" CodeBehind="Message.aspx.cs" Inherits="IMS.Subscription.Message" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <br />
        <div class="jumbotron text-center" id="successdiv" runat="server">
            <i class="fa fa-check-circle fa-4x" style="color: green; font-size: 100px;" aria-hidden="true"></i>
            <h1>Payment Success</h1>
            <p>We Will Email You a Receipt Confirming Your Payment Shortly.</p>
        </div>
        <div class="jumbotron text-center" id="failuerdiv" runat="server" visible="false">
            <i class="fa fa-exclamation-circle fa-4x" style="color: red; font-size: 100px;" aria-hidden="true"></i>
            <h1>Some Error Occurred</h1>
            <p>
                Please Select Your Plan And Retry To Pay Payment. 
                In Case This Error Occured Multiple Times Please Contact To Our Support Team.
            </p>
        </div>
    </div>
</asp:Content>
