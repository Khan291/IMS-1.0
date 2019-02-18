<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Godown.aspx.cs" Inherits="IMS.Godown" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type='text/javascript'>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }
    </script>
    <script type="text/javascript">

        function CheckDouble() {

            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Godown.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtGodownName.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                }
            });
        }
        function OnSuccess(response) {
            var msg = $("#<%=lblcheckDoubleError.ClientID%>")[0];
             var hd1 = $("#<%=hd.ClientID%>")[0];
             switch (response.d) {
                 case "true":
                     msg.style.display = "block";
                     msg.style.color = "red";
                     msg.innerHTML = "This Godown name already Exists";
                     hd1.value = true;
                     break;
                 case "false":
                     msg.style.display = "none";
                     hd1.value = false;
                     break;
             }
         }

         function OnlyNumericEntry(evt) {
             var charCode = (evt.which) ? evt.which : evt.keyCode;
             if (charCode > 31 && (charCode < 48 || charCode > 57))
                 return false;
         }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= GridView1.ClientID %>').DataTable();
        });
        var txt = $("<%=txtGodownName.ClientID%>");

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
                <h1>GoDown Master</h1>
            </div>
            <div class="panel-body" id="pb">
                <div class="col-md-12">
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group lef ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label">
                                        Godown Name :<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtGodownName" runat="server" onchange="CheckDouble()" CssClass="form-control"></asp:TextBox>
                                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="godwn" ErrorMessage="Name is required" ControlToValidate="txtGodownName" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:HiddenField ID="hd" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label">
                                        Address :<asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtGodownAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="godwn" ErrorMessage="Address is required" ControlToValidate="txtGodownAddress" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label">
                                        Contact No :<asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ValidationGroup="godwn" runat="server" ErrorMessage="Contact is required" ControlToValidate="txtContactNo" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="rgx" runat="server" ErrorMessage="Enter valid Phone number in between 10-14 digits"
                                        ControlToValidate="txtContactNo" Display="Dynamic" ValidationExpression="^[0-9]{10}$" ForeColor="Red" ValidationGroup="godwn">
                                    </asp:RegularExpressionValidator>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="leftpadd0  ">
                                        Contact Person :<asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtContactPerson" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="godwn" Display="Dynamic" runat="server" ErrorMessage="Contact Person is required" ControlToValidate="txtContactPerson" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer text-center">

                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" OnClientClick="DisableOnSave(this,'godwn');"  UseSubmitBehavior="false" ValidationGroup="godwn" />
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="godwn" />
                <input class="btn btn-primary " type="button" value="Clear"  onclick="javascript: window.location = 'Godown.aspx'" />
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
                    <asp:GridView ID="GridView1" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound" runat="server" DataKeyNames="godown_id" OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" CssClass="table table-responsive table-striped table-bordered table-hover" SelectedIndex="0">
                        <Columns>
                            <asp:BoundField DataField="godown_name" HeaderText="Godown Name"></asp:BoundField>
                            <asp:BoundField DataField="godown_address" HeaderText="Address" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                            <asp:BoundField DataField="contact_no" HeaderText="Contact No"></asp:BoundField>
                            <asp:BoundField DataField="contact_person" HeaderText="Contact Person" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="UpdateRow" />

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnimg_delete" CommandArgument='<%# Eval("godown_id") %>' runat="server" ImageUrl="~/assets/img/remove.png" CommandName="DeleteRow" />
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
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
    <form id="form1" runat="server">
        <div class="container">
            <div class="padding50"></div>
            <div class="panel panel-default ">
                <div class="panel-heading text-center">
                    <h1>GoDown Master</h1>
                </div>
                <div class="panel-body" id="pb">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group lef ">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label">Godown Name   :
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="godwn" ErrorMessage="*" ControlToValidate="txtGodownName" Display="Dynamic"  ForeColor="Red"></asp:RequiredFieldValidator>

                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtGodownName" runat="server" onchange="CheckDouble()" CssClass="form-control"></asp:TextBox>
                                         <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                           <asp:HiddenField ID="hd" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label">Address       :
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="godwn" ErrorMessage="*" ControlToValidate="txtGodownAddress" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtGodownAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                      
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label">Contact No    :
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ValidationGroup="godwn"  runat="server" ErrorMessage="*" ControlToValidate="txtContactNo" ForeColor="Red"></asp:RequiredFieldValidator>

                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="rgx" runat="server" ErrorMessage="Enter valid Phone number in between 10-14 digits"
                                            ControlToValidate="txtContactNo" display="Dynamic" ValidationExpression="^[0-9]{10}$" ForeColor="Red" ValidationGroup="godwn" >
                                        </asp:RegularExpressionValidator>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="leftpadd0  ">Contact Person:
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="godwn" Display="Dynamic"  runat="server" ErrorMessage="*" ControlToValidate="txtContactPerson" ForeColor="Red"></asp:RequiredFieldValidator>

                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtContactPerson" runat="server" CssClass="form-control"></asp:TextBox>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer text-center">

                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="godwn" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false"/>
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="godwn" />
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
                        <asp:GridView ID="GridView1" runat="server" DataKeyNames="godown_id" OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" CssClass="table table-responsive table-striped table-bordered table-hover" SelectedIndex="0">
                            <Columns>
                                <asp:BoundField DataField="godown_name" HeaderText="Godown Name"></asp:BoundField>
                                <asp:BoundField DataField="godown_address" HeaderText="Address" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="contact_no" HeaderText="Contact No"></asp:BoundField>
                                <asp:BoundField DataField="contact_person" HeaderText="Contact Person" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="UpdateRow" />

                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnimg_delete" CommandArgument='<%# Eval("godown_id") %>' runat="server" ImageUrl="~/assets/img/remove.png" CommandName="DeleteRow" />
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
                        <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click"  />
                        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>--%>
