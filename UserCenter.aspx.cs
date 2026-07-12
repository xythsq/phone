using System;
using WapCoovee.BAL;
using WapCoovee.Entity;

namespace WapCoovee.Admin
{
    public partial class UserCenter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadUserHeader();
            }
        }

        private void LoadUserInfo()
        {
            int userId = (int)Session["AdminUserID"];
            tblAdminUser_entity user = AdminUserBLL.GetByUserID(userId);

            if (user == null)
            {
                Session.Clear();
                Response.Redirect("Login.aspx");
                return;
            }

            ltlUserID.Text = user.UserID.ToString();
            ltlAccount.Text = user.UserAccount;
            ltlUserName.Text = user.UserName ?? "-";
            ltlCreateTime.Text = user.CreateTime?.ToString("yyyy-MM-dd HH:mm") ?? "-";
            ltlStatus.Text = user.UserIsEnabled == true ? "启用" : "禁用";
        }

        private void LoadUserHeader()
        {
            string name = Session["AdminUserName"] as string ?? "Admin";
            ltlHeaderUser.Text = name;
            ltlAvatar.Text = name.Length > 0 ? name[0].ToString() : "A";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        protected void btnChangePwd_Click(object sender, EventArgs e)
        {
            string oldPwd = txtOldPwd.Text.Trim();
            string newPwd = txtNewPwd.Text.Trim();
            string confirmPwd = txtConfirmPwd.Text.Trim();

            if (string.IsNullOrEmpty(oldPwd) || string.IsNullOrEmpty(newPwd) || string.IsNullOrEmpty(confirmPwd))
            {
                ShowMessage("请填写完整密码信息", false);
                return;
            }

            if (newPwd != confirmPwd)
            {
                ShowMessage("两次输入的新密码不一致", false);
                return;
            }

            if (newPwd.Length < 4)
            {
                ShowMessage("新密码长度不能少于4位", false);
                return;
            }

            int userId = (int)Session["AdminUserID"];
            tblAdminUser_entity user = AdminUserBLL.GetByUserID(userId);

            if (user == null || user.UserPassword != oldPwd)
            {
                ShowMessage("原密码错误", false);
                return;
            }

            if (AdminUserBLL.ChangePassword(userId, newPwd))
            {
                ShowMessage("密码修改成功", true);
                txtOldPwd.Text = "";
                txtNewPwd.Text = "";
                txtConfirmPwd.Text = "";
            }
            else
            {
                ShowMessage("密码修改失败，请重试", false);
            }
        }

        protected void btnResetPwd_Click(object sender, EventArgs e)
        {
            txtOldPwd.Text = "";
            txtNewPwd.Text = "";
            txtConfirmPwd.Text = "";
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            pnlMessage.CssClass = "msg-bar " + (isSuccess ? "success" : "error");
            pnlMessage.Visible = true;
            ltlMessage.Text = msg;
        }
    }
}
