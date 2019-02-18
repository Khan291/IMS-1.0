<%@ Page Title="" Language="C#" MasterPageFile="~/Subscription/Subscription.Master" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="IMS.Subscription.Pricing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div id="pricing" class="container-fluid">
            <div class="text-center">
                <h1>Pricing</h1>
                <h3>Choose a payment plan that works for you</h3>
            </div>
            <div class="row slideanim">
                <div class="col-sm-4 col-xs-12">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading " style="background-color: #090e63; color: white">
                            <h1><asp:Label ID="lblName1" runat="server"></asp:Label></h1>
                        </div>
                        <div class="panel-body">
                            <h3>&#8377;<asp:Label ID="lblPrice1" runat="server"></asp:Label></h3>
                            <h4>First 15 day's Free </h4>
                            <h4><asp:Label ID="lblDuration1" runat="server"></asp:Label> Month Access</h4>
                            <h4>3 User</h4>
                            <h4>Unlimited Warehouse</h4>
                            <h4>Unlimited Purchase Order</h4>
                            <h4>Unlimited Sale Order</h4>
                            <h4>Reports</h4>
                        </div>
                        <div class="panel-footer">


                            <button class="btn btn-lg btn-primary">Subscribe</button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 col-xs-12">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading" style="background-color: #090e63; color: white">
                            <h1><asp:Label ID="lblName2" runat="server"></asp:Label></h1>
                        </div>
                        <div class="panel-body">

                            <h3>&#8377;<asp:Label ID="lblPrice2" runat="server"></asp:Label></h3>
                            <h4>First 15 day's Free </h4>
                            <h4><asp:Label ID="lblDuration2" runat="server"></asp:Label> Month Access</h4>
                            <h4>5 User</h4>
                            <h4>Unlimited Warehouse</h4>
                            <h4>Unlimited Purchase Order</h4>
                            <h4>Unlimited Sale Order</h4>
                            <h4>Reports</h4>

                        </div>
                        <div class="panel-footer">


                            <button class="btn btn-lg btn-primary">Subscribe</button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 col-xs-12">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading" style="background-color: #090e63; color: white">
                            <h1><asp:Label ID="lblName3" runat="server"></asp:Label></h1>
                        </div>
                        <div class="panel-body">
                            <h3>&#8377;<asp:Label ID="lblPrice3" runat="server"></asp:Label></h3>
                            <h4>First 15 day's Free </h4>
                            <h4><asp:Label ID="lblDuration3" runat="server"></asp:Label> Month Access</h4>
                            <h4>8 User</h4>
                            <h4>Unlimited Warehouse</h4>
                            <h4>Unlimited Purchase Order</h4>
                            <h4>Unlimited Sale Order</h4>
                            <h4>Reports</h4>
                        </div>
                        <div class="panel-footer">


                            <button class="btn btn-lg btn-primary">Subscribe</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       
    </div>
</asp:Content>
