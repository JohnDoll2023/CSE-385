<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    Vendor State(leave blank for all): <asp:ListBox ID="lstVendors" runat="server" Height="220px" Width="238px"></asp:ListBox>
    <br /><br />
    <asp:Button ID="lstLoadVendors" runat="server" Text="Load Vendors" CssClass ="btn btn-info " OnClick="lstLoadVendors_Click"/>

</asp:Content>
