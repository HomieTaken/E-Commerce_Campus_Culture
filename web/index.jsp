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
<%@ page import="Operations.ViewProduct" %>
<%@ page import="Operations.MessageOperate" %>
<%@ page import="Actions.UpdateUserInfo" %>
<%@ page import="Entity.User" %>

<html lang="en">
<head>
    <script src="js/server-01.js"></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-用户主页</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link rel="alternate icon" href="img/qm.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/extend.css" rel="stylesheet">

    <style>
        .nav-link:hover{
            background-color: #4F4F4F;
        }

        .img-group {
            position: relative;
            display: inline-block;
        }

        .img-tip {
            position: absolute;
            bottom: 0;
            background: #333;
            color: #fff;
            opacity: 0.6;
            display: none;
        }

        .img-group:hover .img-tip {
            display: block;
            width: 100%;
            text-align: center;
        }
    </style>
</head>
<body style="background-color: #F0F0F0">
<%String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
<%
    try {
        new DisplayProduct().execute();
    } catch (Exception e) {
        e.printStackTrace();
    }
    ArrayList<CultureProduct> products = (ArrayList<CultureProduct>) session.getAttribute("products");
    ArrayList<User> teams = (ArrayList<User>)session.getAttribute("teams");
%>
<%if(request.getSession().getAttribute("user_id")!=null){%>
<script>createConn();</script>
<%}%>
<div class="container-fluid">
    <div class="row" style="margin-top:85px">
        <div class="col-md-12">

            <%--导航栏--%>
            <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
                <a class="navbar-brand col-sm-2" href="javascript:void(0)" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng </a>

                <li class="nav-item col-sm-2" style="margin-left: 20px">
                    <a class="nav-link" href="#teamList" style="height: 70px;width:110px;color:#FFFFFF;font-size:18px;"><span style="position: relative;top:12px;">优秀团队</span></a>
                </li>
                <li class="nav-item col-sm-2" style="margin-left: -110px">
                    <a class="nav-link" href="#proList" style="height: 70px;width:110px;color:#FFFFFF;font-size:18px;"><span style="position: relative;top:12px;">热销产品</span></a>
                </li>
                <li class="nav-item col-sm-2" style="margin-left: -110px">
                    <a class="nav-link" href="javascript:void(0)" style="height: 70px;width:110px;color:#FFFFFF;font-size:18px;" onclick="checkEnterChat()"><span style="position: relative;top:12px;">兴趣小组</span></a>
                </li>

                <li class="nav-item col-sm-3" style="margin-left: 40px">
                    <form class="form-inline" style="margin-top:18px;" action="search.action">
                        <input name="entry" id = "search" class="form-control mr-sm-2" type="text" style="width: 230px;">
                        <button class="btn btn-default my-2 my-sm-0"  onclick="return checkSearch()" >
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </form>
                </li>

                <s:if test="#session.message_count!=null">
                    <div class="col-sm-1">
                    <div style="margin-left:0;margin-top:18px;position:relative;left: 25px;">
                        <a href="enterMessageBox.action"><button type="button" class="btn" style="height: 38px">
                            <span class="glyphicon glyphicon-envelope"></span>
                        </button></a>
                    </div>

                    <div class="badge-bg" id="messageCircle" style="position: relative;left:65px;top:-48px;z-index:999; width:20px;
    height:20px;
    background-color:#F00;
    border-radius:25px;display:none;">
                            <span id="message_count"  class="badge-span" style="height:20px;line-height:20px;display:block;color:#FFF;text-align:center;"><s:if test="#session.message_count>0">
                                <s:property value="#session.message_count"/></s:if></span>
                    </div>
                    </div>
                    <s:if test="#session.message_count>0">
                        <script>document.getElementById("messageCircle").style.display=""</script></s:if>
                </s:if>
                <s:else>
                    <div class="col-sm-1"></div>
                </s:else>

                <li class="nav-item " style="margin-left: -40px">
                    <s:if test="#session.user_name==null">
                        <div style="margin-top:25px;margin-left:75px;">
                            <a href="login.jsp" style="color: white;margin-right: 5px">登录</a>
                            <span style="color: white">|</span>
                            <a href="register.jsp" style="color: white;margin-left: 5px">注册</a>
                        </div>
                    </s:if>
                    <s:else>
                    <div class="dropdown" style="margin-top:18px;margin-left:40px">
                        <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" >
                            <span class="glyphicon glyphicon-user"></span>&emsp;已登录
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="/enterShopping">购物车</a>
                            <a href="#modal-update" class="dropdown-item" data-toggle="modal" style="height:30px;">修改信息</a>
                            <a class="dropdown-item" href="logout.action">退出登录</a>
                        </div>
                    </div>
                    </s:else>
                </li>
            </ul>

            <%--信息修改--%>
            <div class="row">
                <div class="col-md-12">

                    <div class="modal fade" id="modal-update" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="myModalLabel">
                                        修改用户<b><%=(String)session.getAttribute("user_name")%></b>的信息
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!--修改信息页面主体-->
                                    <form action="update_user_info.action" role="form" class="form-horizontal">

                                        <br />
                                        <div class="input-group col-sm-10 " style="margin-left:10%">
									<span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
									<span class="glyphicon glyphicon-user">
									</span>
									</span>
                                            <input name="name" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" type="text" class="form-control" id="username" placeholder="修改昵称">
                                            <em id="name"></em>
                                        </div>
                                        <br />
                                        <div class="input-group col-sm-10" style="margin-left:10%">
									<span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
									<span class="glyphicon glyphicon-lock">
									</span>
									</span>
                                            <input name = "password" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" id="userpwd1" placeholder="修改密码" type="password" class="form-control">
                                            <em id="pwd1"></em>
                                        </div>
                                        <br />
                                        <div class="input-group col-sm-10" style="margin-left:10%">
									<span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
									<span class="glyphicon glyphicon-lock">
									</span>
									</span>
                                            <input  style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" id="userpwd2" placeholder="确认密码" type="password" class="form-control">
                                            <em id="pwd2"></em>
                                        </div>
                                        <br />
                                        <div class="input-group col-sm-10" style="margin-left:10%">
									<span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
									<span class="glyphicon glyphicon-envelope">
									</span>
									</span>
                                            <input name = "email" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" id="useremail" placeholder="修改邮箱" type="email" class="form-control">
                                            <em id="email"></em>
                                        </div>
                                        <br />
                                        <div class="form-group" style="margin-left:34%">
                                            <div class="col-sm-offset-2 col-md-6">
                                                <button type="submit" class="btn btn-info btn-block" onclick="return checkRegister()">确认修改</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>

            <!--轮播图-->
            <div  style="background-color:white;padding: 20px">
                <div class="row" >
                    <div class="col-md-9">
                        <div class=" carousel slide" id="carousel-335963" style="overflow:hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;-webkit-box-shadow: #666 0px 0px 10px;">
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
                                    <img class="d-block w-100" alt="Carousel Bootstrap First" src="img/showimg8.png" style="width: 900px;height: 500px">
                                    <div class="carousel-caption">
                                        <h4>
                                        </h4>
                                        <p>
                                        </p>
                                    </div>
                                </div>
                                <div class="carousel-item active">
                                    <img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/showimg9.png" style="width: 950px;height: 500px">
                                    <div class="carousel-caption">
                                        <h4>
                                        </h4>
                                        <p>
                                        </p>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" alt="Carousel Bootstrap Third" src="img/showimg10.png" style="width: 950px;height: 500px">
                                    <div class="carousel-caption">
                                        <h4>
                                        </h4>
                                        <p>
                                        </p>
                                    </div>
                                </div>
                            </div> <a class="carousel-control-prev" href="#carousel-335963" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-335963" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>
                        </div>
                    </div>

                    <div class="col-md-2" style="margin-left: 40px;">
                        <img src="img/advertise.png" style="width: 200px;height: 500px;">
                    </div>
                </div>
            </div>
            <br />

            <!--团队介绍缩略图-->
            <div id="teamList" style="padding: 20px">
                <div class="row" style="margin-top:0px">
                    <div class="col-md-6" style="background-color:white;padding: 20px;left: -5px;">
                        <blockquote class="blockquote" style="margin-left: 10px;">
                            <p class="mb-0" style="font-size: 16px">
                                任何一个文化的轮廓，在不同的人的眼里看来都可能是一幅不同的图景。
                            </p>
                        </blockquote>
                        <div class="img-group" style="margin-left: 10px;height: 180px;width: 180px;overflow: hidden;-webkit-box-shadow: #666 0px 0px 10px;">
                            <a  href="/enterTeam?teamID=28">
                                <img src="img/wd1.jpg" style="height: 180px;width: 180px;object-fit: cover">
                            </a>
                            <div class="img-tip">武大1</div>
                        </div>
                        <div class="img-group" style="margin-left: 10px;height: 180px;width: 180px;overflow: hidden;-webkit-box-shadow: #666 0px 0px 10px;">
                            <a  href="/enterTeam?teamID=41">
                                <img src="img/qh1.jpg" style="height: 180px;width: 180px;object-fit: cover">
                            </a>
                            <div class="img-tip">清华1</div>
                        </div>
                        <div class="img-group" style="margin-left: 10px;height: 180px;width: 180px;overflow: hidden;-webkit-box-shadow: #666 0px 0px 10px;">
                            <a  href="/enterTeam?teamID=37">
                                <img src="img/hk1.jpg" style="height: 180px;width: 180px;object-fit: cover">
                            </a>
                            <div class="img-tip">华科1</div>
                        </div>
                    </div>
                    <div class="col-md-6" style="background-color:white;left:5px;padding: 20px">
                        <blockquote class="blockquote" style="margin-left: 10px;">
                            <p class="mb-0" style="font-size: 16px">
                                这富有历史背景、富有高度私人秘密性的社会，人类文化应是多彩多姿的。
                            </p>
                        </blockquote>
                        <div class="img-group" style="margin-left: 10px;height: 180px;width: 180px;overflow: hidden;-webkit-box-shadow: #666 0px 0px 10px;">
                            <a  href="/enterTeam?teamID=27">
                                <img src="img/wd2.jpg" style="height: 180px;width: 180px;object-fit: cover">
                            </a>
                            <div class="img-tip">武大2</div>
                        </div>
                        <div class="img-group" style="margin-left: 10px;height: 180px;width: 180px;overflow: hidden;-webkit-box-shadow: #666 0px 0px 10px;">
                            <a  href="/enterTeam?teamID=43">
                                <img src="img/qh2.jpg" style="height: 180px;width: 180px;object-fit: cover">
                            </a>
                            <div class="img-tip">清华2</div>
                        </div>
                        <div class="img-group" style="margin-left: 10px;height: 180px;width: 180px;overflow: hidden;-webkit-box-shadow: #666 0px 0px 10px;">
                            <a  href="/enterTeam?teamID=38">
                                <img src="img/hk2.jpg" style="height: 180px;width: 180px;object-fit: cover">
                            </a>
                            <div class="img-tip">华科2</div>
                        </div>
                    </div>
                </div>
            </div>
            <br />

            <!--缩略图1-->
            <div id="proList" style="background-color:white;padding: 20px;margin-top:0px">
                <blockquote class="blockquote" style="margin-left: 10px;">
                    <p class="mb-0" style="font-size: 16px">
                        在一个文化廉价的社会，人的交流是无益甚至是有害的，因为此时交流所起的作用恰恰在于传播低俗、扩大无知。
                        在这样的环境下，阅读经典无疑是明智的选择。
                    </p>
                </blockquote>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card" style="overflow: hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;-webkit-box-shadow: #666 0px 0px 10px;">
                            <img class="card-img-top" alt="Bootstrap Thumbnail First" src="<%=basePath%>/getPic.action?productID=<%=products.get(0).getProductID()%>" style="height:200px;overflow:hidden;object-fit: cover">
                            <div class="card-block">
                                <h5 class="card-title" >
                                    <%=products.get(0).getName()%>
                                </h5>
                                <p class="card-text" style="height: 72px;">
                                    <%= products.get(0).getDescription()%>
                                </p>
                                <p>
                                    <a class="btn btn-primary" href="/enterProduct?productID=<%=products.get(0).getProductID()%>">购买</a> <a class="btn" href="toComment.action?product_id=<%=products.get(0).getProductID()%>">查看评论</a>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card" style="overflow: hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;-webkit-box-shadow: #666 0px 0px 10px;">
                            <img class="card-img-top" alt="Bootstrap Thumbnail Second" src="<%=basePath%>/getPic.action?productID=<%=products.get(1).getProductID()%>"  style="height:200px;overflow:hidden;object-fit: cover" >
                            <div class="card-block">
                                <h5 class="card-title">
                                    <%=products.get(1).getName()%>
                                </h5>
                                <p class="card-text" style="height: 72px;">
                                    <%= products.get(1).getDescription()%>
                                </p>
                                <p>
                                    <a class="btn btn-primary" href="/enterProduct?productID=<%=products.get(1).getProductID()%>">购买</a> <a class="btn" href="toComment.action?product_id=<%=products.get(1).getProductID()%>">查看评论</a>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card" style="overflow: hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;-webkit-box-shadow: #666 0px 0px 10px;">
                            <img class="card-img-top" alt="Bootstrap Thumbnail Third"  src="<%=basePath%>/getPic.action?productID=<%=products.get(2).getProductID()%>" style="height:200px;overflow:hidden;object-fit: cover">
                            <div class="card-block">
                                <h5 class="card-title">
                                    <%=products.get(2).getName()%>
                                </h5>
                                <p class="card-text" style="height: 72px;">
                                    <%= products.get(2).getDescription()%>
                                </p>
                                <p>
                                    <a class="btn btn-primary" href="/enterProduct?productID=<%=products.get(2).getProductID()%>">购买</a> <a class="btn" href="toComment.action?product_id=<%=products.get(2).getProductID()%>">查看评论</a>
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <br />

            <!--缩略图2-->
            <div style="background-color:white;padding: 20px;margin-top:0px">
                <blockquote class="blockquote" style="margin-left: 10px;">
                    <p class="mb-0" style="font-size: 16px">
                        文化要融合，必须要从让大家互相碰撞开始，你要了解差异前，先要发现差异，然后才能决定哪个是正确的方向，
                        大家看到对的方向后，才能认真执行下去。
                    </p>
                </blockquote>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card" style="overflow: hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;-webkit-box-shadow: #666 0px 0px 10px;">
                            <img class="card-img-top" alt="Bootstrap Thumbnail First" style="height:200px;overflow:hidden;object-fit: cover"  src="<%=basePath%>/getPic.action?productID=<%=products.get(3).getProductID()%>">
                            <div class="card-block">
                                <h5 class="card-title">
                                    <%=products.get(3).getName()%>
                                </h5>
                                <p class="card-text" style="height: 72px;">
                                    <%= products.get(3).getDescription()%>
                                </p>
                                <p>
                                    <a class="btn btn-primary" href="/enterProduct?productID=<%=products.get(3).getProductID()%>">购买</a> <a class="btn" href="toComment.action?product_id=<%=products.get(3).getProductID()%>">查看评论</a>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card" style="overflow: hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;-webkit-box-shadow: #666 0px 0px 10px;">
                            <img class="card-img-top" alt="Bootstrap Thumbnail Second" style="height:200px;overflow:hidden;object-fit: cover" src="<%=basePath%>/getPic.action?productID=<%=products.get(4).getProductID()%>">
                            <div class="card-block">
                                <h5 class="card-title">
                                    <%=products.get(4).getName()%>
                                </h5>
                                <p class="card-text" style="height: 72px;">
                                    <%= products.get(4).getDescription()%>
                                </p>
                                <p>
                                    <a class="btn btn-primary" href="/enterProduct?productID=<%=products.get(4).getProductID()%>">购买</a> <a class="btn" href="toComment.action?product_id=<%=products.get(4).getProductID()%>">查看评论</a>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card" style="overflow: hidden; border-top-left-radius: 5px; border-top-right-radius: 5px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;-webkit-box-shadow: #666 0px 0px 10px;">
                            <img class="card-img-top" alt="Bootstrap Thumbnail Third" style="height:200px;overflow:hidden;object-fit: cover"  src="<%=basePath%>/getPic.action?productID=<%=products.get(5).getProductID()%>">
                            <div class="card-block">
                                <h5 class="card-title">
                                    <%=products.get(5).getName()%>
                                </h5>
                                <p class="card-text" style="height: 72px;">
                                    <%= products.get(5).getDescription()%>
                                </p>
                                <p>
                                    <a class="btn btn-primary" href="/enterProduct?productID=<%=products.get(5).getProductID()%>">购买</a> <a class="btn" href="toComment.action?product_id=<%=products.get(5).getProductID()%>">查看评论</a>
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
<br />
<div style="background-color:#333;height: 300px;color: white;padding: 50px;">
    <div class="row">
        <div class="col-md-3">
            <h3>网站简介</h3>
            <br>
            这是一个年轻的校园文化供销平台，<br>
            我们致力于推动校园文化的碰撞与交流，<br>
            在校园创业兴起的浪潮中，<br>
            青云直上，破浪前行
        </div>
        <div  class="col-md-3">
            <h3>团队成员</h3>
            <br>
            项目经理：张伟<br>
            产品经理：郑晓欣<br>
            技术总监：韩阳<br>
            技术人员：周彪
        </div>
        <div  class="col-md-3">
            <h3>联系我们</h3>
            <br>
            电话：13966029638<br>
            邮箱：2455221474@qq.com<br>
            地址：武汉大学信息学部<br>
        </div>
    </div>
</div>


<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript">
    window.onload=function (ev) {
        var ps = $('.card-text').find('p');
        ps=ps.prevObject;
        for (var i = 0; i < ps.length; i++) {
            var temp = ps[i].innerText;
            if (temp.length > 60) {
                temp = temp.substring(0, 60);
                temp += '...';
            }
            ps[i].innerText = temp;
        }
    };

    function checkEnterChat() {
        var user_id=<%=session.getAttribute("user_id")%>;
        if(user_id===null){
            window.alert("请先登录再进行此操作！");
        }
        else window.location.href="chat.jsp";
    }

    window.alert = function (name) {
        var iframe = document.createElement('IFRAME');
        iframe.style.display = 'none';
        iframe.setAttribute('src', 'data:text/plain,');
        iframe.setAttribute('title','提示');
        document.documentElement.appendChild(iframe);
        window.frames[0].window.alert(name);
        iframe.parentNode.removeChild(iframe);
    };
</script>
</body>
</html>
