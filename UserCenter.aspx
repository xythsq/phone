<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserCenter.aspx.cs" Inherits="WapCoovee.Admin.UserCenter" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>用户中心 - 后台管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Microsoft YaHei", "微软雅黑", Arial, sans-serif; }
        body { background: #f0f2f5; font-size: 14px; color: #333; overflow: hidden; }

        /* ===== Header ===== */
        .header { position: fixed; top: 0; left: 0; right: 0; height: 56px; background: #1a1a2e; color: #fff; display: flex; align-items: center; justify-content: space-between; padding: 0 24px; z-index: 1000; box-shadow: 0 2px 8px rgba(0,0,0,0.15); }
        .header .logo { font-size: 20px; font-weight: bold; display: flex; align-items: center; gap: 12px; }
        .header .logo span { color: #e94560; }
        .header .logo .toggle-sidebar { font-size: 20px; cursor: pointer; padding: 4px 8px; border-radius: 4px; user-select: none; }
        .header .logo .toggle-sidebar:hover { background: rgba(255,255,255,0.1); }
        .header .user-info { display: flex; align-items: center; gap: 16px; font-size: 13px; }
        .header .user-info .avatar { width: 32px; height: 32px; border-radius: 50%; background: #e94560; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: bold; color: #fff; }
        .header .user-info .btn-link { color: rgba(255,255,255,0.7); text-decoration: none; cursor: pointer; background: none; border: none; font-size: 13px; padding: 0; }
        .header .user-info .btn-link:hover { color: #e94560; }

        /* ===== Layout ===== */
        .layout { display: flex; margin-top: 56px; height: calc(100vh - 56px); }

        /* ===== Sidebar ===== */
        .sidebar { width: 220px; background: #1e1e3a; color: #fff; flex-shrink: 0; overflow-y: auto; transition: width 0.3s; }
        .sidebar.collapsed { width: 0; overflow: hidden; }
        .sidebar .menu-group { padding: 0; }
        .sidebar .menu-group .group-title { padding: 20px 20px 8px; font-size: 11px; text-transform: uppercase; color: rgba(255,255,255,0.35); letter-spacing: 1px; }
        .sidebar .menu-item { display: flex; align-items: center; gap: 10px; padding: 12px 20px; cursor: pointer; color: rgba(255,255,255,0.65); text-decoration: none; font-size: 14px; transition: all 0.2s; border-left: 3px solid transparent; background: none; border-top: none; border-right: none; border-bottom: none; width: 100%; text-align: left; }
        .sidebar .menu-item:hover { background: rgba(255,255,255,0.06); color: #fff; }
        .sidebar .menu-item.active { background: rgba(233,69,96,0.15); color: #e94560; border-left-color: #e94560; }
        .sidebar .menu-item .icon { width: 20px; text-align: center; font-size: 16px; }

        /* ===== Main Content ===== */
        .main-content { flex: 1; display: flex; flex-direction: column; overflow: hidden; min-width: 0; }

        /* ===== Tab Bar ===== */
        .tab-bar { display: flex; background: #f5f5f5; border-bottom: 1px solid #d8d8d8; flex-shrink: 0; overflow: hidden; box-shadow: 0 1px 2px rgba(0,0,0,0.04); }
        .tab-bar .tab-list { display: flex; overflow-x: auto; flex: 1; }
        .tab-bar .tab-list::-webkit-scrollbar { height: 3px; }
        .tab-bar .tab-list::-webkit-scrollbar-thumb { background: #ccc; border-radius: 2px; }
        .tab-bar .tab-item { display: flex; align-items: center; gap: 6px; padding: 8px 16px; cursor: pointer; font-size: 12px; color: #666; background: #eee; border-right: 1px solid #d8d8d8; white-space: nowrap; user-select: none; transition: all 0.15s; min-width: 0; position: relative; }
        .tab-bar .tab-item:hover { color: #333; background: #e5e5e5; }
        .tab-bar .tab-item.active { color: #1a1a2e; background: #fff; font-weight: 600; border-bottom: 2px solid #e94560; margin-bottom: -1px; }
        .tab-bar .tab-item .tab-title { overflow: hidden; text-overflow: ellipsis; max-width: 140px; }
        .tab-bar .tab-item .tab-pin { font-size: 10px; color: #e94560; }
        .tab-bar .tab-item .tab-close { font-size: 14px; color: #bbb; padding: 0 2px; border-radius: 2px; visibility: hidden; }
        .tab-bar .tab-item:hover .tab-close { visibility: visible; }
        .tab-bar .tab-item.active .tab-close { visibility: visible; }
        .tab-bar .tab-item .tab-close:hover { color: #e94560; background: rgba(233,69,96,0.1); }
        .tab-bar .tab-actions { display: flex; align-items: center; padding: 0 8px; gap: 4px; border-left: 1px solid #d8d8d8; background: #f5f5f5; }
        .tab-bar .tab-actions button { background: none; border: none; cursor: pointer; padding: 4px 6px; border-radius: 3px; font-size: 13px; color: #888; }
        .tab-bar .tab-actions button:hover { background: #ddd; color: #333; }

        /* ===== Tab Content ===== */
        .tab-content { flex: 1; position: relative; background: #f0f2f5; }
        .tab-pane { display: none; width: 100%; height: 100%; overflow: auto; padding: 24px; }
        .tab-pane.active { display: block; }
        .tab-pane iframe { width: 100%; height: 100%; border: none; }

        /* ===== Card / Info ===== */
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,0.08); padding: 30px; max-width: 640px; }
        .info-row { display: flex; padding: 14px 0; border-bottom: 1px solid #f0f0f0; }
        .info-row:last-child { border-bottom: none; }
        .info-row .label { width: 120px; font-weight: 600; color: #666; flex-shrink: 0; }
        .info-row .value { color: #333; }

        /* ===== Forms ===== */
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: #555; margin-bottom: 6px; }
        .form-group input { width: 100%; max-width: 360px; padding: 9px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; outline: none; }
        .form-group input:focus { border-color: #e94560; box-shadow: 0 0 0 2px rgba(233,69,96,0.15); }

        /* ===== Buttons ===== */
        .btn { display: inline-block; padding: 8px 24px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; }
        .btn-primary { background: #e94560; color: #fff; }
        .btn-primary:hover { background: #d63851; }
        .btn-default { background: #fff; color: #555; border: 1px solid #ddd; }
        .btn-default:hover { background: #f5f5f5; }
        .actions { margin-top: 24px; display: flex; gap: 10px; }

        /* ===== Message ===== */
        .msg-bar { padding: 10px 16px; border-radius: 4px; margin-bottom: 16px; font-size: 13px; }
        .msg-bar.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .msg-bar.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        .section-title { font-size: 18px; font-weight: bold; color: #1a1a2e; margin-bottom: 20px; }

        /* ===== Context Menu ===== */
        .ctx-menu { display: none; position: fixed; background: #fff; border-radius: 6px; box-shadow: 0 4px 16px rgba(0,0,0,0.15); padding: 4px 0; z-index: 2000; min-width: 140px; }
        .ctx-menu .ctx-item { padding: 8px 16px; cursor: pointer; font-size: 13px; color: #333; display: flex; align-items: center; gap: 8px; }
        .ctx-menu .ctx-item:hover { background: #f0f2f5; }
        .ctx-menu .ctx-divider { height: 1px; background: #eee; margin: 4px 0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- ===== Header ===== -->
        <div class="header">
            <div class="logo">
                <span class="toggle-sidebar" onclick="toggleSidebar()">☰</span>
                <span>Admin</span> <span style="font-weight:normal;font-size:13px;color:rgba(255,255,255,0.5)">| 后台管理</span>
            </div>
            <div class="user-info">
                <div class="avatar"><asp:Literal ID="ltlAvatar" runat="server" /></div>
                <span style="color:rgba(255,255,255,0.8)"><asp:Literal ID="ltlHeaderUser" runat="server" /></span>
                <asp:LinkButton ID="btnLogout" runat="server" Text="退出" CssClass="btn-link" OnClick="btnLogout_Click" OnClientClick="return confirm('确认退出登录？')" />
            </div>
        </div>

        <!-- ===== Layout ===== -->
        <div class="layout">

            <!-- ===== Sidebar ===== -->
            <div class="sidebar" id="sidebar">
                <div class="menu-group">
                    <div class="group-title">导航菜单</div>
                    <button class="menu-item active" onclick="openTab('profile','用户中心',null,true)"><span class="icon">👤</span> 用户中心</button>
                 <%--   <button class="menu-item" onclick="openTab('password','修改密码',null,true)"><span class="icon">🔒</span> 修改密码</button>--%>
                </div>
                <div class="menu-group">
                    <div class="group-title">功能管理</div>
                    <button class="menu-item" onclick="openTab('antifake','防伪码管理','<%= ResolveUrl("~/Admin/AntiFakeManage.aspx") %>',false)"><span class="icon">📋</span> 防伪码管理</button>
                    <button class="menu-item" onclick="openTab('usermgr','用户管理','<%= ResolveUrl("~/Admin/UserManage.aspx") %>',false)"><span class="icon">👥</span> 用户管理</button>
                </div>
                <div class="menu-group">
                    <div class="group-title">系统</div>
                    <button class="menu-item" onclick="if(confirm('确认退出登录？'))location='Login.aspx'"><span class="icon">🚪</span> 退出登录</button>
                </div>
            </div>

            <!-- ===== Main Content ===== -->
            <div class="main-content">

                <!-- Tab Bar -->
                <div class="tab-bar" id="tabBar">
                    <div class="tab-list" id="tabList"></div>
                    <div class="tab-actions">
                        <button title="刷新当前页" onclick="refreshCurrentTab()">↻</button>
                    </div>
                </div>

                <!-- Content Area -->
                <div class="tab-content" id="tabContent">

                    <!-- ===== Inline: 用户中心 ===== -->
                    <div class="tab-pane" id="pane-profile" data-tab="profile">
                        <div class="section-title">用户中心</div>
                        <div class="card">
                            <div class="info-row"><div class="label">用户ID</div><div class="value"><asp:Literal ID="ltlUserID" runat="server" /></div></div>
                            <div class="info-row"><div class="label">账号</div><div class="value"><asp:Literal ID="ltlAccount" runat="server" /></div></div>
                            <div class="info-row"><div class="label">姓名</div><div class="value"><asp:Literal ID="ltlUserName" runat="server" /></div></div>
                            <div class="info-row"><div class="label">创建时间</div><div class="value"><asp:Literal ID="ltlCreateTime" runat="server" /></div></div>
                            <div class="info-row"><div class="label">状态</div><div class="value"><asp:Literal ID="ltlStatus" runat="server" /></div></div>
                        </div>
                    </div>

                    <!-- ===== Inline: 修改密码 ===== -->
                    <div class="tab-pane" id="pane-password" data-tab="password">
                        <div class="section-title">修改密码</div>
                        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="msg-bar">
                            <asp:Literal ID="ltlMessage" runat="server" />
                        </asp:Panel>
                        <div class="card">
                            <div class="form-group">
                                <label>原密码</label>
                                <asp:TextBox ID="txtOldPwd" runat="server" TextMode="Password" placeholder="请输入原密码" />
                            </div>
                            <div class="form-group">
                                <label>新密码</label>
                                <asp:TextBox ID="txtNewPwd" runat="server" TextMode="Password" placeholder="请输入新密码" />
                            </div>
                            <div class="form-group">
                                <label>确认新密码</label>
                                <asp:TextBox ID="txtConfirmPwd" runat="server" TextMode="Password" placeholder="请再次输入新密码" />
                            </div>
                            <div class="actions">
                                <asp:Button ID="btnChangePwd" runat="server" Text="保存修改" CssClass="btn btn-primary" OnClick="btnChangePwd_Click" />
                                <asp:Button ID="btnResetPwd" runat="server" Text="重置" CssClass="btn btn-default" OnClick="btnResetPwd_Click" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- ===== Context Menu ===== -->
        <div class="ctx-menu" id="ctxMenu">
            <div class="ctx-item" id="ctxRefresh" onclick="ctxRefresh()">↻ 刷新</div>
            <div class="ctx-item" id="ctxPin" onclick="ctxTogglePin()">📌 固定</div>
            <div class="ctx-divider"></div>
            <div class="ctx-item" id="ctxClose" onclick="ctxClose()">✕ 关闭</div>
            <div class="ctx-item" id="ctxCloseOthers" onclick="ctxCloseOthers()">✕ 关闭其他</div>
            <div class="ctx-item" id="ctxCloseAll" onclick="ctxCloseAll()">✕ 关闭全部</div>
        </div>

        <asp:HiddenField ID="hfActiveTab" runat="server" Value="profile" />
        <asp:HiddenField ID="hfOpenTabs" runat="server" Value="" />
    </form>

    <script>
        // ===== Tab Manager =====
        var tabManager = {
            tabs: [],
            activeId: null,
            ctxTabId: null,
            counter: 0,

            definitions: {
                'profile': { id:'profile', title:'用户中心', type:'inline', pinned:true, paneId:'pane-profile' },
                'password': { id:'password', title:'修改密码', type:'inline', pinned:true, paneId:'pane-password' }
            },

            open: function(id, title, url, pinned) {
                var existing = this.tabs.find(function(t) { return t.id === id; });
                if (existing) {
                    this.activate(id);
                    return;
                }

                var def = this.definitions[id];
                if (def) {
                    this.tabs.push({
                        id: def.id, title: def.title, type: def.type,
                        pinned: def.pinned, paneId: def.paneId, url: null
                    });
                    this.saveState();
                    this.render();
                    this.activate(id);
                    this.saveState();
                    return;
                }

                var tabId = id || ('tab-' + (++this.counter));
                var paneId = 'pane-' + tabId;
                var content = document.getElementById('tabContent');
                var pane = document.createElement('div');
                pane.className = 'tab-pane';
                pane.id = paneId;
                pane.setAttribute('data-tab', tabId);
                var iframe = document.createElement('iframe');
                iframe.src = url;
                iframe.setAttribute('frameborder', '0');
                pane.appendChild(iframe);
                content.appendChild(pane);

                this.tabs.push({
                    id: tabId, title: title || tabId, type: 'iframe',
                    pinned: !!pinned, paneId: paneId, url: url
                });
                this.saveState();
                this.render();
                this.activate(tabId);
                this.saveState();
            },

            activate: function(id) {
                this.activeId = id;
                var self = this;

                document.querySelectorAll('.tab-item').forEach(function(el) {
                    el.classList.toggle('active', el.getAttribute('data-tab') === id);
                });

                document.querySelectorAll('.sidebar .menu-item').forEach(function(el) {
                    el.classList.remove('active');
                    var onclick = el.getAttribute('onclick') || '';
                    if (onclick.indexOf("'"+id+"'") > -1 || onclick.indexOf('"'+id+'"') > -1) {
                        el.classList.add('active');
                    }
                });

                document.querySelectorAll('.tab-pane').forEach(function(el) {
                    el.classList.toggle('active', el.getAttribute('data-tab') === id);
                });

                var activeTab = document.querySelector('.tab-item.active');
                if (activeTab) {
                    activeTab.scrollIntoView({ behavior: 'smooth', inline: 'nearest', block: 'nearest' });
                }

                document.getElementById('<%= hfActiveTab.ClientID %>').value = id;
                this.saveState();
            },

            close: function(id) {
                var idx = -1;
                for (var i = 0; i < this.tabs.length; i++) {
                    if (this.tabs[i].id === id) { idx = i; break; }
                }
                if (idx === -1) return;
                var tab = this.tabs[idx];
                if (tab.pinned) return;

                this.tabs.splice(idx, 1);

                if (tab.type === 'iframe') {
                    var pane = document.getElementById(tab.paneId);
                    if (pane) pane.remove();
                }

                if (this.activeId === id) {
                    var next = this.tabs.length > 0
                        ? this.tabs[Math.min(idx, this.tabs.length - 1)]
                        : null;
                    if (next) {
                        this.activate(next.id);
                    } else {
                        this.open('profile', '用户中心', null, true);
                    }
                }
                this.saveState();
                this.render();
            },

            closeOthers: function(id) {
                var self = this;
                var toRemove = [];
                this.tabs.forEach(function(t) {
                    if (t.id !== id && !t.pinned) toRemove.push(t.id);
                });
                toRemove.forEach(function(tid) { self.close(tid); });
            },

            closeAll: function() {
                var self = this;
                var toRemove = [];
                this.tabs.forEach(function(t) { if (!t.pinned) toRemove.push(t.id); });
                toRemove.forEach(function(tid) { self.close(tid); });
            },

            refresh: function(id) {
                var tab = this.tabs.find(function(t) { return t.id === id; });
                if (!tab) return;
                if (tab.type === 'iframe') {
                    var iframe = document.querySelector('#' + tab.paneId + ' iframe');
                    if (iframe) iframe.src = iframe.src;
                } else if (tab.type === 'inline') {
                    var pane = document.getElementById(tab.paneId);
                    if (pane) {
                        pane.style.display = 'none';
                        setTimeout(function() { pane.style.display = ''; }, 10);
                    }
                }
            },

            togglePin: function(id) {
                var tab = this.tabs.find(function(t) { return t.id === id; });
                if (!tab) return;
                tab.pinned = !tab.pinned;
                this.saveState();
                this.render();
            },

            render: function() {
                var list = document.getElementById('tabList');
                list.innerHTML = '';
                var self = this;
                this.tabs.forEach(function(tab) {
                    var el = document.createElement('div');
                    el.className = 'tab-item' + (tab.id === self.activeId ? ' active' : '');
                    el.setAttribute('data-tab', tab.id);
                    el.setAttribute('data-pinned', tab.pinned ? '1' : '0');

                    if (tab.pinned) {
                        el.innerHTML = '<span class="tab-pin">📌</span><span class="tab-title">' + tab.title + '</span>';
                    } else {
                        el.innerHTML = '<span class="tab-title">' + tab.title + '</span><span class="tab-close" onclick="event.stopPropagation();tabManager.close(\'' + tab.id + '\')">✕</span>';
                    }

                    el.addEventListener('click', function() { self.activate(tab.id); });
                    el.addEventListener('dblclick', function() { self.refresh(tab.id); });
                    el.addEventListener('contextmenu', function(e) {
                        e.preventDefault();
                        self.ctxTabId = tab.id;
                        self.showContextMenu(e.clientX, e.clientY, tab);
                    });

                    list.appendChild(el);
                });
            },

            saveState: function() {
                var data = this.tabs.map(function(t) {
                    return { id: t.id, title: t.title, type: t.type, pinned: t.pinned, url: t.url };
                });
                document.getElementById('<%= hfOpenTabs.ClientID %>').value = JSON.stringify(data);
            },

            restoreState: function(savedJson, activeId) {
                var self = this;
                if (savedJson) {
                    try {
                        var savedTabs = JSON.parse(savedJson);
                        savedTabs.forEach(function(st) {
                            var def = self.definitions[st.id];
                            if (def) {
                                self.tabs.push({
                                    id: def.id, title: def.title, type: def.type,
                                    pinned: def.pinned, paneId: def.paneId, url: null
                                });
                            } else if (st.type === 'iframe' && st.url) {
                                var tabId = st.id;
                                var paneId = 'pane-' + tabId;
                                var content = document.getElementById('tabContent');
                                // Check if pane already exists
                                if (!document.getElementById(paneId)) {
                                    var pane = document.createElement('div');
                                    pane.className = 'tab-pane';
                                    pane.id = paneId;
                                    pane.setAttribute('data-tab', tabId);
                                    var iframe = document.createElement('iframe');
                                    iframe.src = st.url;
                                    iframe.setAttribute('frameborder', '0');
                                    pane.appendChild(iframe);
                                    content.appendChild(pane);
                                }
                                self.tabs.push({
                                    id: tabId, title: st.title, type: 'iframe',
                                    pinned: !!st.pinned, paneId: paneId, url: st.url
                                });
                            }
                        });
                    } catch(e) {}
                }
                // Ensure profile is always first
                if (!this.tabs.find(function(t) { return t.id === 'profile'; })) {
                    var def = this.definitions['profile'];
                    this.tabs.unshift({
                        id: def.id, title: def.title, type: def.type,
                        pinned: def.pinned, paneId: def.paneId, url: null
                    });
                }
                this.render();
                if (activeId) {
                    this.activate(activeId);
                } else if (this.tabs.length > 0) {
                    this.activate(this.tabs[0].id);
                }
            },

            showContextMenu: function(x, y, tab) {
                var menu = document.getElementById('ctxMenu');
                document.getElementById('ctxPin').textContent = tab.pinned ? '📌 取消固定' : '📌 固定';
                document.getElementById('ctxClose').style.display = tab.pinned ? 'none' : '';
                menu.style.display = 'block';
                menu.style.left = x + 'px';
                menu.style.top = y + 'px';
            },

            hideContextMenu: function() {
                document.getElementById('ctxMenu').style.display = 'none';
            }
        };

        function ctxRefresh() {
            if (tabManager.ctxTabId) tabManager.refresh(tabManager.ctxTabId);
            tabManager.hideContextMenu();
        }
        function ctxTogglePin() {
            if (tabManager.ctxTabId) tabManager.togglePin(tabManager.ctxTabId);
            tabManager.hideContextMenu();
        }
        function ctxClose() {
            if (tabManager.ctxTabId) tabManager.close(tabManager.ctxTabId);
            tabManager.hideContextMenu();
        }
        function ctxCloseOthers() {
            if (tabManager.ctxTabId) tabManager.closeOthers(tabManager.ctxTabId);
            tabManager.hideContextMenu();
        }
        function ctxCloseAll() {
            tabManager.closeAll();
            tabManager.hideContextMenu();
        }

        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        }

        function openTab(id, title, url, pinned) {
            tabManager.open(id, title, url, pinned);
        }

        function refreshCurrentTab() {
            if (tabManager.activeId) tabManager.refresh(tabManager.activeId);
        }

        document.addEventListener('click', function(e) {
            if (!e.target.closest('#ctxMenu')) {
                tabManager.hideContextMenu();
            }
        });

        // ===== Init =====
        (function() {
            var openTabs = document.getElementById('<%= hfOpenTabs.ClientID %>').value;
            var activeTab = document.getElementById('<%= hfActiveTab.ClientID %>').value;
            tabManager.restoreState(openTabs, activeTab);
        })();
    </script>
</body>
</html>
