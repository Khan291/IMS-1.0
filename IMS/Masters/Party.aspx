<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Party.aspx.cs" Inherits="IMS.Party" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type='text/javascript'>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }
    </script>
    <script type="text/javascript">

        function countChar(val) {

            var len = val.value.length;
            var hd1 = $("#<%=hd2.ClientID%>")[0];
            if (len != 15) {
                document.getElementById('<%=lblgstinerror.ClientID %>').innerHTML = "GSTIN No Must be 15 digit alphanumeric only";
               hd1.value = "true";
           }
           else {
               document.getElementById('<%=lblgstinerror.ClientID %>').innerHTML = "";
               hd1.value = "false";
           }
       };

       function CheckDouble() {
           $.ajax({
               type: "POST",
               url: '<%= ResolveUrl("~/Masters/Party.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
               data: '{useroremail: "' + $("#<%=txtPartyName.ClientID%>")[0].value + '" }',// user name or email value  
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
           var hd1 = $("#<%=hde.ClientID%>")[0];
           switch (response.d) {
               case "true":
                   msg.style.display = "block";
                   msg.style.color = "red";
                   msg.innerHTML = "This Party name already exists";
                   hd1.value = "true";
                   break;
               case "false":
                   msg.style.display = "none";
                   hd1.value = "false";
                   break;
           }
       }
        $(document).ready(function () {
            $('#<%= GridView1.ClientID %>').DataTable();
        });

       var txt = $("<%=txtPartyName.ClientID%>");

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
                <h1>Party Master</h1>
            </div>
            <div class="panel-body">
                <div class="col-md-12">
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-4 leftpadd0">
                                    <label class="control-label   ">
                                        Party Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtPartyName" onchange="CheckDouble()" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ValidationGroup="abc" runat="server" ErrorMessage="Party name is required" ControlToValidate="txtPartyName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hde" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-4 leftpadd0">
                                    <label class="control-label   ">
                                        Address:<asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtPartyAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ValidationGroup="abc" runat="server" ErrorMessage="Address is required" ControlToValidate="txtPartyAddress" ForeColor="Red"></asp:RequiredFieldValidator>
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
                                    <label class="control-label   ">
                                        Contact No:<asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="abc" Display="Dynamic" ErrorMessage="Contact is required" ControlToValidate="txtContactNo" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="rgx" runat="server" ValidationGroup="abc" ErrorMessage="Invalid Mobile No" Display="Dynamic"
                                        ControlToValidate="txtContactNo" ValidationExpression="^[0-9]{10}$" ForeColor="Red">
                                    </asp:RegularExpressionValidator>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-4 leftpadd0">
                                    <label class="control-label   ">
                                        GSTIN No:<asp:Label ID="Label3" runat="server"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtGSTIN" runat="server" CssClass="form-control"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="abc" Display="Dynamic" ErrorMessage="GSTIN is required" ControlToValidate="txtGSTIN" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <asp:Label ID="lblgstinerror" ForeColor="Red" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hd2" runat="server" />
                                    <asp:RegularExpressionValidator ID="rxgst" runat="server" ErrorMessage="Invalid GSTIN" Display="Dynamic" ValidationExpression="\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d[Z]{1}[A-Z\d]{1}" ControlToValidate="txtGSTIN" ValidationGroup="abc"></asp:RegularExpressionValidator>
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
                                    <label class="control-label   ">
                                        Party Type:<asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="ddlPartyType" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Select Party" Value="0" />
                                        <asp:ListItem Text="Customer" Value="Customer" />
                                        <asp:ListItem Text="Vendor" Value="Vendor" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="abc" InitialValue="0" Display="Dynamic" ErrorMessage="Select Type" ControlToValidate="ddlPartyType" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-4 leftpadd0">
                                    <label class="control-label   ">
                                        State:<asp:Label ID="Label5" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="abc" InitialValue="0" Display="Dynamic" ErrorMessage="State is required" ControlToValidate="ddlState" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer text-center">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" OnClientClick="DisableOnSave(this,'abc');"  UseSubmitBehavior="false" ValidationGroup="abc" />
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="abc" />
                <input class="btn btn-primary " type="button" value="Clear"  onclick="javascript: window.location = 'Party.aspx'" />
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
                    <asp:GridView ID="GridView1" OnRowDataBound="GridView1_RowDataBound" OnPreRender="GridView1_PreRender" runat="server" AutoGenerateColumns="false" CssClass="table table table-striped table-bordered table-hover" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="party_id" SelectedIndex="0">
                        <Columns>
                            <asp:BoundField DataField="party_name" HeaderText="Party Name"></asp:BoundField>
                            <asp:BoundField DataField="party_address" HeaderText="Address" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                <HeaderStyle CssClass="hidden-xs"></HeaderStyle>

                                <ItemStyle CssClass="hidden-xs"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="contact_no" HeaderText="Contact No" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                <HeaderStyle CssClass="hidden-xs"></HeaderStyle>

                                <ItemStyle CssClass="hidden-xs"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="gstin_no" HeaderText="GSTIN No"></asp:BoundField>
                            <asp:BoundField DataField="party_type" HeaderText="Type"></asp:BoundField>
                            <asp:BoundField DataField="state_id" HeaderText="state_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>

                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="Select" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnimg_delete" CommandArgument='<%# Eval("party_id") %>' runat="server" ImageUrl="~/assets/img/remove.png" CommandName="DeleteRow" />
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
<%-- <div class="container">
            <div class="padding50"></div>
            <div class="panel panel-default ">
                <div class="panel-heading text-center">
                    <h1>Party Master</h1>
                </div>
                <div class="panel-body">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label   ">Party Name: 
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ValidationGroup="abc" runat="server" ErrorMessage="*" ControlToValidate="txtPartyName" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPartyName" onchange="CheckDouble()" runat="server" CssClass="form-control" ></asp:TextBox>
                                   <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                        
                                         <asp:HiddenField ID="hde" runat="server" />
                                         </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label   ">Address:
                                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ValidationGroup="abc" runat="server" ErrorMessage="*" ControlToValidate="txtPartyAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPartyAddress" runat="server" CssClass="form-control" ></asp:TextBox>
                               

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
                                        <label class="control-label   ">Contact No: 
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="abc" Display="Dynamic" ErrorMessage="*" ControlToValidate="txtContactNo" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" ></asp:TextBox>

                                        <asp:RegularExpressionValidator ID="rgx" runat="server" ValidationGroup="abc" ErrorMessage="Invalid Mobile No" Display="Dynamic"
                                            ControlToValidate="txtContactNo" ValidationExpression="^[0-9]{10}$" ForeColor="Red">
                                        </asp:RegularExpressionValidator>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label   ">GSTIN No:
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="abc" Display="Dynamic" ErrorMessage="*" ControlToValidate="txtGSTIN" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtGSTIN" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:Label ID="lblgstinerror" ForeColor="Red" runat="server" ></asp:Label>
                                        <asp:HiddenField ID="hd2" runat="server" />
                                        <asp:RegularExpressionValidator ID="rxgst" runat="server" ErrorMessage="Invalid GSTIN" ForeColor="Red" Display="Dynamic" ValidationExpression="\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d[Z]{1}[A-Z\d]{1}" ControlToValidate="txtGSTIN" ValidationGroup="abc"></asp:RegularExpressionValidator>
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
                                        <label class="control-label   ">Party Type: 
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="abc" InitialValue="0" Display="Dynamic" ErrorMessage="*" ControlToValidate="ddlPartyType" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlPartyType" runat="server" CssClass="form-control" >
                                            <asp:ListItem Text="Select Party" Value=0 />
                                            <asp:ListItem Text="Customer" Value="Customer" />
                                            <asp:ListItem Text="Vendor" Value="Vendor" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label   ">State: 
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="abc" InitialValue="0" Display="Dynamic" ErrorMessage="*" ControlToValidate="ddlState" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" >
                                         
                                        </asp:DropDownList>
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
                     <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" style="float:right" />
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
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table table-striped table-bordered table-hover" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="party_id" SelectedIndex="0">
                            <Columns>
                                <asp:BoundField DataField="party_name" HeaderText="Party Name"></asp:BoundField>
                                <asp:BoundField DataField="party_address" HeaderText="Address" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                    <HeaderStyle CssClass="hidden-xs"></HeaderStyle>

                                    <ItemStyle CssClass="hidden-xs"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="contact_no" HeaderText="Contact No" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                    <HeaderStyle CssClass="hidden-xs"></HeaderStyle>

                                    <ItemStyle CssClass="hidden-xs"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="gstin_no" HeaderText="GSTIN No"></asp:BoundField>
                                <asp:BoundField DataField="party_type" HeaderText="Type"></asp:BoundField>
                                <asp:BoundField DataField="state_id" HeaderText="state_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                             
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="Select" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnimg_delete"  CommandArgument='<%# Eval("party_id") %>' runat="server" ImageUrl="~/assets/img/remove.png" CommandName="DeleteRow" />
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
<%-- <!-- Core Scripts - Include with every page -->
        <script src="assets/plugins/jquery-1.10.2.js"></script>
        <script src="assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="assets/plugins/pace/pace.js"></script>
        <script src="assets/scripts/siminta.js"></script>
        <!-- Page-Level Plugin Scripts-->
        <script src="assets/plugins/dataTables/jquery.dataTables.js"></script>
        <script src="assets/plugins/dataTables/dataTables.bootstrap.js"></script>
        <script>--%>
<%-- //$(document).ready(function () {
            //    $('#dataTables-example').dataTable();
            //});
        </script>--%>
<%--  </form>
</body>
</html>--%>
