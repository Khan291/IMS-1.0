<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="Mrp_PurchaseSale_Report.aspx.cs" Inherits="IMS.Reports.Mrp_PurchaseSale_Report" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager> 
             
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="861px" Width="1347px">
                <LocalReport ReportPath="Reports\Mrp_PurchaseSale_Report.rdlc" EnableExternalImages="True">
                </LocalReport>
            </rsweb:ReportViewer>
            
        
        </div>
    </form>
</body>
</html>
