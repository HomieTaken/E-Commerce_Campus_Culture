<%@ page import="Entity.CultureProduct" %><%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/7/10
  Time: 18:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    CultureProduct[] products = (CultureProduct[])session.getAttribute("search_products") ;
    int state = (Integer) session.getAttribute("search_state");
    String str1 = "";
    if(state == 1)
        str1 = "-店铺";
    String str2 = "search.action";
    if(state == 1)
        str2 = "search_plus.action";
%>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-商品列表页</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/extend.css" rel="stylesheet">
</head>

<body>


    <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
        <a class="navbar-brand col-sm-4" href="index.jsp" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng<%=str1%></a>

        <li class="nav-item col-sm-1" >
            <a class="nav-link"   style="color:#FFFFFF;font-size:18px;margin-top:12px;">  </a>
        </li>
        <li class="nav-item col-sm-2">
            <a class="nav-link"  style="color:#FFFFFF;font-size:18px;margin-top:12px;">  </a>
        </li>
        <li class="nav-item col-sm-3">
            <form action = <%=str2%> class="form-inline" style="margin-top:18px;">
                <input class="form-control mr-sm-2" id="search" name="entry" type="text" style="width: 200px;" placeholder="搜索">
                <button class="btn btn-default my-2 my-sm-0" onclick="return checkSearch()" >
                    <span class="glyphicon glyphicon-search"></span>
                </button>
            </form>
        </li>
        <li class="nav-item ">
            <s:if test="#session.user_name==null">
                <div style="margin-top:18px;margin-left:40px">
                    <a href="login.jsp">登录</a>
                    <a href="register.jsp">注册</a>
                </div>
            </s:if>
            <s:else>
                <div class="dropdown" style="margin-top:18px;margin-left:40px">
                    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="text-shadow: black 5px 3px 3px;">
                        <span class="glyphicon glyphicon-user"></span>&emsp;已登录
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item disabled" href="#">Action</a>
                        <a class="dropdown-item" href="/shoppingcart.jsp">购物车</a>
                    </div>
                </div>
            </s:else>
        </li>
    </ul>

<br />
<div class="col-md-12" style="margin-top:5%">
    <ul class="nav nav-pills" style="background-color: #F0F0F0; height:50px;">
        <li style="margin-top:13px" class="caught">
            <a href="sort.action?sortFlag=3"  style="top:10px;isplay: block; color: black; text-align: center; padding: 14px 16px; text-decoration: none;">综合排序</a>
        </li>
        <li style="margin-top:13px" class="caught">
            <a href="sort.action?sortFlag=2" style="top:10px;isplay: block; color: black; text-align: center; padding: 14px 16px; text-decoration: none;">销量</a>
        </li>
        <li class="nav-item caught" style="margin-top:13px">
            <div class="dropdown-more">
                <a style="top:10px;isplay: block; color: black; text-align: center; padding: 14px 16px; text-decoration: none;">价格</a>
                <div class="dropdown-content-more">
                    <a href="sort.action?sortFlag=0"  style="top:10px;display: block; color: black; text-align: center; padding: 12px 22px 6px 22px; text-decoration: none;">价格由低到高</a>
                    <div style="height:10px"></div>
                    <a href="sort.action?sortFlag=1" style="top:10px;display: block; color: black; text-align: center; padding: 6px 22px 12px 22px; text-decoration: none;">价格由高到低</a>
                </div>
            </div>
        </li>
        <li style="margin-left:70%;margin-top:5px;">
            <nav>
                <%--<ul class="pagination">--%>
                <%--<li class="page-item">--%>
                <%--<a class="page-link" href="#"><text style="opacity: 0.2"><</text></a>--%>
                <%--</li>--%>
                <%--<li class="page-item">--%>
                <%--<!----%>
                <%--href="javascript:return false;"：设置为不可点击--%>
                <%--加入style=”opacity: 0.2”可以实现变灰的效果--%>
                <%---->--%>
                <%--<a class="page-link" href="javascript:return false;">1/25</a>--%>
                <%--</li>--%>
                <%--<li class="page-item">--%>
                <%--<a class="page-link" href="#">></a>--%>
                <%--</li>--%>
                <%--</ul>--%>
            </nav>
        </li>
    </ul>
</div>
<br>

<!--5张图一行-->
<div class="row" style="margin-left:-7px;" >
    <s:iterator var = "u" value="#session.search_products">
        <div class="border-change" id="box">
            <a target="_blank" href="/enterProduct?productID=<s:property value="#u.getProductID()"></s:property>">
                <img src="<%=basePath%>/getPic.action?productID=<s:property value="#u.getProductID()"></s:property> "  alt="图片文本描述" style="weight:240px;height:240px;object-fit:cover;">
            </a>
            <div class="text-danger prolist-price">￥<s:property value="#u.getPrice()"></s:property>  <br/> 销量<s:property value="#u.getAmount()"></s:property> </div>
            <div class="desc"><s:property value="#u.getName()"></s:property></div>
        </div>
    </s:iterator>
</div>



<nav style="margin-top:20px;margin-left:35%">
    <ul class="pagination" id = "pages">
    </ul>
</nav>

<script src="js/scripts.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
    var $div = $(".row");
    var $show = $("#show");
    var $pages = $("#pages");
    var pgindex = 1;//当前页
    var eachCnt = 5;//每页显示个数
    var boxes = $("div[id='box']");
    var cnt = boxes.length;
    var indexs = new Array(cnt);
    for(var i=0; i<cnt; i++) {
        indexs[i] = i;
    }
    var allPages = Math.ceil(cnt/eachCnt);
    $( function() {
        // $pages.html("<li class=\"page-item\"><p class = \"page-link\">共 " + allPages + "页</p></li>");
        if(cnt == 0)
            $pages.append("抱歉,未找到搜索结果")
        else {
            showPage(1);
            $pages.append("<li class=\"page-item\">" + "<a class = \"page-link\" href=\"javascript:goPage(-1);\">上一页</a>" + "</li>");
            for (var i = 0; i < allPages; i++) {
                $pages.append(" <li class=\"page-item\">" + "<a class = \"page-link\" href=\"javascript:showPage('" + (i + 1) + "');\"> " + (i + 1) + " </a>" + "</li>");
            }
            $pages.append("<li class=\"page-item\">" + "<a class = \"page-link\" href=\"javascript:goPage(1);\">下一页</a>" + "</li>");
        }

    });

    function goPage(value){
        try{
            if(value == 1)
                pgindex++;
            else
                pgindex--
            showPage(pgindex);
        }catch(e){
        }
    }
    function showPage(pageIndex)
    {
        if(pageIndex== 0 || pageIndex == (allPages+1)) {
            return false;
        }
        var start = (pageIndex-1)*5;//8
        //alert("start:" + start);
        var end = start + 5;
        end = end > cnt ? cnt : end;//16
        //alert("end:" + end);
        var subIndexs = indexs.slice(start, end);
        for(var i=0; i<cnt; i++) {
            if(contains(i, subIndexs)) {
                boxes.eq(i).show();
            }else{
                boxes.eq(i).hide();
            }
        }
        pgindex = pageIndex;
        //alert(pgindex);
    }

    var contains = function (element, arr) {

        for (var i = 0; i < arr.length; i++) {
            if (arr[i] == element) {
                return true;
            }
        }
        return false;
    }

    //alert(contains(23, indexs));
</script>

</body>
</html>
