<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Product.ascx.cs" Inherits="IMS.UserControl.UC_Product" %>

<%@ Register src="~/UserControl/UC_Category.ascx" TagName="ctrlcategory"  TagPrefix="TWebControl"%>

<%@ Register src="~/UserControl/UC_Unit.ascx" TagName="ctrlunit"  TagPrefix="abc"%>

<%@ Register src="~/UserControl/UC_Godown.ascx" TagName="ctrlgodown"  TagPrefix="TWebControlGodwn"%>

<%@ Register Src="~/UserControl/UC_Rack.ascx" TagName="ctrlrack" TagPrefix="TWebControlRack" %>
<style>
    .input-group-addons {
        padding: 6px 10px;
        font-weight: normal;
        line-height: 1;
        color: #555555;
        text-align: center;
        background-color: #428bca;
        border-top-right-radius: 10px;
        border-bottom-right-radius: 10px;
        width: 1%;
        white-space: nowrap;
        vertical-align: middle;
        line-height: 1;
        /*border-radius: 3px;*/
    }

    .input-group-addons,
    .input-group .form-control {
        display: table-cell;
        height: 30px;
    }


    .input-group-sm > .form-control,
    .input-group-sm > .input-group-addons,
    .input-group-sm > .input-group-btn > .btn {
        height: 30px;
        /*padding: 5px 10px;*/
        font-size: 12px;
        line-height: 1.5;
        border-radius: 3px;
    }

    a img {
        border: none;
    }

    ol li {
        list-style: decimal outside;
    }

    div.container {
        width: 100%;
        margin: 0 auto;
        padding: 0 0;
    }

    div.side-by-side {
        width: 100%;
        /*margin-bottom: 1em;*/
    }

        div.side-by-side > div {
            float: left;
            width: 100%;
        }

            div.side-by-side > div > em {
                margin-bottom: 10px;
                display: block;
            }

    .clearfix:after {
        content: "\0020";
        display: block;
        height: 0;
        clear: both;
        overflow: hidden;
        visibility: hidden;
    }
</style>


