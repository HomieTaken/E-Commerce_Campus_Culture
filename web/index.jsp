<%@ page import="Actions.NavigationSwitch" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/3/003
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page  import ="Actions.DisplayProduct"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.CultureProduct" %>

<%String path = request.getContextPath();

    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
<%
    new DisplayProduct().execute();
    ArrayList<CultureProduct> products = (ArrayList<CultureProduct>) session.getAttribute("products");
    ArrayList<String> urls = (ArrayList<String>)session.getAttribute("urls");
%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-用户主页</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">

</head>
<body>


<div class="container-fluid">
    <div class="row" style="margin-top:85px">
        <div class="col-md-12">
            <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" >
                <ol class="breadcrumb" style="background-color: #CAFFFF; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px; box-shadow: 10px 10px 5px #888888;">
                    <div class="row">
                        <div class="col-md-4">
                            <li class="breadcrumb-item ">
                                <img src="img/logo%20.png" alt="Logo" style="width:70px;height: 35px;">
                            </li>
                            <li class="breadcrumb-item center-vertical">
                                <a href="#">主页</a>
                            </li>
                            <li class="breadcrumb-item center-vertical">
                                <a href="#teamList">团队列表</a>
                            </li>
                            <li class="breadcrumb-item center-vertical">
                                <a href="#proList">热销产品</a>
                            </li>
                            <li class="breadcrumb-item center-vertical">
                                <a href="chat.jsp">兴趣小组</a>
                            </li>
                        </div>

                        <div class="col-md-6">
                            <li class="breadcrumb-item ">
                                <form class="form-inline">
                                    <input class="form-control mr-sm-2" type="text" style="width: 400px;">
                                    <button class="btn btn-primary my-2 my-sm-0" type="submit" >
                                        <span class="glyphicon glyphicon-search"></span>
                                    </button>
                                </form>
                            </li>
                        </div>

                        <s:if test="#session.user_name==null">
                            <div class="col-md-1"></div>
                            <div class="col-md-1">
                            <a href="login.jsp">登录</a>
                            <a href="register.jsp">注册</a>
                            </div>
                        </s:if>
                        <s:else>
                        <div class="col-md-2">
                            <li class="breadcrumb-item ">
                                <div class="dropdown">
                                    <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="text-shadow: black 5px 3px 3px;">
                                        <span class="glyphicon glyphicon-user"></span>&emsp; 已登录
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <%--<a class="dropdown-item disabled" href="#">收藏</a>--%>
                                        <a class="dropdown-item" href="/shoppingcart.jsp">购物车</a>
                                        <%--<a class="dropdown-item" href="#">修改信息</a>--%>
                                        <a class="dropdown-item" href="logout.action">退出登录</a>
                                    </div>
                                </div>
                            </li>

                        </div>
                        </s:else>
                    </div>
                </ol>
            </nav>

            <!--轮播图-->
            <div class="carousel slide" id="carousel-335963" style="overflow:hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;  box-shadow: 10px 10px 5px #888888;">
                <ol class="carousel-indicators">
                    <li data-slide-to="0" data-target="#carousel-335963">
                    </li>
                    <li data-slide-to="1" data-target="#carousel-335963" class="active">
                    </li>
                    <li data-slide-to="2" data-target="#carousel-335963">
                    </li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item">
                        <img class="d-block w-100" alt="Carousel Bootstrap First" src="img/showimg4.png">
                        <div class="carousel-caption">
                            <h4>
                            </h4>
                            <p>
                            </p>
                        </div>
                    </div>
                    <div class="carousel-item active">
                        <img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/showimg2.png">
                        <div class="carousel-caption">
                            <h4>
                            </h4>
                            <p>
                            </p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" alt="Carousel Bootstrap Third" src="img/showimg6.png">
                        <div class="carousel-caption">
                            <h4>
                            </h4>
                            <p>
                            </p>
                        </div>
                    </div>
                </div> <a class="carousel-control-prev" href="#carousel-335963" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-335963" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>
            </div>
            <br />

            <!--团队介绍缩略图-->
            <div class="row" id="teamList">
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                队伍名
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="/enterTeam?teamID=4">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                队伍名
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="#">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                队伍名
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="#">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                队伍名
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="#">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                队伍名
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="#">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                队伍名
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="#">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <br />

            <!--缩略图-->
            <div class="row" id="proList">
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <!--img class="card-img-top" alt="Bootstrap Thumbnail First" style="height:200px;overflow:hidden" src="out/artifacts/E_Commerce_Campus_Culture_war_exploded/img/7.jpg"-->
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" style="height:200px;overflow:hidden" src="<%=basePath+urls.get(0)%>">
                        <div class="card-block">
                            <h5 class="card-title" >
                                <%=products.get(0).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(0).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(0).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail Second" style="height:200px;overflow:hidden"  src="<%=basePath+urls.get(1)%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(1).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(1).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(0).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail Third" style="height:200px;overflow:hidden"  src="<%=basePath+urls.get(2)%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(2).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(2).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(0).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <br />

            <!--缩略图2-->
            <div class="row"  action="DisplayProduct.action">
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" style="height:200px;overflow:hidden"  src="<%=basePath+urls.get(3)%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(3).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(3).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(0).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail Second" style="height:200px;overflow:hidden" src="<%=basePath+urls.get(4)%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(4).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(4).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(0).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail Third" style="height:200px;overflow:hidden"  src="<%=basePath+urls.get(5)%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(5).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(5).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(0).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br />
<nav class="navbar navbar-expand-lg navbar-light" style="background-color:#ADADAD;">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div  id="copyright" class="col-md-6">
            <p style="margin-top:10px">2018@共享gis  All Rights Reserved. </p>
            <p> 工信部备案号： xxxxx备xxxxx号 </p>
            <p> 联系方式：qq:245522147    邮箱：2455221474@qq.com</p>
        </div>
        <img src="img/qm.png">
    </div>
