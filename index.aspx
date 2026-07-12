<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WapCoovee.index" Async="true" %>
<%@ Import Namespace="Coovee.UrlRewriter" %>
<%@ Import Namespace="WapCoovee.Common" %>
<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
    <meta name="applicable-device" content="mobile">
    <link rel="stylesheet" href="/css/china-base-css.css">
    <link rel="stylesheet" href="/css/home_page.css">
    <link rel="stylesheet" href="/css/caigou.css"/>
    <title>虎易网-B2B电子商务平台，免费B2B平台，免费信息发布推广平台</title>
    <meta name="keywords" content="虎易网,B2B网站,导购网站" />
    <meta name="description" content="虎易网 是国内较早一批B2B电子商务平台，成立近20年，一直免费发布供求信息网，提供免费发布供应信息，企业黄页信息、，找意向客户、找求购尽在虎易网b2b平台，免费发布信息，免费推广，大家选虎易网B2B电子商务网站！" />
    <link rel="canonical" href="https://www.coovee.com" >
    <link rel="icon" href="/favicon.ico">
    <link rel="shortcut icon" href="/favicon.ico">
    <script>
    //if ((navigator.userAgent.match(/(iPhone|iPod|Android|ios|iOS|iPad|Backerry|WebOS|Symbian|Windows Phone|Phone)/i))) {
    //    //手机端显示的代码
        
    //}else{
    //    //非手机端要显示的代码
    //    window.location.replace("https://www.coovee.com");
    //}
    </script>
</head>
<body>
	<div class="header">
	<%=XMLCommonUrls.Head3("", "gy")%>
	</div>
	<div class="main">
		<div class="nav">
			<span></span>
			<div class="nav_Tmip">
                <ul>
					<%=sb.ToString() %>
				</ul>
            <div class=" gd">
                <span class="hidden"></span>
                <span class="show"></span>
            </div>
			</div>	 
		</div>
        <div class="banner">
            <img src="https://a2.att.hudong.com/71/04/300224654811132504044925945_950.jpg" alt="Alternate Text" />
        </div>
		<div class="nav2">
			 <a href="/1.aspx">
				<img src="/china-base-img/p1.jpg" alt="">
				<span>产品中心111</span>
			</a>
            <a href="/gy/">
				<img src="/china-base-img/p1.jpg" alt="">
				<span>产品中心</span>
			</a>
			<a href="/gs/">
				<img src="/china-base-img/p2.jpg" alt="">
				<span>企业黄页</span>
			</a>
			<a href="/sp/">
				<img src="/china-base-img/p3.jpg" alt="">
				<span>美图分享</span>
			</a>
			<a href="/sp/">
				<img src="/china-base-img/p4.jpg" alt="">
				<span>美图精选</span>
			</a>
			<a href="#">
				<img src="/china-base-img/p5.jpg" alt="">
				<span>分类信息</span>
			</a>
		</div>

        <div class="tab-all">
		    <div class="tab_s">
		        <p class="active">较新产品</p>
		        <p>较新分享</p>
                <div class="clearfix"></div>
		    </div>
		    <div class="tab_a">
		    	<div class="boutique">
		 
               <%=sbbshot.ToString() %>
				
		    	</div>	    	
		    	<div class="boutique">
		    		  <%=sbbshot2.ToString() %>
		    	</div>	
		    </div>
           </div>
		<div class="friend_link">
			<p>友情链接</p>
			<div class="fk">
				<a href="https://m.coovee.com">虎易网</a>
			</div>
		</div>
		<div class="nav_bottom">
			<span></span>
			<ul>
				<%=sb1.ToString() %>
			</ul>
		</div>
	</div>
	<div class="footer">
    <%=TxtHelper.ReadTxtByNameDefaultForFoot("Foot.txt","https://www.coovee.com/") %>
	</div>

    
    <div class="newLayer">
        <a class="layer-caigou" href="javascript:void(0);" onclick="enterXunjia()">全网询价</a>
    </div>

    <!--
    <div class="newLayer2">
        <a href="javascript:void(0);">
            <i class="layer2-kefu"></i>
            <div>进店</div>
        </a>
        <a href="javascript:void(0);">
            <i class="layer2-call"></i>
            <div>电话</div>
        </a>
        <div class="layer2-liuyan">采购留言</div>
        <div class="layer2-caigou">全网询价</div>
    </div>-->

</body>
</html>


<script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/index.js"></script>
<script type="text/javascript" src="/js/gundong.js"></script>
<script type="text/javascript" src="/js/layer/layer.js"></script>
<script type="text/javascript" src='/js/layer/layer.js'></script>
<script type="text/javascript" id="xunjia" src='/js/xunjia.js' data-lx="10" data-id="0"></script>