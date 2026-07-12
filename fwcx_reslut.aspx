<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fwcx_reslut.aspx.cs" Inherits="WapCoovee.fwcx_reslut" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>欢迎使用陈升茶业防伪查询</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="./chengshengfiles/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="./chengshengfiles/layui.js"></script>
    <script type="text/javascript" src="./chengshengfiles/NumsKeyPad2.js"></script>
    <link href="./chengshengfiles/NumsKeyPad3.css" rel="Stylesheet">
    <link href="./chengshengfiles/layui.css" rel="Stylesheet">

    <style>
        body
        {
            padding:0;
            margin:0;
            background-color:#F6EFE8
        }
    </style>
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
    <link rel="stylesheet" href="./chengshengfiles/layer.css" media="all"><style id="ai-assist-webType-style">
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
       <div style=" text-align:center; padding:20px">
        <img src="./chengshengfiles/reslut.png" style="width:40%">
    </div>
    <div style=" text-align:center; padding:10px">
        <img id="simg" src="./chengshengfiles/error.png" style="width:18%">
    </div>
    <div style="text-align: center;font-size: 1.8rem;"><%=anticode %></div>
    <div style="text-align: -webkit-center;">
        <div id="resluttxt" style="text-align:left; width: 90%;padding: 10px;margin: 10px 0px;border: 1px solid #E0D1B4; color:#663A24;box-sizing: border-box;"><%=message %></div>
    </div>
    <div style=" width:90%; background-color:#FFF9ED; margin:20px;border-radius:20px; ">
        <input id="allcode" type="text" onfocus="this.blur();" style="height:40px;background:rgba(255,249,237,1);border-radius:20px; width:100%; background-color:#FFF9ED; border:none;padding-left: 15px;box-sizing: border-box;" placeholder="请刮开银色涂层，输入16位防伪编码查询真伪">
    </div>
    <div style=" width:90%;  margin:20px;    text-align:center;">
        <input id="goindex" type="button" value="返回首页" style="height:38px;background:linear-gradient(180deg,rgba(156,79,60,1) 0%,rgba(83,41,31,1) 100%);border-radius:19px; width:30%;color: white;border: none;">
        <input onclick="postAnticode16()" id="anti_query" type="button" value="继续查询" style="height:38px;background:linear-gradient(180deg,rgba(156,79,60,1) 0%,rgba(83,41,31,1) 100%);border-radius:19px; width:30%;color: white;border: none; margin-left:20px">
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    //var status = "2";
    //if (status == "1") {
    //    //正确
    //    $("#simg").attr("src", "../../Content/cspuer/success.png");
    //} else if (status == "2") {
    //    //编码错误
    //    $("#simg").attr("src", "../../Content/cspuer/error.png");
    //} else if (status == "3") {
    //    //黑名单
    //    $("#simg").attr("src", "../../Content/cspuer/error.png");
    //}
    window.onload = function () {
        NumsKeyPad2_Alert("allcode", "16");
    }
    function postAnticode16() {
        //先检查是否填写完毕防伪码
        var anticode = $("#allcode").val();
        var re = / /gi;
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
        location.href = "fwcx_reslut.aspx?anticode=" + anticode;
    }
    $("#goindex").click(function () {
        window.location.href = "home.aspx"
    })
</script>