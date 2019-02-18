<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ExpenseMasterModel.aspx.cs" Inherits="IMS.Masters.ExpenseMasterModel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div>
            <a href="../Master.aspx" id="bMaster" runat="server">
                <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading text-center">
                <h1>Expense Master</h1>
            </div>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Expense Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtExpenseName" runat="server" onchange="CheckDouble()" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rvaldt1" runat="server" ValidationGroup="abc" ErrorMessage="Expense is required" ControlToValidate="txtExpenseName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>

                                    <asp:HiddenField ID="hde" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer text-center">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="abc" />
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="abc" />
                <input class="btn btn-primary" type="button" value="Clear" onclick="cleartextboxes();" />
                <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
            </div>
        </div>
        <div class="row">
            <div class="alert alert-success" id="divalert" runat="server" visible="false">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label ID="lblAlert" runat="server"></asp:Label>

            </div>
        </div>
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
                    <p>Do You want to delete This Unit? </p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
