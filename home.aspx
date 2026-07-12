<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="WapCoovee.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>欢迎使用陈升茶业防伪查询</title>

    <script type="text/javascript" src="chengshengfiles/jquery-1.11.3.js"></script>
<script type="text/javascript" src="./chengshengfiles/jweixin-1.6.0.js"></script>
<style>
    body {
        padding: 0;
        margin: 0;
        background-color: #F6EFE8
    }

    .fontcolor {
        color: #695B45;
        font-size: 2.5em;
        
    }
</style>

<style type="text/css">
    .qa-sdk-wrapper {
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
        .qa-sdk-wrapper {
            width: 356px;
        }

        #qa-sdk-iframe {
            width: 356px;
        }
    }
</style>
<style id="ai-assist-webType-style">
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



        <div style="display: ">
            <div>
                <img src="./chengshengfiles/banner.png" style="width: 100%">
            </div>
         
            <table style="width: 100%; text-align: center">
                <tbody>
                    <tr>
                        <td style="padding: 95px 0px 15px 0px; width: 33%" id="cpsy">
                            <img src="./chengshengfiles/icon_cpsy.png" style="width: 50%">
                            <div class="fontcolor">产品溯源</div>
                        </td>
                        <td style="padding: 95px 0px 15px 0px; width: 34%" id="fwcx">
                            <img src="./chengshengfiles/icon-fwcx.png" style="width: 60%">
                            <div class="fontcolor">防伪查询</div>
                        </td>
                        <td style="padding: 95px 0px 15px 0px; width: 33%" id="gogw">
                            <img src="./chengshengfiles/icon_zjpp.png" style="width: 50%">
                            <div class="fontcolor">走进品牌</div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 110px 0px 15px 0px; width: 33%" id="zyd">
                            <img src="./chengshengfiles/icon_zyd.png" style="width: 50%">
                            <div class="fontcolor">专营店</div>
                        </td>
                        <td style="padding:110px 0px 15px 0px; width: 34%" id="govr">
                            <img src="./chengshengfiles/icon_vr.png" style="width: 50%">
                            <div class="fontcolor">VR</div>
                        </td>
                        <td style="padding:110px 0px 15px 0px; width: 33%" id="gocc">
                            <img src="./chengshengfiles/icon_cscc.png" style="width: 50%">
                            <div class="fontcolor">陈升仓储</div>
                        </td>
                    </tr>
                    </tbody>
            </table>
        </div>


        <script type="text/javascript">
            $("#zyd").click(function () {
                window.location.href = "http://him56.com/cspuer/Shop2/1";
            })
            $("#fwcx").click(function () {
                window.location.href = "/CheckAuthenticity.aspx";
            })
            $("#cpsy").click(function () {
                window.location.href = "/cpsy.aspx"; //"http://him56.com/cspuer/cpsy/CS7203679304";
            })
            $("#gocc").click(function () {
                window.location.href = "http://him56.com/cspuer/cscc/1";
            })
            $("#govr").click(function () {
                window.location.href = "https://720yun.com/t/3m9qw4am88hrm7oqhg?pano_id=vpqgHDCnGupnhyjH";
            })
            $("#gogw").click(function () {
                window.location.href = "http://him56.com//cspuer/EPInfo/1";
            })
        </script>
    </form>
</body>
</html>
