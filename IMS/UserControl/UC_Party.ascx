<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Party.ascx.cs" Inherits="IMS.UserControl.UC_Party" %>


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

       function Checkgstin() {
           $.ajax({
               type: "POST",
               url: '<%= ResolveUrl("~/Masters/Party.aspx/checkGstinNo") %>', // this for calling the web method function in cs code.  
               data: '{useroremail: "' + $("#<%=txtGSTIN.ClientID%>")[0].value + '" }',// user name or email value  
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: OnSuccessgstin,
               failure: function (response) {
                   alert(response);
               }
           });
       }
       function OnSuccessgstin(response) {
           var msg = $("#<%=lblgstinerror.ClientID%>")[0];
            var hd1 = $("#<%=hde.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This Gstin No is already exists";
                    hd1.value = "true";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = "false";
                    break;
            }
        } function CheckmobileNo() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Party.aspx/checkContactNo") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtContactNo.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessmobile,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccessmobile(response) {
            var msg = $("#<%=lblContactNo.ClientID%>")[0];
            var hd1 = $("#<%=hde.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This Contact No is already exists";
                    hd1.value = "true";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = "false";
                    break;
            }
        }


        var txt = $("<%=txtPartyName.ClientID%>");

    txt.focus();
</script>

<div class="panel panel-default">
    <div class="panel-body">
        <div class="col-md-12">
            <div class="col-md-5">
                <div class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-4 leftpadd0">
                            <label class="control-label">
                                Party Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </label>
                        </div>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtPartyName" onchange="CheckDouble()" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ValidationGroup="prtyvalidationgrp" runat="server" ErrorMessage="Party name is required" ControlToValidate="txtPartyName" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                            <asp:HiddenField ID="hde" runat="server" />
                            <asp:HiddenField ID="hdpartyid" runat="server"/>
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ValidationGroup="prtyvalidationgrp" runat="server" ErrorMessage="Address is required" ControlToValidate="txtPartyAddress" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <asp:TextBox ID="txtContactNo" runat="server" onchange="CheckmobileNo()" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="prtyvalidationgrp" Display="Dynamic" ErrorMessage="Contact is required" ControlToValidate="txtContactNo" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rgx" runat="server" ValidationGroup="prtyvalidationgrp" ErrorMessage="Invalid Mobile No" Display="Dynamic"
                                ControlToValidate="txtContactNo" ValidationExpression="^[0-9]{10}$" ForeColor="Red">
                            </asp:RegularExpressionValidator>
                            <asp:Label ID="lblContactNo" ForeColor="Red" runat="server"></asp:Label>
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
                            <asp:TextBox ID="txtGSTIN" runat="server" onchange="Checkgstin()" CssClass="form-control"></asp:TextBox>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="prtyvalidationgrp" Display="Dynamic" ErrorMessage="GSTIN is required" ControlToValidate="txtGSTIN" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                            <asp:Label ID="lblgstinerror" ForeColor="Red" runat="server"></asp:Label>
                            <asp:HiddenField ID="hd2" runat="server" />
                            <asp:RegularExpressionValidator ID="rxgst" runat="server" ErrorMessage="Invalid GSTIN" ForeColor="Red" Display="Dynamic" ValidationExpression="\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d[Z]{1}[A-Z\d]{1}" ControlToValidate="txtGSTIN" ValidationGroup="prtyvalidationgrp"></asp:RegularExpressionValidator>
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
                            <label class="control-label">
                                Party Type:<asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </label>
                        </div>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="ddlPartyType" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Party" Value="0" />
                                <asp:ListItem Text="Customer" Value="Customer" />
                                <asp:ListItem Text="Vendor" Value="Vendor" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="prtyvalidationgrp" InitialValue="0" Display="Dynamic" ErrorMessage="Select Type" ControlToValidate="ddlPartyType" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="prtyvalidationgrp" InitialValue="0" Display="Dynamic" ErrorMessage="State is required" ControlToValidate="ddlState" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel-footer text-center">
        <asp:Button ID="btnprtySave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnprtySave_Click" UseSubmitBehavior="false" ValidationGroup="prtyvalidationgrp" />
        <asp:Button ID="btnprtyUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnprtyUpdate_Click" Visible="false" ValidationGroup="prtyvalidationgrp" />
        <input class="btn btn-primary " type="button" value="Clear" />
        <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
    </div>
</div>
<div class="row">
    <div class="alert alert-success" id="divalert" runat="server" visible="false">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label ID="lblAlert" runat="server"></asp:Label>

    </div>
</div>
