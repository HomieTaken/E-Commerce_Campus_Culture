<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/5/005
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-购物车</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">

</head>
<body>

<div class="container-fluid">
    <br />
    <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
        <a class="navbar-brand col-sm-10" href="#" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng-购物车 </a>


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
                    <%--<a class="dropdown-item" href="#">地址</a>--%>
                    <%--<a class="dropdown-item" href="#">支付设置</a>--%>
                    <a class="dropdown-item" href="/logout.action">退出登录</a>
                </div>
            </div>
</s:else>
        </li>
    </ul>

    <div class="row" style="margin-top:5%">


        <div class="col-md-12">

            <div class="card">
                <div class="card-header">
                    <a class="card-link collapsed" data-toggle="collapse"  href="#card-element-1">1. 印象武大纪念明信片</a>
                </div>
                <div id="card-element-1" class="collapse">
                    <div class="card-body">
                        <div class="row" style="margin:10px">
                            <!--图片-->
                            <div class="col-md-4">
                                <img class="img-thumbnail" alt="Bootstrap Image Preview" style="height:100px" src="img/WHUpro1.jpg" />
                            </div>
                            <!--价格-->
                            <div class="col-md-2" style="margin-top:35px">
                                ￥10
                            </div>
                            <!--数量-->
                            <div class="col-md-2" style="margin-top:35px">
                                4
                            </div>
                            <!--总价-->
                            <div class="col-md-3 text-danger" style="margin-top:35px">
                                ￥40
                            </div>
                            <div class="col-md-1" style="margin-top:35px">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox">
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <em>来自 武汉大学 一码平川团队</em>
                </div>
            </div>
            <br />

            <div class="card">
                <div class="card-header">
                    <a class="card-link collapsed" data-toggle="collapse" data-parent="#card-616798" href="#card-element-2">2.清华纪念册</a>
                </div>
                <div id="card-element-2" class="collapse">
                    <div class="card-body">
                        <div class="row" style="margin:10px">
                            <!--图片-->
                            <div class="col-md-4">
                                <img class="img-thumbnail" style="height:100px" alt="Bootstrap Image Preview" src="img/WHUpro2.jpg" />
                            </div>
                            <!--价格-->
                            <div class="col-md-2" style="margin-top:35px">
                                ￥30
                            </div>
                            <!--数量-->
                            <div class="col-md-2" style="margin-top:35px">
                                2
                            </div>
                            <!--总价-->
                            <div class="col-md-3 text-danger" style="margin-top:35px">
                                ￥60
                            </div>
                            <div class="col-md-1" style="margin-top:35px">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox">
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <em>来自 清华大学 异火团队</em>
                </div>
            </div>
            <br />

            <div class="card">
                <div class="card-header">
                    <a class="card-link collapsed" data-toggle="collapse" data-parent="#card-616798" href="#card-element-3">3. 未名湖图册</a>
                </div>
                <div id="card-element-3" class="collapse">
                    <div class="card-body">
                        <div class="row" style="margin:10px">
                            <!--图片-->
                            <div class="col-md-4">
                                <img class="img-thumbnail" alt="Bootstrap Image Preview" style="height:100px" src="img/WHUpro3.jpg" />
                            </div>
                            <!--价格-->
                            <div class="col-md-2" style="margin-top:35px">
                                ￥20
                            </div>
                            <!--数量-->
                            <div class="col-md-2" style="margin-top:35px">
                                3
                            </div>
                            <!--总价-->
                            <div class="col-md-3 text-danger" style="margin-top:35px">
                                ￥60
                            </div>
                            <div class="col-md-1" style="margin-top:35px">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox">
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <em>来自 北京大学 零行团队</em>
                </div>
            </div>
        </div>
    </div>
    <br />

    <!--提交-->
    <div class="row">
        <div class="col-md-1">
            <strong>合计：</strong>
        </div>
        <div class="text-danger col-md-1">
            ￥0.00
        </div>
    </div>
    <br/>

    <a id="modal-774029" href="#modal-container-774029" role="button" class="btn btn-warning" data-toggle="modal">结算</a>

    <div class="modal fade" id="modal-container-774029" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel">
                        结算
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    确认付款？
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary">
                        确认
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        取消
                    </button>
                </div>
            </div>

        </div>

    </div>
    <br /><br />

</div>


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
    <%--<link href="css/style.css" rel="stylesheet">--%>

<%--</head>--%>
<%--<body>--%>

