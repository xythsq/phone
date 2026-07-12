using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WapCoovee.BAL;
using WapCoovee.Entity;

namespace WapCoovee.Admin
{
    public partial class UserManage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                BindUserList();
            }
        }

        private void BindUserList(string keyword = "")
        {
            List<tblAdminUser_entity> list;
            if (!string.IsNullOrWhiteSpace(keyword))
            {
                list = AdminUserBLL.GetAll()
                    .Where(u => u.UserAccount.IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0
                             || (u.UserName ?? "").IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0)
                    .ToList();
            }
            else
            {
                list = AdminUserBLL.GetAll();
            }
            rptUsers.DataSource = list;
            rptUsers.DataBind();
            if (list.Count == 0)
                ltlEmpty.Text = "<tr class=\"empty-row\"><td colspan=\"11\">暂无数据</td></tr>";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindUserList(txtSearch.Text.Trim());
        }

        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            ClearForm();
            ltlFormTitle.Text = "添加用户";
            hfUserID.Value = "0";
            pnlForm.Visible = true;
        }

        protected void btnCancelForm_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int userID = string.IsNullOrEmpty(hfUserID.Value) ? 0 : Convert.ToInt32(hfUserID.Value);
            string account = txtAccount.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(account))
            {
                ShowMessage("请输入账号", false);
                return;
            }

            if (userID == 0)
            {
                if (AdminUserBLL.IsAccountExists(account))
                {
                    ShowMessage("账号已存在", false);
                    return;
                }
                if (string.IsNullOrEmpty(password))
                {
                    ShowMessage("请输入密码", false);
                    return;
                }

                tblAdminUser_entity obj = NewEntityFromForm();
                obj.UserPassword = password;
                obj.CreateTime = DateTime.Now;
                AdminUserBLL.Add(obj);
                ShowMessage("添加成功", true);
                pnlForm.Visible = false;
            }
            else
            {
                tblAdminUser_entity obj = AdminUserBLL.GetByUserID(userID);
                if (obj == null)
                {
                    ShowMessage("用户不存在", false);
                    return;
                }

                obj.UserAccount = account;
                if (!string.IsNullOrEmpty(password))
                    obj.UserPassword = password;
                obj.UserName = string.IsNullOrEmpty(txtUserName.Text.Trim()) ? null : txtUserName.Text.Trim();
                //obj.EmployeeID = ParseInt(txtEmployeeID.Text.Trim());
                //obj.CustomerID = ParseInt(txtCustomerID.Text.Trim());
                //obj.SupplierID = ParseInt(txtSupplierID.Text.Trim());
                //obj.LogInCustomerport = chkCustomerPort.Checked;
                //obj.LogInSupplierport = chkSupplierPort.Checked;
                //obj.LogInSubcontractport = chkSubcontractPort.Checked;
                //obj.UserIsEnabled = chkEnabled.Checked;
                //obj.MobileIsEnabled = chkMobileEnabled.Checked;
                //obj.UserType = ParseInt(ddlUserType.SelectedValue);

                AdminUserBLL.Update(obj);
                ShowMessage("更新成功", true);
                pnlForm.Visible = false;
            }

            BindUserList();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int userID = Convert.ToInt32(btn.CommandArgument);
            tblAdminUser_entity obj = AdminUserBLL.GetByUserID(userID);
            if (obj != null)
            {
                hfUserID.Value = obj.UserID.ToString();
                txtAccount.Text = obj.UserAccount;
                txtPassword.Text = obj.UserPassword;
                txtUserName.Text = obj.UserName ?? "";
                //txtEmployeeID.Text = obj.EmployeeID?.ToString() ?? "";
                //txtCustomerID.Text = obj.CustomerID?.ToString() ?? "";
                //txtSupplierID.Text = obj.SupplierID?.ToString() ?? "";
                //chkCustomerPort.Checked = obj.LogInCustomerport ?? false;
                //chkSupplierPort.Checked = obj.LogInSupplierport ?? false;
                //chkSubcontractPort.Checked = obj.LogInSubcontractport ?? false;
                //chkEnabled.Checked = obj.UserIsEnabled ?? true;
                //chkMobileEnabled.Checked = obj.MobileIsEnabled ?? false;
                //ddlUserType.SelectedValue = obj.UserType?.ToString() ?? "";

                ltlFormTitle.Text = "编辑用户 - " + obj.UserAccount;
                pnlForm.Visible = true;
            }
        }

        protected void btnToggle_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string[] args = btn.CommandArgument.Split(',');
            int userID = Convert.ToInt32(args[0]);
            bool currentStatus = Convert.ToBoolean(args[1]);
            AdminUserBLL.SetEnabled(userID, !currentStatus);
            BindUserList();
            ShowMessage("状态已更新", true);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int userID = Convert.ToInt32(btn.CommandArgument);
            AdminUserBLL.Delete(userID);
            BindUserList();
            ShowMessage("已删除", true);
        }

        private tblAdminUser_entity NewEntityFromForm()
        {
            tblAdminUser_entity obj = new tblAdminUser_entity();
            obj.UserAccount = txtAccount.Text.Trim();
            obj.UserName = string.IsNullOrEmpty(txtUserName.Text.Trim()) ? null : txtUserName.Text.Trim();
            //obj.EmployeeID = ParseInt(txtEmployeeID.Text.Trim());
            //obj.CustomerID = ParseInt(txtCustomerID.Text.Trim());
            //obj.SupplierID = ParseInt(txtSupplierID.Text.Trim());
            //obj.LogInCustomerport = chkCustomerPort.Checked;
            //obj.LogInSupplierport = chkSupplierPort.Checked;
            //obj.LogInSubcontractport = chkSubcontractPort.Checked;
            //obj.UserIsEnabled = chkEnabled.Checked;
            //obj.MobileIsEnabled = chkMobileEnabled.Checked;
            //obj.UserType = ParseInt(ddlUserType.SelectedValue);
            return obj;
        }

        private void ClearForm()
        {
            txtAccount.Text = "";
            txtPassword.Text = "";
            txtUserName.Text = "";
            //txtEmployeeID.Text = "";
            //txtCustomerID.Text = "";
            //txtSupplierID.Text = "";
            //chkCustomerPort.Checked = false;
            //chkSupplierPort.Checked = false;
            //chkSubcontractPort.Checked = false;
            //chkEnabled.Checked = true;
            //chkMobileEnabled.Checked = false;
            //ddlUserType.SelectedIndex = 0;
        }

        private int? ParseInt(string val)
        {
            if (string.IsNullOrEmpty(val)) return null;
            if (int.TryParse(val, out int result)) return result;
            return null;
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            pnlMessage.CssClass = "msg-bar " + (isSuccess ? "success" : "error");
            pnlMessage.Visible = true;
            ltlMessage.Text = msg;
        }
    }
}
