<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Barcode.aspx.cs" Inherits="IMS.Barcode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="padding50"></div>
    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h1>Barcode</h1>
        </div>
        <div class="panel-body">
            <div class="container form-horizontal">
                <div class="col-md-12">
                    <div class="col-md-5 padd0">
                        <div class="form-group ">
                            <div class="col-sm-2 leftpadd0">
                                <label class="control-label   ">Product: </label>
                            </div>
                            <div class="col-sm-8 padd0">
                                <asp:DropDownList ID="txtRackName" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-5 leftpadd0">
                        <div class="form-group">
                            <div class="col-sm-2 padd0">
                                <label class="control-label   ">Batch: </label>
                            </div>
                            <div class="col-sm-8 padd0">
                                <asp:DropDownList ID="txtGodownName" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer text-center">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary " Text="Print" />
            <input class="btn btn-primary " type="button" value="Clear" onclick="cleartextboxes();" />
        </div>
    </div>
</asp:Content>
