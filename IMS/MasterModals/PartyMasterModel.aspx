<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="PartyMasterModel.aspx.cs" Inherits="IMS.PartyMasterModel" %>

<html>
<head>
    <title>IMS</title>
        
    <link href="../assets/plugins/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../assets/scripts/jquery.min.js"></script>

    <script type="text/javascript">

        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }

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
    var txt = $("<%=txtPartyName.ClientID%>");

        txt.focus();
    </script>
</head>

<body>
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container-fluid">
            <div class="padding50"></div>
            <div class="panel panel-default ">
                <div class="panel-body">
                    <div class="col-md-12">
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label   ">
                                            Party Name:<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPartyName" onchange="CheckDouble()" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ValidationGroup="abc" runat="server" ErrorMessage="Party name is required" ControlToValidate="txtPartyName" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                        <asp:HiddenField ID="hde" runat="server" />
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
                                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="rgx" runat="server" ValidationGroup="abc" ErrorMessage="Invalid Mobile No" Display="Dynamic"
                                            ControlToValidate="txtContactNo" ValidationExpression="^[0-9]{10}$" ForeColor="Red">
                                        </asp:RegularExpressionValidator>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-4 leftpadd0">
                                        <label class="control-label   ">
                                            GSTIN No:<asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtGSTIN" runat="server" CssClass="form-control"></asp:TextBox>
                                       
                                        <asp:Label ID="lblgstinerror" ForeColor="Red" runat="server"></asp:Label>
                                        <asp:HiddenField ID="hd2" runat="server" />
                                        <asp:RegularExpressionValidator ID="rxgst" runat="server" ErrorMessage="Invalid GSTIN" ForeColor="Red" Display="Dynamic" ValidationExpression="\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d[Z]{1}[A-Z\d]{1}" ControlToValidate="txtGSTIN" ValidationGroup="abc"></asp:RegularExpressionValidator>
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
                                            Party Type:<asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                        </label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlPartyType" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Select Party" Value="0" />
                                            <asp:ListItem Text="Customer" Value="Customer" />
                                            <asp:ListItem Text="Vendor" Value="Vendor" />
                                        </asp:DropDownList>
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ValidationGroup="abc" runat="server" InitialValue="0" ErrorMessage="Party type is required" ControlToValidate="ddlPartyType" ForeColor="Red"></asp:RequiredFieldValidator>
                                     
                                      
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
                                       
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer text-center">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="abc" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="abc" />
                    <input class="btn btn-primary " type="button" value="Clear" onclick="cleartextboxes();" />
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

        <div class="modal fade" id="myModal" role="dialog" runat="server">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Success</h4>
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

    </form>
</body>
</html>



