<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Rack.ascx.cs" Inherits="IMS.UserControl.UC_Rack" %>
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
                            <asp:DropDownList ID="ddlGodownName" runat="server" AutoPostBack="true" CssClass="form-control" AppendDataBoundItems="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" ValidationGroup="rckvalidationgrp" ErrorMessage="Select Godown" ControlToValidate="ddlGodownName" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="rckvalidationgrp" ErrorMessage="Rack name is required" ControlToValidate="txtRackName" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="hd" runat="server" />
                            <asp:HiddenField ID="hdrack" runat="server" />
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
    <div class="panel-footer text-center">
        <asp:Button ID="btnrckSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnrckSave_Click"  UseSubmitBehavior="false" ValidationGroup="rckvalidationgrp" />
        <asp:Button ID="btnrckUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnrckUpdate_Click"  Visible="false" ValidationGroup="rckvalidationgrp" />
        <asp:Button ID="btnrckClear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btnrckClear_Click"      />
        <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
    </div>

</div>
<div class="row">
    <div class="alert alert-success" id="divalert" runat="server" visible="false">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label ID="lblAlert" runat="server"></asp:Label>

    </div>
</div>
