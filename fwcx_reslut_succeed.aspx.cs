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
    public partial class fwcx_reslut_succeed : System.Web.UI.Page
    {
        public string anticode = "";
        public string queryLogHtml = "";
        public int queryCount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            anticode = DataValiCheck.GetQueryString("anticode", true);

            if (!string.IsNullOrEmpty(anticode) && anticode.Length == 16)
            {
                var product = ProductAntiFakeBLL.GetByAntiCode(anticode);
                if (product != null)
                {
                    queryCount = AntiFakeQueryLogBLL.GetCountByAntiCode(anticode);
                    var logs = AntiFakeQueryLogBLL.GetByAntiCode(anticode);
                    var logList = logs.OrderBy(l => l.QueryTime).ToList();

                    for (int i = 0; i < logList.Count; i++)
                    {
                        string line;
                        if (i == 0)
                        {
                            line = string.Format("{0}, 首次查询。查询方式：二维码查询",
                                ((DateTime)logList[i].QueryTime).ToString("yyyy年MM月dd日 HH时mm分ss秒")); 
                        }
                        else
                        {
                            line = string.Format("{0}, 第{1}次查询。查询方式：二维码查询",
                                ((DateTime)logList[i].QueryTime).ToString("yyyy年MM月dd日 HH时mm分ss秒"), i + 1);
                        }
                        if (i == logList.Count - 1)
                        {
                            queryLogHtml += "<span style=\"color: red;\">" + line + "</span>";
                        }
                        else
                        {
                            queryLogHtml += line + "<br data-filtered=\"filtered\">";
                        }
                    }

                    if (logList.Count == 0)
                    {
                        queryLogHtml = "<span style=\"color: red;\">暂无查询记录</span>";
                    }
                }
            }
        }
    }
}