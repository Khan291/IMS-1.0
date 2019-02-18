<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="UserMasterModel.aspx.cs" Inherits="IMS.UserMasterModel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        function openalert(msg) {
            alertify.alert('Alert', msg)
        }
    </script>
    <script type='text/javascript'>
        function openModal() {
            $('#<%=myModal.ClientID%>').modal('show');
        }
    </script>
    <script type="text/javascript">

        function CheckDouble1() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/User.aspx/CheckDouble1") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtContactNo.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess1,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function OnSuccess1(response) {
            var msg = $("#<%=lblcheck.ClientID%>")[0];
            var hd1 = $("#<%=hde.ClientID%>")[0];
            switch (response.d) {
                case "true":

                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "Mobile No is already exists";
                    hd1.value = true;
                    break;
                case "false":
                    msg.style.display = "none";
                    hd1.value = false;
                    break;
            }
        }
    </script>
    <script type="text/javascript">

        function CheckDouble() {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Masters/User.aspx/CheckDouble") %>', // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtUserEmail.ClientID%>")[0].value + '" }',// user name or email value  
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

                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "Email-ID already exists";
                    hd1.value = true;
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

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div>
            <a href="../Master.aspx" id="bMaster" runat="server">
                <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
        </div>
        <div class="padding50"></div>
        <div>
            <div class="row">
                <div class="panel panel-default ">
                    <div class="panel-heading text-center">
                        <h1>User Master</h1>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group lef ">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label">
                                                First Name   :<asp:Label ID="lblStar" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ErrorMessage="First name is required" ValidationGroup="usr" ControlToValidate="txtFirstName" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group lef ">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label">
                                                Last Name   :<asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="txtLastname" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ErrorMessage="Last name is required" ValidationGroup="usr" ControlToValidate="txtLastname" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label">
                                                Password       :<asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfPassword" runat="server" Display="Dynamic" ErrorMessage="Password is required" ValidationGroup="usr" ControlToValidate="txtPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ForeColor="Red" ControlToValidate="txtPassword" ValidationGroup="usr" ErrorMessage="Password should have atleast 8 characters, preferably atleast one number,one upper case and one special character" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="leftpadd0  ">
                                                Email:<asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="txtUserEmail" runat="server" onchange="CheckDouble()" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="usr" ErrorMessage="Email is required" ControlToValidate="txtUserEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:Label ID="lblcheckDoubleError" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hd" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label">
                                                Role   :<asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Select Role" InitialValue="0" ValidationGroup="usr" ControlToValidate="ddlRole" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label">
                                                Branch   :<asp:Label ID="Label5" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ErrorMessage="Select Branch" InitialValue="0" ValidationGroup="usr" ControlToValidate="ddlBranch" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <div class="col-sm-5 leftpadd0">
                                            <label class="control-label">
                                                Contact No    :<asp:Label ID="Label6" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" onchange="CheckDouble1()" onkeypress="return OnlyNumericEntry(event);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfcontact" Display="Dynamic" runat="server" ErrorMessage="Contact is required" ValidationGroup="usr" ControlToValidate="txtContactNo" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="rgx" runat="server" ErrorMessage="Enter 10 digits Number Only" ValidationGroup="usr"
                                                ControlToValidate="txtContactNo" ValidationExpression="^[0-9]{10}$" ForeColor="Red" Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                            <asp:Label ID="lblcheck" runat="server"></asp:Label>
                                            <asp:HiddenField ID="hde" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer text-center">

                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Save" OnClick="btnSave_Click" ValidationGroup="usr" />
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" Visible="false" OnClick="btnUpdate_Click" ValidationGroup="usr" />
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary " Text="Clear" OnClick="Button1_Click" />
                        <%--<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="btnCancel_Click" Style="float: right" />--%>
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
</asp:Content>
