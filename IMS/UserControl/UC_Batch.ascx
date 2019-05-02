<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Batch.ascx.cs" Inherits="IMS.UserControl.UC_Batch" %>
<script type="text/javascript">




    function CheckDouble() {
        try {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Batch.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                    data: '{useroremail: "' + $("#<%=txtBatchName.ClientID%>")[0].value + '" }',// user name or email value  
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response);
                    }
                });
            }
            catch (exceptin) {

            }
        }

        function OnSuccess(response) {
            var msg = $("#<%=lblcheckDoubleError.ClientID%>")[0];
               var hd1 = $("#<%=hd.ClientID%>")[0];
               switch (response.d) {
                   case "true":
                       msg.style.display = "block";
                       msg.style.color = "red";
                       msg.innerHTML = "This Batch name already Exists";
                       hd1.value = "true";
                       break;
                   case "false":
                       msg.style.display = "none";
                       hd1.value = "false";
                       break;
               }
           }
   
           var txt = $("<%=txtBatchName.ClientID%>");

    txt.focus();
</script>
<div class="panel panel-default text-center">

    <div class="panel-body">
        <div class="form-horizontal">
            <div class="col-md-12">
                <div class="col-md-5">
                    <div class="form-group ">
                        <div class="col-sm-5 leftpadd0">
                            <label class="control-label   ">
                                Batch Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </label>
                        </div>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtBatchName" runat="server" onchange="CheckDouble()" CssClass="form-control"></asp:TextBox>
                            <asp:Label ID="lblcheckDoubleError" runat="server" ForeColor="Red"></asp:Label>
                            <asp:RequiredFieldValidator ID="rvaldt1" runat="server" ErrorMessage="Batch name is required" ValidationGroup="btchvalidationgrp" ControlToValidate="txtBatchName" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="hd" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-5">
                </div>
            </div>
        </div>
    </div>
    <div class="panel-footer">
        <%--<asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" ValidationGroup="btchvalidationgrp" OnClick="btnSave_Click" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />--%>
        <asp:Button ID="btnbtchSave" runat="server" CssClass="btn btn-primary " Text="Save" ValidationGroup="btchvalidationgrp" OnClick="btnbtchSave_Click"  />
        <asp:Button ID="btnbtchUpdate" runat="server" CssClass="btn btn-primary" Text="Update" ValidationGroup="btchvalidationgrp" OnClick="btnbtchUpdate_Click" Visible="false" />
        <input class="btn btn-primary " type="button" value="Clear" onclick="cleartextboxes()" />
        <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
    </div>

</div>
<div class="row">
    <div class="alert alert-success" id="divalert" runat="server" visible="false">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label ID="lblAlert" runat="server"></asp:Label>
    </div>
</div>
