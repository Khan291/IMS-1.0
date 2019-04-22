<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SalesReturn.aspx.cs" Inherits="IMS.Sales.SalesReturn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .scrollClass {
            height: 100px;
            overflow-y: scroll;
        }
    </style>
    <script>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }
    </script>
    <script type='text/javascript'>
        $(function () {
            $("#<%=txtquantity.ClientID %>").keypress(function () {
                $("#<%=lblcheckDoubleError.ClientID%>").text('');
            });
        });
        function openalert(msg, val) {
            alertify.alert('Success', msg).setting({
                'onok': function () {
                    if (val == 'True') {
                        window.location.href = "SalesReturn.aspx";
                    }
                }
            });

        }

        function OnlyNumericEntry(evt) {
              <%--$("#<%=lblcheckDoubleError.ClientID%>").text('');--%>
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode > 31
                && (charCode < 48 || charCode > 57))
                return false;

            ValidateQuantity();
            return true;
        }
        function ValidateQuantity() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Sales/SalesReturn.aspx/ValidateQuantity") %>', // this for calling the web method function in cs code.  
                 data: '{enterdQuantity: "' + $("#<%=txtquantity.ClientID%>")[0].value + '",productid: "' + $("#<%=ddlproduct.ClientID%>")[0].value + '",saleId:"' + $("#<%=hdnSaleId.ClientID%>")[0].value + '" }',// user name or email value  
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
            switch (response.d[0]) {
                case "true":
                    msg.style.display = "block";
                    msg.innerHTML = response.d[1];
                    $("#<%=btnAdd.ClientID%>").prop('disabled', true);
                    break;

                case "false":
                    msg.style.display = "none";
                    $("#<%=btnAdd.ClientID%>").prop('disabled', false);
                    break;
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>Sales Return</h1>
        </div>
        <div class="panel-body">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <div class="row">
                    <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                        <div class="form-horizontal Fhorizontal">
                            <asp:HiddenField ID="hdnSaleId" runat="server" />
                            <div class="col-sm-10 leftpadd0">
                                <label class="control-label">
                                    Enter Invoice No.
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSoNo" ErrorMessage="*" ForeColor="Red" ValidationGroup="searchvalidation"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="txtSoNo" runat="server" CssClass="form-control"></asp:TextBox>
                                <div id="listPlacement" style="height:100px; overflow-y:scroll;" ></div>
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                                    ServiceMethod="GetPoNumbers"
                                    MinimumPrefixLength="1"
                                    CompletionInterval="100"
                                    EnableCaching="false"
                                    CompletionSetCount="10"
                                    TargetControlID="txtSoNo"
                                    FirstRowSelected="false"
                                    CompletionListElementID="listPlacement">
                                </ajaxToolkit:AutoCompleteExtender>
                            </div>

                        </div>

                    </div>
                    <div class="col-md-2 col-lg-2 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-top: 20px">
                        <div class="col-sm-10 leftpadd0">
                            <%--<asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" Text="Add" Width="100px" />--%>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" Width="100px" OnClick="btnSearch_Click" ValidationGroup="searchvalidation" />
                        </div>
                    </div>
                </div>
                <div id="OriginalSaleDetails" runat="server" visible="false">
                    <div class="row">
                        <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                            <div class="form-horizontal Fhorizontal">
                                <div class="col-sm-10 leftpadd0">
                                    <label class="control-label">
                                        Original Sale Details
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">


                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px; margin-top: 10px">
                            <asp:GridView ID="GrdOriginalSale" runat="server" CssClass="table table-bordered " Font-Size="Small" AutoGenerateColumns="false" OnDataBound="GrdOriginalSale_DataBound" BorderStyle="None" GridLines="Horizontal" OnRowDataBound="GrdOriginalSale_RowDataBound">
                                <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Image ID="image" Visible="false" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Type" HeaderText="Type"></asp:BoundField>
                                  <%--  <asp:BoundField DataField="Product" HeaderText="Product"></asp:BoundField>
                                    <asp:BoundField DataField="Batch" HeaderText="Batch" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>--%>
                                    <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                   <%-- <asp:BoundField DataField="Quantity" HeaderText="Quantity"></asp:BoundField>--%>
                                  <%--  <asp:BoundField DataField="SaleRate" HeaderText="Sale Price" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>--%>
                                    <asp:BoundField DataField="TotalDiscount" HeaderText="Discount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                    <asp:BoundField DataField="TotalTax" HeaderText="Tax" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                     <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                     <asp:BoundField DataField="GivenAmnt" HeaderText="Given Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                     <asp:BoundField DataField="BalanceAmnt" HeaderText="Balance Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                    <asp:BoundField DataField="GrandTotal" HeaderText="Grand Total" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                </Columns>

                                <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                            </asp:GridView>
                        </div>
                    </div>

                    <div style="border: 1px solid black; margin-top: 10px; margin-bottom: 10px;"></div>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                                <%--<div class="form-horizontal Fhorizontal">--%>
                                <div class="col-sm-10 leftpadd0">
                                    <label class="control-label">
                                        Select Product
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlproduct" ErrorMessage="*" ForeColor="Red" ValidationGroup="addvalidation"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:DropDownList ID="ddlproduct" runat="server" CssClass="form-control" AppendDataBoundItems="true" AutoPostBack="true"></asp:DropDownList>
                                    <%--</div>--%>
                                </div>
                            </div>
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                                <div class="col-sm-10 leftpadd0">
                                    <label class="control-label">
                                        Return Quantity
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtquantity" ErrorMessage="*" ForeColor="Red" ValidationGroup="addvalidation"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox ID="txtquantity" onkeypress="return OnlyNumericEntry(event);" runat="server" onchange="ValidateQuantity()" CssClass="form-control" ValidationGroup="addvalidation"></asp:TextBox>
                                    <asp:Label ID="lblcheckDoubleError" runat="server" ForeColor="Red"></asp:Label>
                                </div>

                            </div>
                            <div class="col-md-4 col-lg-2 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-top: 20px">
                                <div class="col-sm-10 leftpadd0">
                                    <%--<asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" Text="Add" Width="100px" />--%>
                                    <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" Width="100px" OnClick="btnAdd_Click" ValidationGroup="addvalidation" />
                                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" Width="100px" Visible="false" ValidationGroup="addvalidation" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 " style="padding-left: 0px; margin-top: 10px">
                                <asp:GridView ID="gvsalesdetails" runat="server" CssClass="table table-bordered scrollClass " AutoGenerateColumns="false" OnRowCommand="gvsalesdetails_RowCommand" BorderStyle="None" GridLines="Horizontal">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.No" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="product_name" HeaderText="Product" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="Product_id" HeaderText="Product id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                        <asp:BoundField DataField="batch_name" HeaderText="Batch" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="batch_id" HeaderText="batch_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                        <asp:BoundField DataField="quantity" HeaderText="Quantity" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="sale_rate" HeaderText="Price" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="dicount_amt" HeaderText="Discount Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="tax_percentage" HeaderText="Tax" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="tax_amt" HeaderText="Tax Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="amount" HeaderText="Total" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="saledetails_id" HeaderText="Sale Detail Id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                        <asp:BoundField DataField="group_id" HeaderText="Group Id"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Update">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Update Row" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                            <ItemTemplate>
                                                <asp:ImageButton CommandName="Delete row" CommandArgument='<%#Eval("saledetails_id")%>' ID="btnimg_Remove" runat="server" ImageUrl="~/assets/img/remove.png" data-toggle="modal" href="#myModal" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="row  ">
                            <div class=" col-md-6 pull-left ">
                                <asp:GridView ID="gvTaxDetailsNew" runat="server" CssClass="table table-bordered scrollClass" AutoGenerateColumns="false" BorderStyle="None" GridLines="Horizontal">
                                    <Columns>
                                        <asp:BoundField DataField="product_id" HeaderText="Product id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                        <asp:BoundField DataField="group_id" HeaderText="Product id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                        <asp:BoundField DataField="group_name" HeaderText="Tax Group" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="type_name" HeaderText="Tax Type" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="tax_percentage" HeaderText="Tax Type Percent" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="totaltaxPercentage" HeaderText="Total Tax Percent" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                        <asp:BoundField DataField="type_id" HeaderText="Product id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                    </Columns>
                                    <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                                </asp:GridView>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6 pull-right">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label class="control-label col-sm-3 text-center"></label>
                                        <label class="control-label col-sm-3 text-center">Orig. Purchase</label>
                                        <label class="control-label col-sm-3 text-center">Return</label>
                                        <label class="control-label col-sm-3 text-center">Result</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6 pull-right">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label class="control-label col-sm-3">Sub Total</label>

                                        <asp:Label ID="lblTotalAmnt" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblsubtotal" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblResultSubTotal" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6 pull-right">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label class="control-label col-sm-3">Tax Amount</label>

                                        <asp:Label ID="lblTotalTax" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblTaxAmount" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblResultTotalTaxAmnt" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6 pull-right">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label class="control-label col-sm-3 left">Disc. Amount</label>

                                        <asp:Label ID="lblTotalDiscount" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblDiscountAmt" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblResultTotalDiscount" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div style="border: 1px solid black; margin-top: 10px; margin-bottom: 10px;"></div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-6 pull-right">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <label class="control-label col-sm-3">Grand Total</label>

                                        <asp:Label ID="lblOriginalGrndTotal" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblGrandTotal" Font-Bold="true" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                        <asp:Label ID="lblResultGrndTotal" runat="server" CssClass="control-label col-sm-3 text-center" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-4  col-xs-4  pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <asp:Label class="control-label col-sm-9" runat="server" Font-Bold="true" Font-Size="Large">Given Amnt till Date:</asp:Label>
                                            <asp:Label class="control-label col-sm-3 text-center" ID="lblGivenAmnt" Font-Bold="true" runat="server" Text="" Font-Size="Large"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">Payment Mode</label>
                                            <asp:DropDownList ID="ddlPaymentMode" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 ">
                            </div>
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group pull-right">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9"></label>
                                            <asp:Button ID="btnPayBack" Text="Pay Back" runat="server" CssClass="btn btn-primary" Visible="false" OnClick="btnPayBack_Click"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">
                                                Paid Amount
                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtBalanceAmt" ErrorMessage="*" ValidationGroup="savesale" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </label>
                                            <asp:TextBox ID="txtPaidAmt" runat="server" CssClass="form-control" AutoPostBack="true" Enabled="false" OnTextChanged="txtPaidAmt_TextChanged" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ForeColor="Red" ControlToValidate="txtPaidAmt" ErrorMessage="Paid Amount Should be digits only" ValidationGroup="savesale" ValidationExpression="^\s*(?=.*[0-9])\d*(?:\.\d{1,5})?\s*$" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 pull-right">
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 leftpadd0 pull-right" style="padding: 0px;">
                                    <div class="form-group">
                                        <div class="col-sm-12 leftpadd0">
                                            <label class="control-label col-sm-9">
                                                Balance Amount
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtBalanceAmt" ErrorMessage="*" ValidationGroup="savesale" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </label>
                                            <asp:TextBox ID="txtBalanceAmt" runat="server" CssClass="form-control" Enabled="false" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ForeColor="Red" ControlToValidate="txtBalanceAmt" ErrorMessage="Balance Amount Should be digits only" ValidationGroup="savesale" ValidationExpression="^\s*(?=.*[0-9])\d*(?:\.\d{1,5})?\s*$" Display="Dynamic">
                                            </asp:RegularExpressionValidator>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <!--=====================================================Attachment field ====================================================================-->
        <div class="row">
            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-left: 30px;">
                <div class="col-sm-10 leftpadd0">
                    <label class="control-label">Attach File</label>
                       <asp:FileUpload ID="fuAttacheFile"  runat="server" />
               </div>
           </div>
            <div class="col-md-2 col-lg-4 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-left: 25px;">
                <div class="col-sm-10 leftpadd0">
                    <label class="control-label">Note</label>
                    <asp:TextBox ID="txtSaleNote" runat="server" TextMode="MultiLine" CssClass="form-control" Style="display: block; resize: none"></asp:TextBox>
                </div>
            </div>
        </div><br />

        <div class="panel-footer leftpadd0">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " OnClick="btnSave_Click" Text="Save" ValidationGroup="savesale" OnClientClick="DisableOnSave(this,'savesale');" UseSubmitBehavior="false" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary" OnClick="btnCancel_Click" Text="Cancel" />

            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
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
                        <p>Are You Sure You want to delete it? </p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnOk" runat="server" Text="Ok" OnClick="btnOk_Click" CssClass="btn btn-primary" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
