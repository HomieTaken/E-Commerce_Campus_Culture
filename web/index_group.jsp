<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/4/004
  Time: 22:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>interestgroup</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <%--<link href="css/style.css" rel="stylesheet">--%>

</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">

            <nav>
                <ol class="breadcrumb">
                    <div class="row">
                        <div class="col-md-4">
                            <li class="breadcrumb-item ">
                                <img src="img/logo%20.png" alt="Logo" style="width:70px;height: 35px;">
                            </li>
                            <li class="breadcrumb-item center-vertical">
                                <a href="/index.jsp">主页</a>
                            </li>
                            <li class="breadcrumb-item center-vertical">
                                <a href="/index_group.jsp">兴趣小组</a>
                            </li>
                            <li class="breadcrumb-item center-vertical">
                                <a href="/index_team.jsp">产品团队</a>
                            </li>
                        </div>

                        <div class="col-md-6">
                            <li class="breadcrumb-item ">
                                <form class="form-inline">
                                    <input class="form-control mr-sm-2" type="text" style="width: 400px;">
                                    <button class="btn btn-primary my-2 my-sm-0" type="submit" >
                                        Search
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
                                            <a class="dropdown-item disabled" href="#">修改信息</a>
                                            <a class="dropdown-item" href="/shoppingcart.jsp">购物车</a>
                                            <a class="dropdown-item" href="/index.jsp">退出登录</a>
                                        </div>
                                    </div>
                                </li>
                            </div>
                        </s:else>
                    </div>
                </ol>
            </nav>

            <div class="list-group">
                <a href="#" class="list-group-item list-group-item-action active">Home</a>
                <div class="list-group-item">
                    聊天框
                </div>
                <div class="list-group-item">
                    <h4 class="list-group-item-heading">
                        List group item heading
                    </h4>
                    <p class="list-group-item-text">
                        ...
                    </p>
                </div>
                <div class="list-group-item justify-content-between">
                    Help <span class="badge badge-secondary badge-pill">14</span>
                </div> <a href="#" class="list-group-item list-group-item-action active justify-content-between">Home <span class="badge badge-light badge-pill">14</span></a>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
</body>
</html>
