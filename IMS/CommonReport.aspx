<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CommonReport.aspx.cs" Inherits="IMS.Reports.CommonReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="assets/invoicedesign/styles/bauhaus.css" rel="stylesheet" />
    <link href="assets/invoicedesign/styles/bauhaus_print.css" rel="stylesheet" />    --%>
    <script>
        function PrintPage() {
            $('#btnprint').hide();
            window.print();
        }

        $(function () {
            $('[id*=lstProduct]').multiselect({
                includeSelectAllOption: true
            });
            $('[id*=lstVendor]').multiselect({
                includeSelectAllOption: true
            });
            $('[id*=lstCustomers]').multiselect({
                includeSelectAllOption: true
            });
            $('[id*=lstGodowns]').multiselect({
                includeSelectAllOption: true
            });
        });
        function openalert(msg) {
            debugger;
            alertify.alert('Success', msg).setting({
                'onok': function () { window.location.href = "CommonReport.aspx"; }
            });
        }

        function PrintPanel() {
            var panel = document.getElementById("<%=reportSection.ClientID %>");
            var printWindow = window.open('', '', 'height=400,width=2000');
            printWindow.document.write('<html><head><title>DIV Contents</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            setTimeout(function () {
                printWindow.print();
            }, 500);
            return false;
        }
    </script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <div class="panel panel-default " >
        <div class="panel-heading text-center">
            <h2>Common Reports</h2>
        </div>
        <div class="panel-body">
            <div>
                <div class="form-horizontal">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4 ">
                                <div>
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            Select Report                                    
                                        </label>
                                        <asp:DropDownList ID="ddlReportType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
                                            <asp:ListItem Text="Choose Report" Value="0" />
                                            <asp:ListItem Text="Inventory Report" Value="1" />
                                            <asp:ListItem Text="Stock Report" Value="2" />
                                             <asp:ListItem Text="Balance Report" Value="3" />
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" ControlToValidate="ddlReportType" ErrorMessage="Please Select Report Type" ForeColor="Red" ValidationGroup="except"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 ">
                                <div>
                                    <div class="col-sm-10 ">
                                        <label class="control-label">
                                            Filter By                                    
                                        </label>
                                        <asp:DropDownList ID="ddlFilerBy" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlFilerBy_SelectedIndexChanged">
                                            <asp:ListItem Text="Choose Filter" Value="0" />
                                            <asp:ListItem Text="Product Wise" Value="1" />
                                            <asp:ListItem Text="Vendor Wise" Value="2" />
                                            <asp:ListItem Text="Cutomer Wise" Value="3" />
                                            <asp:ListItem Text="Godown Wise" Value="4"  />
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" InitialValue="0" ControlToValidate="ddlFilerBy" ErrorMessage="Please Select Filter By" ForeColor="Red" ValidationGroup="search"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                            <%--<asp:UpdatePanel ID="lstpanel" runat="server">--%>
                            <%--<ContentTemplate>--%>
                            <div class="col-md-4 ">
                                <div>
                                    <div id="Products" runat="server" visible="false">
                                        <div class="col-sm-10  ">
                                            <label class="control-label">
                                                Products                                    
                                            </label>
                                            <asp:ListBox ID="lstProduct" runat="server" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                        </div>
                                    </div>
                                </div>
                                <div id="Vendors" runat="server" visible="false">
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            Vendors                                  
                                        </label>
                                        <asp:ListBox ID="lstVendor" runat="server" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                    </div>
                                </div>
                                <div id="Customers" runat="server" visible="false">
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            Customers                                  
                                        </label>
                                        <asp:ListBox ID="lstCustomers" runat="server" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                    </div>
                                </div>
                                 <div id="Godowns" runat="server" visible="false">
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            Godowns                                  
                                        </label>
                                        <asp:ListBox ID="lstGodowns" runat="server" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                            <%--   </ContentTemplate>
                            </asp:UpdatePanel>--%>
                        </div>
                        <div class="row">
                              <div class="col-md-4 ">
                                <div>
                                    
                                    <div class="col-sm-10 ">
                                        
                                        <label class="control-label">
                                            From Bigning of Financial Year                                   
                                        </label>
                                       <asp:CheckBox ID="cbEnable" runat="server" CssClass="checkbox" OnCheckedChanged="cbEnable_CheckedChanged" AutoPostBack="true" />
                                    </div>
                                   
                                        

                                    
                                </div>
                            </div>
                            <div class="col-md-4 ">
                                <div>
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            From Date                                    
                                        </label>
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" TargetControlID="txtStartDate" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 ">
                                <div class=" Fhorizontal ">
                                    <div class="col-sm-10 ">
                                        <label class="control-label">
                                            To Date                                    
                                        </label>
                                        <asp:TextBox ID="txtenddate" runat="server" CssClass="form-control"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" TargetControlID="txtenddate" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <asp:Label ID="Label1" runat="server"></asp:Label>
            </div>
        </div>
        <div class="panel-footer text-center">
            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click" Text="Search" ValidationGroup="search" />
            <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary" OnClick="btnClear_Click" Text="Clear" />
        </div>

        <div id="displayReportSection" runat="server" visible="false">
            <asp:Panel ID="reportSection" runat="server">
                <div class="row">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <div id="invoice" class="pagestyle">
                            <div id="invoice-header">
                                <div class="row">
                                    <div class="col-md-6">
                                        <asp:Image ID="imglogo" runat="server" Height="150" Width="300" />
                                        <asp:Label ID="lblIms" runat="server" Font-Bold="true" Style="padding: 0; font-size: 55px;" Text="!MSB!ZZ" Visible="false"></asp:Label>
                                    </div>
                                    <div class="col-md-6">

                                        <div class="vcard" id="company-address">
                                            <div class="fn org">
                                                <h2>
                                                    <strong>
                                                        <asp:Label ID="lblCompanyName" runat="server"></asp:Label>
                                                    </strong>
                                                </h2>
                                            </div>
                                            <div class="adr">
                                                <div class="street-address">
                                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                                </div>
                                                <div class="locality">Locality</div>
                                                <div id="company-postcode">
                                                    <asp:Label ID="lblzipcode" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="email">
                                                <asp:Label ID="lblemail" runat="server"></asp:Label>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="invoice-info">
                                <strong>Start Date:
                                    <asp:Label ID="lblStartDate" runat="server"></asp:Label>
                                    End Date:
                                    <asp:Label ID="lblEndDate" runat="server"></asp:Label>
                                </strong>
                            </div>

                            <div class="vcard" id="client-details">
                                <div class="fn">
                                    <asp:Label ID="lblpartyname" runat="server"></asp:Label>
                                </div>
                                <div class="org">
                                </div>
                                <div class="adr">
                                    <div class="street-address">
                                        <asp:Label ID="lblpartyaddress" runat="server"></asp:Label>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 0px; margin-top: 10px">

                                    <asp:GridView ID="grdreport" EmptyDataText="No Record Found" runat="server" OnDataBound="grdreport_DataBound" HeaderStyle-BackColor="#0033CC" Font-Size="X-Small" AutoGenerateColumns="true" CssClass="table table-bordered" BorderStyle="Solid" GridLines="Horizontal">


                                        <HeaderStyle BackColor="#0033CC" ForeColor="White" />
                                    </asp:GridView>

                                </div>
                            </div>

                            <br />
                            <br />
                            <div class="row">
                                <input type="button" class="btn btn-danger" id="btnprint" value="print" onclick="return PrintPanel();" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>

    </div>
</asp:Content>
