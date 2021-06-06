<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="SQLInjection.admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    Vendor State: <asp:TextBox ID="txtState" runat="server"></asp:TextBox>
    <br />
    <asp:ListBox ID="lstVendors" runat="server" Height="221px" Width="213px"></asp:ListBox>
    <asp:Button ID="btnLoadInvoices" runat="server" Text="Load Invoices >>" OnClick="btnLoadInvoices_Click" />
    <asp:ListBox ID="lstInvoices" runat="server"></asp:ListBox>
    <br />
    <asp:Button ID="btnLoadVendors" runat="server" Text="Load Vendors" OnClick="btnLoadVendors_Click" />
</asp:Content>
