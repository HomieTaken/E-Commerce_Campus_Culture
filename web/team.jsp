<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.CultureProduct" %>
<%@ page import="Entity.Activity" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="java.util.Map" %>
<%@ page import="Entity.Team" %>
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


	  <link rel="alternate icon" href="img/qm.ico">
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
<%Team team=Team.getTeam(Integer.parseInt(request.getAttribute("report_team_id").toString()));%>
	<br>
		 <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
			 <a class="navbar-brand col-sm-2" href="index.jsp" style="color:#FFFFFF;top:2px;font-size:25px"> QinG MAng-店铺 </a>
			 <a class="navbar-brand" href="javascript:void(0)"
				style="color:#FFFFFF;margin-top:40px;margin-left:-160px;font-size:14px;"> —<%=team.getTeamSchool()+" "+team.getTeamName()%>团队 </a>
			 <a href="#modal-report" class="btn" data-toggle="modal" style="height:38px;position: relative;top: 18px;margin-left:0">
				 <span class="glyphicon glyphicon-exclamation-sign" style="color: white"></span>
			 </a>

			<li class="nav-item col-sm-1" style="margin-left: 50px;" >
			  <a class="nav-link" href="#showact" style="color:#FFFFFF;font-size:18px;margin-top:12px;">活动</a>
			</li>
			<li class="nav-item col-sm-1">
			  <a class="nav-link" href="#showpro" style="color:#FFFFFF;font-size:18px;margin-top:12px;">商品</a>
			</li>
			<li class="nav-item col-sm-4">
					  <form action="search_plus.action"  class="form-inline" style="margin-top:18px;margin-left: 100px">
					  	<input id="search" name = "entry" class="form-control mr-sm-2" type="text" style="width: 250px;" placeholder="搜本店">
					  	<button class="btn btn-default my-2 my-sm-0" onclick="return checkSearch()" >
					  		<span class="glyphicon glyphicon-search"></span>
					  	</button>
					  </form>
			</li>

			 <!------------------------------------------------------->
			 <!---消息显示按钮-->
			 <%--<s:if test="#session.message_count!=null">--%>
				 <%--<div class="col-md-1" style="margin-left:10px;margin-top: 18px;padding-left: 95px">--%>
					 <%--<a href="enterMessageBox.action"><button type="button" class="btn btn-info">--%>
						 <%--<span class="glyphicon glyphicon-envelope"></span>--%>
					 <%--</button></a>--%>
				 <%--</div>--%>

				 <%--<div id="messageCircle" class="badge-bg" style="margin-left:-70px;margin-top:10px;z-index:2; width:20px;--%>
    <%--height:20px;--%>
    <%--background-color:#F00;--%>
    <%--border-radius:25px;display:none;">--%>
                            <%--<span id="message_count" class="badge-span" style="    height:20px;--%>
    <%--line-height:20px;--%>
    <%--display:block;--%>
    <%--color:#FFF;--%>
    <%--text-align:center;"><s:if test="#session.message_count>0">--%>
								<%--<s:property value="#session.message_count"/></s:if></span>--%>
				 <%--</div>--%>
				 <%--<s:if test="#session.message_count>0">--%>
					 <%--<script>document.getElementById("messageCircle").style.display=""</script></s:if>--%>
			 <%--</s:if>--%>
             <%--<s:else>--%>
                 <%--<div class="col-md-1"></div>--%>
             <%--</s:else>--%>
			 <!---------------------------------------------->

             <li class="nav-item col-sm-1"></li>

			<li class="nav-item ">
                <s:if test="#session.user_name==null">
                    <div style="margin-top:25px;margin-left:117px;">
                        <a href="login.jsp" style="color: white;margin-right: 5px">登录</a>
                        <span style="color: white">|</span>
                        <a href="register.jsp" style="color: white;margin-left: 5px">注册</a>
                    </div>
                </s:if>
                <s:else>
                    <div class="dropdown" style="margin-top:18px;margin-left:10px;padding-left: 40px">
                        <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-user"></span>&emsp;已登录
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="/shoppingcart.jsp">购物车</a>
                            <a class="dropdown-item" href="/logout">退出登录</a>
                        </div>
                    </div>
                </s:else>
            </li>
		</ul>

		<!-----------举报团队------------>
		<div class="row">
			<div class="col-md-12">

				<div class="modal fade" id="modal-report" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="myModalLabel">
									举报
								</h5>
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">×</span>
								</button>
							</div>
							<div class="modal-body">
								<form role="form"  enctype="multipart/form-data" class="form-horizontal" method="post" action="sendReport">
									<input type="hidden" id="change-activity" name="reportTeamID" value="<%=request.getAttribute("report_team_id")%>" />
									<div class="input-group">
										<span class="col-md-3" style="margin-left:-5px">举报类型:</span>
										<select name ="briefReportSchool" class="form-control" style="left:0px;top:-6px;width:250px;border-top-left-radius: 5px; border-top-right-radius: 5px;border-bottom-left-radius:5px; border-bottom-right-radius:5px; ">
											<option >商品与实物不符</option>
											<option>虚假商品</option>
											<option>有害信息</option>
											<option>色情信息</option>
											<option>组织违法活动</option>
										</select>
									</div>
									<br>
									<div class="input-group">
										<span class="col-md-3" style="margin-left:-5px">详细描述:</span>
										<textarea name="detailReportSchool" cols="4" class="form-control" style="height: 120px;left:0px; border-top-left-radius: 5px; border-top-right-radius: 5px;border-bottom-left-radius:5px; border-bottom-right-radius:5px;" placeholder="请描述详情"></textarea>
									</div>
									<br><br>
									<div class="input-group">
									<label for="pictureFile">
										添加图片：
									</label>
									<input type="file" accept=".png,.jpg,.jpeg,image/png,image/jpg,image/jpeg" name="pictureFile" class="form-control-file" id="pictureFile" />
									</div>
									<br><br>
									<div class="form-group" style="margin-left:0%">
										<div class="row">
											<div class="col-md-4" style="margin-left: 10%">
												<button type="submit" class="btn btn-warning btn-block">确认举报</button>
											</div>
											<div class="col-md-4" style="margin-left: 15%">
												<button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">
													<span aria-hidden="true">我再想想</span>
												</button>
											</div>
										</div>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<div style="font-size: 12px;position: relative;left: -130px;">您的举报将督促团队的进步，但也会影响团队的声誉，请慎重</div>
							</div>
						</div>

					</div>

				</div>

			</div>
		</div>





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
						<tr>
							<th>参加活动：</th><td>
							<%if(activities[i].isHaveEntered()){%>
							<a href="#" onclick="exitActivity(<%=activities[i].getActivityID()%>)" id="activity-exit-<%=activities[i].getActivityID()%>"
							   role="button" class="btn btn-primary" style="margin-left:0%;">退出活动</a>
								<a href="#" onclick="enterActivity(<%=activities[i].getActivityID()%>)" role="button"
								   id="activity-enter-<%=activities[i].getActivityID()%>" class="btn btn-warning" style="margin-left:0%;display:none;">加入活动</a>
							<%}else{%>
								<a href="#" onclick="exitActivity(<%=activities[i].getActivityID()%>)" id="activity-exit-<%=activities[i].getActivityID()%>"
								   role="button" class="btn btn-primary" style="margin-left:0%;display:none;">退出活动</a>
							<a href="#" onclick="enterActivity(<%=activities[i].getActivityID()%>)" role="button"
							   id="activity-enter-<%=activities[i].getActivityID()%>" class="btn btn-warning" style="margin-left:0%;">加入活动</a>
							<%}%>
							<td>
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
			<!----------------注释处----------------->
		<!--div style="margin-left:90%;margin-top:1%">
		<label><a href = "#">查看更多 >></a></label>
		<!--/div-->
			<!---------------------------------->
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
			  <HR style= " FILTER: progid:DXImageTransform.Microsoft.Glow ( color= #987cb9 ,strength = 10) " width= "80%" color= #987 cb9 SIZE =1>
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
		<!------------注释处------------>
			<!--div style="margin-left:90%;margin-top:1%">
			<label><a href = "#">查看更多 >></a></label>
			</div-->
		<!------------------------>
	</div>
  </div>

		<br><br><br>
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
      function enterActivity(id) {
          var xmlhttp;
          if (window.XMLHttpRequest) {
              // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
              xmlhttp = new XMLHttpRequest();
          }
          else {
              // IE6, IE5 浏览器执行代码
              xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp.open("GET", "enterActivity.action?activity_id=" + id, false);
          xmlhttp.send();
          if(document.getElementById("activity-exit-"+id)!=null){
              document.getElementById("activity-exit-"+id).style.display="";
          }
          if(document.getElementById("activity-enter-"+id)!=null){
              document.getElementById("activity-enter-"+id).style.display="none";
          }
          if(xmlhttp.responseText=="fail"){
              window.location.href="/login.jsp";
          }
      }
      function exitActivity(id) {
          var xmlhttp;
          if (window.XMLHttpRequest) {
              // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
              xmlhttp = new XMLHttpRequest();
          }
          else {
              // IE6, IE5 浏览器执行代码
              xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp.open("GET", "exitActivity.action?activity_id=" + id, false);
          xmlhttp.send();
          if(document.getElementById("activity-enter-"+id)!=null){
              document.getElementById("activity-enter-"+id).style.display="";
          }
          if(document.getElementById("activity-exit-"+id)!=null){
              document.getElementById("activity-exit-"+id).style.display="none";
          }
          if(xmlhttp.responseText=="fail"){
              window.location.href="/login.jsp";
          }
      }
  </script>
  </body>
</html>