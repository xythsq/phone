<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="1.aspx.cs" Inherits="WapCoovee._1" %>



<!DOCTYPE html>
<html lang="zh-CN">
<head runat="server">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>陈升茶业防伪查询</title>
<style>
*{margin:0;padding:0;-webkit-box-sizing:border-box;box-sizing:border-box;font-family:"微软雅黑",sans-serif}
body{background:#f7f2e8;font-size:14px;color:#333}
/* 顶部标题栏 */
.wap-top{background:#fff;padding:12px 15px;text-align:center;border-bottom:1px solid #eee;position:relative}
.wap-top .close{position:absolute;left:15px;font-size:20px;color:#333}
.wap-top .more{position:absolute;right:15px;font-size:20px;color:#333}
.wap-top h1{font-size:18px;font-weight:normal}
.wap-top .domain{font-size:12px;color:#777;margin-top:4px}

/* 头部banner */
.wap-banner{background:linear-gradient(#f8e9c9,#f0ddb5);padding:20px 15px;position:relative;overflow:hidden}
.banner-logo{display:flex;align-items:center;margin-bottom:20px}
.logo-left{width:70px;height:70px;background:url(data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 80 80'%3E%3Ctext x='10' y='50' font-size='40' fill='%23b88628'%3E陳升號%3C/text%3E%3C/svg%3E) no-repeat;background-size:contain;margin-right:10px}
.logo-title h2{font-size:40px;color:#b88628;font-weight:normal}
.logo-title p{font-size:12px;color:#b88628;text-align:right}
.banner-txt{text-align:center;color:#8b5a2b;margin:15px 0}
.banner-txt .t1{font-size:16px;margin-bottom:4px}
.banner-txt .t2{font-size:14px}
.banner-cake{display:flex;justify-content:center;gap:6px;margin:15px 0}
.cake{width:60px;height:60px;border-radius:50%;background:#fff;border:1px solid #d4b886}
.banner-tree{position:absolute;right:5px;top:110px;width:150px;height:180px;background:url(data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 180 200'%3E%3Cpath d='M150,20 Q120,60 140,100 Q130,140 150,180' stroke='%23b88628' fill='none' stroke-width='2'/%3E%3C/svg%3E) no-repeat;background-size:contain}
.banner-hill{height:25px;background:#e6c890;border-radius:50% 50% 0 0;margin-top:-8px}

/* 功能区第一行 */
.func-row1{display:flex;justify-content:space-around;padding:35px 5px}
.func-row2{display:flex;justify-content:space-around;padding:0 5px 35px}
.func-item{display:flex;flex-direction:column;align-items:center}
.func-icon{width:70px;height:70px;border-radius:50%;background:#d4c2a0;display:flex;align-items:center;justify-content:center;margin-bottom:10px;color:#fff;font-size:22px}
.func-icon.mid{border:2px dashed #999;background:transparent;border-radius:6px}
.func-icon.square{border-radius:10px}
.func-name{font-size:16px;color:#444}
</style>
</head>
<body>
<!-- 顶部 -->
<div class="wap-top">
    <span class="close">×</span>
    <h1>欢迎使用陈升茶业防伪查询</h1>
    <div class="domain">him56.com</div>
    <span class="more">⋯</span>
</div>

<!-- 头部 -->
<div class="wap-banner">
    <div class="banner-logo">
        <div class="logo-left"></div>
        <div class="logo-title">
            <h2>陈升号</h2>
            <p>大树茶味道… Chen Sheng Hao The Taste Of Ancient Tree</p>
        </div>
    </div>
    <div class="banner-txt">
        <div class="t1">连续五年荣膺云南省十大名茶</div>
        <div class="t2">2022年评定为云南省“10大名茶”第一名</div>
    </div>
    <div class="banner-cake">
        <div class="cake"></div>
        <div class="cake"></div>
        <div class="cake"></div>
        <div class="cake"></div>
        <div class="cake"></div>
    </div>
    <div class="banner-tree"></div>
    <div class="banner-hill"></div>
</div>

<!-- 功能第一行 -->
<div class="func-row1">
    <div class="func-item">
        <div class="func-icon">🌿</div>
        <div class="func-name">产品溯源</div>
    </div>
    <div class="func-item">
        <div class="func-icon mid">☑</div>
        <div class="func-name">防伪查询</div>
    </div>
    <div class="func-item">
        <div class="func-icon">印</div>
        <div class="func-name">走进品牌</div>
    </div>
</div>

<!-- 功能第二行 -->
<div class="func-row2">
    <div class="func-item">
        <div class="func-icon square">🏪</div>
        <div class="func-name">专营店</div>
    </div>
    <div class="func-item">
        <div class="func-icon square">🥽</div>
        <div class="func-name">VR</div>
    </div>
    <div class="func-item">
        <div class="func-icon square">🏠</div>
        <div class="func-name">陈升仓储</div>
    </div>
</div>
</body>
</html>
