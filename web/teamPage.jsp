<%@ page import="java.sql.ResultSet" %>
<%@ page import="DataBase.DBOperation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.CultureProduct" %>
<%@ page import="Entity.Activity" %>
<%@ page import="Entity.Message" %>
<%@ page import="Operations.MessageOperate" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
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

    <link rel="alternate icon" href="img/qm.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <script src="js/server-01.js"></script>
    <style>
        .nav-link1:hover{
            background-color: #4F4F4F;
        }
    </style>
</head>


<%
//    session.getAttribute("user_id");
    Object id=request.getSession().getAttribute("user_id");
    String sqlProduct="select * from product where product_team_id="+id;
    String sqlActivity="select * from activity where activity_team_id="+id;
    ArrayList<CultureProduct> products=new ArrayList<CultureProduct>();
    ArrayList<Activity> activities=new ArrayList<Activity>();
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
<!--修改by:zheng---->
<%
    Object userID;
    if(request.getSession().getAttribute("user_name")!=null) {
        userID =  request.getSession().getAttribute("user_id");
        if (request.getSession().getAttribute("message_count")!=null) {
            int count = MessageOperate.getNewMessageNum((Integer)userID);
            request.getSession().setAttribute("message_count", count);
        }
    }%>

<!------------------------------------------------------------------------------------------->

<%if(request.getSession().getAttribute("user_id")!=null){%>
<script>createConn();</script>
<%}%>
<ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
    <a class="navbar-brand col-sm-2" href="#" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng </a>

    <li class="nav-item col-sm-2" style="margin-left: 20px">
        <a class="nav-link nav-link1" href="#publishedpro" style="height: 70px;width:130px;color:#FFFFFF;font-size:18px;"><span style="position: relative;top:12px;">已发布活动</span></a>
    </li>
    <li class="nav-item col-sm-6" style="margin-left: -90px">
        <a class="nav-link nav-link1" href="#publishedact" style="height: 70px;width:130px;color:#FFFFFF;font-size:18px;"><span style="position: relative;top:12px;">已发布商品</span></a>
    </li>

    <s:if test="#session.message_count!=null">
        <div class="col-sm-1" style="margin-left: 20px">
            <div style="margin-left:0;margin-top:18px;left: 30px;">
                <a href="enterTeamBox.action"><button type="button" class="btn" style="height: 38px">
                    <span class="glyphicon glyphicon-envelope"></span>
                </button></a>
            </div>

            <div class="badge-bg" id="messageCircle" style="position: relative;left:40px;top:-48px;z-index:999; width:20px;
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
                    <a class="dropdown-item" href="#modal-update" data-toggle="modal" style="height:30px;">修改信息</a>
                    <a class="dropdown-item" href="logout.action">退出登录</a>
                </div>
            </div>
        </s:else>

    </li>
</ul>

<br /><br /><br /><br />
<!-----------------------------------合代码新增----------------------------------------->
<div class="row">
    <div class="col-md-12">
<!---------------------------------------此处myModalLabe2原为myModalLabe1 因重名修改---------------------------------------->
        <div class="modal fade" id="modal-update" role="dialog" aria-labelledby="myModalLabe2" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myModalLabe2">
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

<!---------------------------------------------------------------------------->
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
                        <img class="d-block w-100" alt="Carousel Bootstrap Second" src="img/showimg5.png">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" alt="Carousel Bootstrap Third" src="img/showimg7.png">
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
                                    <input hidden name="teamID" value="<%=session.getAttribute("user_id")%>" />
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
                                        <input name="imgFile" type="file" class="form-control-file" id="picture" accept=".png,.jpg,.jpeg,image/png,image/jpg,image/jpeg">
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        发布
                                    </button>

                                </form>
                            </div>

                            <div class="tab-pane" id="panel-364800">
                                <br />
                                <form action="releaseActivity.action" method="post" role="form">
                                    <input hidden name="teamID" value="<%=session.getAttribute("user_id")%>" />
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
                        <th>活动名</th><th>活动地点</th><th>开始时间</th><th>结束时间</th><th>管理动态</th>
                        <%for (Activity activity:activities){%>
                            <tr><td><%=activity.getActivityName()%></td><td><%=activity.getAddress()%></td><td><%=activity.getReleaseDate()%></td><td><%=activity.getEndDate()%></td>
                                <td><a href="#modal-pubact" onclick="changeActivity(<%=activity.getActivityID()%>)" role="button" class="btn btn-outline-info"
                                       data-toggle="modal" style="height:30px; margin-left:0px">
                                    <span class="glyphicon glyphicon-bell"></span></a>
                                </td>
                            </tr>
                        <%}%>
                    </table>
                </div>
                <div class="card-footer">
                    <br />
                </div>
            </div>
            <!--发布活动遮罩窗-->
            <div class="row">
                <div class="col-md-12">

                    <div class="modal fade" id="modal-pubact" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content" style="width: 800px;margin-left: -28%">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="myModalLabel">
                                        发布推送
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!---------------在此处添加-------------->
                                    <table id="GetResources" class="table">
                                        <!--th>序号</th><th>动态内容 </th>
                                        <tr><td>1</td><td><div style='width:250px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容'>详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容</div></td></tr>
                                        <tr><td>2</td><td><div style='width:120px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容'>详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容详细推送内容</div></td></tr-->
                                    </table>

                                    <form role="form"  enctype="multipart/form-data" method="post" class="form-horizontal" action="sendMessage.action">
                                        <input type="hidden" id="change-activity" name="updateActivity" value="" />
                                        <br />
                                        <div class="input-group">
                                            <span class="col-md-3" style="margin-left:10px">推送内容:</span>
                                            <textarea class="form-control" name="updateMessage" style="left:-90px; border-top-left-radius: 5px;
                                             border-top-right-radius: 5px;border-bottom-left-radius:5px;
                                              border-bottom-right-radius:5px;" placeholder="活动动态内容"></textarea>
                                        </div>
                                        <br>
                                        <div class="input-group">

                                            <label for="pictureFile">
                                                添加图片说明：
                                            </label>
                                            <input type="file" name="pictureFile" class="form-control-file" id="pictureFile" accept=".png,.jpg,.jpeg,image/png,image/jpg,image/jpeg"/>
                                            <!--input type="file" name="updatePictureFile" class="form-control-file" id="exampleInputFile" /-->
                                        </div>
                                        <br />
                                        <div class="form-group" style="margin-left:34%">
                                            <div class="col-sm-offset-2 col-md-6">
                                                <button type="submit" class="btn btn-warning btn-block">发布</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                        取消
                                    </button>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>

            <!--------------------------------->
        </div>
    </div>
</div>


<br /><br /><br />
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
<script>
    function changeActivity(id){
        document.getElementById("change-activity").setAttribute("value",id);
        var xmlhttp;
        if (window.XMLHttpRequest)
        {
            // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
            xmlhttp=new XMLHttpRequest();
        }
        else
        {
            // IE6, IE5 浏览器执行代码
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.open("GET","getActivityResources?activity_id="+id,false);
        xmlhttp.send();
        document.getElementById("GetResources").innerHTML=xmlhttp.responseText;
    }
</script>


</body>
</html>
