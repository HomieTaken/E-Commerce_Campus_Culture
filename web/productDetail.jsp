<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/5/005
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.CultureProduct" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-商品</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>
<body>
<%String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>

<%CultureProduct product= (CultureProduct) request.getAttribute("productDetail");%>
<div class="container-fluid">

    <!--导航栏，也是页头-->
    <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
        <a class="navbar-brand col-sm-7" href="#" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng-商品 </a>


        <li class="nav-item col-sm-3">
            <form class="form-inline" style="margin-top:18px;">
                <input class="form-control mr-sm-2" type="text" style="width: 200px;" placeholder="搜本店">
                <button class="btn btn-default my-2 my-sm-0" type="submit" >
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
                        <a class="dropdown-item" href="/logout">退出登录</a>
                    </div>
                </div>
            </s:else>
        </li>
    </ul>

    <!--商品图片展示及描述-->
    <div class="row" style="margin-top:5%">
        <div class="col-md-6">
            <div class="col-md-12">
                <!--product picture-->
                <br />
                <img height="200px" class="img-thumbnail img-fluid" alt="Carousel Bootstrap Second" src="<%=basePath%>/getPic.action?productID=<%=product.getProductID()%>" />
                <!--img src="http://static.runoob.com/images/mix/paris.jpg" class="img-thumbnail img-fluid"-->
            </div>
            <br />
            <!--product description-->
            <div class="col-md-12">
                <dl>
                    <dt>
                        商品描述
                    </dt>
                    <br />
                    <dd>
                        <%=product.getDescription()%>
                        <!--这里有一条路，叫樱花大道。三月赏樱，唯有武大。樱树袅娜生长，遍天都是纯白的、淡粉的花朵。抬头只见花不见天，仿佛进入一个晶莹透亮的世界。
                    这里有一个恋爱圣地，叫情人坡。一对对恋人坐在参天大树下的小石凳子上或读书、或聊天......-->
                    </dd>
                </dl>
            </div>
        </div>

        <br />
        <div class="col-md-6" style="margin-top:2%">
            <div class="card" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
                <div class="card-header">
                    <div style="FILTER: shadow(color=#6495ED, strength=50); WIDTH:600px; HEIGHT: 40px">
                        <div align=center>
				<span style="FONT-SIZE: 24pt; COLOR: blue; FONT-FAMILY: 华文行楷; mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-CN; mso-bidi-language: AR-SA; mso-hansi-font-family: 'Times New Roman'; mso-bidi-font-family: 'Times New Roman'">
				<%=product.getName()%>
				</span>
                        </div>
                    </div>
                </div>
                <br />

                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-2">
                            价格：
                        </div>
                        <div class="col-md-4 text-danger" style="font-size:18px">
                            <%=product.getPrice()%>
                        </div>
                    </div>

                    <form class="form" role="form">
                        <!--配送地址-->
                        <br />
                        <div class="form-group">
                            <label class="control-label" for="shipaddress">选择配送地点</label>
                            <select name="address" class="form-control" id="shipaddress">
                                <option>湖北省武汉市信息学部</option>
                                <option>美国洛杉矶</option>
                            </select>
                        </div>

                        <!--配送数量-->
                        <br />
                        <div class="form-group">
                            <label for="pronum" class="control-label">
                                选择数量：(现存99件)
                            </label>
                            <input name="number" type="number" class="form-control" id="pronum">
                        </div>
                        <br />

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <span class="glyphicon glyphicon-shopping-cart"></span> 加入购物车
                            </button>
                        </div>

                    </form>
                    <br />
                </div>

            </div>
        </div>
    </div>
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
    <%--<link href="css/bootstrap.css" rel="stylesheet">--%>
    <%--&lt;%&ndash;<link href="css/style.css" rel="stylesheet">&ndash;%&gt;--%>

<%--</head>--%>
<%--<body>--%>

