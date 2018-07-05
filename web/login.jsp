<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/4/004
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bootstrap 模板</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">

</head>

<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div class="page-header">
                <h2>
                    <em>易学购 <small>一个年轻的校园文化电子商务平台</small></em>
                </h2>
            </div>
        </div>
    </div>

    <form action="login.action" method="post" class="form-horizontal" role="form">

        <div class="form-group">
            <label for="firstname" class="col-sm-2 control-label">账户名</label>
            <div class="col-sm-8">
                <input name="userName" type="text" class="form-control" id="firstname" placeholder="请输入名字">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="inputPassword" >密码</label>
            <div class="col-sm-8">
                <input name="userPassword" id="inputPassword" placeholder="Password" type="password" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <div class="checkbox">
                    <label>
                        <input type="checkbox">记住密码
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">登录</button>
            </div>
        </div>
    </form>
    <br><br><br>
    <form class="form-horizontal" role="form">
        <div class="form-group">
            <label for="register" class="col-sm-2 control-label">没有账户？注册一个</label>
            <div class="col-sm-8">
                <button type="submit" class="btn btn-default" id="register">点此注册</button>
            </div>
        </div>
    </form>

</div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="js/jquery-3.3.1.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="js/bootstrap.min.js"></script>
</body>
</html>
