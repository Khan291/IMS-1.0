<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Category.ascx.cs" Inherits="IMS.UserControl.UC_Category" %>



<script type="text/javascript">
    function CheckDouble_category() {
        debugger;
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/Masters/Category.aspx/CheckDouble_category") %>', // this for calling the web method function in cs code.  
                data: '{categoryName: "' + $("#<%=txtCategoryName.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess_category,
                failure: function (response) {
                    alert(response);
                }
            });
        }
    function OnSuccess_category(response) {
            debugger;
            var msg_category = $("#<%=lblcheckDoubleError.ClientID%>")[0];
            var hdcategory = $("#<%=hd.ClientID%>")[0];
            switch (response.d) {
                case true:

                    msg_category.style.display = "block";
                    msg_category.style.color = "red";
                    msg_category.innerHTML = "This category name already Exists";
                    hdcategory.value = "true";
                    break;
                case false:
                    msg_category.style.display = "none";
                    hdcategory.value = "false";
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
                            <asp:TextBox ID="txtCategoryName" onchange="CheckDouble_category()" runat="server" CssClass="form-control"></asp:TextBox>
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

        <asp:Button ID="btnctgrySave123" runat="server" CssClass="btn btn-primary" ValidationGroup="categoryvalidationgroup"  Text="Save" OnClick="btnctgrySave123_Click"  />
        <asp:Button ID="btnctgryUpdate" runat="server" CssClass="btn btn-primary" ValidationGroup="categoryvalidationgroup" Text="Update" Visible="false" OnClick="btnctgryUpdate_Click" />
        <input class="btn btn-primary " type="button" value="Clear" />
    </div>
</div>
<div class="row">
    <div class="alert alert-success" id="divalert" runat="server" visible="false">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label ID="lblAlert" runat="server"></asp:Label>
    </div>
</div>
