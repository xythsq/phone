<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cpsy.aspx.cs" Inherits="WapCoovee.cpsy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>陈升茶业-产品溯源</title>
    <script type="text/javascript" src="./chengshengfiles/jquery-1.11.3.js"></script>
    <link rel="stylesheet" href="./chengshengfiles/swiper.min.css">
    <script type="text/javascript" src="./chengshengfiles/swiper.min.js"></script>
    <script type="text/javascript" src="./chengshengfiles/jweixin-1.6.0.js"></script>
    <style>
        body {
            padding: 0;
            margin: 0;
            background-color: #F6EFE8
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

        <div style="text-align: center; background-color: rgba(246,239,232,1);" id="logodiv">
            <img src="./chengshengfiles/logo2.png" style="width: 60%; padding: 20px 0px;">
        </div>



        <div id="Remarks" style="text-align: center; padding: 10px 0px 0px 0px; font-size: 2.5em;">
        <%--    <span>基本信息</span><br>
            <span>生产年份：2023年</span><br>
            <span>茶品类型：普洱茶·生茶</span><br>
            <span>规格:357g/饼，28饼/件</span>
            <br>
            <br>
            <span>具体参数</span><br>
            <span>生产许可证编号：SC11453282248002</span><br>
            <span>厂名：勐海陈升茶业有限公司</span><br>
            <span>厂址：云南省西双版纳州勐海县工业园区</span><br>
            <span>厂家联系方式：400-107-2007</span><br>
            <span>配料表：云南西双版纳勐海大叶种大树晒青毛茶</span><br>
            <span>储藏方法：在清洁、通风、干燥、避免阳光暴晒、无异味的环境保存</span><br>
            <span>保质期：符合储存方式下，该产品适合长期保存</span>--%>
            <img src="./chengshengfiles/20230819174041_0358.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174046_1761.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174055_3357.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174103_9386.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174111_0915.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174117_6360.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174123_8094.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174131_3402.jpg" alt="" style="width: 100%;">
            <img src="./chengshengfiles/20230819174138_7694.jpg" alt="" style="width: 100%;">
        </div>
        <div id="PBP" style="text-align: center; display: none;">
            <div style="display: inline-block; width: 90%; background-color: #FFF9ED; border-radius: 6px">
                <div style="padding: 20px; color: #6C481F; font-size: 18px; border-bottom: 1px solid #E9EAEB;">相关推荐</div>
                <div id="BannerPBP" class="swiper-container swiper-container-horizontal swiper-container-autoheight" style="text-align: center; padding-top: 15px">
                    <div id="pbplist" class="swiper-wrapper" style="transition-duration: 0ms;">
                    </div>
                    <div id="BannerPBPpagination" class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"></div>
                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                </div>
            </div>
        </div>
        <div id="gap" style="height: 52px;"></div>
       <%-- <table id="bottom" style="font-size: 0.8rem; width: 100%; text-align: center; position: fixed; bottom: 0; background-color: white; z-index: 2">
            <tbody>
                <tr>
                    <td style="padding: 10px 0px; text-align: -webkit-center;">
                        <div id="goindex" style="background: linear-gradient(180deg,rgba(156,79,60,1) 0%,rgba(83,41,31,1) 100%); color: white; border-radius: 1rem; padding: 8px 0px; width: 80%;">返回首页</div>
                    </td>
                   <td style="padding: 10px 0px; text-align: -webkit-center;">
                        <div id="showmore" style="background: linear-gradient(180deg,rgba(156,79,60,1) 0%,rgba(83,41,31,1) 100%); color: white; border-radius: 1rem; padding: 8px 0px; width: 80%;">查看更多</div>
                    </td>
                    <td style="padding: 10px 0px; text-align: -webkit-center;">
                        <div id="ljgm" style="background: linear-gradient(180deg,rgba(156,79,60,1) 0%,rgba(83,41,31,1) 100%); color: white; border-radius: 1rem; padding: 8px 0px; width: 80%;">专营店购买</div>
                    </td>
                </tr>
            </tbody>
        </table>--%>
        
    </form>
</body>
</html>
<script>
    $("#goindex").click(function () {
        if ("CS7203679304" == "") {
            window.location.href = "../../cspuer/home/1"
        } else {
            window.location.href = "../../cspuer/home/CS7203679304"
        }
    })
    var tempid = "CS7203679304";
    var temppid = "";
    $("#showmore").click(function () {
        window.location.href = "../../cspuer/more/CS7203679304"
    })
    $("#ljgm").click(function () {
        window.location.href = "../../cspuer/shop2/1"
    })
    window.onload = function () {
        //获取数据
        $.ajax({
            type: "post",
            //async: true,   // 锁定当前页面 等待返回结果才允许操作
            url: "../../cspuer/cpsy_getPinfo/" + tempid,
            data: { id: tempid, pid: temppid },
            dataType: "json",
            success: function (Jsondata) {
                //console.log(Jsondata);
                if (Jsondata != "") {
                    if (Jsondata.code == 0) {


                        //显示3个值
                        if (Jsondata.ProductId == null || Jsondata.ProductId == '') {
                            $("#Name_2").css("display", "none");
                        }
                        else {
                            //产品ID是406，则是通用产品，则不显示
                            if (Jsondata.ProductId == '406') {
                                $("#Name_2").css("display", "none");
                            }
                            else {
                                //如果价格字段没有维护，那3个字段都隐藏。
                                if (Jsondata.Price == null || Jsondata.Price == '' || Jsondata.Price == '0') {
                                    $("#Name_2").css("display", "none");
                                }
                                else {
                                    $("#Name").html(Jsondata.Name);
                                    $("#Price").html('¥' + Jsondata.Price);
                                    $("#Spec").html(Jsondata.Spec);
                                }
                            }
                        }


                        var domainWeburl = document.getElementById('domainWeburl').value;

                        //图文初始化
                        $("#Remarks").html(Jsondata.Remark);

                        //视频轮播初始化
                        var videoHtml = "";
                        //                            alert(Jsondata.VideoUrl);
                        if (Jsondata.VideoUrl == null || Jsondata.VideoUrl == '') {
                            $("#BannerVideo").css("display", "none");
                        }
                        else {
                            for (var i = 0; i < Jsondata.VideoUrl.split(',').length; i++) {
                                videoHtml += '<div class="swiper-slide" style="width: 100%; height: auto;">' +
                                    '<iframe class="iframe" frameborder="0" src="' + Jsondata.VideoUrl.split(',')[i] + '" allowFullScreen="true" style="height:200px; width:100%"></iframe>' +
                                    '</div>';
                            }
                            $("#blist").html(videoHtml);
                        }

                        //图片轮播初始化
                        var imgListHtml = "";
                        for (var i = 0; i < Jsondata.ImgListUrl.split('|').length; i++) {
                            if (Jsondata.ImgListUrl.split('|')[i] != "") {
                                imgListHtml += '<div class="swiper-slide" style="width: 100%; height: auto;">' +
                                    '<img style="width:90%" src="' + domainWeburl + Jsondata.ImgListUrl.split('|')[i] + '" />' +
                                    '</div>';//http://4000851315.com/cspuer/
                            }
                        }
                        $("#imgList").html(imgListHtml);

                        //更多产品轮播初始化
                        if (Jsondata.MoreProduct == null || Jsondata.MoreProduct.length <= 0) {
                            $("#PBP").css("display", "none");
                        }
                        else {
                            var pbpListHtml = "";
                            for (var i = 0; i < Jsondata.MoreProduct[0].length; i++) {
                                pbpListHtml += '<div onclick="gopbpid(this)" class="swiper-slide" style="width: 100%; height: auto;" pbpid="' + Jsondata.MoreProduct[0][i].pbpid + '">' +
                                    '<img style="width:90%; background-color:#EAE2D3" src="' + domainWeburl + Jsondata.MoreProduct[0][i].ImgUrl + '" />' +
                                    '<div style="color:#6A2F21; font-size: 14px;">' + Jsondata.MoreProduct[0][i].Name + '</div>' +
                                    '</div>';//http://4000851315.com/cspuer/
                            }
                            $("#pbplist").html(pbpListHtml);
                        }
                        if ((Jsondata.VideoUrl == "" && Jsondata.ImgListUrl == "" && Jsondata.Remark == "") || Jsondata.PStatus != "1") {
                            $("#Remarks").css("padding", "50px");
                            $("#Remarks").css("text-align", "center");
                            $("#Remarks").css("color", "#6B461E");
                            $("#Remarks").text("抱歉，该产品还未维护信息");
                            $("#Remarks").css("display", "");
                            $("#BannerVideo").css("display", "none");
                            $("#BannerImg").css("display", "none");
                        }
                        $("#gap").css("height", $("#bottom").height() + "px");
                        $("#Remarks").find('img').css("width", "100%");
                        var ishttpimg;
                        $("#Remarks").find('img').each(function () {
                            ishttpimg = $(this).attr("src");
                            if (ishttpimg.indexOf("http") == -1) {
                                //                                    $(this).attr("src","http://4000851315.com"+$(this).attr("src"));
                                $(this).attr("src", domainWeburl + $(this).attr("src"));
                            }
                            var _w = $(window).width() - 30;
                            var realWidth;//真实的宽度
                            var realHeight;//真实的高度
                            $(this).attr("src", $(this).attr("src")).load(function () {
                                realWidth = this.width;
                                realHeight = this.height;
                                //如果真实的宽度大于浏览器的宽度就按照100%显示
                                if (realWidth >= _w) {
                                    $(this).css("width", "100%");
                                } else {//如果小于浏览器的宽度按照原尺寸显示
                                    $(img).css("width", realWidth + 'px').css("height", realHeight + 'px');
                                }
                            });
                        })
                        //轮播初始化
                        swiperInit();
                    } else {
                        $("#Remarks").css("padding", "50px");
                        $("#Remarks").css("text-align", "center");
                        $("#Remarks").css("color", "#6B461E");
                        $("#Remarks").text("抱歉，该产品还未维护信息");
                        $("#Remarks").css("display", "");
                        $("#BannerVideo").css("display", "none");
                        $("#BannerImg").css("display", "none");
                        $("#PBP").css("display", "none");
                    }
                } else {
                    $("#Remarks").css("padding", "50px");
                    $("#Remarks").css("text-align", "center");
                    $("#Remarks").css("color", "#6B461E");
                    $("#Remarks").text("抱歉，网络异常，请稍候再试");
                    $("#Remarks").css("display", "");
                    $("#BannerVideo").css("display", "none");
                    $("#BannerImg").css("display", "none");
                    $("#PBP").css("display", "none");
                }
            },
            error: function (a, b, c) {
                console.log(a);
                console.log(b);
                console.log(c);
            }
        });




    }
    function gopbpid(e) {
        window.location.href = "../../cspuer/cpsy/1?pid=" + $(e).attr("pbpid");
    }
    function swiperInit() {
        //视频轮播初始化
        var swiper = new Swiper('#BannerVideo', {
            //effect : 'flip',切换动画fade、cube、coverflow
            autoHeight: true,
            pagination: {//分页器
                el: '#Bannerpagination',//分页器的标签Class
                hideOnClick: false,//点击时会隐藏分页器
                clickable: true,//点击分页器的指示点会控制切换
                type: 'bullets',//分页器的样式fraction、progress、bullets
                dynamicBullets: true
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            loop: true,//允许首位接应
        });
        //图片轮播初始化
        var swiper = new Swiper('#BannerImg', {
            //effect : 'flip',切换动画fade、cube、coverflow
            autoHeight: true,
            pagination: {//分页器
                el: '#BannerImgpagination',//分页器的标签Class
                hideOnClick: false,//点击时会隐藏分页器
                clickable: true,//点击分页器的指示点会控制切换
                type: 'bullets',//分页器的样式fraction、progress、bullets
            },
            loop: true,//允许首位接应
        });
        //相关产品轮播初始化
        var swiper2 = new Swiper('#BannerPBP', {
            //effect : 'flip',切换动画fade、cube、coverflow
            autoHeight: true,
            slidesPerView: 3,
            spaceBetween: 0,
            slidesPerGroup: 3,
            loopFillGroupWithBlank: true,
            pagination: {
                el: '#BannerPBPpagination',
                clickable: true,
            },
            loop: true,//允许首位接应
        });
    }
    </script>
