<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="IMS.Products" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Inventory Management System</title>
    <!-- Core CSS - Include with every page -->
    <link href="../assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <link href="../assets/css/main-style.css" rel="stylesheet" />
    <!-- Page-Level CSS -->
    <link href="../assets/plugins/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <script src="../assets/scripts/main.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="row">

        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div style="overflow-x: auto">
                <asp:GridView ID="GrProducts" runat="server" EmptyDataText="No Recorde Found" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="false" CssClass="table table-bordered " AllowPaging="true" PageSize="10" >

                    <Columns>
                        <asp:TemplateField HeaderText="SR.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="product_id" HeaderText="Purchase ID" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden">
                            <HeaderStyle CssClass="hidden-xs"></HeaderStyle>

                            <ItemStyle CssClass="hidden-xs"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="product_name" HeaderText="Product Name"></asp:BoundField>
                        <asp:BoundField DataField="product_code" HeaderText="product code "></asp:BoundField>
                        <asp:BoundField DataField="purchas_price" HeaderText="purchas_price"></asp:BoundField>
                        <asp:BoundField DataField="sales_price" HeaderText="sales_price"></asp:BoundField>
                        <asp:BoundField DataField="qty" HeaderText="qty"></asp:BoundField>
                        <asp:BoundField DataField="reorder_level" HeaderText="reorder_level"></asp:BoundField>
                        <asp:TemplateField HeaderText="Show">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnimg_update" runat="server" ImageUrl="../assets/img/edit.png" CommandName="Select" CommandArgument='<%# Eval("product_id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                    <HeaderStyle BackColor="#428BCA" ForeColor="White" />
                    <PagerStyle Wrap="False" CssClass="GridPager" HorizontalAlign="Center" VerticalAlign="Middle" />

                </asp:GridView>
                <%--<asp:Button ID="btnExporttoexcel" runat="server" CssClass="btn btn-primary " Text="Export To Excel" OnClick="btnExporttoexcel_Click" />--%>
            </div>
        </div>
        </div>
    </div>
    </form>
</body>
</html>
