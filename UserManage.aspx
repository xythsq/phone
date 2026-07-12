<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManage.aspx.cs" Inherits="WapCoovee.Admin.UserManage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>管理员用户管理 - 网后台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", "微软雅黑", Arial, sans-serif; }
        body { background: #f0f2f5; font-size: 14px; color: #333; }

        .topbar { background: #1a1a2e; color: #fff; height: 56px; line-height: 56px; padding: 0 30px; display: flex; justify-content: space-between; box-shadow: 0 2px 8px rgba(0,0,0,0.15); }
        .topbar .logo { font-size: 20px; font-weight: bold; }
        .topbar .logo span { color: #e94560; }

        .main { padding: 24px 30px; max-width: 1800px; margin: 0 auto; }
        .page-title { font-size: 22px; font-weight: bold; margin-bottom: 20px; color: #1a1a2e; }
        .page-title small { font-size: 13px; font-weight: normal; color: #999; margin-left: 10px; }

        .toolbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
        .toolbar .btn { display: inline-block; padding: 8px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; text-decoration: none; }
        .toolbar .btn-primary { background: #e94560; color: #fff; }
        .toolbar .btn-primary:hover { background: #d63851; }
        .toolbar .btn-sm { padding: 5px 12px; font-size: 12px; }
        .search-box { display: flex; gap: 8px; }
        .search-box input { padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px; width: 220px; font-size: 13px; outline: none; }
        .search-box input:focus { border-color: #e94560; }
        .search-box .btn { border-radius: 4px; }

        .msg-bar { padding: 10px 16px; border-radius: 4px; margin-bottom: 16px; font-size: 13px; }
        .msg-bar.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .msg-bar.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        .table-wrap { background: #fff; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        thead { background: #fafafa; }
        th { padding: 12px 16px; text-align: left; font-weight: 600; font-size: 13px; color: #666; border-bottom: 2px solid #eee; white-space: nowrap; }
        td { padding: 12px 16px; border-bottom: 1px solid #f0f0f0; font-size: 13px; }
        tr:hover td { background: #fafbff; }
        .status { display: inline-block; padding: 2px 10px; border-radius: 10px; font-size: 12px; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
        .action a, .action asp\:linkbutton { color: #e94560; text-decoration: none; margin-right: 8px; font-size: 13px; cursor: pointer; }
        .action a:hover { text-decoration: underline; }
        .empty-row td { text-align: center; padding: 40px; color: #999; font-size: 14px; }

        .form-panel { background: #fff; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,0.08); padding: 24px; margin-top: 20px; }
        .form-panel h3 { font-size: 16px; color: #1a1a2e; margin-bottom: 20px; padding-bottom: 12px; border-bottom: 2px solid #e94560; }
        .form-row { display: flex; gap: 16px; margin-bottom: 16px; }
        .form-group { flex: 1; min-width: 0; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: #555; margin-bottom: 6px; }
        .form-group label .required { color: #e94560; }
        .form-group input, .form-group select { width: 100%; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 13px; outline: none; }
        .form-group input:focus, .form-group select:focus { border-color: #e94560; box-shadow: 0 0 0 2px rgba(233,69,96,0.15); }
        .form-group .checkbox-group { padding-top: 6px; }
        .form-group .checkbox-group label { display: inline-block; margin-right: 16px; font-weight: normal; cursor: pointer; }
        .form-group .checkbox-group input { margin-right: 4px; vertical-align: middle; }
        .form-divider { border: none; border-top: 1px solid #eee; margin: 20px 0; }
        .form-actions { display: flex; gap: 8px; justify-content: flex-end; padding-top: 16px; border-top: 1px solid #eee; margin-top: 20px; }
        .btn-cancel { padding: 8px 24px; border: 1px solid #ddd; border-radius: 4px; background: #fff; cursor: pointer; font-size: 14px; }
        .btn-cancel:hover { background: #f5f5f5; }
        .btn-submit { padding: 8px 24px; border: none; border-radius: 4px; background: #e94560; color: #fff; cursor: pointer; font-size: 14px; }
        .btn-submit:hover { background: #d63851; }
        .btn-gray { padding: 8px 24px; border: none; border-radius: 4px; background: #6c757d; color: #fff; cursor: pointer; font-size: 14px; }
        .btn-gray:hover { background: #5a6268; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
      

        <div class="main">
       
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="msg-bar">
                <asp:Literal ID="ltlMessage" runat="server" />
            </asp:Panel>

            <div class="toolbar">
                <asp:LinkButton ID="btnShowAdd" runat="server" CssClass="btn btn-primary" OnClick="btnShowAdd_Click">+ 添加用户</asp:LinkButton>
                <div class="search-box">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="搜索账号/用户名..." />
                    <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="btn btn-primary btn-sm" OnClick="btnSearch_Click" />
                </div>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>账号</th>
                            <th>姓名</th>
                       <%--     <th>员工ID</th>
                            <th>客户/供应商</th>
                            <th>登录权限</th>
                            <th>状态</th>
                            <th>手机端</th>
                            <th>类型</th>--%>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptUsers" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("UserID") %></td>
                                    <td><strong><%# Eval("UserAccount") %></strong></td>
                                    <td><%# Eval("UserName") %></td>
                                  <%--  <td><%# Eval("EmployeeID") %></td>
                                    <td>C:<%# Eval("CustomerID") ?? "-" %> S:<%# Eval("SupplierID") ?? "-" %></td>
                                    <td>
                                        <%# Convert.ToBoolean(Eval("LogInCustomerport")) ? "客户 " : "" %>
                                        <%# Convert.ToBoolean(Eval("LogInSupplierport")) ? "供应商 " : "" %>
                                        <%# Convert.ToBoolean(Eval("LogInSubcontractport")) ? "外包" : "" %>
                                    </td>
                                    <td><span class="status <%# Convert.ToBoolean(Eval("UserIsEnabled")) ? "status-active" : "status-inactive" %>"><%# Convert.ToBoolean(Eval("UserIsEnabled")) ? "启用" : "禁用" %></span></td>
                                    <td><%# Convert.ToBoolean(Eval("MobileIsEnabled")) ? "✓" : "✗" %></td>
                                    <td><%# Eval("UserType") %></td>--%>
                                    <td><%# Eval("CreateTime", "{0:yyyy-MM-dd HH:mm}") %></td>
                                    <td class="action">
                                        <asp:LinkButton ID="btnEdit" runat="server" Text="编辑" OnClick="btnEdit_Click" CommandArgument='<%# Eval("UserID") %>' />
                                        <asp:LinkButton ID="btnToggle" runat="server" Text='<%# Convert.ToBoolean(Eval("UserIsEnabled")) ? "禁用" : "启用" %>' OnClick="btnToggle_Click" CommandArgument='<%# Eval("UserID") + "," + Eval("UserIsEnabled") %>' OnClientClick="return confirm('确认操作？')" />
                                        <asp:LinkButton ID="btnDelete" runat="server" Text="删除" OnClick="btnDelete_Click" CommandArgument='<%# Eval("UserID") %>' OnClientClick="return confirm('确定删除该用户？')" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:Literal ID="ltlEmpty" runat="server" />
                    </tbody>
                </table>
            </div>

            <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="form-panel">
                <h3><asp:Literal ID="ltlFormTitle" runat="server" Text="添加用户" /></h3>
                <asp:HiddenField ID="hfUserID" runat="server" Value="0" />

                <div class="form-row">
                    <div class="form-group">
                        <label>账号 <span class="required">*</span></label>
                        <asp:TextBox ID="txtAccount" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>密码 <span class="required">*</span></label>
                        <asp:TextBox ID="txtPassword" runat="server"  />
                    </div>
                    <div class="form-group">
                        <label>姓名</label>
                        <asp:TextBox ID="txtUserName" runat="server" />
                    </div>
                </div>

           <%--     <div class="form-row">
                    <div class="form-group">
                        <label>员工ID</label>
                        <asp:TextBox ID="txtEmployeeID" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>客户ID</label>
                        <asp:TextBox ID="txtCustomerID" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>供应商ID</label>
                        <asp:TextBox ID="txtSupplierID" runat="server" />
                    </div>
                </div>--%>

                <hr class="form-divider" />

                <%--<div class="form-row">
                    <div class="form-group">
                        <label>登录权限</label>
                        <div class="checkbox-group">
                            <label><asp:CheckBox ID="chkCustomerPort" runat="server" /> 客户端口</label>
                            <label><asp:CheckBox ID="chkSupplierPort" runat="server" /> 供应商端口</label>
                            <label><asp:CheckBox ID="chkSubcontractPort" runat="server" /> 外包端口</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>用户类型</label>
                        <asp:DropDownList ID="ddlUserType" runat="server">
                            <asp:ListItem Text="-- 请选择 --" Value="" />
                            <asp:ListItem Text="超级管理员" Value="1" />
                            <asp:ListItem Text="普通管理员" Value="2" />
                            <asp:ListItem Text="运营人员" Value="3" />
                            <asp:ListItem Text="客服" Value="4" />
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <div class="checkbox-group" style="padding-top:8px">
                            <label><asp:CheckBox ID="chkEnabled" runat="server" Checked="true" /> 启用</label>
                            <label><asp:CheckBox ID="chkMobileEnabled" runat="server" /> 手机端可用</label>
                        </div>
                    </div>
                </div>--%>

                <div class="form-actions">
                    <asp:Button ID="btnCancelForm" runat="server" Text="取消" CssClass="btn-cancel" OnClick="btnCancelForm_Click" />
                    <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn-submit" OnClick="btnSave_Click" />
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
