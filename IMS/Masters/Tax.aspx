﻿<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Tax.aspx.cs" Inherits="IMS.Tax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type='text/javascript'>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= GridView1.ClientID %>').DataTable();
        });
        function validdiscount() {
            if ($('#<%=txtTaxPercent.ClientID%>').val() > 100) {
                $('#<%=txtTaxPercent.ClientID%>').val('100');
            }
        }


        function OnlyNumericEntry(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;

            return true;

        }

    </script>
    <script type="text/javascript">

        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Tax.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtTaxName.ClientID%>")[0].value + '" }',// user name or email value  
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
                    hd1.value = true;
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This Tax Name Already Eixst";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = false;
                    break;
            }
        }
        var txt = $("<%=txtTaxName.ClientID%>");

        txt.focus();
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div>
            <a href="../Master.aspx" id="bMaster" runat="server">
                <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
        </div>
        <div class="padding50"></div>
        <div class="panel panel-default ">
            <div class="panel-heading text-center">
                <h1>Tax Master</h1>
            </div>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Tax Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>                                                
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtTaxName" runat="server" onchange="CheckDouble()" CssClass="form-control"> </asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="tx" ErrorMessage="Name is required" ControlToValidate="txtTaxName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:HiddenField ID="hd" runat="server" />
                                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>

                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label">
                                        Tax Percentage:<asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>                                                
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtTaxPercent" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="tx" ErrorMessage="Percentage is required" ControlToValidate="txtTaxPercent" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ValidationExpression="^\s*(?=.*[0-9])\d*(?:\.\d{1,3})?\s*$" runat="server" ValidationGroup="tx" Display="Dynamic" ForeColor="Red" ControlToValidate="txtTaxPercent" ErrorMessage="Tax Percentage should be greater then 0"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Tax Percentage should be in between 1 to 99" MaximumValue="99" MinimumValue="1" ControlToValidate="txtTaxPercent" ForeColor="Red"></asp:RangeValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer text-center">
                <asp:Button ID="btnSave" runat="server" ValidationGroup="tx" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" />
                <asp:Button ID="btnUpdate" runat="server" ValidationGroup="tx" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" />
                <input class="btn btn-primary " type="button" value="Clear"  onclick="javascript: window.location = 'Tax.aspx'" />
                <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
            </div>
        </div>
        <div class="row">
            <div class="alert alert-success" id="divalert" runat="server" visible="false">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label ID="lblAlert" runat="server"></asp:Label>


            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <div>
                        <asp:GridView ID="GridView1" runat="server" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="tax_id" CssClass="table table table-striped table-bordered table-hover" AutoGenerateColumns="false" SelectedIndex="0">
                            <Columns>
                                <asp:BoundField DataField="tax_name" HeaderText="Tax Name"></asp:BoundField>
                                <asp:BoundField DataField="tax_percentage" HeaderText="Tax Percent"></asp:BoundField>
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="Select" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("tax_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog" runat="server">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Alert</h4>
                </div>
                <div class="modal-body">
                    <p>Do You want to delete This Tax? </p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<%--<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">--%>
<%--<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System</title>
    <!-- Core CSS - Include with every page -->
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />
    <!-- Page-Level CSS -->
    <link href="../assets/plugins/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <script src="../assets/scripts/main.js"></script>
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/responsive/1.0.7/css/responsive.bootstrap.min.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/responsive/1.0.7/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

</head>--%>
<%--<body>
    <form id="form1" runat="server">--%>

<%--        <div class="container">
            <div class="padding50"></div>
            <div class="panel panel-default ">
                <div class="panel-heading text-center">
                    <h1>Tax Master</h1>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-group ">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label   ">
                                            Tax Name:
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="tx" ErrorMessage="*" ControlToValidate="txtTaxName" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtTaxName" runat="server" onchange="CheckDouble()" CssClass="form-control"> </asp:TextBox>
                                        <asp:HiddenField ID="hd" runat="server" />
                                        <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label   ">
                                            Tax Percentage:
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="tx" ErrorMessage="*" ControlToValidate="txtTaxPercent" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtTaxPercent" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ValidationExpression="^\s*(?=.*[0-9])\d*(?:\.\d{1,3})?\s*$" runat="server" ValidationGroup="tx" Display="Dynamic" ForeColor="Red" ControlToValidate="txtTaxPercent" ErrorMessage="Tax Percentage should be greater then 0"></asp:RegularExpressionValidator>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Tax Percentage should be in between 1 to 99" MaximumValue="99" MinimumValue="1" ControlToValidate="txtTaxPercent" ForeColor="Red"></asp:RangeValidator>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer text-center">
                    <asp:Button ID="btnSave" runat="server" ValidationGroup="tx" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />

                    <asp:Button ID="btnUpdate" runat="server" ValidationGroup="tx" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" />
                    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary " Text="Clear" OnClick="btnClear_Click" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />
                </div>
            </div>
            <div class="row">
                <div class="alert alert-success" id="divalert" runat="server" visible="false">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label ID="lblAlert" runat="server"></asp:Label>


                </div>
                <div class="row">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <div>
                            <asp:GridView ID="GridView1" runat="server" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="tax_id" CssClass="table table table-striped table-bordered table-hover" AutoGenerateColumns="false" SelectedIndex="0">
                                <Columns>
                                    <asp:BoundField DataField="tax_name" HeaderText="Tax Name"></asp:BoundField>
                                    <asp:BoundField DataField="tax_percentage" HeaderText="Tax Percent"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Update">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="Select" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                        <ItemTemplate>
                                            <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("tax_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog" runat="server">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Alert</h4>
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
        </div>--%>
<%-- </form>
</body>
</html>--%>
