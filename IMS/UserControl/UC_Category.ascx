<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Category.ascx.cs" Inherits="IMS.UserControl.UC_Category" %>



<script type="text/javascript">
    function CheckDouble() {
        debugger;
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Masters/Category.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{categoryName: "' + $("#<%=txtCategoryName.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccess(response) {
            debugger;
            var msg = $("#<%=lblcheckDoubleError.ClientID%>")[0];
            var hd1 = $("#<%=hd.ClientID%>")[0];
            switch (response.d) {
                case true:

                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "This category name already Exists";
                    hd1.value = "true";
                    break;
                case false:
                    msg.style.display = "none";
                    hd1.value = "false";
                    break;
            }
        }
        function clearcategory() {
            cleartextboxes();
            $("#<%=txtCategoryName.ClientID%>").focus();
        }
</script>

<div class="panel panel-default text-center">
    
    <div class="panel-body">
        <div class="form-horizontal">
            <div class="col-md-12">
                <div class="col-md-5">
                    <div class="form-group ">
                        <div class="col-sm-5 leftpadd0">
                            <label class="control-label   ">
                                Category Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                            </label>
                        </div>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtCategoryName" onchange="CheckDouble()" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rvaldt1" runat="server" Display="Dynamic" ErrorMessage="Category name is required" ValidationGroup="categoryvalidationgroup" ControlToValidate="txtCategoryName" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                    <asp:HiddenField ID="hd" runat="server" />
                    <asp:HiddenField ID="hdcategoryid" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel-footer">

        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " ValidationGroup="categoryvalidationgroup" Text="Save" OnClick="btnSave_Click" />
        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" ValidationGroup="categoryvalidationgroup" Text="Update" Visible="false" OnClick="btnUpdate_Click" />
        <input class="btn btn-primary " type="button" value="Clear" onclick="javascript: window.location = 'Category.aspx'" />
    </div>
</div>
<div class="row">
    <div class="alert alert-success" id="divalert" runat="server" visible="false">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label ID="lblAlert" runat="server"></asp:Label>
    </div>
</div>
