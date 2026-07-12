using ServiceStack;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WapCoovee.BAL;
using WapCoovee.Entity;

namespace WapCoovee.Admin
{
    public partial class AntiFakeManage : System.Web.UI.Page
    {
        private int PageIndex
        {
            get { return ViewState["PageIndex"] != null ? (int)ViewState["PageIndex"] : 1; }
            set { ViewState["PageIndex"] = value; }
        }

        private int PageSize
        {
            get { return ViewState["PageSize"] != null ? (int)ViewState["PageSize"] : 10; }
            set { ViewState["PageSize"] = value; }
        }

        private string SearchKeyword
        {
            get { return ViewState["SearchKeyword"] as string ?? ""; }
            set { ViewState["SearchKeyword"] = value; }
        }

        private string FilterIsExcel
        {
            get { return ViewState["FilterIsExcel"] as string ?? ""; }
            set { ViewState["FilterIsExcel"] = value; }
        }

        private string FilterIsInUse
        {
            get { return ViewState["FilterIsInUse"] as string ?? ""; }
            set { ViewState["FilterIsInUse"] = value; }
        }

        private List<ProductAntiFake_entity> _allData;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                ddlPageSize.SelectedValue = PageSize.ToString();
                ddlIsExcel.SelectedValue = FilterIsExcel;
                ddlIsInUse.SelectedValue = FilterIsInUse;
                BindList();
            }
        }

        private List<ProductAntiFake_entity> GetAllData()
        {
            if (_allData == null)
            {
                List<ProductAntiFake_entity> raw;
                if (!string.IsNullOrWhiteSpace(SearchKeyword))
                    raw = ProductAntiFakeBLL.Search(SearchKeyword);
                else
                    raw = ProductAntiFakeBLL.GetAll();

                var filtered = raw.AsEnumerable();

                if (!string.IsNullOrWhiteSpace(FilterIsExcel))
                {
                    bool val = Convert.ToBoolean(FilterIsExcel);
                    filtered = filtered.Where(u => u.IsExcel == val);
                }

                if (!string.IsNullOrWhiteSpace(FilterIsInUse))
                {
                    bool val = Convert.ToBoolean(FilterIsInUse);
                    filtered = filtered.Where(u => u.IsInUse == val);
                }

                _allData = filtered.ToList();
            }
            return _allData;
        }

        private void BindList()
        {
            var all = GetAllData();
            int total = all.Count;
            int totalPages = Math.Max(1, (int)Math.Ceiling((double)total / PageSize));

            if (PageIndex > totalPages) PageIndex = totalPages;
            if (PageIndex < 1) PageIndex = 1;

            var pageData = all.Skip((PageIndex - 1) * PageSize).Take(PageSize).ToList();

            var data = pageData.Select((u, index) => new
            {
                RowNumber = (PageIndex - 1) * PageSize + index + 1,
                u.Id,
                u.AntiCode,
                u.ProductName,
                u.BatchNo,
                u.Factory,
                u.MaxQueryTimes,
                QueryCount = ProductAntiFakeBLL.GetQueryCountByAntiCode(u.AntiCode),
                u.IsInvalid,
                u.CreateTime,
                u.IsExcel,
                u.IsInUse
            }).ToList();

            rptList.DataSource = data;
            rptList.DataBind();

            ltlTotal.Text = total.ToString();

            if (data.Count == 0)
                ltlEmpty.Text = "<tr class=\"empty-row\"><td colspan=\"12\">暂无数据</td></tr>";
            else
                ltlEmpty.Text = "";

            BindPager(totalPages);
            UpdateNavButtons(totalPages);
        }

        private void BindPager(int totalPages)
        {
            var pages = new List<object>();
            int start = Math.Max(1, PageIndex - 4);
            int end = Math.Min(totalPages, start + 9);
            start = Math.Max(1, end - 9);

            for (int i = start; i <= end; i++)
            {
                pages.Add(new { Text = i.ToString(), Value = i.ToString(), IsCurrent = i == PageIndex });
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }

        private void UpdateNavButtons(int totalPages)
        {
            btnFirst.Enabled = PageIndex > 1;
            btnPrev.Enabled = PageIndex > 1;
            btnNext.Enabled = PageIndex < totalPages;
            btnLast.Enabled = PageIndex < totalPages;
        }

        protected void btnPage_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int totalPages = Math.Max(1, (int)Math.Ceiling((double)GetAllData().Count / PageSize));

            switch (btn.CommandArgument)
            {
                case "First": PageIndex = 1; break;
                case "Prev": PageIndex = Math.Max(1, PageIndex - 1); break;
                case "Next": PageIndex = Math.Min(totalPages, PageIndex + 1); break;
                case "Last": PageIndex = totalPages; break;
            }
            BindList();
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            PageIndex = Convert.ToInt32(e.CommandArgument);
            BindList();
        }

        protected void ddlPageSize_Changed(object sender, EventArgs e)
        {
            PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            PageIndex = 1;
            BindList();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchKeyword = txtSearch.Text.Trim();
            PageIndex = 1;
            _allData = null;
            BindList();
        }

        protected void ddlFilter_Changed(object sender, EventArgs e)
        {
            FilterIsExcel = ddlIsExcel.SelectedValue;
            FilterIsInUse = ddlIsInUse.SelectedValue;
            PageIndex = 1;
            _allData = null;
            BindList();
        }

        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            ClearForm();
            ltlFormTitle.Text = "生成防伪码";
            hfId.Value = "0";
            txtAntiCode.Text = GenerateUniqueCode();
            pnlForm.Visible = true;
        }

        protected void btnCancelForm_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int id = string.IsNullOrEmpty(hfId.Value) ? 0 : Convert.ToInt32(hfId.Value);
            string antiCode = txtAntiCode.Text.Trim();
            string productName = txtProductName.Text.Trim();

            if (string.IsNullOrEmpty(productName))
            {
                ShowMessage("请输入产品名称", false);
                return;
            }

            if (id == 0)
            {
                if (string.IsNullOrEmpty(antiCode))
                    antiCode = GenerateUniqueCode();

                if (ProductAntiFakeBLL.GetByAntiCode(antiCode) != null)
                {
                    ShowMessage("防伪码已存在，请重新生成", false);
                    txtAntiCode.Text = GenerateUniqueCode();
                    return;
                }

                ProductAntiFake_entity obj = new ProductAntiFake_entity();
                obj.AntiCode = antiCode;
                obj.ProductName = productName;
                obj.BatchNo = string.IsNullOrEmpty(txtBatchNo.Text.Trim()) ? null : txtBatchNo.Text.Trim();
                obj.Factory = string.IsNullOrEmpty(txtFactory.Text.Trim()) ? null : txtFactory.Text.Trim();
                obj.MaxQueryTimes = byte.Parse(ddlMaxTimes.SelectedValue);
                obj.IsInvalid = chkInvalid.Checked;
                obj.CreateTime = DateTime.Now;
               new ProductAntiFakeBLL().Add(obj);
                ShowMessage("防伪码生成成功", true);
                pnlForm.Visible = false;
            }
            else
            {
                ProductAntiFake_entity obj = ProductAntiFakeBLL.GetById(id);
                if (obj == null)
                {
                    ShowMessage("记录不存在", false);
                    return;
                }
                obj.ProductName = productName;
                obj.BatchNo = string.IsNullOrEmpty(txtBatchNo.Text.Trim()) ? null : txtBatchNo.Text.Trim();
                obj.Factory = string.IsNullOrEmpty(txtFactory.Text.Trim()) ? null : txtFactory.Text.Trim();
                obj.MaxQueryTimes = byte.Parse(ddlMaxTimes.SelectedValue);
                obj.IsInvalid = chkInvalid.Checked;
                ProductAntiFakeBLL.Update(obj);
                ShowMessage("更新成功", true);
                pnlForm.Visible = false;
            }

            _allData = null;
            BindList();
        }

        protected void btnBatchGenerate_Click(object sender, EventArgs e)
        {
            int count;
            if (!int.TryParse(txtBatchCount.Text.Trim(), out count) || count < 1 || count > 1000)
            {
                ShowMessage("请输入1-1000之间的数量", false);
                return;
            }

            string productName = txtProductName.Text.Trim();
            string batchNo = string.IsNullOrEmpty(txtBatchNo.Text.Trim()) ? null : txtBatchNo.Text.Trim();
            string factory = string.IsNullOrEmpty(txtFactory.Text.Trim()) ? null : txtFactory.Text.Trim();
            byte maxTimes = byte.Parse(ddlMaxTimes.SelectedValue);
            bool isInvalid = chkInvalid.Checked;

            int successCount = 0;
            int failCount = 0;
            for (int i = 0; i < count; i++)
            {
                string code = GenerateUniqueCode();

                ProductAntiFake_entity obj = new ProductAntiFake_entity
                {
                    AntiCode = code,
                    ProductName = string.IsNullOrEmpty(productName) ? "批量生成" : productName,
                    BatchNo = batchNo,
                    Factory = factory,
                    MaxQueryTimes = 1,
                    IsInvalid = isInvalid,
                    CreateTime = DateTime.Now
                };
                new ProductAntiFakeBLL().Add(obj);
                successCount++;
            }

            _allData = null;
            BindList();
            ShowMessage(string.Format("批量生成完成：成功 {0} 个，失败 {1} 个", successCount, failCount), true);
        }

        protected void btnGenExport_Click(object sender, EventArgs e)
        {
            int count;
            if (!int.TryParse(txtBatchCount.Text.Trim(), out count) || count < 1 || count > 1000)
            {
                ShowMessage("请输入1-1000之间的数量", false);
                return;
            }

            string productName = txtProductName.Text.Trim();
            string batchNo = string.IsNullOrEmpty(txtBatchNo.Text.Trim()) ? null : txtBatchNo.Text.Trim();
            string factory = string.IsNullOrEmpty(txtFactory.Text.Trim()) ? null : txtFactory.Text.Trim();
            byte maxTimes = byte.Parse(ddlMaxTimes.SelectedValue);
            bool isInvalid = chkInvalid.Checked;

            List<ProductAntiFake_entity> newList = new List<ProductAntiFake_entity>();
            for (int i = 0; i < count; i++)
            {
                string code = GenerateUniqueCode();
                ProductAntiFake_entity obj = new ProductAntiFake_entity
                {
                    AntiCode = code,
                    ProductName = string.IsNullOrEmpty(productName) ? "批量生成" : productName,
                    BatchNo = batchNo,
                    Factory = factory,
                    MaxQueryTimes = 1,
                    IsInvalid = isInvalid,
                    CreateTime = DateTime.Now
                };
                new ProductAntiFakeBLL().Add(obj);
                obj.Id = ProductAntiFakeBLL.GetByAntiCode(code).Id;
                newList.Add(obj);
            }

            if (newList.Count == 0)
            {
                ShowMessage("生成失败", false);
                return;
            }

            _allData = null;
            BindList();
            ExportToExcel(newList);
        }

        private void ExportToExcel(List<ProductAntiFake_entity> list)
        {
            var data = list.Select(u => new
            {
                u.Id,
                u.AntiCode,
                u.ProductName,
                u.BatchNo,
                u.Factory,
                u.MaxQueryTimes,
                QueryCount = ProductAntiFakeBLL.GetQueryCountByAntiCode(u.AntiCode),
                Status = u.IsInvalid ? "已作废" : "有效",
                CreateTime = u.CreateTime.ToString("yyyy-MM-dd HH:mm")
            }).ToList();

            StringBuilder sb = new StringBuilder();
            sb.Append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
            sb.Append("<table border='1' cellpadding='5' cellspacing='0' style='border-collapse:collapse;font-size:12px'>");
            sb.Append("<tr style='background:#f0f0f0;font-weight:bold'>");
            sb.Append("<th>ID</th><th>防伪码</th><th>已查次数</th><th>状态</th><th>生成时间</th>");
            sb.Append("</tr>");

            foreach (var item in data)
            {
                ProductAntiFakeBLL.SetIsExcel(item.Id, true);
                sb.Append("<tr>");
                sb.AppendFormat("<td>{0}</td>", item.Id);
                sb.AppendFormat("<td style='mso-number-format:\\@'>{0}</td>", item.AntiCode);
                sb.AppendFormat("<td>{0}</td>", item.QueryCount);
                sb.AppendFormat("<td>{0}</td>", item.Status);
                sb.AppendFormat("<td>{0}</td>", item.CreateTime);
                sb.Append("</tr>");
            }
            sb.Append("</table>");

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "UTF-8";
            Response.ContentEncoding = Encoding.UTF8;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=AntiFakeCodes_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".xls");
            Response.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            string selectedIds = hfSelectedIds.Value;
            List<ProductAntiFake_entity> list;

            if (!string.IsNullOrWhiteSpace(selectedIds))
            {
                var ids = new HashSet<int>(selectedIds.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                    .Select(int.Parse));
                list = GetAllData().Where(u => ids.Contains(u.Id)).ToList();
            }
            else
            {
                list = GetAllData();
            }

            if (list.Count == 0)
            {
                ShowMessage("没有可导出的数据", false);
                return;
            }

            var data = list.Select(u => new
            {
                u.Id,
                u.AntiCode,
                u.ProductName,
                u.BatchNo,
                u.Factory,
                u.MaxQueryTimes,
                QueryCount = ProductAntiFakeBLL.GetQueryCountByAntiCode(u.AntiCode),
                Status = u.IsInvalid ? "已作废" : "有效",
                CreateTime = u.CreateTime.ToString("yyyy-MM-dd HH:mm")
            }).ToList();

            StringBuilder sb = new StringBuilder();
            sb.Append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
            sb.Append("<table border='1' cellpadding='5' cellspacing='0' style='border-collapse:collapse;font-size:12px'>");
            sb.Append("<tr style='background:#f0f0f0;font-weight:bold'>");
            sb.Append("<th>ID</th><th>防伪码</th><th>已查次数</th><th>状态</th><th>生成时间</th>");
            sb.Append("</tr>");

            foreach (var item in data)
            {
                ProductAntiFakeBLL.SetIsExcel(item.Id, true);
                sb.Append("<tr>");
                sb.AppendFormat("<td>{0}</td>", item.Id);
                sb.AppendFormat("<td style='mso-number-format:\\@'>{0}</td>", item.AntiCode);
                //sb.AppendFormat("<td>{0}</td>", item.ProductName);
                //sb.AppendFormat("<td>{0}</td>", item.BatchNo);
                //sb.AppendFormat("<td>{0}</td>", item.Factory);
                //sb.AppendFormat("<td>{0}</td>", item.MaxQueryTimes);
                sb.AppendFormat("<td>{0}</td>", item.QueryCount);
                sb.AppendFormat("<td>{0}</td>", item.Status);
                sb.AppendFormat("<td>{0}</td>", item.CreateTime);
                sb.Append("</tr>");
            }
            sb.Append("</table>");

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "UTF-8";
            Response.ContentEncoding = Encoding.UTF8;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=AntiFakeCodes_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".xls");
            Response.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Convert.ToInt32(btn.CommandArgument);
            ProductAntiFake_entity obj = ProductAntiFakeBLL.GetById(id);
            if (obj != null)
            {
                hfId.Value = obj.Id.ToString();
                txtAntiCode.Text = obj.AntiCode;
                txtProductName.Text = obj.ProductName;
                txtBatchNo.Text = obj.BatchNo ?? "";
                txtFactory.Text = obj.Factory ?? "";
                ddlMaxTimes.SelectedValue = obj.MaxQueryTimes.ToString();
                chkInvalid.Checked = obj.IsInvalid;
                ltlFormTitle.Text = "编辑防伪码 - " + obj.AntiCode;
                pnlForm.Visible = true;
            }
        }

        protected void btnToggle_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string[] args = btn.CommandArgument.Split(',');
            int id = Convert.ToInt32(args[0]);
            bool isInvalid = Convert.ToBoolean(args[1]);
            ProductAntiFakeBLL.SetInvalid(id, !isInvalid);
            ShowMessage("状态已更新", true);
            _allData = null;
            BindList();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Convert.ToInt32(btn.CommandArgument);
            ProductAntiFakeBLL.Delete(id);
            ShowMessage("已删除", true);
            _allData = null;
            BindList();
        }

        protected void btnSetInUse_Click(object sender, EventArgs e)
        {
            string selectedIds = hfSelectedIds.Value;
            if (string.IsNullOrWhiteSpace(selectedIds))
            {
                ShowMessage("请先选择要标记的防伪码", false);
                return;
            }

            var ids = selectedIds.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(int.Parse).ToList();

            int count = 0;
            foreach (int id in ids)
            {
                if (ProductAntiFakeBLL.SetInUse(id, true))
                    count++;
            }

            _allData = null;
            BindList();
            ShowMessage(string.Format("已将 {0} 个防伪码标记为使用中", count), true);
        }

        protected void btnBatchDelete_Click(object sender, EventArgs e)
        {
            string selectedIds = hfSelectedIds.Value;
            if (string.IsNullOrWhiteSpace(selectedIds))
            {
                ShowMessage("请先选择要删除的防伪码", false);
                return;
            }

            var ids = selectedIds.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(int.Parse).ToList();

            int count = 0;
            foreach (int id in ids)
            {
                var entity = ProductAntiFakeBLL.GetById(id);
                if (entity != null)
                {
                    AntiFakeQueryLogBLL.DeleteByAntiCode(entity.AntiCode);
                    if (ProductAntiFakeBLL.Delete(id))
                        count++;
                }
            }

            _allData = null;
            BindList();
            ShowMessage(string.Format("成功删除 {0} 个防伪码", count), true);
        }

        private string GenerateUniqueCode()
        {
            Random rnd = new Random();
            string code;

            //code = rnd.Next(10000000, 99999999).ToString() + rnd.Next(10000000, 99999999).ToString();
            code=Get16UniqueNumber();
            return code;
        }
        public static string Get16UniqueNumber()
        {
            Guid guid = Guid.NewGuid();
            // 把GUID全部转为数字串
            string numStr = string.Concat(guid.ToByteArray().Select(b => b.ToString("D3")));
            // 截取16位
            if (numStr.Length >= 16)
                return numStr.Substring(0, 16);
            return numStr.PadRight(16, '0');
        }
        private void ClearForm()
        {
            txtAntiCode.Text = "";
            txtProductName.Text = "";
            txtBatchNo.Text = "";
            txtFactory.Text = "";
            ddlMaxTimes.SelectedIndex = 0;
            chkInvalid.Checked = false;
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            pnlMessage.CssClass = "msg-bar " + (isSuccess ? "success" : "error");
            pnlMessage.Visible = true;
            ltlMessage.Text = msg;
        }
    }
}
