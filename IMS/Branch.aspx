<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Branch.aspx.cs" Inherits="IMS.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= GridView1.ClientID %>').DataTable();
        });
    </script>
    <script type='text/javascript'>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }
    </script>
    <script type="text/javascript">

        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Branch.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtBranchName.ClientID%>")[0].value + '" }',// user name or email value  
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
                    msg.innerHTML = "This Branch name already Exists";
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


    <!-- Page-Level CSS -->
    <link href="assets/plugins/morris/morris-0.4.3.min.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
        <div class="col-lg-12">
            <div class="row">
                <div class="panel panel-default ">
                    <div>
                        <a href="../Master.aspx" id="bMaster" runat="server">
                            <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
                    </div>
                    <div class="panel-heading text-center">
                        <h1>Company Master</h1>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                <div class="form-horizontal Fhorizontal">
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">
                                                Branch Name<span style="color:red"> *</span>
                                            </label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:TextBox ID="txtBranchName" runat="server" onchange="CheckDouble()" ValidationGroup="abc" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="abc" ErrorMessage="Branch Name is required" ControlToValidate="txtBranchName" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hd" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">Country</label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:DropDownList ID="ddlcountry" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="abc" ErrorMessage="Country  is required" ControlToValidate="ddlcountry" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">
                                                Pin Code<span style="color:red"> *</span>
                                            </label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:TextBox ID="txtpincode" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="abc" ErrorMessage="Pin Code is required" ControlToValidate="txtpincode" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="abc" ForeColor="Red" ControlToValidate="txtpincode" ErrorMessage="Zip Code Should be 6 digits only" ValidationExpression="^[0-9]{6,}$" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">Fax No</label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:TextBox ID="txtFaxno" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ForeColor="Red" ControlToValidate="txtFaxno" ValidationGroup="abc" ErrorMessage="Fax No Should be 10 digits only" ValidationExpression="^[0-9]{10,10}$" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                <div class="form-horizontal Fhorizontal">
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">
                                                Address<span style="color:red"> *</span>
                                            </label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="abc" ErrorMessage="Address is required" ControlToValidate="txtAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">
                                                State<span style="color:red"> *</span>
                                            </label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="abc" ErrorMessage="State is required" InitialValue="0" ControlToValidate="ddlState" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">
                                                City<span style="color:red"> *</span>
                                            </label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="abc" ErrorMessage="City is required" ControlToValidate="txtCity" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4 leftpadd0">
                                            <label class="control-label">
                                                Mobile No.<span style="color:red"> *</span>
                                            </label>
                                        </div>
                                        <div class="col-sm-7 leftpadd0">
                                            <asp:TextBox ID="txttelephoneno" runat="server" CssClass="form-control" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ValidationGroup="abc" ErrorMessage="Mobile No. is required" ControlToValidate="txttelephoneno" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ForeColor="Red" ControlToValidate="txttelephoneno" ValidationGroup="abc" ErrorMessage="Mobile No Should be 10 digits only" ValidationExpression="^[0-9]{10,10}$" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer  text-center">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " ValidationGroup="abc" OnClick="btnSave_Click" Text="Save" OnClientClick="DisableOnSave(this,'abc');" UseSubmitBehavior="false" />
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary " ValidationGroup="abc" OnClick="btnUpdate_Click" Text="Update" Visible="false" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary " Text="Cancel" OnClick="btnCancel_Click" />

                    </div>
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
                        <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="branch_id" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AutoGenerateColumns="false" CssClass="table table-responsive table-striped table-bordered table-hover" SelectedIndex="0">
                            <Columns>

                                <asp:BoundField DataField="branch_name" HeaderText="Branch Name"></asp:BoundField>
                                <asp:BoundField DataField="branch_address" HeaderText="Address" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                <asp:BoundField DataField="pincode" HeaderText="pincode" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="city" HeaderText="city" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="fax_no" HeaderText="fax_no" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="telephone_no" HeaderText="telephone_no" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="country_name" HeaderText="country_name" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="state_name" HeaderText="state_name" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="branch_id" HeaderText="branch_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:BoundField DataField="state_id" HeaderText="state_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="UpdateRow" />

                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("branch_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                        </asp:GridView>
                    </div>
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
                    <h4 class="modal-title">Alert</h4>
                </div>
                <div class="modal-body">
                    <p>Do you want to delete this Branch? </p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
