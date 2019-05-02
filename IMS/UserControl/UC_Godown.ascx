<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Godown.ascx.cs" Inherits="IMS.UserControl.UC_Godown" %>
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
        function cleartextbox() {
            cleartextboxes();
        }
</script>



<div class="panel panel-default text-center">
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="godwnvalidationgrp" ErrorMessage="Name is required" ControlToValidate="txtGodownName" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="hd" runat="server" />
                            <asp:HiddenField ID="hdgodownid" runat="server" />
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="godwnvalidationgrp" ErrorMessage="Address is required" ControlToValidate="txtGodownAddress" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ValidationGroup="godwnvalidationgrp" runat="server" ErrorMessage="Contact is required" ControlToValidate="txtContactNo" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rgx" runat="server" ErrorMessage="Enter valid Phone number in between 10-14 digits"
                                ControlToValidate="txtContactNo" Display="Dynamic" ValidationExpression="^[0-9]{10}$" ForeColor="Red" ValidationGroup="godwnvalidationgrp">
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="godwnvalidationgrp" Display="Dynamic" runat="server" ErrorMessage="Contact Person is required" ControlToValidate="txtContactPerson" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="panel-footer text-center">

        <asp:Button ID="btngodwnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btngodwnSave_Click"  UseSubmitBehavior="false" ValidationGroup="godwnvalidationgrp" />
        <asp:Button ID="btngodwnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btngodwnUpdate_Click"  Visible="false" ValidationGroup="godwnvalidationgrp" />
        <input class="btn btn-primary " type="button" value="Clear" onclick="cleartextbox()"  />
        <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
    </div>
</div>
  <div class="row">
            <div class="alert alert-success" id="divalert" runat="server" visible="false">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label ID="lblAlert" runat="server"></asp:Label>
            </div>
        </div>
