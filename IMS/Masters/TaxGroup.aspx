<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="TaxGroup.aspx.cs" Inherits="IMS.Masters.TaxGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            $('#<%= GridView1.ClientID %>').DataTable();
        });

        function openalert(msg) {
            debugger;
            alertify.alert('Success', msg).setting({
                'onok': function () { window.location.href = "~/Masters/TaxGroup.aspx"; }
            });

        }
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }

        function OnlyNumericEntry(evt) {



            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;

            return true;

        }


        function CheckDouble() {
            try {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveUrl("~/Masters/TaxGroup.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                    data: '{useroremail: "' + $("#<%=txtGrouphName.ClientID%>")[0].value + '" }',// user name or email value  
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
                       msg.innerHTML = "This Group name already Exists";
                       hd1.value = "true";
                       break;
                   case "false":
                       msg.style.display = "none";
                       hd1.value = "false";
                       break;
               }
           }

           var txt = $("<%=txtGrouphName.ClientID%>");

        txt.focus();

        function openalert(msg) {

            alertify.alert('Success', msg).setting({
                'onok': function () { window.location.href = "TaxGroup.aspx"; }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid">

        <div>
            <a href="../Master.aspx" id="bMaster" runat="server">
                <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
        </div>
        <div class="panel panel-default text-center">
            <div class="panel-heading">
                <h1>Batch Master</h1>
            </div>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="row">
                                    <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">
                                        <div class="col-sm-10 leftpadd0">
                                            <label class="control-label">
                                                Group Name:
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtGrouphName" ErrorMessage="*" ForeColor="Red" ValidationGroup="addvalidation"></asp:RequiredFieldValidator>
                                            </label>
                                            <asp:TextBox ID="txtGrouphName" runat="server" onchange="CheckDouble()" CssClass="form-control" ValidationGroup="addvalidation"></asp:TextBox>
                                            <asp:Label ID="lblcheckDoubleError" runat="server" ForeColor="Red"></asp:Label>
                                            <asp:HiddenField ID="hd" runat="server" />
                                        </div>

                                    </div>
                                    <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">

                                        <div class="col-sm-10 leftpadd0">
                                            <label class="control-label">
                                                Select Tax Type:
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlTaxType" ErrorMessage="*" ForeColor="Red" ValidationGroup="addvalidation"></asp:RequiredFieldValidator>
                                            </label>
                                            <asp:HiddenField ID="hdntypeId" runat="server" />
                                            <asp:DropDownList ID="ddlTaxType" runat="server" OnSelectedIndexChanged="ddlTaxType_SelectedIndexChanged" CssClass="form-control" AppendDataBoundItems="true" AutoPostBack="true"></asp:DropDownList>

                                        </div>
                                    </div>
                                    <div class="col-md-3 col-lg-3 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px;">

                                        <div class="col-sm-10 leftpadd0">
                                            <label class="control-label">
                                                Percentage:
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlTaxType" ErrorMessage="*" ForeColor="Red" ValidationGroup="addvalidation"></asp:RequiredFieldValidator>
                                            </label>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                            <asp:TextBox ID="txtPercent" onkeypress="return OnlyNumericEntry(event);" runat="server" CssClass="form-control" />

                                        </div>
                                    </div>
                                    <div class="col-md-4 col-lg-2 col-sm-12 col-xs-12 leftpadd0" style="padding: 0px; margin-top: 20px">
                                        <div class="col-sm-10 leftpadd0">

                                            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" Width="100px" OnClick="btnAdd_Click" ValidationGroup="addvalidation" />
                                            <asp:Button ID="btnUpdateDetailes" runat="server" Text="Update Type" CssClass="btn btn-primary" Width="100px" Visible="false" OnClick="btnUpdateDetailes_Click" ValidationGroup="addvalidation" />

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px; margin-top: 10px">
                                        <asp:GridView ID="gvtaxdetails" runat="server" OnSelectedIndexChanged="gvtaxdetails_SelectedIndexChanged" DataKeyNames="type_id" OnRowCommand="gvtaxdetails_RowCommand" CssClass="table" AutoGenerateColumns="false" BorderStyle="None" GridLines="Horizontal">
                                            <Columns>
                                                
                                                <asp:BoundField DataField="type_name" HeaderText="Type Name" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>

                                                <asp:BoundField DataField="tax_percentage" HeaderText="Tax Percentage" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                                <asp:BoundField DataField="type_id" HeaderText="Type Id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                                <asp:BoundField DataField="taxdetails_id" HeaderText="taxdetails_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>

                                                <asp:TemplateField HeaderText="Update">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Update Row" ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                                    <ItemTemplate>
                                                        <asp:ImageButton CommandName="Delete row" ID="btnimg_Remove" runat="server" ImageUrl="~/assets/img/remove.png" href="#myModal" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                                        </asp:GridView>
                                    </div>
                                </div>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <%--<asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" ValidationGroup="v1" OnClick="btnSave_Click" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />--%>
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" ValidationGroup="v1" OnClick="btnSave_Click" />
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" ValidationGroup="v1" Visible="false" OnClick="btnUpdate_Click" />
                <input class="btn btn-primary " type="button" value="Clear" onclick="cleartextboxes();" />

               
                <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />   
                  
                --%>
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
                    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" DataKeyNames="group_id" SelectedIndex="0" AutoGenerateColumns="False" CssClass="table table-bordered ">
                        <Columns>
                            <asp:BoundField DataField="group_id" HeaderText="Group Id " ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>

                            <asp:BoundField DataField="group_name" HeaderText="Group Name" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>

                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="UpdateRow" CommandArgument='<%# Eval("group_id") %>' ID="btnimg_update2" runat="server" ImageUrl="~/assets/img/edit.png" />
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("group_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" data-toggle="modal" href="#myModal" />
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <HeaderStyle ForeColor="White" BackColor="#428BCA" />
                    </asp:GridView>
                </div>
            </div>
        </div>

    </div>

    <div class="modal fade" id="myModal" role="dialog" runat="server">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Alert</h4>
                </div>
                <div class="modal-body">

                  
                <p>Do You want to delete This Tax Group? </p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
