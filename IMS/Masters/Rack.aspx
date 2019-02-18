<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Rack.aspx.cs" Inherits="IMS.Rack" %>


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
    </script>
    <script type="text/javascript">
        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Rack.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtRackName.ClientID%>")[0].value + '" ,g_id: "' + $("#<%=ddlGodownName.ClientID%>")[0].value + '" }',// user name or email value  
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
                    msg.innerHTML = "This Rack name already Exists";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = false;
                    break;
            }
        }
        var txt = $("<%=txtRackName.ClientID%>");

        txt.focus();
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
                <h1>Rack Master</h1>
            </div>
            <div class="panel-body" id="form2" runat="server">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Godown Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>                                             
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlGodownName" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlGodownName_SelectedIndexChanged" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" ValidationGroup="rck" ErrorMessage="Select Godown" ControlToValidate="ddlGodownName" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label">
                                        Rack Name:<asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>                                            
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtRackName" onchange="CheckDouble()" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="rck" ErrorMessage="Rack name is required" ControlToValidate="txtRackName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:HiddenField ID="hd" runat="server" />
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="panel-footer text-center">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" OnClientClick="DisableOnSave(this,'rck');"  UseSubmitBehavior="false" ValidationGroup="rck" />
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="rck" />
                 <input class="btn btn-primary " type="button" value="Clear"  onclick="javascript: window.location = 'Rack.aspx'" />
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
                    <asp:GridView ID="GridView1" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound" runat="server" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" SelectedIndex="0" DataKeyNames="rack_id" AutoGenerateColumns="false" CssClass="table table table-striped table-bordered table-hover">
                        <Columns>
                            <asp:BoundField DataField="rack_name" HeaderText="Rack Name"></asp:BoundField>
                            <asp:BoundField DataField="godown_name" HeaderText="Godown Name"></asp:BoundField>
                            <asp:BoundField DataField="godown_id" HeaderText="godown_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                            <asp:BoundField DataField="rack_id" HeaderText="rack_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="Select" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("rack_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" />
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
<html xmlns="http://www.w3.org/1999/xhtml">--%>
<%--<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Inventory Management System</title>
    <!-- Core CSS - Include with every page -->
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
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
            <div class="panel panel-default ">
                <div class="panel-heading text-center">
                    <h1>Rack Master</h1>
                </div>
                <div class="panel-body" id="form2" runat="server">
                    <div class="form-horizontal">
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label   ">Godown Name:
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" ValidationGroup="rck" ErrorMessage="*" ControlToValidate="ddlGodownName" ForeColor="Red"></asp:RequiredFieldValidator> 
                                        </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:DropDownList ID="ddlGodownName" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlGodownName_SelectedIndexChanged"   AppendDataBoundItems="true" >
                                           
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group ">
                                    <div class="col-sm-5 leftpadd0">
                                        <label class="control-label   ">Rack Name:
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="rck"  ErrorMessage="*" ControlToValidate="txtRackName" ForeColor="Red"></asp:RequiredFieldValidator> </label>
                                    </div>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtRackName" onchange="CheckDouble()" runat="server" CssClass="form-control" ></asp:TextBox>
                                         <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                                    <asp:HiddenField ID="hd" runat="server" />
                                     
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                        
                    </div>
                </div>
                <div class="panel-footer text-center">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="rck" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="rck"  />  
                       <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary " Text="Clear" OnClick="btnClear_Click"   />
                     <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" style="float:right" />
                
                    
                </div>
            </div>
             <div class="row">
                <div class="alert alert-success" id="divalert" runat="server" visible="false">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <asp:Label ID="lblAlert" runat="server"  ></asp:Label>
                   
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <div>
                        <asp:GridView ID="GridView1" runat="server" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" SelectedIndex="0" DataKeyNames="rack_id" AutoGenerateColumns="false" CssClass="table table table-striped table-bordered table-hover">
                            <Columns>
                                <asp:BoundField DataField="rack_name" HeaderText="Rack Name"  ></asp:BoundField>
                                <asp:BoundField DataField="godown_name" HeaderText="Godown Name"  ></asp:BoundField>
                                <asp:BoundField DataField="godown_id" HeaderText="godown_id"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" ></asp:BoundField>
                                <asp:BoundField DataField="rack_id" HeaderText="rack_id"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" ></asp:BoundField>
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="Select" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Delete"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("rack_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" />
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
        </div>--%>
<%--</form>
</body>
</html>--%>

