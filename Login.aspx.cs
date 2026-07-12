using System;
using System.Web;
using WapCoovee.BAL;
using WapCoovee.Entity;

namespace WapCoovee.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdminUserID"] != null)
                    Response.Redirect("UserCenter.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string account = txtAccount.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(account) || string.IsNullOrEmpty(password))
            {
                ShowMessage("请输入账号和密码", false);
                return;
            }

            tblAdminUser_entity user = AdminUserBLL.Login(account, password);

            if (user == null)
            {
                ShowMessage("账号或密码错误", false);
                return;
            }

            if (user.UserIsEnabled == false)
            {
                ShowMessage("该账号已被禁用", false);
                return;
            }

            Session["AdminUserID"] = user.UserID;
            Session["AdminUserAccount"] = user.UserAccount;
            Session["AdminUserName"] = user.UserName ?? user.UserAccount;

            Response.Redirect("UserCenter.aspx");
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            pnlMessage.CssClass = "msg-bar " + (isSuccess ? "success" : "error");
            pnlMessage.Visible = true;
            ltlMessage.Text = msg;
        }
    }
}
