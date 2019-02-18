<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="ProductMasterModel.aspx.cs" Inherits="IMS.ProductMasterModel" %>


<html>
<head>
    <title>IMS</title>
    
    <link href="../assets/plugins/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../assets/css/chosen.css" rel="stylesheet" />
        
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="../assets/plugins/bootstrap/bootstrap.js"></script>
    <script src="../assets/scripts/chosen.jquery.js"></script>

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

</head>

<body>
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container-fluid">
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
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" style="width:100%">
                                            <asp:ListItem Text="Choose Category" />
                                        </asp:DropDownList>
                                        <span class="input-group-addons">
                                            <a href="javascript:AddSrcToIfram('c')">
                                                <asp:Label ID="Label12" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                        </span>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="adf" InitialValue="0" Display="Dynamic" runat="server" ErrorMessage="Select Category" ControlToValidate="ddlCategory" ForeColor="Red"></asp:RequiredFieldValidator>
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
                                        <span class="input-group-addons">
                                            <a href="javascript:AddSrcToIfram('u')">
                                                <asp:Label ID="Label13" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                        </span>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="adf" InitialValue="0" Display="Dynamic" ErrorMessage="Select Unit" ControlToValidate="ddlUnit" ForeColor="Red"></asp:RequiredFieldValidator>
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
                                                <span class="input-group-addons">
                                                    <a href="javascript:AddSrcToIfram('g')">
                                                        <asp:Label ID="Label14" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                                </span>
                                            </div>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" InitialValue="0" ValidationGroup="adf" runat="server" Display="Dynamic" ErrorMessage="Select Godown" ControlToValidate="ddlGodown" ForeColor="Red"></asp:RequiredFieldValidator>
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
                                                <span class="input-group-addons">
                                                    <a href="javascript:AddSrcToIfram('r')">
                                                        <asp:Label ID="Label15" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                                </span>
                                            </div>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="0" ValidationGroup="adf" runat="server" Display="Dynamic" ErrorMessage="Select Rack" ControlToValidate="ddlRack" ForeColor="Red"></asp:RequiredFieldValidator>
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
                                    <%--<div class="input-group input-group-xs">
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Choose Rack" Value="0" />
                                        </asp:DropDownList>
                                        <span class="input-group-addons">
                                            <a href="javascript:AddSrcToIfram('t')">
                                                <asp:Label ID="Label16" runat="server" Text="+" Font-Bold="true" Font-Size="20px" ForeColor="White"></asp:Label></a>
                                        </span>
                                    </div>--%>
                                    <asp:DropDownList ID="ddlTax" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Choose Tax" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="adf" InitialValue="0" ErrorMessage="Select Tax" ControlToValidate="ddlTax" ForeColor="Red"></asp:RequiredFieldValidator>
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
                                    <asp:TextBox ID="txtProductName" runat="server" onchange="CheckDouble1()" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="adf" ErrorMessage="Name is required" ControlToValidate="txtProductName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hd" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Product Code:
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtProductCode" runat="server" onchange="CheckDouble()" CssClass="form-control"></asp:TextBox>
                                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="adf" ErrorMessage="Product code is required" ControlToValidate="txtProductName" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <asp:HiddenField ID="hde" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        HSN Code:
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtHSNCode" runat="server" CssClass="form-control"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="adf" ErrorMessage="HSN Code is required" ControlToValidate="txtHSNCode" ForeColor="Red"></asp:RequiredFieldValidator>--%>
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
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Display="Dynamic" ValidationGroup="adf" ErrorMessage="Re-Order level is required" ControlToValidate="txtReorderqty" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationExpression="^[1-9][0-9]*$" runat="server" ValidationGroup="adf" Display="Dynamic" ForeColor="Red" ControlToValidate="txtReorderqty" ErrorMessage="Re-Order Quantity should b greater then 0"></asp:RegularExpressionValidator>

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
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ValidationGroup="adf" ErrorMessage="Purchase price is required" ControlToValidate="txtPurchasePrice" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d{1,5})?\s*$" runat="server" ValidationGroup="adf" Display="Dynamic" ForeColor="Red" ControlToValidate="txtPurchasePrice" ErrorMessage="Purchase Price should b greater then 0"></asp:RegularExpressionValidator>
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
                                    <asp:TextBox ID="txtSalesPrice" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ValidationGroup="adf" ErrorMessage="Sale price is required" ControlToValidate="txtSalesPrice" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationExpression="^(0*[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*)$" runat="server" ValidationGroup="adf" Display="Dynamic" ForeColor="Red" ControlToValidate="txtSalesPrice" ErrorMessage="Sales Price should b greater then 0"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer text-center">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="adf" />
                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="Button1_Click" />
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
                        <h4 class="modal-title">Alert</h4>
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

        <div class="modal fade" role="dialog" id="AddModal" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                   <%-- <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>--%>
                    <center><h2><asp:Label ID="lblModalHeader" runat="server"></asp:Label></h2></center>
                </div>
                <div class="modal-body">
                    <iframe id="ModalIfram" runat="server" width="100%" height="350px" scrolling="yes" frameborder="0" allowfullscreen="true"></iframe>
                </div>
                <div class="modal-footer">
                      <asp:Button ID="btnCloseMode" runat="server" Text="Close" CssClass="btn btn-primary" OnClick="btnCloseMode_Click" />
                    </div>
            </div>
        </div>
    </div>

        <script>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }

        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Product.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtProductCode.ClientID%>")[0].value + '" }',// user name or email value  
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
            var hd3 = $("#<%=hde.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This Product Code name already Exists";
                    hd3.value = true;
                    break;
                case "false":
                    msg.style.display = "none";
                    hd3.value = false;
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

        function CheckDouble1() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/Product.aspx/CheckDouble1") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtProductName.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess1,
                failure: function (response) {
                    alert(response);
                }
            });
        }

        function OnSuccess1(response) {
            var msg = $("#<%=Label1.ClientID%>")[0];
            var hd1 = $("#<%=hd.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This Product name already Exists";
                    hd1.value = true;
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = false;
                    break;
            }
        }

        function AddSrcToIfram(val) {
            debugger;
            if (val == 'c') {
                $('#<%=lblModalHeader.ClientID%>').text("Add Category");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/CategoryMasterModal.aspx")
            }
            if (val == 'u') {
                $('#<%=lblModalHeader.ClientID%>').text("Add Unit");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/UnitMasterModel.aspx")
            }
            if (val == 'g') {
                $('#<%=lblModalHeader.ClientID%>').text("Add Godown");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/GodownMasterModel.aspx")
            }
            if (val == 'r') {
                $('#<%=lblModalHeader.ClientID%>').text("Add Rack");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/RackMasterModel.aspx")
            }
            if (val == 't') {
                $('#<%=lblModalHeader.ClientID%>').text("Add Tax");
                $('#<%=ModalIfram.ClientID%>').attr("src", "../MasterModals/TaxMasterModel.aspx")
            }
            $('#<%= AddModal.ClientID %>').modal('show');
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

            $('#<%= ddlTax.ClientID %>').chosen();
            $("#<%= ddlTax.ClientID %>-deselect").chosen(
                { allow_single_deselect: true });

    </script>

    </form>
</body>
</html>
