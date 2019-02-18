<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="TaxType.aspx.cs" Inherits="IMS.Masters.TaxType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">

         $(document).ready(function () {
             $('#<%= GridView1.ClientID %>').DataTable();
         });
         function openModal() {
             $('#<%=myModal.ClientID%>').modal('show');
         }


         function CheckDouble() {
             try {
                 $.ajax({
                     type: "POST",
                     url: '<%= ResolveUrl("~/Masters/TaxType.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                     data: '{useroremail: "' + $("#<%=txtTaxtype.ClientID%>")[0].value + '" }',// user name or email value  
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
                    msg.innerHTML = "This Type name already Exists";
                    hd1.value = "true";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = "false";
                    break;
            }
        }

        var txt = $("<%=txtTaxtype.ClientID%>");

         txt.focus();
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
                <h1>Tax Type Master</h1>
            </div>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-group ">
                                <div class="col-sm-5 leftpadd0">
                                    <label class="control-label   ">
                                        Type Name:<%--<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                                    </label>
                                </div>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtTaxtype" runat="server" onchange="CheckDouble()" CssClass="form-control"></asp:TextBox>  
                                    <asp:Label ID="lblcheckDoubleError" runat="server" ForeColor="Red"></asp:Label>
                                    <asp:RequiredFieldValidator ID="rvaldt1" runat="server" ErrorMessage="Group name is required" ValidationGroup="v1" ControlToValidate="txtTaxtype" ForeColor="Red"></asp:RequiredFieldValidator>
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
                <%--<asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" ValidationGroup="v1" OnClick="btnSave_Click" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false" />--%>
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" ValidationGroup="v1" OnClick="btnSave_Click"  />
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" ValidationGroup="v1"  Visible="false" OnClick="btnUpdate_Click" />
                <input class="btn btn-primary " type="button" value="Clear" onclick="cleartextboxes();" />
                <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />   
                    OnClick="btnUpdate_Click"
                    OnClick="btnSave_Click"
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
                    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" DataKeyNames="type_id"  SelectedIndex="0" AutoGenerateColumns="False" CssClass="table table-bordered ">
                        <Columns>
                            <asp:BoundField DataField="type_name" HeaderText="Batch Name"></asp:BoundField>

                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="UpdateRow" CommandArgument='<%# Eval("type_id") %>' ID="btnimg_update2" runat="server" ImageUrl="~/assets/img/edit.png" />
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                                <ItemTemplate>
                                    <asp:ImageButton CommandName="DeleteRow" CommandArgument='<%# Eval("type_id") %>' ID="btnimg_delete" runat="server" ImageUrl="~/assets/img/remove.png" data-toggle="modal" href="#myModal" />
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
                    <p>Do You want to delete This Unit? </p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary"  />
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
