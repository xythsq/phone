<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WapCoovee.Admin.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>管理员登录</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", "微软雅黑", Arial, sans-serif; }
        body { background: #f0f2f5; font-size: 14px; color: #333; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .login-wrap { background: #fff; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); width: 400px; padding: 40px; }
        .login-wrap h1 { font-size: 22px; color: #1a1a2e; text-align: center; margin-bottom: 8px; }
        .login-wrap h1 span { color: #e94560; }
        .login-wrap .subtitle { text-align: center; font-size: 13px; color: #999; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: #555; margin-bottom: 6px; }
        .form-group input { width: 100%; padding: 10px 14px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; outline: none; transition: border-color 0.2s; }
        .form-group input:focus { border-color: #e94560; box-shadow: 0 0 0 2px rgba(233,69,96,0.15); }
        .btn-login { width: 100%; padding: 12px; border: none; border-radius: 4px; background: #e94560; color: #fff; font-size: 16px; cursor: pointer; }
        .btn-login:hover { background: #d63851; }
        .msg-bar { padding: 10px 16px; border-radius: 4px; margin-bottom: 16px; font-size: 13px; text-align: center; }
        .msg-bar.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .msg-bar.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-wrap">
            <h1><span>Admin</span> 登录</h1>
  
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="msg-bar">
                <asp:Literal ID="ltlMessage" runat="server" />
            </asp:Panel>
            <div class="form-group">
                <label>账号</label>
                <asp:TextBox ID="txtAccount" runat="server" placeholder="请输入管理员账号" />
            </div>
            <div class="form-group">
                <label>密码</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="请输入密码" />
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="登 录" CssClass="btn-login" OnClick="btnLogin_Click" />
        </div>
    </form>
</body>
</html>
