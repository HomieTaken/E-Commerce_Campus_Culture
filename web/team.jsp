<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.CultureProduct" %>
<%@ page import="Entity.Activity" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!-------------------组号---------------------------->

<!------------------------------------------------->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-团队</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
	<link href="css/bootstrap.css" rel="stylesheet">
	  <script src="js/server-01.js"></script>
  </head>
  <body>
  <%if(request.getSession().getAttribute("user_id")!=null){%>
  <script>createConn();</script>
  <%}%>
    <div class="container-fluid">

	<br>
		 <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
			<a class="navbar-brand col-sm-3" href="index.jsp" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng-店铺 </a>
			
			<li class="nav-item col-sm-1" >
			  <a class="nav-link" href="#showact" style="color:#FFFFFF;font-size:18px;margin-top:12px;">活动</a>
			</li>
			<li class="nav-item col-sm-2">
			  <a class="nav-link" href="#showpro" style="color:#FFFFFF;font-size:18px;margin-top:12px;">商品</a>
			</li>
			<li class="nav-item col-sm-3">
					  <form action="search_plus.action"  class="form-inline" style="margin-top:18px;">
					  	<input name = "entry" class="form-control mr-sm-2" type="text" style="width: 200px;" placeholder="搜本店">
					  	<button class="btn btn-default my-2 my-sm-0" type="submit" onclick="return checkSearch()" >
					  		<span class="glyphicon glyphicon-search"></span>
					  	</button>
					  </form>
			</li>

			 <!------------------------------------------------------->
			 <!---消息显示按钮-->
			 <s:if test="#session.message_count!=null">
				 <div class="col-md-1" style="margin-left:0px;margin-top: 18px;">
					 <a href="enterMessageBox.action"><button type="button" class="btn btn-info">
						 <span class="glyphicon glyphicon-envelope"></span>
					 </button></a>
				 </div></a>

				 <div id="messageCircle" class="badge-bg" style="margin-left:-70px;margin-top:10px;z-index:2; width:20px;
    height:20px;
    background-color:#F00;
    border-radius:25px;display:none;">
                            <span id="message_count" class="badge-span" style="    height:20px;
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
		
		<div class="row" style="margin-top:5%" id="showact">
			<%
				Activity[]activities= (Activity[]) request.getAttribute("ActsBriefView");
				for(int i=0;i<activities.length;i++){
			%>
		<div class="col-md-6" style="margin-bottom:30px;">
			<div class="card" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
				<h5 class="card-header">
					<!--“赢在师大”市场调研大赛-->
					<%=activities[i].getActivityName()%>
				</h5>
				<div class="card-body" style="height:200px">
				<div class="col-md-12">
				<br />
					<p class="card-text">
						<%=activities[i].getDescription()%>
					&emsp;<!--由广西师范大学校团委主办、经济管理学院分团委学生会承办的广西师大2009年校园学术科技节之“赢在师大”
					市场调研大赛决赛暨成果展评会于近日在雁山校区大学生学术报告厅隆重举行。校团委副书记罗元老师、经济管理学院党委书记蒋团标教授、经济管理学
					院教师陆奇岸教授、王修志副教授及桂林市诺嘉克企业管理咨询有
					限责任公司总经理韦根先生等领导嘉宾莅临现场并担任比赛评委。各学院学生代表近250人也在参加活动中分享了入围决赛的各参赛团队调研的所见所闻、所思所想。-->
					</p>
				<br />
				</div>
				</div>
				<div class="card-footer">
					<table class="table">
					<tr>
					<th>活动时间：</th><td><%=activities[i].getReleaseDate()%>至<%=activities[i].getEndDate()%></td>
					</tr>
					<tr>
					<th>活动地点：</th><td><%=activities[i].getAddress()%></td>
					</tr>
					</table>
				</div>
			</div>
		</div>
			<%}%>
		<!--div class="col-md-6">
			<div class="card" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
				<h5 class="card-header">
					“毕业碗”美式橄榄球赛，激情送别毕业生
				</h5>
				<div class="card-body" style="height:200px">
				<div class="col-md-12">
				<br />
					<p class="card-text">
					&emsp;&emsp;一场名为“毕业碗”的美式橄榄球比赛在苏州大学天赐庄校区田径场举行，这是学校第二次举办校园美式橄榄球赛，数百名师生受邀观展了整场比赛，给毕业季的校园带来更多欢乐的气氛和拼搏的青春气息。校党委常委、副校长刘标，党委宣传部、学生工作部（处）、团委以及部分学院（部）领导出席观摩了比赛。比赛由体育学院院长王国祥主持，文正学院张耀扬同学担任现场解说。
					</p>
				<br />
				</div>
				</div>
				<div class="card-footer">
					<table class="table">
					<tr>
					<th>活动时间：</th><td>9.01-9.02</td>
					</tr>
					<tr>
					<th>活动地点：</th><td>苏州大学</td>
					</tr>
					</table>
				</div>
			</div>
		</div-->
		<div style="margin-left:90%;margin-top:1%">
		<label><a href = "#">查看更多 >></a></label>
		</div>
		</div>
		<br />
		
		<!--团队店铺商品展示-->
			<div class="card" id="showpro" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
			<div class="card-header text-center">
			<span class="glyphicon glyphicon-fire"></span> 商品火热销售中！
			</div>
			<div class="card-body">
			<div class="col-md-12">
			<br />
				<%CultureProduct[]products= (CultureProduct[]) request.getAttribute("ProsBriefView");
					for(int i=0;i<products.length;i++){
				%>
			<div class="media">
				<a href="/enterProduct.action?productID<%="="+products[i].getProductID()%>">
					<img style="height:100px;" class="mr-3 img-thumbnail" alt="Bootstrap Media Preview" src="/getPic?productID=<%=products[i].getProductID()%>" />
				</a>
				<div class="media-body">
					<h5 class="mt-0">
						商品名称：<%=products[i].getName()%>
					</h5><%=products[i].getDescription()%><%i++;%>
					<%if(products.length<=i)break;%>
					<br>
					<br>
					<div class="media mt-3">
						<a href="/enterProduct?productID<%="="+products[i].getProductID()%>">
							<img style="height:100px;" class="mr-3 img-thumbnail" alt="Bootstrap Media Preview" src="/getPic?productID=<%=products[i].getProductID()%>" />
						</a>
						<div class="media-body">
							<h5 class="mt-0">
								商品名称：<%=products[i].getName()%>
							</h5>  <%=products[i].getDescription()%>
						</div>
					</div>
				</div>
			</div>
				<br>
				<br>
				<%}%>
			  <%--<HR style= " FILTER: progid:DXImageTransform.Microsoft.Glow ( color= #6996b9 ,strength = 10) " width= "80%" color= #987 cb9 SIZE =1>--%>
			<!--div class="media">
				<img class="mr-3" alt="Bootstrap Media Preview" src="https://www.layoutit.com/img/sports-q-c-64-64-8.jpg">
				<div class="media-body">
					<h5 class="mt-0">
						书籍
						Nested media heading
					</h5> Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.
					<div class="media mt-3">
						 <a class="pr-3" href="#"><img alt="Bootstrap Media Another Preview" src="https://www.layoutit.com/img/sports-q-c-64-64-2.jpg"></a>
						<div class="media-body">
							<h5 class="mt-0">
								Nested media heading
							</h5> 书籍介绍Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.
						</div>
					</div>
				</div>
			</div-->
			<br />
			</div>
			</div>
			</div>
			<div style="margin-left:90%;margin-top:1%">
			<label><a href = "#">查看更多 >></a></label>
			</div>
	</div>

		<br><br><br>
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