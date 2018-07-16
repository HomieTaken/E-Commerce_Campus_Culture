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

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/extend.css" rel="stylesheet">

</head>
<body>
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

                        <div class="col-md-5">
                            <li class="breadcrumb-item ">
                                <form accept-charset="UTF-8" class="form-inline" action="search.action">
                                    <input name="entry" id = "search" class="form-control mr-sm-2" type="text" style="width: 400px;">
                                    <button class="btn btn-primary my-2 my-sm-0"  onclick="return checkSearch()" >
                                       <!----------------------增加onclick方法------------------->
                                        <span class="glyphicon glyphicon-search"></span>
                                    </button>
                                </form>
                            </li>
                        </div>
<!------------------------------------------------------->
                        <!---消息显示按钮-->
<s:if test="#session.message_count!=null">
                       <div class="col-md-1" style="margin-left:0px;">
                           <a href="enterMessageBox.action"><button type="button" class="btn btn-info">
                                <span class="glyphicon glyphicon-envelope"></span>
                           </button></a>
                        </div></a>

                        <div class="badge-bg" id="messageCircle" style="margin-left:-70px;margin-top:-10px;z-index:2; width:20px;
    height:20px;
    background-color:#F00;
    border-radius:25px;display:none;">
                            <span id="message_count"  class="badge-span" style="    height:20px;
    line-height:20px;
    display:block;
    color:#FFF;
    text-align:center;"><s:if test="#session.message_count>0">
                                <s:property value="#session.message_count"/></s:if></span>
                        </div>
    <s:if test="#session.message_count>0">
        <script>document.getElementById("messageCircle").style.display=""</script></s:if>
</s:if>
<!---------------------------------------------->
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
                                        <a class="dropdown-item" href="/enterShopping">购物车</a>
                                        <%--<a class="dropdown-item" href="#">修改信息</a>--%>
                                            <a href="#modal-update" class="dropdown-item" data-toggle="modal" style="height:30px;">修改信息</a>
                                        <a class="dropdown-item" href="logout.action">退出登录</a>
                                    </div>
                                </div>
                            </li>

                        </div>
                        </s:else>
                    </div>
                </ol>
            </nav>
<!-------------------------------------------------------------------------------------->
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
            <!----------------------------------------------------------------------------->
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
                                <%=teams.get(0).getUserName()%>
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="/enterTeam?teamID=<%=teams.get(0).getId()%>">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                <%=teams.get(1).getUserName()%>
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="/enterTeam?teamID=<%=teams.get(1).getId()%>">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                <%=teams.get(2).getUserName()%>
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="/enterTeam?teamID=<%=teams.get(2).getId()%>">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                <%=teams.get(3).getUserName()%>
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="/enterTeam?teamID=<%=teams.get(3).getId()%>">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                <%=teams.get(4).getUserName()%>
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="/enterTeam?teamID=<%=teams.get(4).getId()%>">队伍主页</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" style="border-radius: 50%; overflow: hidden;box-shadow: 5px 5px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" src="img/WHUpro1.jpg" height="100px">
                        <div class="card-block text-center">
                            <h5 class="card-title">
                                <%=teams.get(5).getUserName()%>
                            </h5>
                            <p>
                                <a class="btn btn-primary" href="/enterTeam?teamID=<%=teams.get(5).getId()%>">队伍主页</a>
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
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" style="height:200px;overflow:hidden" src="<%=basePath%>/getPic.action?productID=<%=products.get(0).getProductID()%>">
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
                        <img class="card-img-top" alt="Bootstrap Thumbnail Second" style="height:200px;overflow:hidden"  src="<%=basePath%>/getPic.action?productID=<%=products.get(1).getProductID()%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(1).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(1).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(1).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail Third" style="height:200px;overflow:hidden"  src="<%=basePath%>/getPic.action?productID=<%=products.get(2).getProductID()%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(2).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(2).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(2).getProductID()%>">购买</a>
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
                        <img class="card-img-top" alt="Bootstrap Thumbnail First" style="height:200px;overflow:hidden"  src="<%=basePath%>/getPic.action?productID=<%=products.get(3).getProductID()%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(3).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(3).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(3).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail Second" style="height:200px;overflow:hidden" src="<%=basePath%>/getPic.action?productID=<%=products.get(4).getProductID()%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(4).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(4).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(4).getProductID()%>">购买</a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="overflow: hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px;box-shadow: 8px 8px 5px #888888;">
                        <img class="card-img-top" alt="Bootstrap Thumbnail Third" style="height:200px;overflow:hidden"  src="<%=basePath%>/getPic.action?productID=<%=products.get(5).getProductID()%>">
                        <div class="card-block">
                            <h5 class="card-title">
                                <%=products.get(5).getName()%>
                            </h5>
                            <p class="card-text">
                                <%= products.get(5).getDescription()%>
                            </p>
                            <p>
                                <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="/enterProduct?productID=<%=products.get(5).getProductID()%>">购买</a>
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
