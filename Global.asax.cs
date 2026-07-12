using FishWebLib;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using WapCoovee;

namespace WapCoovee
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            ConnectionStringSettings setting = ConfigurationManager.ConnectionStrings["con"];

            if (setting == null || string.IsNullOrEmpty(setting.ConnectionString))
                throw new Exception("没有设置连接字符串。");

            // 设置默认的数据库连接字符串。
            FishDbContext.Init(setting.ProviderName, "@", setting.ConnectionString);


            // 需要自动在调用存储过程后，取出将输出参数并赋值到调用对象的相关成员。
            FishDbContext.AutoGetSpOutputValues = true;

            // 设置在从数据库加载实体时，是否采用【严格】的加载模式，此时要求每个成员都能加载成功。默认值：true
            // 如果代码经常只需要加载实体成员的一部分成员，那么请启用下面的代码。
            FishWebLib.FishDbContext.StrictModeLoadItem = false;

      
        }

        void Application_End(object sender, EventArgs e)
        {
            //  在应用程序关闭时运行的代码

        }

        void Application_Error(object sender, EventArgs e)
        {
            // 在出现未处理的错误时运行的代码

        }
    }
}
