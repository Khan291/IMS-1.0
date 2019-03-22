<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="IMS.Category" %>

<%@ Register src="~/UserControl/UC_Category.ascx" TagName="ctrlcategory"  TagPrefix="TWebControl"%>

<%--<!DOCTYPE html>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    
<%--    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/responsive/1.0.7/css/responsive.bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css" />

    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/responsive/1.0.7/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/dataTables.bootstrap.min.js"></script>--%>
   <%-- <script src="../assets/datatable/jquery-3.3.1.js"></script>
    <script src="../assets/datatable/jquery.dataTables.min.js"></script>
    <link href="../assets/datatable/dataTables.min.css" rel="stylesheet" />--%>
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
    <script type="text/javascript">
       <%-- function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Category.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{categoryName: "' + $("#<%=txtCategoryName.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccess(response) {
            debugger;
            var msg = $("#<%=lblcheckDoubleError.ClientID%>")[0];
            var hd1 = $("#<%=hd.ClientID%>")[0];
            switch (response.d) {
                case true:

                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This category name already Exists";
                    hd1.value = "true";
                    break;
                case false:
                    msg.style.display = "none";
                    hd1.value = "false";
                    break;
            }
        }
        function clearcategory() {
            cleartextboxes();
            $("#<%=txtCategoryName.ClientID%>").focus();
        }--%>
    </script>
    <script type="text/javascript">
        // Reference the textbox and call its focus function
      <%--  var txt = $("<%=txtCategoryName.ClientID%>");

        txt.focus();--%>
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">
        <div>
            <a href="../Master.aspx" id="bMaster" runat="server">
                <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
        </div>

        
       
         

        <div class="panel panel-default text-center">
            <div class="panel-heading text-left">
                <h1>Category Master</h1>
            </div>
            
           
           
        </div>
        <twebcontrol:ctrlcategory  ID="ctrlcategory"  runat="server" />
        <div class="row">
            <div class="alert alert-success" id="divalert" runat="server" visible="false">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label ID="lblAlert" runat="server"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <div>
                    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="category_id"
                        CssClass="table table table-striped table-bordered table-responsive table-hover" OnPreRender="GridView1_PreRender" AutoGenerateColumns="False" SelectedIndex="0">
                        <Columns>
                            <asp:BoundField DataField="category_name" HeaderText="Category Name"></asp:BoundField>
                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="Select" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />

                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("category_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" data-toggle="modal" href="#myModal" />
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
                    <h4 class="modal-title">Alert</h4>
                </div>
                <div class="modal-body">
                    <p>Are You Sure You want to delete This Category? </p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inventory Management System</title>
    <!-- Core CSS - Include with every page -->
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />
    <!-- Page-Level CSS -->
    <script src="../assets/scripts/main.js"></script>
    <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
    
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/responsive/1.0.7/css/responsive.bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css" />

    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/responsive/1.0.7/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.9/js/dataTables.bootstrap.min.js"></script>

    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
    <script type="text/javascript">

        $(function () {
            $('#GridView1').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                "responsive": true,
                "sPaginationType": "full_numbers"
            });
        });
    </script>
    <script type='text/javascript'>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
         }
    </script>
    <script type="text/javascript">
        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Category.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{categoryName: "' + $("#<%=txtCategoryName.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccess(response) {
            debugger;
            var msg = $("#<%=lblcheckDoubleError.ClientID%>")[0];
            var hd1 = $("#<%=hd.ClientID%>")[0];
            switch (response.d) {
                case true:

                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This category name already Exists";
                    hd1.value = "true";
                    break;
                case false:
                    msg.style.display = "none";
                    hd1.value = "false";
                    break;
            }
        }
        function clearcategory() {
            cleartextboxes();
            $("#<%=txtCategoryName.ClientID%>").focus();
        }
    </script>
    <script type="text/javascript">
        // Reference the textbox and call its focus function
        var txt = $("<%=txtCategoryName.ClientID%>");

        txt.focus();
    </script>

</head>--%>

<%--<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="panel panel-default text-center">
                <div class="panel-heading">
                    <h1>Category Master</h1>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-group ">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label   ">
                                            Category Name: 
                                             <asp:RequiredFieldValidator ID="rvaldt1" runat="server" Display="Dynamic" ErrorMessage="*" ValidationGroup="abc" ControlToValidate="txtCategoryName" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtCategoryName" onchange="CheckDouble()" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                <asp:HiddenField ID="hd" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">

                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " ValidationGroup="abc" Text="Save" OnClick="btnSave_Click" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" ValidationGroup="abc" Text="Update" OnClick="btnUpdate_Click" Visible="false" />
                    <input class="btn btn-primary " type="button" value="Clear" onclick="clearcategory()" />
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
                        <asp:GridView ID="GridView1" runat="server" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="category_id"
                            CssClass="table table table-striped table-bordered table-hover" AutoGenerateColumns="False" SelectedIndex="0">
                            <Columns>
                                <asp:BoundField DataField="category_name" HeaderText="Category Name"></asp:BoundField>
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="Select" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />

                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("category_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" data-toggle="modal" href="#myModal" />
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
                        <h4 class="modal-title">Alert</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are You Sure You want to delete This Category? </p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>--%>
