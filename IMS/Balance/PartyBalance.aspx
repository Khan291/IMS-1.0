<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PartyBalance.aspx.cs" Inherits="IMS.Balance.PartyBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../assets/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <script type='text/javascript'>
        function addDataTableToGv() {
            $('#<%= gvPartyDetails.ClientID %>').DataTable();
             $('#<%= gvPartyInvoiceDetails.ClientID %>').DataTable();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>Party Balance</h2>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group">
                    <br />
                    <br />

                    <asp:UpdatePanel ID="uprbtnAndgv" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-2">
                                    <asp:RadioButton ID="rbtnVender" AutoPostBack="true" runat="server" Text="Vender"
                                        OnCheckedChanged="rbtnVender_CheckedChanged" Checked="true" GroupName="party" />
                                </div>
                                <div class="col-md-2">
                                    <asp:RadioButton ID="rbtnCustomer" AutoPostBack="true" runat="server" Text="Customer"
                                        OnCheckedChanged="rbtnCustomer_CheckedChanged" GroupName="party" />
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-1">
                                </div>
                                <div class="col-md-10">
                                    <asp:GridView ID="gvPartyDetails"
                                        runat="server"
                                        OnPreRender="gvPartyDetails_PreRender" OnRowDataBound="gvPartyDetails_RowDataBound"
                                        OnSelectedIndexChanged="gvPartyDetails_SelectedIndexChanged"
                                        OnRowCommand="gvPartyDetails_RowCommand"
                                        DataKeyNames="party_id"
                                        AutoGenerateColumns="false"
                                        CssClass="table table table-striped table-bordered table-hover"
                                        SelectedIndex="0">
                                        <Columns>
                                            <asp:BoundField DataField="party_id" HeaderText="party_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                            <asp:BoundField DataField="branch_id" HeaderText="Branch Id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                            <asp:BoundField DataField="party_name" HeaderText="Party Name" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                            <asp:BoundField DataField="BalanceAmnt" HeaderText="Amount"></asp:BoundField>
                                            <asp:BoundField DataField="message" HeaderText="Message"></asp:BoundField>
                                            <asp:BoundField DataField="status" HeaderText="Status" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                            <asp:TemplateField HeaderText="View All">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnimg_Details" runat="server" ImageUrl="~/assets/img/edit.png"
                                                        CommandName="ViewAll"
                                                        CommandArgument='<%# Eval("party_id") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" BackColor="#ffffff" />
                                    </asp:GridView>
                                </div>
                                <div class="col-md-1">
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="row" runat="server" id="dvpartyInvoiceDetails" visible="false">
                                <div class="col-md-10 col-md-offset-1">
                                    <center>
                                        <asp:Label ID="lblPartyName" Font-Bold="true" Font-Size="X-Large" runat="server"></asp:Label>
                                    </center>
                                    <asp:GridView ID="gvPartyInvoiceDetails" runat="server"
                                        OnPreRender="gvPartyInvoiceDetails_PreRender"
                                        OnRowCommand="gvPartyInvoiceDetails_RowCommand"
                                        DataKeyNames="Id"
                                        AutoGenerateColumns="false"
                                        CssClass="table table table-striped table-bordered table-hover">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="checkAll" runat="server" AutoPostBack="true" OnCheckedChanged="checkAll_CheckedChanged" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chbCheck" OnCheckedChanged="chbCheck_CheckedChanged" AutoPostBack="true" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                            <asp:BoundField DataField="ps_id" HeaderText="P.S. Id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                            <%--<asp:BoundField DataField="sale_id" HeaderText="Sale Id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>--%>
                                            <asp:BoundField DataField="party_id" HeaderText="Party Id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                                            <asp:BoundField DataField="InvoiceNumber" HeaderText="Invoice No."></asp:BoundField>
                                            <asp:BoundField DataField="SubTotal" HeaderText="SubTotal" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                            <asp:BoundField DataField="TaxAmount" HeaderText="Tax Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                            <asp:BoundField DataField="GrandTotal" HeaderText="Grand Total"></asp:BoundField>
                                            <asp:BoundField DataField="PaidAmnt" HeaderText="Paid Amount" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                                            <asp:BoundField DataField="BalanceAmnt" HeaderText="Amount"></asp:BoundField>
                                            <asp:BoundField DataField="message" HeaderText="Message"></asp:BoundField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" BackColor="#ffffff" />
                                    </asp:GridView>
                                </div>
                                <br />
                                <div class="row" runat="server">
                                    <div class="col-md-10 col-md-offset-1">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <asp:Label ID="Label3" Font-Bold="true" runat="server">Total Amount: </asp:Label>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label ID="lblAmtToBePaid" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-10" style="height:50px">
                                                <asp:Button ID="btnPay" runat="server" OnClick="btnPay_Click" Visible="false" CssClass="btn btn-primary" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <div class="panel-footer text-center">
            <br />
        </div>
    </div>
    <script type='text/javascript'>
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(addDataTableToGv);
    </script>
</asp:Content>
