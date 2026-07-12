<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckAuthenticity.aspx.cs" Inherits="WapCoovee.CheckAuthenticity" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <title>陈升茶业-防伪查询</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="./chengshengfiles/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="./chengshengfiles/layui.js"></script>
    <script type="text/javascript" src="./chengshengfiles/NumsKeyPad2.js"></script>
    <link href="./chengshengfiles/NumsKeyPad3.css" rel="Stylesheet">
    <link href="./chengshengfiles/layui.css" rel="Stylesheet">
    <script type="text/javascript" src="./chengshengfiles/jweixin-1.6.0.js"></script>
   
    <style>
        body
        {
            padding:0;
            margin:0;
            background-color:#F6EFE8
        }
    </style>
    <script type="text/javascript">
        //注册
        wx.config({
            debug: false,                               // 开启调试模式,调用的所有 api 的返回值会在客户端 alert 出来，若要查看传入的参数，可以在 pc 端打开，参数信息会通过 log 打出，仅在 pc 端时才会打印。
            appId: 'wx8f8ebc825aecdf52',                    // 必填，公众号的唯一标识
            timestamp: '1783215235',            // 必填，生成签名的时间戳------------当前时间的时间戳
            nonceStr: 'uVGASBrqzucpFJa',              // 必填，生成签名的随机串------------这个是密钥吗？还是随便填写的？或微信公众号绑定的？
            signature: '3a94688a0124dd59386583d61f58edee0d41e248',            // 必填，签名---------------------------------------------签名规则没找到
            jsApiList: ['updateAppMessageShareData']    // 必填，需要使用的 JS 接口列表
        });
        wx.error(function (res) {
            // config信息验证失败会执行 error 函数，如签名过期导致验证失败，具体错误信息可以打开 config 的debug模式查看，也可以在返回的 res 参数中查看，对于 SPA 可以在这里更新签名。
            console.log('注册失败-----', res);
        });

        //分享
        wx.ready(function () {   //需在用户可能点击分享按钮前就先调用
            wx.updateAppMessageShareData({
                title: '陈升茶业-防伪查询',  // 分享标题
                desc: '',                           // 分享描述
                link: 'http://him56.com/cspuer/fwcx/CS7203679304',        // 分享链接，该链接域名或路径必须与当前页面对应的公众号 JS 安全域名一致
                imgUrl: window.location.protocol + '//' + window.location.host + '/Content/cspuer/logo_cheshenghao.png', // 分享图标
                success: function () {
                    // 设置成功
                }
            })
        }); 
    </script>
<style type="text/css">.qa-sdk-wrapper {
  position: fixed;
  width: 400px;
  right: -600px;
  max-height: 530px;
  overflow: hidden;
  border-radius: 4px;
  box-shadow: 0px 0px 8px 0px rgba(0, 0, 0, 0.1);
  transition: all 0.5s ease-in-out;
  background: #fff;
}

.qa-sdk-close-btn {
  display: inline-block;
  width: 18px;
  height: 18px;
  cursor: pointer;
  position: absolute;
  top: 16px;
  right: 16px;
}

.qa-sdk-close-btn:hover {
  border-radius: 50%;
  background-color: #d5d9df;
}

#qa-sdk-iframe {
  width: 400px;
}

@media (min-width: 1024px) and (max-width: 1366px) {
  .qa-sdk-wrapper{
    width: 356px;
  }
  #qa-sdk-iframe {
    width: 356px;
  }
}
</style>
    <link  rel="stylesheet" href="./chengshengfiles/layer.css" media="all"><style id="ai-assist-webType-style">
    .ai-assist-highlight {
      background: yellow;
    }
    @media print {
      #ai-assist-root-bangs,
      #ai-assist-root-bilibili,
      #ai-assist-root-new {
        display: none !important;
      }
    }
  </style>
</head>
<body>
    <form id="form1" runat="server">
         <div style=" width:90%; background-color:#FFF9ED; margin:20px">
        <div style="color:#6C481F; padding:20px;border-bottom: 1px solid #ECECEC;">示意标签</div>
        <div style="text-align:-webkit-center; padding:20px 0px">
            <img src="./chengshengfiles/fwcx_bq.png" style="width:90%">
        </div>
        
    </div>
    <div style=" width:90%; background-color:#FFF9ED; margin:20px;border-radius:20px; ">
        <input id="allcode" type="text" onfocus="this.blur();" style="height:40px;background:rgba(255,249,237,1);border-radius:20px; width:100%; background-color:#FFF9ED; border:none;padding-left: 15px;box-sizing: border-box;" placeholder="请刮开银色涂层，输入16位防伪编码查询真伪">
    </div>
    <div style="width: 90%; margin: 20px; text-align:center;">
        <input id="goindex" type="button" value="返回首页" style="height:38px;background:linear-gradient(180deg,rgba(156,79,60,1) 0%,rgba(83,41,31,1) 100%);border-radius:19px; width:30%;color: white;border: none;">
        <input onclick="postAnticode16()" id="anti_query" type="button" value="确 定" style="height:38px;background:linear-gradient(180deg,rgba(156,79,60,1) 0%,rgba(83,41,31,1) 100%);border-radius:19px; width:30%;color: white;border: none;margin-left: 20px;">
    </div>


    </form>
</body>
</html>
<script type="text/javascript">
  
        if ("" == "notWx") {
            $("#allcode").attr("placeholder", "请使用微信打开该页面");
        $("#anti_query").css("display","none");
        alert("请使用微信打开该页面");
    }else{
            window.onload = function () {
                NumsKeyPad2_Alert("allcode", "16");
            }
        function postAnticode16() {
            //先检查是否填写完毕防伪码
            var anticode = $("#allcode").val();
        re = / /gi;
        anticode = anticode.replace(re, "");
        if (anticode == null) {
            alert("未获取物流码，查询失败");
        return false;
            } else if (anticode.length != 16) {
            alert("请输入16位防伪码");
        $("#anticode").click();
        return false;
            }
        document.getElementById("anti_query").disabled = true; //按钮灰掉
        document.getElementById("anti_query").value = "查询中...";

        var time = Math.random(); //接这个参数，以防浏览器缓存
            location.href = "/fwcx_reslut.aspx?anticode=" + anticode;
        }
    }
        $("#goindex").click(function () {
            window.location.href = "home.aspx"
        })
</script>
