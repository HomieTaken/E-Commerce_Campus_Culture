<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/4/004
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>青芒-登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
</head>
<body  background="img/loginbg5.jpg">
<div class="container-fluid">

    <!--青芒logo-->
    <br />
    <br />
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-1">
            <img alt="Bootstrap Image Preview" height="50px" width="100px" src="img/logo%20.png">
        </div>
        <div class="col-md-7" style="margin-top:1%">
            <img alt="Bootstrap Image Preview" height="40px" width="320px" src="img/pintai1.png">
        </div>
    </div>

    <br />
    <br />
    <div class="col-sm-6 " style="margin-left:35%">
        <s:fielderror name="userName"/>
    </div>
    <form action="login.action" method="post" role="form">
        <div class="row">
            <div class="input-group col-sm-6 " style="margin-left:25%">
			    <span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
			        <span class="glyphicon glyphicon-user">
			        </span>
			    </span>
                <input name="userName" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" type="text" class="form-control" id="username" placeholder="请输入名字" >
            </div>
            <div class="col-sm-2">
                <em id="name"></em>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="input-group col-sm-6" style="margin-left:25%">
                <span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
			        <span class="glyphicon glyphicon-lock">
			        </span>
			    </span>
                <input name = "userPassword" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" id="userpwd" placeholder="请输入密码" type="password" class="form-control">
            </div>
            <div class="col-sm-2">
                <em id="pwd"></em>
            </div>
        </div>
        <br />
        <br />
        <div class="form-group" style="margin-left:34%">
            <div class="col-sm-offset-2 col-md-6">
                <button class="btn btn-info btn-block" onclick="return checkLogin()">登录&emsp;
                    <span class="glyphicon glyphicon-share-alt" >
			        </span>
                </button>
            </div>
        </div>
    </form>
    <div style="margin-left:53%">
        <label class="col-md-4 control-label"><a href = "/register.jsp"  data-toggle="modal">没有账户？注册一个</a></label>
    </div>


</div>

<!-- 包括所有已编译的插件 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js" charset="UTF-8"></script>


</body>
</html>