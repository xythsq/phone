using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WapCoovee.BAL;
using WapCoovee.Common;
using WapCoovee.Entity;

namespace WapCoovee
{
    public partial class fwcx_reslut : System.Web.UI.Page
    {
        public string anticode = "";
        public string message = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            anticode = DataValiCheck.GetQueryString("anticode", true);

            if (!string.IsNullOrEmpty(anticode) && anticode.Length == 16)
            {
                var product = ProductAntiFakeBLL.GetByAntiCode(anticode);
                if (product != null && !product.IsInvalid)
                {
                    AntiFakeQueryLog_entity log = new AntiFakeQueryLog_entity
                    {
                        AntiCode = anticode,
                        QueryIp = Request.UserHostAddress,
                        QueryTime = DateTime.Now,
                        QueryDevice = Request.UserAgent
                    };
                    AntiFakeQueryLogBLL.Add(log);

                    Response.Redirect("/fwcx_reslut_succeed.aspx?anticode=" + anticode);
                }
                else if (product != null && product.IsInvalid)
                {
                    message = "该防伪码已被作废，请谨防假冒！";
                }
                else
                {
                    message = "该编码错误，请谨防假冒！";
                }
            }
            else
            {
                message = "请输入正确的16位防伪码";
            }
        }
    }
}