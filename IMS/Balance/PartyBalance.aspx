<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PartyBalance.aspx.cs" Inherits="IMS.Balance.PartyBalance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h2>Stock Management</h2>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group">
                    <br /><br />
                    <div class="row">
                        <div class="col-md-1">
                        </div>
                        <div class="col-md-10">
                            <asp:GridView ID="gvPartyDetails" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowCommand="GridView1_RowCommand" DataKeyNames="product_id" AutoGenerateColumns="false" CssClass="table table table-striped table-bordered table-hover" SelectedIndex="0">
                        <Columns>
                             <asp:BoundField DataField="product_name" HeaderText="Product Name"></asp:BoundField>
                            <asp:BoundField DataField="godown_name" HeaderText="Godown Name" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                           
                            <asp:BoundField DataField="sales_price" HeaderText="Sales Price" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                            <asp:BoundField DataField="purchas_price" HeaderText="Purchase Price" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"></asp:BoundField>
                            <asp:BoundField DataField="product_code" HeaderText="Product Code" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                            <asp:BoundField DataField="reorder_level" HeaderText="Reorder Level" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"></asp:BoundField>
                            <asp:TemplateField HeaderText="Detailes">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="~/assets/img/edit.png" CommandName="Select" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                    </asp:GridView>
                        </div>
                        <div class="col-md-1">
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="panel-footer text-center">
            <br />
        </div>
    </div>
</asp:Content>