<%--<div class="container-fluid">--%>

    <%--<!--青芒logo-->--%>
    <%--<br />--%>
    <%--<div class="row">--%>
        <%--<div class="col-md-12">--%>
            <%--<h3>--%>
                <%--<img alt="Bootstrap Image Preview" height="50px" width="100px" src="img/qingmang.png">--%>
            <%--</h3>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<br />--%>

    <%--<!--商品图片展示及描述-->--%>
    <%--<div class="row">--%>
        <%--<div class="col-md-6">--%>
            <%--<div class="row">--%>
                <%--<!--product picture-->--%>
                <%--<div class="col-md-10">--%>
                    <%--<div class="carousel slide" id="carousel-335963" >--%>
                        <%--<ol class="carousel-indicators">--%>
                            <%--<li data-slide-to="0" data-target="#carousel-335963">--%>
                            <%--</li>--%>
                            <%--<li data-slide-to="1" data-target="#carousel-335963" class="active">--%>
                            <%--</li>--%>
                            <%--<li data-slide-to="2" data-target="#carousel-335963">--%>
                            <%--</li>--%>
                        <%--</ol>--%>
                        <%--<div class="carousel-inner" >--%>
                            <%--<div class="carousel-item">--%>
                                <%--<img height="200px"  class="d-block w-100" alt="Carousel Bootstrap First" src="img/WHUpro1.jpg">--%>
                            <%--</div>--%>
                            <%--<div class="carousel-item active">--%>
                                <%--<img height="200px"  class="d-block w-100" alt="Carousel Bootstrap Second" src="img/WHUpro2.jpg">--%>
                            <%--</div>--%>
                            <%--<div class="carousel-item">--%>
                                <%--<img height="200px"  class="d-block w-100" alt="Carousel Bootstrap Third" src="img/WHUpro3.jpg">--%>
                            <%--</div>--%>
                        <%--</div> <a class="carousel-control-prev" href="#carousel-335963" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-335963" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>--%>
                    <%--</div>--%>
                <%--</div>--%>

                <%--<div class="col-md-2">--%>
                    <%--<button type="button" class="btn btn-md btn-outline-info">--%>
                        <%--<span class="glyphicon glyphicon-search"></span>  收藏--%>
                    <%--</button>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<br />--%>
            <%--<!--product description-->--%>
            <%--<dl>--%>
                <%--<dt>--%>
                    <%--商品描述--%>
                <%--</dt>--%>
                <%--<dd>--%>
					<%--<pre>--%>
<%--这里有一所大学--%>
<%--春天--%>
<%--她樱花漫野--%>
<%--夏天--%>
<%--这里树荫蔽日--%>
<%--秋天--%>
<%--她色彩斑斓、金桂飘香--%>
<%--冬天--%>
<%--这里的腊梅傲立雪中--%>
<%--这里有一条路，叫樱花大道。三月赏樱，唯有武大。樱树袅娜生长，遍天都是纯白的、淡粉的花朵。抬头只见花不见天，仿佛进入一个晶莹透亮的世界。--%>
<%--这里有一个恋爱圣地，叫情人坡。一对对恋人坐在参天大树下的小石凳子上或读书、或聊天......--%>
					<%--</pre>--%>
                <%--</dd>--%>
            <%--</dl>--%>
        <%--</div>--%>

        <%--<div class="col-md-6">--%>
            <%--<h3 class="text-info text-center">--%>
                <%--印象武大纪念明信片--%>
            <%--</h3>--%>
            <%--<br />--%>
            <%--<h4 class="text-center">--%>
                <%--<em>价格：￥10</em>--%>
            <%--</h4>--%>

            <%--<form class="form" role="form">--%>
                <%--<!--配送地址-->--%>
                <%--<br />--%>
                <%--<div class="form-group">--%>
                    <%--<label class="control-label" for="shipaddress">选择配送地点</label>--%>
                    <%--<select class="form-control" id="shipaddress">--%>
                        <%--<option>湖北省武汉市信息学部</option>--%>
                        <%--<option>美国洛杉矶</option>--%>
                    <%--</select>--%>
                <%--</div>--%>

                <%--<!--配送数量-->--%>
                <%--<br />--%>
                <%--<div class="form-group">--%>
                    <%--<label for="pronum" class="control-label">--%>
                        <%--选择数量：(现存99件)--%>
                    <%--</label>--%>
                    <%--<input type="number" class="form-control" id="pronum">--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--<div class="form-group">--%>
                    <%--&lt;%&ndash;<s:set var="#session.product_id>&ndash;%&gt;--%>
                    <%--<a href="shoppingcart.jsp?product_id=7">--%>
                    <%--<button class="btn btn-primary">--%>
                        <%--加入购物车--%>
                    <%--</button>--%>
                    <%--</a>--%>
                <%--</div>--%>

            <%--</form>--%>


        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>

<%--<script src="js/jquery.min.js"></script>--%>
<%--<script src="js/bootstrap.min.js"></script>--%>
<%--<script src="js/scripts.js"></script>--%>
<%--</body>--%>
<%--</html>--%>