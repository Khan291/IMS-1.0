<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="IMS.Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>Company Information</h1>
        </div>
        <div class="panel-body">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                    <div class="form-horizontal Fhorizontal">
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Company Name</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtName"  runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">

                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Country</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:DropDownList ID="ddlcountry" Enabled="false" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">City</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Pin Code</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtpincode" runat="server" Enabled="false" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Fax No.</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtFaxno" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Website</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtwebsite" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Owner Address</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtowneraddress" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Owner Email</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtOwnerEmail" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                    <div class="form-horizontal Fhorizontal">
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Address</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">State</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Telephone No.</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txttelephoneno" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                      

                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">GSTIN</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtGSTIN" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Owner Name</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtOwnername" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Owner Mobile No.</label>
                            </div>
                            <div class="col-sm-7 leftpadd0">
                                <asp:TextBox ID="txtownermobileno" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 leftpadd0">
                                <label class="control-label">Company Logo</label>
                            </div>
                            <div class="col-sm-4 leftpadd0">
                                <asp:FileUpload ID="fileuplogo" runat="server" CssClass="btn btn-file btn-group" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="panel-footer ">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Update" OnClick="btnSave_Click" OnClientClick="this.disabled='true'; this.value='Processing...';" UseSubmitBehavior="false"/>
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary " Text="Cancel" />
        </div>
    </div>
</asp:Content>