<%--<div class="container-fluid">--%>
    <%--<br />--%>
    <%--<div class="row">--%>
        <%--<div class="col-md-1">--%>
            <%--<img alt="Bootstrap Image Preview" height="60px" width="120px" src="img/qingmang.png">--%>
        <%--</div>--%>
        <%--<div class="col-md-2">--%>
            <%--<br />--%>
            <%--<img alt="Bootstrap Image Preview" height="40px" width="120px" src="img/shopcart.png">--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<br />--%>

    <%--<div class="row">--%>


        <%--<div class="col-md-12">--%>

            <%--<div class="card">--%>
                <%--<div class="card-header">--%>
                    <%--<a class="card-link collapsed" data-toggle="collapse"  href="#card-element-1">1. 印象武大纪念明信片</a>--%>
                <%--</div>--%>
                <%--<div id="card-element-1" class="collapse">--%>
                    <%--<div class="card-body">--%>
                        <%--<div class="row">--%>
                            <%--<!--图片-->--%>
                            <%--<div class="col-md-4">--%>
                                <%--<img alt="Bootstrap Image Preview" width="100px" height="100px" src="img/WHUpro1.jpg" />--%>
                            <%--</div>--%>
                            <%--<!--价格-->--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--￥10--%>
                            <%--</div>--%>
                            <%--<!--数量-->--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--4--%>
                            <%--</div>--%>
                            <%--<!--总价-->--%>
                            <%--<div class="col-md-2 text-danger">--%>
                                <%--<br />--%>
                                <%--￥40--%>
                            <%--</div>--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--<div class="checkbox">--%>
                                    <%--<label>--%>
                                        <%--<input type="checkbox">--%>
                                    <%--</label>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="card-footer">--%>
                    <%--<em>来自 武汉大学 一码平川团队</em>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br />--%>

            <%--<div class="card">--%>
                <%--<div class="card-header">--%>
                    <%--<a class="card-link collapsed" data-toggle="collapse" data-parent="#card-616798" href="#card-element-2">2.清华纪念册</a>--%>
                <%--</div>--%>
                <%--<div id="card-element-2" class="collapse">--%>
                    <%--<div class="card-body">--%>
                        <%--<div class="row">--%>
                            <%--<!--图片-->--%>
                            <%--<div class="col-md-4">--%>
                                <%--<img alt="Bootstrap Image Preview" width="100px" height="100px" src="WHUpro2.jpg" />--%>
                            <%--</div>--%>
                            <%--<!--价格-->--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--￥30--%>
                            <%--</div>--%>
                            <%--<!--数量-->--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--2--%>
                            <%--</div>--%>
                            <%--<!--总价-->--%>
                            <%--<div class="col-md-2 text-danger">--%>
                                <%--<br />--%>
                                <%--￥60--%>
                            <%--</div>--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--<div class="checkbox">--%>
                                    <%--<label>--%>
                                        <%--<input type="checkbox">--%>
                                    <%--</label>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="card-footer">--%>
                    <%--<em>来自 清华大学 异火团队</em>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br />--%>

            <%--<div class="card">--%>
                <%--<div class="card-header">--%>
                    <%--<a class="card-link collapsed" data-toggle="collapse" data-parent="#card-616798" href="#card-element-3">2. 未名湖图册</a>--%>
                <%--</div>--%>
                <%--<div id="card-element-3" class="collapse">--%>
                    <%--<div class="card-body">--%>
                        <%--<div class="row">--%>
                            <%--<!--图片-->--%>
                            <%--<div class="col-md-4">--%>
                                <%--<img alt="Bootstrap Image Preview" width="100px" height="100px" src="img/WHUpro3.jpg" />--%>
                            <%--</div>--%>
                            <%--<!--价格-->--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--￥20--%>
                            <%--</div>--%>
                            <%--<!--数量-->--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--3--%>
                            <%--</div>--%>
                            <%--<!--总价-->--%>
                            <%--<div class="col-md-2 text-danger">--%>
                                <%--<br />--%>
                                <%--￥60--%>
                            <%--</div>--%>
                            <%--<div class="col-md-2">--%>
                                <%--<br />--%>
                                <%--<div class="checkbox">--%>
                                    <%--<label>--%>
                                        <%--<input type="checkbox">--%>
                                    <%--</label>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="card-footer">--%>
                    <%--<em>来自 北京大学 零行团队</em>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<br />--%>

    <%--<!--提交-->--%>
    <%--<div class="row">--%>
        <%--<div class="col-md-1">--%>
            <%--<strong>合计：</strong>--%>
        <%--</div>--%>
        <%--<div class="text-danger col-md-1">--%>
            <%--￥0.00--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<br/>--%>
    <%--<br />--%>

    <%--<a id="modal-774029" href="#modal-container-774029" role="button" class="btn btn-warning" data-toggle="modal">结算</a>--%>

    <%--<div class="modal fade" id="modal-container-774029" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--%>
        <%--<div class="modal-dialog" role="document">--%>
            <%--<div class="modal-content">--%>
                <%--<div class="modal-header">--%>
                    <%--<h5 class="modal-title" id="myModalLabel">--%>
                        <%--结算--%>
                    <%--</h5>--%>
                    <%--<button type="button" class="close" data-dismiss="modal">--%>
                        <%--<span aria-hidden="true">×</span>--%>
                    <%--</button>--%>
                <%--</div>--%>
                <%--<div class="modal-body">--%>
                    <%--确认付款？--%>
                <%--</div>--%>
                <%--<div class="modal-footer">--%>

                    <%--<button type="button" class="btn btn-primary">--%>
                        <%--确认--%>
                    <%--</button>--%>
                    <%--<button type="button" class="btn btn-secondary" data-dismiss="modal">--%>
                        <%--取消--%>
                    <%--</button>--%>
                <%--</div>--%>
            <%--</div>--%>

        <%--</div>--%>

    <%--</div>--%>
    <%--<br /><br />--%>

<%--</div>--%>


<%--<script src="js/jquery.min.js"></script>--%>
<%--<script src="js/bootstrap.min.js"></script>--%>
<%--<script src="js/scripts.js"></script>--%>
<%--</body>--%>
<%--</html>--%>
