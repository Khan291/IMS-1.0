<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="LowStockReport.aspx.cs" Inherits="IMS.LowStockReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container">
  <h2>Table Rows</h2>
    <asp:GridView class="table  table-striped" ID="gvLowSTockReport" runat="server">

    </asp:GridView>
</div>      
    



</asp:Content>
