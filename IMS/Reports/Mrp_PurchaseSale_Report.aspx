<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Main.Master" CodeBehind="Mrp_PurchaseSale_Report.aspx.cs" Inherits="IMS.Reports.Mrp_PurchaseSale_Report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <br />
        <div>
            <a href="../Home.aspx" id="bMaster" runat="server">
                <img src="../assets/img/goback-5-w800.png" height="50" width="130" /></a>
        </div>
        <div style="text-align:center; font-size:30px; font-family:sans-serif; color:#117dcb" >
        <b><asp:label id="lblmrpReportHeading" runat="server"></asp:label></b>
        </div>
        <br />
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="861px" Width="100%">
            <LocalReport ReportPath="Reports\Mrp_PurchaseSale_Report.rdlc" EnableExternalImages="True">
            </LocalReport>
        </rsweb:ReportViewer>

    </div>

</asp:Content>
