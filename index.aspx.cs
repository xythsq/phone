using Coovee.UrlRewriter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using WapCoovee.BAL;
using WapCoovee.Common;
using WapCoovee.Entity;

namespace WapCoovee
{
    public partial class index : System.Web.UI.Page
    {
        public StringBuilder sb = new StringBuilder();
        public StringBuilder sb1 = new StringBuilder();
        public StringBuilder sbbshot = new StringBuilder();
        public StringBuilder sbbshot2 = new StringBuilder();
        public StringBuilder sbprhot = new StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {
           // XMLCommonUrls.IpRecord(XMLCommonUrls.GetuserOther());//ip记录
            //Databinder();
            //DataBinderSolr();

        }
        void DataBinderSolr()
        {

            string url = XMLCommonUrls.GetSolrAPI() + "/wap/typen.aspx?keyWord=*&pageSize=12&pageNo=1";
            //初始化一个xml实例
            XmlDocument xml = new XmlDocument();
            try
            {
                //导入指定xml文件
                xml.Load(url);

                DataBinderType(xml.SelectNodes("//WosoAdResultAll/WosoAdResultType/AdlistType/AdResult"));
            }
            catch { }
        }
        void DataBinderType(XmlNodeList list)
        {

            int i = 0;
            foreach (XmlNode node in list)
            {
                i++;
                if (i <= 6)
                {
                    sb.AppendFormat("<a href=\"{0}\">{1}</a>", SiteUrl.GetGyw(node.SelectNodes("url_all").Item(0).InnerText), node.SelectNodes("typename").Item(0).InnerText);
                }
                else
                {
                    sb1.AppendFormat("<li><a href=\"{0}\">{1}</a></li>", SiteUrl.GetGyw(node.SelectNodes("url_all").Item(0).InnerText), node.SelectNodes("typename").Item(0).InnerText);
                }
            }
        }
        void Databinder()
        {
            //List<qy_info_entity> list = AllBll.Getm_china_home_bshot(9);

            //foreach (qy_info_entity ls in list)
            //{
            //    sbbshot.AppendFormat("<a href=\"{0}\">", SiteUrl.GetGyid(ls.id));
            //    sbbshot.AppendFormat("<img src=\"{0}\" alt=\"{1}\">", XMLCommonUrls.GetAutoImgb(ls.pic_rule, ls.pic_web, ls.picture, "300x300", "biginfopic"), ls.allkeyword);
            //    sbbshot.AppendFormat("<p>{0}</p>", ls.showname);
            //    sbbshot.AppendFormat("<span>￥{0}</span>", ls.det_jg);
            //    sbbshot.Append("</a>");
            //}

            DataTable dt = AllBll.Getm_china_home_bshotsql(9);

            for (int i=0;i<dt.Rows.Count;i++)
            {
                sbbshot.AppendFormat("<a href=\"{0}\">", SiteUrl.GetGyid(Convert.ToInt32(dt.Rows[i]["id"].ToString())));
                sbbshot.AppendFormat("<img src=\"{0}\" alt=\"{1}\">", XMLCommonUrls.GetAutoImgb(Convert.ToInt32(dt.Rows[i]["pic_rule"].ToString()), dt.Rows[i]["pic_web"].ToString(), dt.Rows[i]["picture"].ToString(), "300x300", "biginfopic"), dt.Rows[i]["allkeyword"].ToString());
                sbbshot.AppendFormat("<p>{0}</p>", dt.Rows[i]["showname"].ToString());
                sbbshot.AppendFormat("<span>￥{0}</span>", dt.Rows[i]["det_jg"].ToString());
                sbbshot.Append("</a>");
            }

            List<qy_spzs_entity> list1 = AllBll.Getm_cn_home_prhot(9);
            foreach (qy_spzs_entity ls in list1)
            {
                sbbshot2.AppendFormat("<a href=\"{0}\">", SiteUrl.GetSpid(ls.id));
                sbbshot2.AppendFormat("<img src=\"{0}\" alt=\"{1}\">", XMLCommonUrls.GetAutoImgb(ls.pic_rule, ls.pic_web, ls.picture, "500x0", "biginfopic"), ls.allkeyword);
                sbbshot2.AppendFormat("<p>{0}</p>", ls.showname);
                sbbshot2.AppendFormat("<span>￥{0}</span>", ls.det_jg);
                sbbshot2.Append("</a>");
            }

        }
    }
}