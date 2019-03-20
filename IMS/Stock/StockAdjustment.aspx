<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="StockAdjustment.aspx.cs" Inherits="IMS.Stock.StockAdjustment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        
     $(document).ready(function () {
            $('#<%= gvStockDetails.ClientID %>').DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
            </div>
            <div class="col-md-2">
            </div>
        </div>
        <br /><br />
        <div class="row">
            <div class="col-md-1">
            </div>
            <div class="col-md-10">
                <asp:GridView ID="gvStockDetails" runat="server" AutoGenerateColumns="False" CellPadding="6"
                    OnRowCancelingEdit="gvStockDetails_RowCancelingEdit"
                    OnRowEditing="gvStockDetails_RowEditing"
                    OnRowUpdating="gvStockDetails_RowUpdating"
                    OnPreRender="gvStockDetails_PreRender"
                    CssClass="table table-bordered">
                    <Columns>
                        <asp:TemplateField HeaderText="Stock ID" ItemStyle-CssClass="hidden-xs text-center" HeaderStyle-CssClass="hidden-xs text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblStockId" runat="server" Text='<%#Eval("stock_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Id" ItemStyle-CssClass="hidden text-center" HeaderStyle-CssClass="hidden text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblProductId" runat="server" Text='<%#Eval("product_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name" ItemStyle-CssClass="hidden-xs text-center" HeaderStyle-CssClass="hidden-xs text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("product_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity" ItemStyle-CssClass="hidden-xs text-center" HeaderStyle-CssClass="hidden-xs text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblqty" runat="server" Text='<%#Eval("qty") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtqty" runat="server" Text='<%#Eval("qty") %>' TextMode="Number" required ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company Id" ItemStyle-CssClass="hidden text-center" HeaderStyle-CssClass="hidden text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblCompanyId" runat="server" Text='<%#Eval("company_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="hidden text-center" HeaderStyle-CssClass="hidden text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%--<asp:Button ID="btn_Edit" runat="server" Text="Edit" CommandName="Edit" />--%>
                                <asp:ImageButton CommandName="Edit" ID="btn_Edit" runat="server" ImageUrl="~/assets/img/edit.png" />
                                <asp:ImageButton CommandName="Delete row" ID="btnimg_Remove" runat="server" ImageUrl="~/assets/img/remove.png" href="#myModal" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:ImageButton CommandName="Update" ID="btn_Edit" runat="server" ImageUrl="~/assets/img/edit.png" />
                                <asp:ImageButton CommandName="Cancel" ID="btn_Cancel" runat="server" ImageUrl="~/assets/img/Cancel.png" />
                                <%--<asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel" />--%>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="text-center" BackColor="#428BCA" ForeColor="White" />
                </asp:GridView>
            </div>
            <div class="col-md-1">
            </div>
        </div>
    </div>
</asp:Content>