</nav>


<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
</body>
</html>
<%--<html lang="en">--%>
<%--<head>--%>
    <%--<meta charset="utf-8">--%>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1">--%>

    <%--<title>userhomepage</title>--%>

    <%--<meta name="description" content="Source code generated using layoutit.com">--%>
    <%--<meta name="author" content="LayoutIt!">--%>

    <%--<link href="css/bootstrap.min.css" rel="stylesheet">--%>
    <%--<link href="css/style.css" rel="stylesheet">--%>
    <%--<link href="css/bootstrap.css" rel="stylesheet">--%>

<%--</head>--%>
<%--<body>--%>


<%--<div class="container-fluid">--%>
    <%--<br />--%>
    <%--<div class="row">--%>
        <%--<div class="col-md-12">--%>
            <%--<nav>--%>
                <%--<ol class="breadcrumb">--%>
                    <%--<div class="row">--%>
                        <%--<div class="col-md-4">--%>
                            <%--<li class="breadcrumb-item ">--%>
                                <%--<img src="img/logo%20.png" alt="Logo" style="width:70px;height: 35px;">--%>
                            <%--</li>--%>
                            <%--<li class="breadcrumb-item center-vertical">--%>
                                <%--<a href="/index.jsp">主页</a>--%>
                            <%--</li>--%>
                            <%--<li class="breadcrumb-item center-vertical">--%>
                                <%--<a href="/index_group.jsp">兴趣小组</a>--%>
                            <%--</li>--%>
                            <%--<li class="breadcrumb-item center-vertical">--%>
                                <%--<a href="/teamPage.jsp">产品团队</a>--%>
                            <%--</li>--%>
                        <%--</div>--%>

                        <%--<div class="col-md-6">--%>
                            <%--<li class="breadcrumb-item ">--%>
                                <%--<form class="form-inline">--%>
                                    <%--<input class="form-control mr-sm-2" type="text" style="width: 400px;">--%>
                                    <%--<button class="btn btn-primary my-2 my-sm-0" type="submit" >--%>
                                        <%--Search--%>
                                    <%--</button>--%>
                                <%--</form>--%>
                            <%--</li>--%>
                        <%--</div>--%>

                        <%--<s:if test="#session.user_name==null">--%>
                            <%--<div class="col-md-1"></div>--%>
                        <%--<div class="col-md-1">--%>
                            <%--<a href="login.jsp">登录</a>--%>
                            <%--<a href="register.jsp">注册</a>--%>
                        <%--</div>--%>
                        <%--</s:if>--%>
                        <%--<s:else>--%>
                        <%--<div class="col-md-2">--%>
                            <%--<li class="breadcrumb-item ">--%>
                                <%--<div class="dropdown">--%>
                                    <%--<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="text-shadow: black 5px 3px 3px;">--%>
                                        <%--<span class="glyphicon glyphicon-user"></span>&emsp; 已登录--%>
                                    <%--</button>--%>
                                    <%--<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">--%>
                                        <%--<a class="dropdown-item disabled" href="#">修改信息</a>--%>
                                        <%--<a class="dropdown-item" href="/shoppingcart.jsp">购物车</a>--%>
                                        <%--<a class="dropdown-item" href="/index.jsp">退出登录</a>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</li>--%>
                        <%--</div>--%>
                        <%--</s:else>--%>
                    <%--</div>--%>
                <%--</ol>--%>
            <%--</nav>--%>

            <%--<!--轮播图-->--%>
            <%--<div class="carousel slide" id="carousel-335963">--%>
                <%--<ol class="carousel-indicators">--%>
                    <%--<li data-slide-to="0" data-target="#carousel-335963">--%>
                    <%--</li>--%>
                    <%--<li data-slide-to="1" data-target="#carousel-335963" class="active">--%>
                    <%--</li>--%>
                    <%--<li data-slide-to="2" data-target="#carousel-335963">--%>
                    <%--</li>--%>
                <%--</ol>--%>
                <%--<div class="carousel-inner">--%>
                    <%--<div class="carousel-item">--%>
                        <%--<img class="d-block w-100" alt="Carousel Bootstrap First" src="https://www.layoutit.com/img/sports-q-c-1600-500-1.jpg">--%>
                        <%--<div class="carousel-caption">--%>
                            <%--<h4>--%>
                                <%--第一个学校--%>
                            <%--</h4>--%>
                            <%--<p>--%>
                                <%--学校介绍--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="carousel-item active">--%>
                        <%--<img class="d-block w-100" alt="Carousel Bootstrap Second" src="https://www.layoutit.com/img/sports-q-c-1600-500-2.jpg">--%>
                        <%--<div class="carousel-caption">--%>
                            <%--<h4>--%>
                                <%--第二个学校--%>
                            <%--</h4>--%>
                            <%--<p>--%>
                                <%--学校介绍--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="carousel-item">--%>
                        <%--<img class="d-block w-100" alt="Carousel Bootstrap Third" src="https://www.layoutit.com/img/sports-q-c-1600-500-3.jpg">--%>
                        <%--<div class="carousel-caption">--%>
                            <%--<h4>--%>
                                <%--第三个学校--%>
                            <%--</h4>--%>
                            <%--<p>--%>
                                <%--学校介绍--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div> <a class="carousel-control-prev" href="#carousel-335963" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-335963" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>--%>
            <%--</div>--%>
            <%--<br />--%>

            <%--<!--团队介绍缩略图-->--%>
            <%--<div class="row" >--%>
                <%--<div class="col-md-2">--%>
                    <%--<div class="card" style="border-radius: 50%; overflow: hidden;">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">--%>
                        <%--<div class="card-block text-center">--%>
                            <%--<h5 class="card-title">--%>
                                <%--队伍名--%>
                            <%--</h5>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="index_team.jsp?userID=1">队伍主页</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-2">--%>
                    <%--<div class="card" style="border-radius: 50%; overflow: hidden;">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">--%>
                        <%--<div class="card-block text-center">--%>
                            <%--<h5 class="card-title">--%>
                                <%--队伍名--%>
                            <%--</h5>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="index_team.jsp?userID=2">队伍主页</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-2">--%>
                    <%--<div class="card" style="border-radius: 50%; overflow: hidden;">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">--%>
                        <%--<div class="card-block text-center">--%>
                            <%--<h5 class="card-title">--%>
                                <%--队伍名--%>
                            <%--</h5>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="index_team.jsp?userID=3">队伍主页</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-2">--%>
                    <%--<div class="card" style="border-radius: 50%; overflow: hidden;">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">--%>
                        <%--<div class="card-block text-center">--%>
                            <%--<h5 class="card-title">--%>
                                <%--队伍名--%>
                            <%--</h5>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="index_team.jsp?userID=4">队伍主页</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-2">--%>
                    <%--<div class="card" style="border-radius: 50%; overflow: hidden;">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">--%>
                        <%--<div class="card-block text-center">--%>
                            <%--<h5 class="card-title">--%>
                                <%--队伍名--%>
                            <%--</h5>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="index_team.jsp?userID=5">队伍主页</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-2">--%>
                    <%--<div class="card" style="border-radius: 50%; overflow: hidden;">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">--%>
                        <%--<div class="card-block text-center">--%>
                            <%--<h5 class="card-title">--%>
                                <%--队伍名--%>
                            <%--</h5>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="index_team.jsp?userID=6">队伍主页</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br />--%>

            <%--<!--缩略图-->--%>
            <%--<div class="row">--%>
                <%--<div class="col-md-4">--%>
                    <%--<div class="card">--%>
                        <%--<a href="productDetail.jsp">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="https://www.layoutit.com/img/people-q-c-600-200-1.jpg">--%>
                        <%--</a>--%>
                        <%--<div class="card-block">--%>
                            <%--<h5 class="card-title">--%>
                                <%--商品1--%>
                            <%--</h5>--%>
                            <%--<p class="card-text">--%>
                                <%--商品介绍--%>
                            <%--</p>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-4">--%>
                    <%--<div class="card">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail Second" src="https://www.layoutit.com/img/city-q-c-600-200-1.jpg">--%>
                        <%--<div class="card-block">--%>
                            <%--<h5 class="card-title">--%>
                                <%--商品2--%>
                            <%--</h5>--%>
                            <%--<p class="card-text">--%>
                                <%--商品介绍--%>
                            <%--</p>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-4">--%>
                    <%--<div class="card">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail Third" src="https://www.layoutit.com/img/sports-q-c-600-200-1.jpg">--%>
                        <%--<div class="card-block">--%>
                            <%--<h5 class="card-title">--%>
                                <%--商品3--%>
                            <%--</h5>--%>
                            <%--<p class="card-text">--%>
                                <%--商品介绍--%>
                            <%--</p>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br />--%>

            <%--<!--缩略图2-->--%>
            <%--<div class="row">--%>
                <%--<div class="col-md-4">--%>
                    <%--<div class="card">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail First" src="https://www.layoutit.com/img/people-q-c-600-200-1.jpg">--%>
                        <%--<div class="card-block">--%>
                            <%--<h5 class="card-title">--%>
                                <%--商品4--%>
                            <%--</h5>--%>
                            <%--<p class="card-text">--%>
                                <%--商品介绍--%>
                            <%--</p>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-4">--%>
                    <%--<div class="card">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail Second" src="https://www.layoutit.com/img/city-q-c-600-200-1.jpg">--%>
                        <%--<div class="card-block">--%>
                            <%--<h5 class="card-title">--%>
                                <%--商品5--%>
                            <%--</h5>--%>
                            <%--<p class="card-text">--%>
                                <%--商品介绍--%>
                            <%--</p>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-4">--%>
                    <%--<div class="card">--%>
                        <%--<img class="card-img-top" alt="Bootstrap Thumbnail Third" src="https://www.layoutit.com/img/sports-q-c-600-200-1.jpg">--%>
                        <%--<div class="card-block">--%>
                            <%--<h5 class="card-title">--%>
                                <%--商品6--%>
                            <%--</h5>--%>
                            <%--<p class="card-text">--%>
                                <%--商品介绍--%>
                            <%--</p>--%>
                            <%--<p>--%>
                                <%--<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>--%>
                            <%--</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>

<%--<script src="js/jquery.min.js"></script>--%>
<%--<script src="js/bootstrap.min.js"></script>--%>
<%--<script src="js/scripts.js"></script>--%>
<%--</body>--%>
<%--</html>--%>