<div class="panel panel-default ">
     <div class="panel-body">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Category:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <div class="input-group input-group-xs">
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Choose Category" />
                                        </asp:DropDownList>
                                        <span class="input-group-addons" id="spncategory" runat="server">
                                            <a href="javascript:AddSrcToIfram('c')">
                                                <asp:Label ID="Label12" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                        </span>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="prdvalidationgrp" InitialValue="0" Display="Dynamic" runat="server" ErrorMessage="Select Category" ControlToValidate="ddlCategory" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Unit:<asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <div class="input-group input-group-xs">
                                        <asp:DropDownList ID="ddlUnit" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Choose Unit" />
                                        </asp:DropDownList>
                                        <span class="input-group-addons" id="spnunit" runat="server">
                                            <a href="javascript:AddSrcToIfram('u')">
                                                <asp:Label ID="Label13" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                        </span>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="prdvalidationgrp" InitialValue="0" Display="Dynamic" ErrorMessage="Select Unit" ControlToValidate="ddlUnit" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="col-md-12">
                                <div class="col-md-5">
                                    <div class="form-group ">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label   ">
                                                Godown:<asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <div class="input-group input-group-xs">
                                                <asp:DropDownList ID="ddlGodown" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlGodown_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Text="Choose godown" Value="0" />
                                                </asp:DropDownList>
                                                <span class="input-group-addons" id="spngodown" runat="server">
                                                    <a href="javascript:AddSrcToIfram('g')">
                                                        <asp:Label ID="Label14" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                                </span>
                                            </div>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" InitialValue="0" ValidationGroup="prdvalidationgrp" runat="server" Display="Dynamic" ErrorMessage="Select Godown" ControlToValidate="ddlGodown" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-group">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label">
                                                Rack:<asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <div class="input-group input-group-xs">
                                                <asp:DropDownList ID="ddlRack" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="Choose Rack" Value="0" />
                                                </asp:DropDownList>
                                                <span class="input-group-addons" id="spnrack" runat="server">
                                                    <a href="javascript:AddSrcToIfram('r')">
                                                        <asp:Label ID="Label15" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                                </span>
                                            </div>
                                          <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="0" ValidationGroup="prdvalidationgrp" runat="server" Display="Dynamic" ErrorMessage="Select Rack" ControlToValidate="ddlRack" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                            <asp:Label ID="lblrackerror" runat="server" ForeColor="Red"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Tax:<asp:Label ID="Label5" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                  
                                    <asp:ListBox ID="ddlTaxgroup" runat="server" CssClass="form-control" style="width:100%" SelectionMode="Multiple">
                                        
                                    </asp:ListBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="prdvalidationgrp" InitialValue="0" ErrorMessage="Select Tax" ControlToValidate="ddlTaxgroup" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Product Name:<asp:Label ID="Label6" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtProductName" runat="server" onchange="CheckDoubleProductName()" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="prdvalidationgrp" ErrorMessage="Name is required" ControlToValidate="txtProductName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblmsgprodname" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hdprodname" runat="server" />
                                    <asp:HiddenField ID="hdproductid" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Product Code:<asp:Label ID="Label7" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtProductCode" runat="server" onchange="CheckDoubleProductCode()" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="prdvalidationgrp" ErrorMessage="Product code is required" ControlToValidate="txtProductName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hdprodcode" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        HSN Code:<asp:Label ID="Label8" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtHSNCode" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="prdvalidationgrp" ErrorMessage="HSN Code is required" ControlToValidate="txtHSNCode" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Re-Order Level:<asp:Label ID="Label9" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                    <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" title="Reorder level is the inventory level at which a company would place a new order."></i>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtReorderqty" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Display="Dynamic" ValidationGroup="prdvalidationgrp" ErrorMessage="Re-Order level is required" ControlToValidate="txtReorderqty" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationExpression="^[1-9][0-9]*$" runat="server" ValidationGroup="prdvalidationgrp" Display="Dynamic" ForeColor="Red" ControlToValidate="txtReorderqty" ErrorMessage="Re-Order Quantity should b greater then 0"></asp:RegularExpressionValidator>

                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Purchase Price:<asp:Label ID="Label10" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPurchasePrice" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ValidationGroup="prdvalidationgrp" ErrorMessage="Purchase price is required" ControlToValidate="txtPurchasePrice" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d{1,5})?\s*$" runat="server" ValidationGroup="prdvalidationgrp" Display="Dynamic" ForeColor="Red" ControlToValidate="txtPurchasePrice" ErrorMessage="Purchase Price should b greater then 0"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Sales Price:<asp:Label ID="Label11" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtSalesPrice" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox><%--^[1-9][0-9]*$--%>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ValidationGroup="prdvalidationgrp" ErrorMessage="Sale price is required" ControlToValidate="txtSalesPrice" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationExpression="^(0*[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*)$" runat="server" ValidationGroup="prdvalidationgrp" Display="Dynamic" ForeColor="Red" ControlToValidate="txtSalesPrice" ErrorMessage="Sales Price should b greater then 0"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer text-center">
                <asp:Button ID="btnprdSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnprdSave_Click"  ValidationGroup="prdvalidationgrp"  UseSubmitBehavior="false" />
                <asp:Button ID="btnprdUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnprdUpdate_Click" Visible="false" ValidationGroup="prdvalidationgrp" />
                <input class="btn btn-primary " type="button" value="Clear" onclick="javascript: window.location = 'Product.aspx'" />
                <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />  --%>
            </div>
</div>
 <div class="row">
            <div class="alert alert-success" id="divalert" runat="server" visible="false">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label ID="lblAlert" runat="server"></asp:Label>
            </div>
        </div>


 <%--<div class="modal fade" role="dialog" id="AddModal" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <center><h2><asp:Label ID="lblModalHeader" runat="server"></asp:Label></h2></center>
                </div>
                <div class="modal-body">
                    <iframe id="ModalIfram" runat="server" width="100%" height="350px" scrolling="yes" frameborder="0" allowfullscreen="true"></iframe>
                </div>
              <div class="modal-footer" >
                        <asp:Button ID="btnCloseMode" runat="server" Text="Close" CssClass="btn btn-primary"   />
                    </div>
            </div>
        </div>
    </div>--%>

  <%--start model popup code for display category usercontrol--%>
    <div class="modal fade" role="dialog" id="divcategorymodel" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="padding: 0px 10px 0px 10px;">
                    <button type="button" class="close" data-dismiss="modal" id="btncloseofmodelcategory" runat="server" onserverclick="btncloseofmodelcategory_ServerClick">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3>
                        <asp:Label ID="Label16" runat="server" Text="Add Category"></asp:Label></h3>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="upCIR" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <%--Call user control to show in popup body--%>
                            <twebcontrol:ctrlcategory  ID="ctrlcategory"  runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <%--end model popup --%>

     <%--start model popup code for display Unit usercontrol--%>
    <div class="modal fade" id="divunitmodel" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="padding: 0px 10px 0px 10px;">
                    <button type="button" class="close" data-dismiss="modal" id="btnunitmodelclose" runat="server" onserverclick="btnunitmodelclose_ServerClick">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3>
                        <asp:Label ID="Label17" runat="server" Text="Add Unit"></asp:Label></h3>
                </div>
                <div class="modal-body">
                   <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <%--Call user control to show in popup body--%>
                            <abc:ctrlunit  ID="ctrlunit"  runat="server" />
                            </ContentTemplate>
                       </asp:UpdatePanel>
                    
                       
                </div>
            </div>
        </div>
    </div>
    <%--end model popup --%>

<%--start model popup code for display Godown usercontrol--%>
    <div class="modal fade" id="divgodownmodel" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="padding: 0px 10px 0px 10px;">
                    <button type="button" class="close" data-dismiss="modal" id="btngwdnmodelclose" runat="server" onserverclick="btngwdnmodelclose_ServerClick" >
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3>
                        <asp:Label ID="Label18" runat="server" Text="Add Godown"></asp:Label></h3>
                </div>
                <div class="modal-body">
                   <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <%--Call user control to show in popup body--%>
                              <TWebControlGodwn:ctrlgodown ID="ctrlgodown" runat="server" />
                            </ContentTemplate>
                       </asp:UpdatePanel>
                    
                       
                </div>
            </div>
        </div>
    </div>
    <%--end model popup --%>
<%--start model popup code for display Rack usercontrol--%>
    <div class="modal fade" id="divrackmodel" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="padding: 0px 10px 0px 10px;">
                    <button type="button" class="close" data-dismiss="modal" id="btnrckmodelclose" runat="server"  onserverclick="btnrckmodelclose_ServerClick"  >
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3>
                        <asp:Label ID="Label19" runat="server" Text="Add Rack"></asp:Label></h3>
                </div>
                <div class="modal-body">
                  <%-- <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>--%>
                            <%--Call user control to show in popup body--%>
                              <TWebControlRack:ctrlrack ID="ctrlrack" runat="server" />
                           <%-- </ContentTemplate>
                       </asp:UpdatePanel>
                    --%>
                       
                </div>
            </div>
        </div>
    </div>
    <%--end model popup --%>
    <script>
       
        function Closepopup() {
            $('#AddModal').modal('close');

        }
        function CheckDoubleProductCode() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Product.aspx/CheckDoubleProductCode") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtProductCode.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessproductcode,
                failure: function (response) {
                    alert(response);
                }
            });
        }

        function OnSuccessproductcode(response) {
            var msgprodcode = $("#<%=lblcheckDoubleError.ClientID%>")[0];
            var hdprodcode = $("#<%=hdprodcode.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    msgprodcode.style.display = "block";
                    msgprodcode.style.color = "red";
                    msgprodcode.innerHTML = "This Product Code name already Exists";
                    hdprodcode.value = true;
                    break;
                case "false":
                    msgprodcode.style.display = "none";
                    hdprodcode.value = false;
                    break;
            }
        }

        function OnlyNumericEntry(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function CheckDoubleProductName() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Product.aspx/CheckDoubleProductName") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtProductName.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessproductname,
                failure: function (response) {
                    alert(response);
                }
            });
        }

        function OnSuccessproductname(response) {
            var msgprdname = $("#<%=lblmsgprodname.ClientID%>")[0];
            var hdprdname = $("#<%=hdprodname.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    msgprdname.style.display = "block";
                    msgprdname.style.color = "red";
                    msgprdname.innerHTML = "This Product name already Exists";
                    hdprdname.value = true;
                    break;
                case "false":
                    msgprdname.style.display = "none";
                    hdprdname.value = false;
                    break;
            }
        }


        function AddSrcToIfram(val) {
            if (val == 'c') {


                $('#<%= divcategorymodel.ClientID %>').modal('show');

               <%-- $('#<%=lblModalHeader.ClientID%>').text("Add Category");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/CategoryMasterModal.aspx")--%>
            }
            if (val == 'u') {

                $('#<%= divunitmodel.ClientID %>').modal('show');

            <%--    $('#<%=lblModalHeader.ClientID%>').text("Add Unit");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/UnitMasterModel.aspx");
                $('#<%= AddModal.ClientID %>').modal('show');--%>
            }
            if (val == 'g') {
                $('#<%= divgodownmodel.ClientID %>').modal('show');
            }
            if (val == 'r') {
                $('#<%= divrackmodel.ClientID %>').modal('show');
            }
           <%-- if (val == 't') {
                $('#<%=lblModalHeader.ClientID%>').text("Add Tax");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/TaxMasterModel.aspx")
                $('#<%= AddModal.ClientID %>').modal('show');
            }--%>

        }

        $('#<%= ddlCategory.ClientID %>').chosen();
        $("#<%= ddlCategory.ClientID %>-deselect").chosen(
            { allow_single_deselect: true });

        $('#<%= ddlUnit.ClientID %>').chosen();
        $("#<%= ddlUnit.ClientID %>-deselect").chosen(
            { allow_single_deselect: true });

        $('#<%= ddlGodown.ClientID %>').chosen();
        $("#<%= ddlGodown.ClientID %>-deselect").chosen(
            { allow_single_deselect: true });

        $('#<%= ddlRack.ClientID %>').chosen();
        $("#<%= ddlRack.ClientID %>-deselect").chosen(
        { allow_single_deselect: true });

        $(document).ready(function () {

            $('[id*=ddlTaxgroup]').multiselect({
                includeSelectAllOption: true
            });

        });

    </script>

