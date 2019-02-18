<%@ Page Title="" Language="C#" MasterPageFile="~/Registration/Site.Master" AutoEventWireup="true" CodeBehind="WelcomePage.aspx.cs" Inherits="IMS.Registration.WelcomePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Thank You, </h1>
    <h2><%= lblusername.Text %> you email has been verified</h2>
    <h3>Click Below Button to Login</h3>.
    <asp:Label ID="lblusername" runat="server" Visible="false"></asp:Label>
    <asp:Button ID="btnloginclick" runat="server" Text="Login" OnClick="btnloginclick_Click" CssClass="btn btn btn-primary" />
</asp:Content>
