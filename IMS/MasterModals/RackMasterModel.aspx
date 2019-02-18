<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="RackMasterModel.aspx.cs" Inherits="IMS.RackMasterModel" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>IMS</title>

    <link href="../assets/plugins/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../assets/scripts/jquery.min.js"></script>

    <script type="text/javascript">

        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }

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
</head>
<body>
    <form runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="panel panel-default ">
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
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="rck" />
                    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary " Text="Clear" OnClick="btnClear_Click" />
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
    </form>
</body>
</html>
