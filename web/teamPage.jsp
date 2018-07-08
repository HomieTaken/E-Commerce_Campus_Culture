<%@ page import="java.sql.ResultSet" %>
<%@ page import="DataBase.DBOperation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.CultureProduct" %>
<%@ page import="Entity.Activity" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/5/005
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-团队主页</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">

</head>
<%
//    session.getAttribute("user_id");
    String sqlProduct="select * from product where product_team_id=4";
    String sqlActivity="select * from activity where activity_team_id=4";
    ArrayList<CultureProduct> products=new ArrayList<>();
    ArrayList<Activity> activities=new ArrayList<>();
    try {
        ResultSet rsProduct=DBOperation.getRS(sqlProduct);
        while (rsProduct.next()){
            CultureProduct product=new CultureProduct();
            product.setProductID(rsProduct.getInt(1));
            product.setDescription(rsProduct.getString(2));
            product.setPicture(rsProduct.getBlob(3));
            product.setName(rsProduct.getString(4));
            product.setPrice(rsProduct.getDouble(5));
            product.setTeamID(rsProduct.getInt(6));
            product.setAmount(rsProduct.getInt(7));
            products.add(product);
        }

        ResultSet rsActivity=DBOperation.getRS(sqlActivity);
        while (rsActivity.next()){
            Activity activity=new Activity();
            activity.setActivityID(rsActivity.getInt(1));
            activity.setActivityName(rsActivity.getString(2));
            activity.setTeamID(rsActivity.getInt(3));
            activity.setReleaseDate(rsActivity.getDate(4));
            activity.setEndDate(rsActivity.getDate(5));
            activity.setDescription(rsActivity.getString(6));
            activity.setAddress(rsActivity.getString(7));
            activities.add(activity);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" >
    <ol class="breadcrumb" style="background-color: #CAFFFF; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px; box-shadow: 10px 10px 5px #888888;">
        <div class="row">
            <div class="col-md-4">
                <li class="breadcrumb-item ">
                    <img src="img/logo%20.png" alt="Logo" style="width:70px;height: 35px;">
                </li>
                <li class="breadcrumb-item center-vertical">
                    <a href="#publishedpro">已发布商品</a>
                </li>
                <li class="breadcrumb-item center-vertical">
                    <a href="#publishedact">已发布活动</a>
                </li>
            </div>

            <div class="col-md-6">

            </div>

            <div class="col-md-2">
                <li class="breadcrumb-item ">
                    <div class="dropdown">
                        <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="text-shadow: black 5px 3px 3px;">
                            <span class="glyphicon glyphicon-user"></span>&emsp; 已登录
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item disabled" href="#">Action</a>
                            <a class="dropdown-item" href="">修改信息</a>
                            <a class="dropdown-item" href="logout.action">退出登录</a>
                        </div>
                    </div>
                </li>
            </div>

        </div>
    </ol>
</nav>
<br /><br /><br /><br />

<div class="container-fluid">


    <div class="row">

        <div class="col-md-6">
            <div class="carousel slide" id="carousel-335963"  style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 10px 10px 5px #888888;">
                <ol class="carousel-indicators">
                    <li data-slide-to="0" data-target="#carousel-335963">
                    </li>
                    <li data-slide-to="1" data-target="#carousel-335963" class="active">
                    </li>
                    <li data-slide-to="2" data-target="#carousel-335963">
                    </li>
                </ol>
                <div class="carousel-inner" >
                    <div class="carousel-item">
                        <img class="d-block w-100" alt="Carousel Bootstrap First" src="img/showimg3.png">
                    </div>
                    <div class="carousel-item active">
                        <img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/showimg7.png">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" alt="Carousel Bootstrap Third" src="img/showimg5.png">
                    </div>
                </div> <a class="carousel-control-prev" href="#carousel-335963" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-335963" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>
            </div>

            <!--已发布商品-->
            <br />
            <div id="publishedpro" class="card" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
                <div class="card-header">
                    已发布商品
                </div>
                <div class="card-body">
                    <table class="table">
                        <th>产品</th><th>价格 </th><th>库存 </th>
                        <%for (CultureProduct product:products) {%>
                            <tr><td><%=product.getName()%></td><td>￥<%=product.getPrice()%></td><td><%=product.getAmount()%></td></tr>
                        <%}%>
                        <%--<tr><td>产品 A</td><td>￥200</td><td>10</td></tr>--%>
                        <%--<tr><td>产品 B</td><td>￥400</td><td>20</td></tr>--%>
                        <%--<tr><td>产品 B</td><td>￥100</td><td>19</td></tr>--%>
                        <%--<tr><td>产品 B</td><td>￥50</td><td>50</td></tr>--%>
                    </table>
                </div>
                <div class="card-footer">
                    <br />
                </div>
            </div>
        </div>

        <!--边框颜色：border:solid 2px pink;
        -->
        <div class="col-md-6">
            <div class="card" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
                <div class="card-header">
                    发布
                </div>
                <div class="card-body">
                    <br />
                    <div class="tabbable col-sm-11" id="tabs-607311" style="margin-left:5%">
                        <ul class="nav nav-pills role='tablist'">
                        <li class="nav-item ">
                            <a class="nav-link active" href="#panel-832269" data-toggle="pill">发布商品</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#panel-364800" data-toggle="pill">发布活动</a>
                        </li>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane active show" id="panel-832269">
                                <br />
                                <form enctype="multipart/form-data" action="releaseProduct.action" method="post" class="form-horizontal" role="form" >
                                    <div class="form-group">
                                        <label for="goods">
                                            商品名:
                                        </label>
                                        <input name="productName" type="text" class="form-control" id="goods">
                                    </div>
                                    <div class="form-group">
                                        <label for="goodsprice">
                                            商品价格:
                                        </label>
                                        <input name="productPrice" type="number" class="form-control" id="goodsprice">
                                    </div>
                                    <div class="form-group">
                                        <label for="goodsnum">
                                            商品数量:
                                        </label>
                                        <input name="productAmount" type="number" class="form-control" id="goodsnum">
                                    </div>
                                    <div class="form-group">
                                        <label for="goodsdescription">
                                            商品描述:
                                        </label>
                                        <textarea name="description" cols="4" class="form-control" id="goodsdescription">输入商品描述</textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="picture">
                                            上传图片:
                                        </label>
                                        <input name="imgFile" type="file" class="form-control-file" id="picture">
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        发布
                                    </button>

                                </form>
                            </div>

                            <div class="tab-pane" id="panel-364800">
                                <br />
                                <form action="releaseActivity.action" method="post" role="form">
                                    <div class="form-group">
                                        <label for="activityname">
                                            活动名:
                                        </label>
                                        <input name="activityName" type="text" class="form-control" id="activityname">
                                    </div>
                                    <div class="form-group">
                                        <label for="activityaddress">
                                            活动地点:
                                        </label>
                                        <input name="activityAddress" type="text" class="form-control" id="activityaddress">
                                    </div>
                                    <div class="form-group">
                                        <label for="begindate">
                                            开始日期:
                                        </label>
                                        <input name="beginDate" type="date" class="form-control" id="begindate">
                                    </div>
                                    <div class="form-group">
                                        <label for="enddate">
                                            结束日期:
                                        </label>
                                        <input name="endDate" type="date" class="form-control" id="enddate">
                                    </div>
                                    <div class="form-group">
                                        <label for="activitydes">
                                            活动描述:
                                        </label>
                                        <textarea name="description" cols="4" class="form-control" id="activitydes">输入商品描述</textarea>
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        发布
                                    </button>

                                </form>
                            </div>
                        </div>
                        <br />
                    </div>
                </div>
                <div class="card-footer">
                    <br />
                </div>
            </div>

            <!--已发布活动-->
            <br />
            <div id="publishedact" class="card" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
                <div class="card-header">
                    已发布活动
                </div>
                <div class="card-body">
                    <table class="table">
                        <th>活动名</th><th>活动地点</th><th>开始时间</th><th>结束时间</th>
                        <%for (Activity activity:activities){%>
                            <tr><td><%=activity.getActivityName()%></td><td><%=activity.getAddress()%></td><td><%=activity.getReleaseDate()%></td><td><%=activity.getEndDate()%></td></tr>
                        <%}%>
                        <%--<tr><td>活动1</td><td>珞珈山</td><td>9-01</td><td>9-02</td></tr>--%>
                        <%--<tr><td>活动2</td><td>珞珈创意城</td><td>9-05</td><td>9-07</td></tr>--%>
                    </table>
                </div>
                <div class="card-footer">
                    <br />
                </div>
            </div>
        </div>
    </div>
</div>


<br /><br /><br />
<nav class="navbar navbar-expand-lg navbar-light bg-info">
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

    <%--<title>Bootstrap 4, from LayoutIt!</title>--%>

    <%--<meta name="description" content="Source code generated using layoutit.com">--%>
    <%--<meta name="author" content="LayoutIt!">--%>

    <%--<link href="css/bootstrap.min.css" rel="stylesheet">--%>
    <%--&lt;%&ndash;<link href="css/style.css" rel="stylesheet">&ndash;%&gt;--%>

<%--</head>--%>
<%--<body>--%>

<%--<div class="container-fluid">--%>
    <%--<div class="row">--%>
        <%--<div class="col-md-9">--%>
            <%--<br>--%>
            <%--<div class="row-fluid">--%>
                <%--<div class="span12">--%>
                    <%--<div class="page-header">--%>
                        <%--<h2>--%>
                            <%--<em>青芒 <small>一个年轻的校园文化电子商务平台</small></em>--%>
                        <%--</h2>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br>--%>
        <%--</div>--%>

        <%--<div class="col-md-1">--%>
            <%--<br>--%>
            <%--<a id="modal-739657" href="#modal-container-739657" role="button" class="btn" data-toggle="modal">设置</a>--%>

            <%--<div class="modal fade" id="modal-container-739657" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--%>
                <%--<div class="modal-dialog" role="document">--%>
                    <%--<div class="modal-content">--%>
                        <%--<div class="modal-header">--%>
                            <%--<h5 class="modal-title" id="myModalLabel">--%>
                                <%--更改团队设置--%>
                            <%--</h5>--%>
                            <%--<button type="button" class="close" data-dismiss="modal">--%>
                                <%--<span aria-hidden="true">×</span>--%>
                            <%--</button>--%>
                        <%--</div>--%>
                        <%--<div class="modal-body">--%>
                            <%--<form class="form-horizontal" role="form">--%>
                                <%--<div class="form-group">--%>
                                    <%--<label for="chteamname">--%>
                                        <%--更改团队名:--%>
                                    <%--</label>--%>
                                    <%--<input type="text" class="form-control" id="chteamname">--%>
                                <%--</div>--%>
                                <%--<button type="submit" class="btn btn-primary">--%>
                                    <%--保存更改--%>
                                <%--</button>--%>

                            <%--</form>--%>
                        <%--</div>--%>
                        <%--<div class="modal-footer">--%>
                            <%--<button type="button" class="btn btn-secondary" data-dismiss="modal">--%>
                                <%--关闭--%>
                            <%--</button>--%>
                        <%--</div>--%>
                    <%--</div>--%>

                <%--</div>--%>

            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="col-md-2">--%>
            <%--<br>--%>
            <%--<a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">xx小组在线</a>--%>
            <%--<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">--%>
                <%--<a class="dropdown-item" href="#">来自xx大学</a>--%>
                <%--<a class="dropdown-item" href="#">粉丝 999</a>--%>
                <%--<div class="dropdown-divider">--%>
                <%--</div>--%>
                <%--<a class="dropdown-item" href="#">退出登录</a>--%>
            <%--</div>--%>

        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="row">--%>
        <%--<div class="col-md-6">--%>
            <%--<div class="tabbable" id="tabs-607311">--%>

                <%--<ul class="nav nav-tabs">--%>
                    <%--<li class="nav-item ">--%>
                        <%--<a class="nav-link active show" href="#panel-832269" data-toggle="tab">发布商品</a>--%>
                    <%--</li>--%>
                    <%--<li class="nav-item">--%>
                        <%--<a class="nav-link" href="#panel-364800" data-toggle="tab">发布活动</a>--%>
                    <%--</li>--%>
                <%--</ul>--%>

                <%--<div class="tab-content">--%>
                    <%--<div class="tab-pane active show" id="panel-832269">--%>
                        <%--<br />--%>
                        <%--<form enctype="multipart/form-data" action="releaseProduct.action" method="post" class="form-horizontal" role="form" >--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="goods">--%>
                                    <%--商品名:--%>
                                <%--</label>--%>
                                <%--<input name="productName" type="text" class="form-control" id="goods">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="goodsprice">--%>
                                    <%--商品价格:--%>
                                <%--</label>--%>
                                <%--<input name="productPrice" type="number" class="form-control" id="goodsprice">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="goodsnum">--%>
                                    <%--商品数量:--%>
                                <%--</label>--%>
                                <%--<input name="productAmount" type="number" class="form-control" id="goodsnum">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="goodsdescription">--%>
                                    <%--商品描述:--%>
                                <%--</label>--%>
                                <%--<textarea name="description" cols="4" class="form-control" id="goodsdescription">输入商品描述</textarea>--%>
                            <%--</div>--%>

                            <%--<div class="form-group">--%>
                                <%--<label for="picture">--%>
                                    <%--上传图片--%>
                                <%--</label>--%>
                                <%--<input name="imgFile" type="file" class="form-control-file" id="picture" onchange="fileChooser(this)">--%>
                            <%--</div>--%>

                            <%--<button type="submit" class="btn btn-primary">--%>
                                <%--发布--%>
                            <%--</button>--%>

                        <%--</form>--%>
                    <%--</div>--%>

                    <%--<div class="tab-pane" id="panel-364800">--%>
                        <%--<br />--%>
                        <%--<form role="form">--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="activityname">--%>
                                    <%--活动名:--%>
                                <%--</label>--%>
                                <%--<input type="text" class="form-control" id="activityname">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="begindate">--%>
                                    <%--开始日期:--%>
                                <%--</label>--%>
                                <%--<input type="date" class="form-control" id="begindate">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="enddate">--%>
                                    <%--结束日期:--%>
                                <%--</label>--%>
                                <%--<input type="date" class="form-control" id="enddate">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="activitydes">--%>
                                    <%--活动描述:--%>
                                <%--</label>--%>
                                <%--<textarea cols="4" class="form-control" id="activitydes">输入商品描述</textarea>--%>
                            <%--</div>--%>

                            <%--<button type="submit" class="btn btn-primary">--%>
                                <%--发布--%>
                            <%--</button>--%>

                        <%--</form>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

        <%--</div>--%>

        <%--<div class="col-md-6">--%>
            <%--<ul class="nav">--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link active" href="#">已发布商品</a>--%>
                <%--</li>--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="#">已发布活动</a>--%>
                <%--</li>--%>
            <%--</ul>--%>
            <%--<ol>--%>
                <%--<li class="list-item">--%>
                    <%--商品1--%>
                <%--</li>--%>
                <%--<li class="list-item">--%>
                    <%--商品2--%>
                <%--</li>--%>
                <%--<li class="list-item">--%>
                    <%--商品3--%>
                <%--</li>--%>
                <%--<li class="list-item">--%>
                    <%--Facilisis in pretium nisl aliquet--%>
                <%--</li>--%>
                <%--<li class="list-item">--%>
                    <%--Nulla volutpat aliquam velit--%>
                <%--</li>--%>
                <%--<li class="list-item">--%>
                    <%--Faucibus porta lacus fringilla vel--%>
                <%--</li>--%>
                <%--<li class="list-item">--%>
                    <%--Aenean sit amet erat nunc--%>
                <%--</li>--%>
                <%--<li class="list-item">--%>
                    <%--Eget porttitor lorem--%>
                <%--</li>--%>
            <%--</ol>--%>
            <%--<nav>--%>
                <%--<ul class="pagination">--%>
                    <%--<li class="page-item">--%>
                        <%--<a class="page-link" href="#">Previous</a>--%>
                    <%--</li>--%>
                    <%--<li class="page-item">--%>
                        <%--<a class="page-link" href="#">1</a>--%>
                    <%--</li>--%>
                    <%--<li class="page-item">--%>
                        <%--<a class="page-link" href="#">2</a>--%>
                    <%--</li>--%>
                    <%--<li class="page-item">--%>
                        <%--<a class="page-link" href="#">3</a>--%>
                    <%--</li>--%>
                    <%--<li class="page-item">--%>
                        <%--<a class="page-link" href="#">4</a>--%>
                    <%--</li>--%>
                    <%--<li class="page-item">--%>
                        <%--<a class="page-link" href="#">5</a>--%>
                    <%--</li>--%>
                    <%--<li class="page-item">--%>
                        <%--<a class="page-link" href="#">Next</a>--%>
                    <%--</li>--%>
                <%--</ul>--%>
            <%--</nav>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>

<%--<script src="js/jquery.min.js"></script>--%>
<%--<script src="js/bootstrap.min.js"></script>--%>
<%--<script src="js/scripts.js"></script>--%>
<%--</body>--%>
<%--</html>--%>
