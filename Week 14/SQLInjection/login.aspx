<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SQLInjection.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Username: <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox><br />
            Password: <asp:TextBox ID="txtPassword" runat="server" MaxLength="100" OnTextChanged="txtPassword_TextChanged" TextMode="Password"></asp:TextBox><br /><br />

            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnSecureLogin" runat="server" OnClick="Button1_Click" Text="Secure Login" />
            <br /><br />
            <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>

        </div>
    </form>
</body>
</html>
