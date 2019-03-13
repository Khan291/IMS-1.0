<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="IMS.Masters.Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div runat="server" id="divParty">
        <div class="container-fluid">
            <div>
                <a href="../Master.aspx" id="bMaster" runat="server">
                    <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
            </div>
            <div class="padding50"></div>
            <div class="panel panel-default ">
                <div class="panel-heading text-center">
                    <h1>Party Details</h1>
                </div>
                <div class="panel-body">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label">
                                            Party Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:Label ID="lblPartyName" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label">
                                            Address:<asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label">
                                            Contact No:<asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label">
                                            GSTIN No:<asp:Label ID="Label3" runat="server"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label">
                                            Party Type:<asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label">
                                            State:<asp:Label ID="Label5" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
