<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MasterReports.aspx.cs" Inherits="IMS.MasterReports" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">   
    <script>
       

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
    </script>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         
        <div class="panel panel-default ">
        <div class="panel-heading text-center">
            <h2>Common Reports</h2>
        </div>
       <%-- <div class="panel-body">
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
                                          <asp:ListItem Text="Stock Report" Value="2"/>
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
                                        <asp:DropDownList ID="ddlFilerBy" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlFilerBy_SelectedIndexChanged" >
                                            <asp:ListItem Text="Choose Filter" Value="0"/>
                                            <asp:ListItem Text="Product Wise" Value="1"/>
                                            <asp:ListItem Text="Vendor Wise"  Value="2"/>
                                            <asp:ListItem Text="Cutomer Wise" Value="3"/>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" InitialValue="0" ControlToValidate="ddlFilerBy" ErrorMessage="Please Select Filter By" ForeColor="Red" ValidationGroup="search"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                            <asp:UpdatePanel ID="lstpanel" runat="server">
                                 <ContentTemplate>
                            <div class="col-md-4 ">
                                <div>
                                <div id="Products" runat="server" visible="false">
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            Products                                    
                                        </label>
                                       <asp:ListBox  ID="lstProduct" runat="server" CssClass="form-control" SelectionMode="Multiple">
                                       </asp:ListBox>
                                    </div>
                                     </div>
                                </div>
                                 <div id="Vendors" runat="server" visible="false">
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            Vendors                                  
                                        </label>
                                       <asp:ListBox  ID="lstVendor" runat="server" CssClass="form-control" SelectionMode="Multiple">                                            
                                        </asp:ListBox>
                                    </div>
                                </div>
                                <div id="Customers" runat="server" visible="false">
                                    <div class="col-sm-10  ">
                                        <label class="control-label">
                                            Customers                                  
                                        </label>
                                       <asp:ListBox  ID="lstCustomers" runat="server" CssClass="form-control" SelectionMode="Multiple">                                            
                                        </asp:ListBox>
                                    </div>
                                </div>
                            </div>     
                                     </ContentTemplate>                   
                            </asp:UpdatePanel>
                        </div>
                        <div class="row">   
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
        </div>--%>

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
            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary"  OnClick="btnSearch_Click" Text="Search" />
            <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary" OnClick="btnClear_Click" Text="Clear" />
        </div>
        
             <div class="row">
        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">  
                        
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="900" Width="1205" ></rsweb:ReportViewer>
            </div>
                 </div>
    </div>
</asp:Content>
