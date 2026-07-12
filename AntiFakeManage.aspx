<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AntiFakeManage.aspx.cs" Inherits="WapCoovee.Admin.AntiFakeManage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>防伪码管理 - 网后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", "微软雅黑", Arial, sans-serif;
        }

        body {
            background: #f0f2f5;
            font-size: 14px;
            color: #333;
        }

        .topbar {
            background: #1a1a2e;
            color: #fff;
            height: 56px;
            line-height: 56px;
            padding: 0 30px;
            display: flex;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

            .topbar .logo {
                font-size: 20px;
                font-weight: bold;
            }

                .topbar .logo span {
                    color: #e94560;
                }

        .main {
            padding: 24px 30px;
            max-width: 2000px;
            margin: 0 auto;
        }

        .page-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #1a1a2e;
        }

            .page-title small {
                font-size: 13px;
                font-weight: normal;
                color: #999;
                margin-left: 10px;
            }

        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            flex-wrap: wrap;
            gap: 8px;
        }

            .toolbar .btn {
                display: inline-block;
                padding: 8px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                text-decoration: none;
            }

            .toolbar .btn-primary {
                background: #e94560;
                color: #fff;
            }

                .toolbar .btn-primary:hover {
                    background: #d63851;
                }

            .toolbar .btn-success {
                background: #2ecc71;
                color: #fff;
            }

                .toolbar .btn-success:hover {
                    background: #27ae60;
                }

            .toolbar .btn-info {
                background: #3498db;
                color: #fff;
            }

                .toolbar .btn-info:hover {
                    background: #2980b9;
                }

            .toolbar .btn-refresh {
                background: #fff;
                color: #555;
                border: 1px solid #ddd;
            }

                .toolbar .btn-refresh:hover {
                    background: #f5f5f5;
                    border-color: #ccc;
                }

            .toolbar .btn-sm {
                padding: 5px 12px;
                font-size: 12px;
            }

            .toolbar .btn-group {
                display: flex;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

        .search-box {
            display: flex;
            gap: 8px;
        }

            .search-box input, .search-box select {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                width: 150px;
                font-size: 13px;
                outline: none;
            }

                .search-box input:focus, .search-box select:focus {
                    border-color: #e94560;
                }

        .batch-input {
            width: 70px;
            padding: 8px 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 13px;
            outline: none;
            text-align: center;
        }

            .batch-input:focus {
                border-color: #e94560;
            }

        .msg-bar {
            padding: 10px 16px;
            border-radius: 4px;
            margin-bottom: 16px;
            font-size: 13px;
        }

            .msg-bar.success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .msg-bar.error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

        .table-wrap {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 950px;
        }

        thead {
            background: #fafafa;
        }

        th {
            padding: 12px 16px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            color: #666;
            border-bottom: 2px solid #eee;
            white-space: nowrap;
        }

        td {
            padding: 12px 12px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 13px;
        }

        tr:hover td {
            background: #eef2ff;
        }

        th.cb-col, td.cb-col {
            width: 40px;
            text-align: center;
            padding: 12px 8px;
        }

            th.cb-col input, td.cb-col input {
                width: 16px;
                height: 16px;
                cursor: pointer;
                vertical-align: middle;
            }

        .code-mono {
            font-family: Consolas, "Courier New", monospace;
            font-size: 14px;
            letter-spacing: 1px;
        }

        .status {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 10px;
            font-size: 12px;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        .action a {
            color: #e94560;
            text-decoration: none;
            margin-right: 6px;
            font-size: 13px;
            cursor: pointer;
        }

            .action a:hover {
                text-decoration: underline;
            }

        .empty-row td {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 14px;
        }

        .pagination {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            background: #fafafa;
            border-top: 1px solid #eee;
            font-size: 13px;
            flex-wrap: wrap;
            gap: 8px;
        }

            .pagination .info {
                color: #888;
            }

            .pagination .pages {
                display: flex;
                align-items: center;
                gap: 4px;
            }

                .pagination .pages a, .pagination .pages span {
                    display: inline-block;
                    padding: 5px 12px;
                    border: 1px solid #ddd;
                    border-radius: 3px;
                    text-decoration: none;
                    color: #333;
                    font-size: 13px;
                }

                    .pagination .pages a:hover {
                        background: #e94560;
                        color: #fff;
                        border-color: #e94560;
                    }

                .pagination .pages .current {
                    background: #e94560;
                    color: #fff;
                    border-color: #e94560;
                    font-weight: bold;
                }

                .pagination .pages .disabled {
                    color: #ccc;
                    cursor: default;
                }

                .pagination .pages select {
                    padding: 4px 8px;
                    border: 1px solid #ddd;
                    border-radius: 3px;
                    font-size: 13px;
                    outline: none;
                }

        .form-panel {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
            padding: 24px;
            margin-top: 20px;
        }

            .form-panel h3 {
                font-size: 16px;
                color: #1a1a2e;
                margin-bottom: 20px;
                padding-bottom: 12px;
                border-bottom: 2px solid #e94560;
            }

        .form-row {
            display: flex;
            gap: 16px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            min-width: 160px;
        }

            .form-group label {
                display: block;
                font-size: 13px;
                font-weight: 600;
                color: #555;
                margin-bottom: 6px;
            }

                .form-group label .required {
                    color: #e94560;
                }

            .form-group input, .form-group select {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 13px;
                outline: none;
            }

                .form-group input:focus, .form-group select:focus {
                    border-color: #e94560;
                    box-shadow: 0 0 0 2px rgba(233,69,96,0.15);
                }

                .form-group input[readonly] {
                    background: #f5f5f5;
                    color: #666;
                }

            .form-group .checkbox-group {
                padding-top: 6px;
            }

                .form-group .checkbox-group label {
                    display: inline-block;
                    margin-right: 16px;
                    font-weight: normal;
                    cursor: pointer;
                }

                .form-group .checkbox-group input {
                    margin-right: 4px;
                    vertical-align: middle;
                    width: auto;
                }

        .form-actions {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
            padding-top: 16px;
            border-top: 1px solid #eee;
            margin-top: 20px;
        }

        .btn-cancel {
            padding: 8px 24px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: #fff;
            cursor: pointer;
            font-size: 14px;
        }

            .btn-cancel:hover {
                background: #f5f5f5;
            }

        .btn-submit {
            padding: 8px 24px;
            border: none;
            border-radius: 4px;
            background: #e94560;
            color: #fff;
            cursor: pointer;
            font-size: 14px;
        }

            .btn-submit:hover {
                background: #d63851;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server" />

        <div class="main">
    
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="msg-bar">
                <asp:Literal ID="ltlMessage" runat="server" />
            </asp:Panel>

            <div class="toolbar">
                <div class="btn-group">
                  <%--  <asp:LinkButton ID="btnShowAdd" runat="server" CssClass="btn btn-primary" OnClick="btnShowAdd_Click">+ 生成防伪码</asp:LinkButton>
                    <span style="color: #ccc">|</span>--%>
                        <span style="color: #ccc">|</span>
                    <asp:LinkButton ID="btnBatchDelete" runat="server" CssClass="btn btn-danger" OnClick="btnBatchDelete_Click" OnClientClick="return confirm('确认删除所选防伪码？此操作不可恢复！')">批量删除</asp:LinkButton>
                    <span style="color: #ccc">|</span>
                    <span style="font-size: 13px; color: #555">批量生成：</span>
                    <asp:TextBox ID="txtBatchCount" runat="server" CssClass="batch-input" Text="10" />
                    <span style="font-size: 13px; color: #555">个</span>
                    <asp:LinkButton ID="btnBatchGenerate" runat="server" CssClass="btn btn-success" OnClick="btnBatchGenerate_Click" OnClientClick="return confirm('确认批量生成？')">生成</asp:LinkButton>
                    <span style="color: #ccc">|</span>
                    <asp:LinkButton ID="btnGenExport" runat="server" CssClass="btn btn-info" OnClick="btnGenExport_Click" OnClientClick="return confirm('确认生成并导出Excel？')">生成并导出Excel</asp:LinkButton>
                    <span style="color: #ccc">|</span>
                    <asp:LinkButton ID="btnSetInUse" runat="server" CssClass="btn btn-success" OnClick="btnSetInUse_Click" OnClientClick="return confirm('确认将所选防伪码标记为使用中？')">把所选设置为使用中</asp:LinkButton>
                
                    <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-info" OnClick="btnExport_Click">导出 Excel</asp:LinkButton>
                    <span style="color: #ccc">|</span>
                    <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-refresh" OnClientClick="window.location.href=window.location.href;return false;">刷新</asp:LinkButton>
                
              
                    是否导出excel:<asp:DropDownList ID="ddlIsExcel" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_Changed">
                        <asp:ListItem Text="全部" Value="" />
                        <asp:ListItem Text="是" Value="true" />
                        <asp:ListItem Text="否" Value="false" />
                    </asp:DropDownList>
                   是否使用中: <asp:DropDownList ID="ddlIsInUse" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_Changed">
                        <asp:ListItem Text="全部" Value="" />
                        <asp:ListItem Text="是" Value="true" />
                        <asp:ListItem Text="否" Value="false" />
                    </asp:DropDownList>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="搜索防伪码" />
                    <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="btn btn-primary btn-sm" OnClick="btnSearch_Click" />
                </div>
           </div>

            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th class="cb-col">
                                <input type="checkbox" id="chkAll" onclick="toggleAll(this)" /></th>
                            <th style="width: 50px">序号</th>

                            <th>防伪码</th>
                            <th>是否导出excel</th>
                            <th>是否使用中</th>
                            <%--       <th>产品名称</th>
                            <th>批次号</th>
                            <th>生产厂家</th>--%>
                            <%--  <th>可查次数</th>--%>
                            <th>已查次数</th>
                            <th>状态</th>
                            <th>生成时间</th>
                            <th>操作</th>
                            <th>ID</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptList" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="cb-col">
                                        <input type="checkbox" class="cb-item" value='<%# Eval("Id") %>' /></td>
                                    <td><%# Eval("RowNumber") %></td>

                                    <td class="code-mono"><strong><%# Eval("AntiCode") %></strong></td>
                                    <td>
                                        <span class="status <%# Convert.ToBoolean(Eval("IsExcel")) ? "status-inactive" : "status-active" %>">
                                            <%# Convert.ToBoolean(Eval("IsExcel")) ? "是" : "否" %>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="status <%# Convert.ToBoolean(Eval("IsInUse")) ? "status-inactive" : "status-active" %>">
                                            <%# Convert.ToBoolean(Eval("IsInUse")) ? "是" : "否" %>
                                        </span>
                                    </td>
                                    <%--    <td><%# Eval("ProductName") %></td>
                                    <td><%# Eval("BatchNo") %></td>
                                    <td><%# Eval("Factory") %></td>--%>
                                    <%--      <td><%# Eval("MaxQueryTimes") %></td>--%>
                                    <td><%# Eval("QueryCount") %></td>
                                    <td>
                                        <span class="status <%# Convert.ToBoolean(Eval("IsInvalid")) ? "status-inactive" : "status-active" %>">
                                            <%# Convert.ToBoolean(Eval("IsInvalid")) ? "已作废" : "有效" %>
                                        </span>
                                    </td>
                                    <td><%# Eval("CreateTime", "{0:yyyy-MM-dd HH:mm}") %></td>
                                    <td class="action">
                                        <asp:LinkButton ID="btnEdit" runat="server" Text="编辑" OnClick="btnEdit_Click" CommandArgument='<%# Eval("Id") %>' />
                                        <asp:LinkButton ID="btnToggle" runat="server"
                                            Text='<%# Convert.ToBoolean(Eval("IsInvalid")) ? "恢复" : "作废" %>'
                                            OnClick="btnToggle_Click"
                                            CommandArgument='<%# Eval("Id") + "," + Eval("IsInvalid") %>'
                                            OnClientClick="return confirm('确认操作？')" />
                                        <asp:LinkButton ID="btnDelete" runat="server" Text="删除"
                                            OnClick="btnDelete_Click"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick="return confirm('确定删除该防伪码？')" />
                                    </td>
                                    <td><%# Eval("Id") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:Literal ID="ltlEmpty" runat="server" />
                    </tbody>
                </table>

                <div class="pagination">
                    <div class="info">
                        共 <strong>
                            <asp:Literal ID="ltlTotal" runat="server" Text="0" /></strong> 条记录
                       
                        <asp:HiddenField ID="hfSelectedIds" runat="server" />
                    </div>
                    <div class="pages">
                        <asp:LinkButton ID="btnFirst" runat="server" Text="首页" OnClick="btnPage_Click" CommandArgument="First" />
                        <asp:LinkButton ID="btnPrev" runat="server" Text="上一页" OnClick="btnPage_Click" CommandArgument="Prev" />
                        <asp:Repeater ID="rptPager" runat="server" OnItemCommand="rptPager_ItemCommand">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnPageNum" runat="server"
                                    Text='<%# Eval("Text") %>'
                                    CommandArgument='<%# Eval("Value") %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("IsCurrent")) ? "current" : "" %>'
                                    Enabled='<%# !Convert.ToBoolean(Eval("IsCurrent")) %>' />
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:LinkButton ID="btnNext" runat="server" Text="下一页" OnClick="btnPage_Click" CommandArgument="Next" />
                        <asp:LinkButton ID="btnLast" runat="server" Text="末页" OnClick="btnPage_Click" CommandArgument="Last" />
                        <span style="margin-left: 8px">每页
                           
                            <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_Changed">
                                <asp:ListItem Text="10" Value="10" />
                                <asp:ListItem Text="20" Value="20" />
                                <asp:ListItem Text="50" Value="50" />
                                <asp:ListItem Text="100" Value="100" />
                            </asp:DropDownList>
                            条
                        </span>
                    </div>
                </div>
            </div>

            <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="form-panel">
                <h3>
                    <asp:Literal ID="ltlFormTitle" runat="server" Text="生成防伪码" /></h3>
                <asp:HiddenField ID="hfId" runat="server" Value="0" />

                <div class="form-row">
                    <div class="form-group" style="flex: 0 0 300px">
                        <label>防伪码（16位数字）</label>
                        <asp:TextBox ID="txtAntiCode" runat="server" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <label>产品名称 <span class="required">*</span></label>
                        <asp:TextBox ID="txtProductName" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>批次号</label>
                        <asp:TextBox ID="txtBatchNo" runat="server" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>生产厂家</label>
                        <asp:TextBox ID="txtFactory" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>最大可查次数</label>
                        <asp:DropDownList ID="ddlMaxTimes" runat="server">
                            <asp:ListItem Text="1 次" Value="1" Selected="True" />
                            <asp:ListItem Text="3 次" Value="3" />
                            <asp:ListItem Text="5 次" Value="5" />
                            <asp:ListItem Text="10 次" Value="10" />
                            <asp:ListItem Text="不限" Value="99" />
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <div class="checkbox-group" style="padding-top: 8px">
                            <label>
                                <asp:CheckBox ID="chkInvalid" runat="server" />
                                直接作废</label>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <asp:Button ID="btnCancelForm" runat="server" Text="取消" CssClass="btn-cancel" OnClick="btnCancelForm_Click" />
                    <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn-submit" OnClick="btnSave_Click" />
                </div>
            </asp:Panel>
        </div>
    </form>

    <script>
        function toggleAll(source) {
            var items = document.querySelectorAll('.cb-item');
            for (var i = 0; i < items.length; i++) {
                items[i].checked = source.checked;
            }
            updateSelectedIds();
        }
        function updateSelectedIds() {
            var ids = [];
            var items = document.querySelectorAll('.cb-item:checked');
            for (var i = 0; i < items.length; i++) {
                ids.push(items[i].value);
            }
            document.getElementById('<%= hfSelectedIds.ClientID %>').value = ids.join(',');
        }
        document.addEventListener('change', function (e) {
            if (e.target && e.target.classList.contains('cb-item')) {
                updateSelectedIds();
                var all = document.querySelectorAll('.cb-item');
                var checked = document.querySelectorAll('.cb-item:checked');
                document.getElementById('chkAll').checked = all.length > 0 && all.length === checked.length;
            }
        });
    </script>
</body>
</html>
