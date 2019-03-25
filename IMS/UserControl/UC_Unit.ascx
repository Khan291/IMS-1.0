<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Unit.ascx.cs" Inherits="IMS.UserControl.UC_Unit" %>
<%--<script type="text/javascript">
    function openModal() {
        $('#<%=myModal.ClientID%>').modal('show');
        }
</script>
<script type='text/javascript'>
    $(document).ready(function () {
        $('#<%= GridView1.ClientID %>').DataTable();
        });
</script>--%>
<script type="text/javascript">

    function CheckDouble() {
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Masters/Unit.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtUnitName.ClientID%>")[0].value + '" }',// user name or email value  
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
                    msg.innerHTML = "This unit name already Exists";
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = false;
                    break;
            }
        }

        var txt = $("<%=txtUnitName.ClientID%>");

    txt.focus();
</script>


<div class="panel panel-default text-center">
    <div class="panel-body">
        <div class="form-horizontal">
            <div class="col-md-12">
                <div class="col-md-5">
                    <div class="form-group">
                        <div class="col-sm-5 leftpadd0">
                            <label class="control-label">
                                Unit Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </label>
                        </div>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtUnitName" onchange="CheckDouble()" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" runat="server" ValidationGroup="v" ErrorMessage="Name is required" ControlToValidate="txtUnitName" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                    <asp:HiddenField ID="hd" runat="server" />
                    <asp:HiddenField ID="hdunitid" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel-footer">
        <asp:Button ID="btnunitsave" runat="server" UseSubmitBehavior="false" ValidationGroup="v" CssClass="btn btn-primary " Text="Save" OnClick="btnunitsave_Click"  />
        <asp:Button ID="btnunitUpdate" runat="server" ValidationGroup="abc" CssClass="btn btn-primary" Text="Update" Visible="false" OnClick="btnunitUpdate_Click" />
        <input class="btn btn-primary " type="button" value="Clear" />
    </div>
</div>
<div class="row">
    <div class="alert alert-success" id="divalert" runat="server" visible="false">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label ID="lblAlert" runat="server"></asp:Label>
    </div>
</div>
