<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FinincialYear.aspx.cs" Inherits="IMS.FinincialYear" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= GridView1.ClientID %>').DataTable();
        });
    </script>
    <script type='text/javascript'>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }
    </script>
    <script>

        $(function () {
            $("#<%= txtStartdate.ClientID %>").datepicker({
                numberOfMonths: 2,
                onSelect: function (selected) {
                    var dt = new Date(selected);
                    dt.setDate(dt.getDate() + 30);
                    $("#<%= txtEndDate.ClientID %>").datepicker("option", "minDate", dt);
                }
            });
            $("#<%= txtEndDate.ClientID %>").datepicker({
                numberOfMonths: 2,
                onSelect: function (selected) {
                    var dt = new Date(selected);
                    dt.setDate(dt.getDate() - 30);
                    $("#<%= txtStartdate.ClientID %>").datepicker("option", "maxDate", dt);
                }
            });
        });
    </script>
    <script type="text/javascript">

        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/FinincialYear.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtStartdate.ClientID%>")[0].value + '" }',// user name or email value  
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
                    msg.innerHTML = "This Start Date already Exists";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = false;
                    break;
            }
        }
    </script>
    <script type="text/javascript">

        function CheckDouble1() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/FinincialYear.aspx/CheckDouble1") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtEndDate.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccess(response) {
            var msg = $("#<%=lblcheckDoubleError2.ClientID%>")[0];
            var hd1 = $("#<%=hd12.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    hd1.value = true;
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This End Date already Exists";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = false;
                    break;
            }
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div>
            <a href="../Master.aspx" id="bMaster" runat="server">
                <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
        </div>
    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>Financial year Master</h1>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="col-md-12">
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="col-sm-5 leftpadd0">
                                <label class="control-label   ">
                                    Start Date:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                </label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtStartdate" runat="server" CssClass="form-control" onchange="CheckDouble()"></asp:TextBox>
                                <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                <asp:RequiredFieldValidator ID="rvaldt1" runat="server" ErrorMessage="Date is required" ValidationGroup="abc" ControlToValidate="txtStartdate" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:HiddenField ID="hd" runat="server" />
                            </div>
                        </div>

                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <div class="col-sm-5 leftpadd0">
                                <label class="control-label">
                                    End Date:
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="abc" ErrorMessage="*" ControlToValidate="txtEndDate" ForeColor="Red"></asp:RequiredFieldValidator>
                                </label>
                            </div>
                            <div class="col-sm-7">

                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" onchange="CheckDouble1()"></asp:TextBox>

                                <asp:Label ID="lblcheckDoubleError2" runat="server"></asp:Label>
                                <asp:HiddenField ID="hd12" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="panel-footer text-center">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="abc" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />
            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="abc" />
            <input class="btn btn-primary " type="button" value="Clear"  onclick="javascript: window.location = 'FinincialYear.aspx'" />
            <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
        </div>
    </div>
    <div class="row">
        <div class="alert alert-success" id="divalert" runat="server" visible="false">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <asp:Label ID="lblAlert" runat="server"></asp:Label>

        </div>
    </div>
    <div class="row">
        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div>
                <asp:GridView ID="GridView1" runat="server" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound" SelectedIndex="0" OnRowCommand="GridView1_RowCommand" DataKeyNames="financialyear_id" AutoGenerateColumns="False" CssClass="table table table-striped table-bordered table-hover">
                    <Columns>
                        <asp:BoundField DataField="start_date" HeaderText="Start_Date"></asp:BoundField>

                        <asp:BoundField DataField="end_date" HeaderText="End _Date"></asp:BoundField>


                        <asp:TemplateField HeaderText="Update">
                            <ItemTemplate>
                                <asp:ImageButton CommandName="UpdateRow" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />

                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                            <ItemTemplate>
                                <asp:ImageButton CommandName="DeleteRow" ID="btnimg_delete" CommandArgument='<%# Eval("financialyear_id") %>' runat="server" ImageUrl="~/assets/img/remove.png" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                </asp:GridView>
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


<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System</title>
    <!-- Core CSS - Include with every page -->
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />
    <link href="../assets/plugins/pickday%20Calender/pikaday.css" rel="stylesheet" />
    <script src="../assets/plugins/pickday%20Calender/pikaday.js"></script>
    <link href="../assets/plugins/pickday%20Calender/theme.css" rel="stylesheet" />
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
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
    
</head>--%>
<%--<body>
    <form id="form1" runat="server">--%>
<%--<div class="container">
            <div class="panel panel-default ">
                <div class="panel-heading text-center">
                    <h1>Financial year Master</h1>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label   ">
                                            Start Date:
                                            <asp:RequiredFieldValidator ID="rvaldt1" runat="server" ErrorMessage="*" ValidationGroup="abc" ControlToValidate="txtStartdate" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtStartdate" runat="server" CssClass="form-control" onchange="CheckDouble()"></asp:TextBox>

                                        <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                        <asp:HiddenField ID="hd" runat="server" />
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label">
                                            End Date:
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="abc" ErrorMessage="*" ControlToValidate="txtEndDate" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-7">

                                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" onchange="CheckDouble1()"></asp:TextBox>

                                        <asp:Label ID="lblcheckDoubleError2" runat="server"></asp:Label>
                                        <asp:HiddenField ID="hd12" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="panel-footer text-center">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="abc" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="abc" />
                    <input class="btn btn-primary " type="button" value="Clear" onclick="cleartextboxes();" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />
                </div>
            </div>
            <div class="row">
                <div class="alert alert-success" id="divalert" runat="server" visible="false">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label ID="lblAlert" runat="server"></asp:Label>

                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <div>
                        <asp:GridView ID="GridView1" runat="server" SelectedIndex="0" OnRowCommand="GridView1_RowCommand" DataKeyNames="financialyear_id" AutoGenerateColumns="False" CssClass="table table table-striped table-bordered table-hover">
                            <Columns>
                                <asp:BoundField DataField="start_date" HeaderText="Start_Date"></asp:BoundField>

                                <asp:BoundField DataField="end_date" HeaderText="End _Date"></asp:BoundField>


                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="UpdateRow" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />

                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="DeleteRow" ID="btnimg_delete" CommandArgument='<%# Eval("financialyear_id") %>' runat="server" ImageUrl="~/assets/img/remove.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                        </asp:GridView>
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
        </div>--%>
<%--</form>
</body>
</html>--%>
