<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.Message" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.opensymphony.xwork2.util.ValueStack" %>
<%@ page import="Entity.CultureProduct" %>
<%@ page import="Operations.ViewProduct" %>
<%@ page import="Entity.Team" %>
<%@ page import="Operations.MessageOperate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-邮箱</title>

	  <link rel="alternate icon" href="img/qm.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/extend.css" rel="stylesheet">
		<link rel="shortcut icon" href="../favicon.ico"> 
		<link rel="stylesheet" type="text/css" href="css/default1.css" />
		<link rel="stylesheet" type="text/css" href="css/component1.css" />
		<script src="js/modernizr.custom.js"></script>
	  <script src="js/boxServer.js"></script>
  </head>
  <body>
  <%if(request.getSession().getAttribute("user_id")!=null){%>
  <script>createConn();</script>
  <%}%>
  <%String path = request.getContextPath();
	  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
  <%Map<String,ArrayList<Message>> messages=new HashMap<String,ArrayList<Message>>();
	  /*ArrayList<Message>activityMessage=new ArrayList<Message>();//活动动态消息列表
	  ArrayList<Message>reportMessage=new ArrayList<Message>();//举报消息列表
	  ArrayList<Message>productMessage=new ArrayList<Message>();//产品动态消息列表
	  ArrayList<Message>commentMessage=new ArrayList<Message>();//评论消息列表
	  ArrayList<Message>discussMessage=new ArrayList<Message>();//其他动态消息列表*/
	   ArrayList<Message>activityMessage=null;//活动动态消息列表
	  ArrayList<Message>reportMessage=null;//举报消息列表
	  ArrayList<Message>productMessage=null;//产品动态消息列表
	  ArrayList<Message>commentMessage=null;//评论消息列表
	  ArrayList<Message>discussMessage=null;//其他动态消息列表
	  int activityUnreadCount=0;//未读的活动消息数量
	  int reportUnreadCount=0;//未读的举报消息数量
	  int productUnreadCount=0;//未读的产品消息数量
	  int commentUnreadCount=0;//未读的评论消息数量
	  int discussUnreadCount=0;//未读的其他消息数量
	  if(request.getAttribute("messages")!=null) {
	      //product,activity,report,comment,other
		  messages = (Map<String, ArrayList<Message>>) request.getAttribute("messages");
		  activityMessage = messages.get("activity");//活动消息类型
		  if(activityMessage==null)
			  activityMessage=new ArrayList<Message>();
		  activityUnreadCount = Message.haveNotRead(activityMessage);
		  reportMessage = messages.get("reportResponse");//举报反馈消息类型
		  if(reportMessage==null)
			  reportMessage=new ArrayList<Message>();
		  reportUnreadCount = Message.haveNotRead(reportMessage);
		  productMessage = messages.get("product");
		  if(productMessage==null)
			  productMessage=new ArrayList<Message>();
		  productUnreadCount = Message.haveNotRead(productMessage);
		  commentMessage = messages.get("comment");
		  if(commentMessage==null)
			  commentMessage=new ArrayList<Message>();
		  commentUnreadCount = Message.haveNotRead(commentMessage);
		  discussMessage = messages.get("other");
		  if(discussMessage==null)
			  discussMessage=new ArrayList<Message>();
		  discussUnreadCount = Message.haveNotRead(discussMessage);
	  } %>
		<ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
			<a class="navbar-brand col-sm-10" href="index.jsp" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng - 邮箱</a>

            <li class="nav-item ">
                <s:if test="#session.user_name==null">
                    <div style="margin-top:25px;margin-left:80px;">
                        <a href="login.jsp" style="color: white;margin-right: 5px">登录</a>
                        <span style="color: white">|</span>
                        <a href="register.jsp" style="color: white;margin-left: 5px">注册</a>
                    </div>
                </s:if>
                <s:else>
                    <div class="dropdown" style="margin-top:15px;margin-left:40px">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="background-color: #E0E0E0">
                            <span class="glyphicon glyphicon-user"></span>&emsp;已登录
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="/enterShopping.action">购物车</a>
                            <a class="dropdown-item" href="logout.action">退出登录</a>
                        </div>
                    </div>
                </s:else>
            </li>
		</ul>
			
		<!--导航栏-->
		<ul class="vertical-ul">
			<li class="vertical-li" ><a class="homepg" href="javascript:return false;" style="font-size:16px;padding:13px;">服务消息&emsp;<span class="glyphicon glyphicon-envelope" style="margin-top:5px;"></span></a></li>
			<li id="li0" class="vertical-li" style="background-color:#D0D0D0;" onclick="showPart(0)">
				<a href="javascript:void(0)">发货提醒<%if(productMessage!=null&&productUnreadCount>0){%>
					<span id="product-new" style="position: relative;top:-10px;color: #A5281B;">new</span><%}%><span id="span0" class="glyphicon glyphicon-chevron-right" style="top:5px;float: right"></span></a>
				
			</li>
			<li id="li1" class="vertical-li" onclick="showPart(1)">
				<a href="javascript:void(0)">活动相关
					<%if(activityMessage!=null&&activityUnreadCount>0){%>
					<span id="activity-new" style="position: relative;top:-10px;color: #A5281B;">new</span><%}%><span id="span1" class="glyphicon glyphicon-chevron-right" style="top:5px;float: right;display: none"></span></a>
				
			</li>
			<li class="vertical-li"><a class="homepg" href="javascript:return false;" style="font-size:16px;padding:11px;">互动消息&emsp;<span class="glyphicon glyphicon-envelope" style="margin-top:5px;"></span></a></li>
			<li id="li2" class="vertical-li" onclick="showPart(2)">
				<a href="javascript:void(0)">举报反馈<%if(reportMessage!=null&&reportUnreadCount>0){%>
					<span id="report-new" style="position: relative;top:-10px;color: #A5281B;">new</span><%}%><span id="span2" class="glyphicon glyphicon-chevron-right" style="top:5px;float: right;display: none"></span></a>
				
			</li>
			<%--<li id="li3" class="vertical-li" onclick="showPart(3);readAllComment();">--%>
				<%--<a href="javascript:void(0)"><%if(discussMessage!=null&&discussUnreadCount>0){%>--%>
					<%--<span id="discuss-new" style="color: #A5281B;">new</span><%}%>评论回复&emsp;&emsp;&emsp;&emsp;&emsp;<span id="span3" class="glyphicon glyphicon-chevron-right" style="display: none"></span></a>--%>
				<%----%>
			<%--</li>--%>
			<li id="li4" class="vertical-li" onclick="showPart(3)">
				<a href="javascript:void(0)">其他信息<%if(commentMessage!=null&&commentUnreadCount>0){%>
					<span id="comment-new" style="position: relative;top:-10px;color: #A5281B;">new</span><%}%><span id="span4" class="glyphicon glyphicon-chevron-right" style="top:5px;float:right;display: none"></span></a>
				
			</li>
		</ul>
		
		<!--主体内容-->
		<div id="display-all-Message" style="margin-left:16%;margin-top:5%;padding:1px 16px;display:none;">
		
		<!--发货提醒-->
		<div id="teamcre">
			<%if(productMessage!=null&&productMessage.size()>0){
				for(int i=productMessage.size()-1;i>=0;i--){%>
			<%CultureProduct pro=ViewProduct.viewGivenPro(productMessage.get(i).getProduct_id());%>
			<div class="alert alert-dismissable alert-success" style="margin-top:20px">
				<img  class="mr-3 img-thumbnail" style="height:100px;width:100px;" alt="商品缩略图"
					 src="<%=basePath%>/getPic.action?productID=<%=productMessage.get(i).getProduct_id()%>" />
				你购买的来自 <strong><%=productMessage.get(i).getSender_name()%></strong> 团队的宝贝<a href="enterProduct.action?productID=<%=pro.getProductID()%>" class="alert-link" style="font-size:20px;"> <%=pro.getName()%> </a>已发货！
				<br><%=productMessage.get(i).getDate()%>
				<%if(productMessage.get(i).getHaveRead()==false){%>
				<a href="#" onclick="readProduct(<%=productMessage.get(i).getMessage_id()%>)" id="not-get-Product-<%=productMessage.get(i).getMessage_id()%>" role="button" class="btn btn-primary" style="margin-left:63%;margin-top: -3%;">确认收货</a>
				<a href="#" role="button" id="get-Product-<%=productMessage.get(i).getMessage_id()%>" class="btn btn-primary disabled" style="margin-left:63%;margin-top: -3%;display:none;">已经收货</a>
				<%}else{%>
				<a href="#" role="button" class="btn btn-primary disabled" style="margin-left:63%;margin-top: -3%;">已经收货</a>
				<%}%>
				<!--a href="#modal-pubact" role="button" onclick="changeShopTeamID(<--%=ViewProduct.viewGivenPro(productMessage.get(i).getProduct_id()).getTeamID()%>)" class="btn btn-primary" data-toggle="modal" style="margin-left:30%;">联系商家</a-->
                <a href="#modal-pubact" role="button" onclick="changeProID(<%=productMessage.get(i).getProduct_id()%>)" class="btn btn-primary" data-toggle="modal" style="margin-left:5px;margin-top: -3%;">联系商家</a>
                <!--------------------------------------------联系商家----------------------------------------->
				<div class="row">
					<div class="col-md-12">

						<div class="modal fade" id="modal-pubact" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content" style="width: 800px;margin-left: -28%">
									<div class="modal-header">
										<h5 class="modal-title" id="myModalLabel">
											联系商家
										</h5>
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">×</span>
										</button>
									</div>
									<div class="modal-body">
										<!---------------在此处添加-------------->

										<form role="form"  enctype="multipart/form-data" method="post" class="form-horizontal" action="sendComment">
											<!--input type="hidden" id="change-shopteam-id" name="updateTeamID" value="" /-->
                                            <input type="hidden" id="change-pro-id" name="relatedProID" value="" />
											<br />
											<div class="input-group">
												<span class="col-md-3" style="margin-left:10px">联系商家:</span>
												<textarea class="form-control" name="updateMessage" style="left:-90px; border-top-left-radius: 5px;
                                             border-top-right-radius: 5px;border-bottom-left-radius:5px;
                                              border-bottom-right-radius:5px;" placeholder="联系商家"></textarea>
											</div>
											<br>
											<div class="input-group">

												<label for="pictureFile">
													添加图片：
												</label>
												<input type="file" name="pictureFile" class="form-control-file" id="pictureFile" accept=".png,.jpg,.jpeg,image/png,image/jpg,image/jpeg"/>
												<!--input type="file" name="updatePictureFile" class="form-control-file" id="exampleInputFile" /-->
											</div>
											<br />
											<div class="form-group" style="margin-left:34%">
												<div class="col-sm-offset-2 col-md-6">
													<button type="submit" class="btn btn-warning btn-block">发送</button>
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
				<!--------------------------------------联系商家----------------------------------------------->
			</div>
			<%}}else{%>
			<img  src="img/nocontent.png">
			<%}%>
		</div>

			<!--活动相关-->
			
			<div id="activity-about" class="activity-about" style="margin-top:2%;display: none">
				<%if(activityMessage!=null&&activityMessage.size()>0){
					for(int i=activityMessage.size()-1;i>=0;i--){%>
                <div class="alert alert-dismissable alert-info">
				<%if(activityMessage.get(i).getHaveRead()==false){%><span id="activity-new-<%=activityMessage.get(i).getMessage_id()%>" style="color: #A5281B">new</span><%}
				else{%>
				<span id="activity-new-<%=activityMessage.get(i).getMessage_id()%>" style="color: #A5281B;display:none;">new</span>
				<%}%>
				你参与的<span style="color:red;"><%=activityMessage.get(i).getSender_name()%></span>
				团队发布的<strong style="font-size:15px;color:red;"><%=activityMessage.get(i).getActivity_name()%>
			</strong>活动有新动态！！！
				<br><%=activityMessage.get(i).getDate()%>
				<br />
				<button class="md-trigger btn-info" data-modal="modal-<%=activityMessage.get(i).getMessage_id()%>" style="margin-top:5px;">查看详情</button>
				<button  onclick="readActivity(<%=activityMessage.get(i).getMessage_id()%>);deleteMessage(<%=activityMessage.get(i).getMessage_id()%>);" style="margin-top:5px;">删除消息</button>
				<!--弹出框-->
				<div class="md-modal md-effect-1" id="modal-<%=activityMessage.get(i).getMessage_id()%>">
				<div class="md-content">
					<h3>活动动态公告</h3>
					<div>
						<ul>
							<li><strong>发布时间：</strong><%=activityMessage.get(i).getDate()%></li>
							<li><strong>活动名:</strong> <%=activityMessage.get(i).getActivity_name()%></li>
							<li><strong>公告内容:</strong> <%=activityMessage.get(i).getMessage_text()%></li>
							<li><strong>附件图片：</strong><%if(activityMessage.get(i).getHavePic()==true){%><img height="200px"
																			 src="<%=basePath%>/getPic.action?messageID=<%=activityMessage.get(i).getMessage_id()%>" /><%}%>
							</li>
						</ul>
						<button class="md-close btn-primary" onclick="readActivity(<%=activityMessage.get(i).getMessage_id()%>)">已读</button>
					</div>
				</div>
				</div>
                </div>
<%}}%>
			</div>
			<!--------------------------------未改完--------------------------------->
			<div id="report-feedback" class="report-feedback" style="margin-top:2%;display:none;">
					<%if(reportMessage!=null&&reportMessage.size()>0){
						for(int i=reportMessage.size()-1;i>=0;i--){%>
					<div class="alert alert-dismissable alert-warning">
					你对<span style="color:red;"><%=Team.getTeam(reportMessage.get(i).getReportedTeamID()).getTeamName()%></span>团队的举报有了新动态
					<%if(reportMessage.get(i).getHaveRead()==false){%><span id="report-new-<%=reportMessage.get(i).getMessage_id()%>" style="top:-10px;color: #A5281B">new</span><%}%>
					<button class="md-trigger btn-info" data-modal="modal-report-<%=reportMessage.get(i).getMessage_id()%>" style="position: relative;top:20px;left: 100px">查看详情</button>
					<br />
                	<%=reportMessage.get(i).getDate()%>
					<!--弹出框-->
					<div class="md-modal md-effect-13" id="modal-report-<%=reportMessage.get(i).getMessage_id()%>">
						<div class="md-content">
							<h3><%=MessageOperate.getSchoolNameThroughID(reportMessage.get(i).getSender_id())%>对您举报的反馈</h3>
							<div>
								<ul>
									<li><strong>举报队伍:</strong><%=Team.getTeam(reportMessage.get(i).getReportedTeamID()).getTeamName()%></li>
									<li><strong>处理结果:</strong><%=reportMessage.get(i).getMessage_text()%></li>
								</ul>
								<button class="md-close btn-primary" onclick="readReport(<%=reportMessage.get(i).getMessage_id()%>)">已读</button>
							</div>
						</div>
					</div>
					<br>
					</div>
					<%}}else{%>
				<img  src="img/nocontent.png">
				<%}%>

			</div>
			<!------------------------------------------------------------------->
				
			
		<!--举报反馈-->
		
			<!------------------------------未改！！！------------------------------------->
		<!--评论回复-->
		<%--<div id="reply" style="margin-top:2%;padding:10px;background-color:#F0F0F0;display: none">--%>
			<%--<span style="color:red;"> 珞珈风梓 </span>回复你：那你真的太棒棒了！--%>
			<%----%>
			<%--<div style="background-color:#E0E0E0; padding:20px;margin-top:5px">--%>
				<%--<span style="color:blue;">YangHan</span>:&emsp;这件商品不错，朕买了。--%>
				<%--<br><br>--%>
				<%--<img class="mr-3 img-thumbnail" style="height:100px;width:100px;" alt="商品缩略图" src="img/WHUpro1.jpg">--%>
			<%--</div>--%>
		<%--</div>--%>
			<!------------------------------------------------------------------->
			<!------------------------------未改！！！------------------------------------->
		<div id="others" style="margin-top:2%;display: none;">
            <%if(commentMessage!=null&&commentMessage.size()>0){
                for(int i=commentMessage.size()-1;i>=0;i--){%>
            <div class="alert alert-dismissable alert-info" style="margin-top:2%; ">
                您购买的<%
                CultureProduct pro=ViewProduct.viewGivenPro(commentMessage.get(i).getRelatedProID());
                if(pro!=null){
                    out.write("<a href=\"/enterProduct.action?productID="+commentMessage.get(i).getRelatedProID()+"\">"+pro.getName()+"</a>");
                }%>所在的
                商家 <strong><%=commentMessage.get(i).getSender_name()%></strong> 回复了您的消息
				<%if(commentMessage.get(i).getHaveRead()==false){%>
				<span id="comment-new-<%=commentMessage.get(i).getMessage_id()%>" style="color:#EA0000;position:relative;top:-10px;left: 4px">new</span><%}%>
                <br><%=commentMessage.get(i).getDate()%>
                <button class="md-trigger btn-success button-arr btn-fill" onclick="showDetail(<%=commentMessage.get(i).getMessage_id()%>)" data-modal="modal-response-<%=commentMessage.get(i).getMessage_id()%>"><span>回复</span></button>
                <button class="md-trigger btn-info button-arr btn-fill" data-modal="modal-<%=commentMessage.get(i).getMessage_id()%>" ><span>查看详情</span></button>
            </div>
            <!--------------------------------------------------------------------------------------------------------------------------->
            <div class="md-modal md-effect-13" id="modal-response-<%=commentMessage.get(i).getMessage_id()%>">
                <div class="md-content">
                    <h3>回复内容 <span style="margin-left: 50%"><a  role="button" class="md-close btn" data-dismiss="modal">x</a></span></h3>
                    <div id="response-detail-<%=commentMessage.get(i).getMessage_id()%>-show">
                        <form id="messageResponse-<%=commentMessage.get(i).getMessage_id()%>" method="post" enctype="multipart/form-data" action="responseUser.action">
                            <ul>
                                <input type="hidden" name="receivedUser" value="<%=commentMessage.get(i).getSender_id()%>" />
                                <input type="hidden" name="relatedProID" value="<%=commentMessage.get(i).getRelatedProID()%>" />
                                <iframe id="rfFrame" name="rfFrame" src="about:blank" style="display:none;"></iframe>
                                <li><strong>回复商家:</strong> <%=commentMessage.get(i).getSender_name()%></li>
                                <li><strong>回复描述:</strong><textarea class="form-control" name="updateMessage" style="left:-90px; border-top-left-radius: 5px;
                                             border-top-right-radius: 5px;border-bottom-left-radius:5px;
                                              border-bottom-right-radius:5px;" placeholder="回复商家"></textarea></li>
                                <li><strong>附件图片:</strong><label for="pictureFile">
                                    添加图片：
                                </label>
                                    <input type="file" name="pictureFile" class="form-control-file" accept=".png,.jpg,.jpeg,image/png,image/jpg,image/jpeg"/></ul>
                        </form>
                        <br>
                        <button type="button" class="md-close btn-primary" data-dismiss="modal" onclick="sendResponseMessage(<%=commentMessage.get(i).getMessage_id()%>);" >发送</button>

                    </div>
                    <div id="response-tip-<%=commentMessage.get(i).getMessage_id()%>-show" style="display:none;">
                        <h4>回复已发送</h4>
                    </div>
                </div>
            </div>
            <!--------------------------------------------------------------------------------------------------------------------------->
            <div class="md-modal md-effect-13" id="modal-<%=commentMessage.get(i).getMessage_id()%>">
                <div class="md-content">
                    <h3>商家消息</h3>
                    <div>
                        <ul>
                            <li><strong>商家:</strong> <%=commentMessage.get(i).getSender_name()%></li>
                            <li><strong>详细描述:</strong><%=commentMessage.get(i).getMessage_text()%></li>
                            <li><strong>附件图片:</strong><%if(commentMessage.get(i).getHavePic()==true){%><img height="200px"
                                                                                                            src="<%=basePath%>/getPic.action?messageID=<%=commentMessage.get(i).getMessage_id()%>" /><%}%></li>
                        </ul>
                        <button class="md-close btn-primary" onclick="readComment(<%=commentMessage.get(i).getMessage_id()%>)">已读</button>
                    </div>
                </div>
            </div>
            <%}}else{%>
            <img  src="img/nocontent.png">
            <%}%>
		<!--img src="img/nocontent.png"-->
		</div>
			<!------------------------------------------------------------------->
		</div>

		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/scripts.js"></script>
		<script src="js/classie.js"></script>
		<script src="js/modalEffects.js"></script>

		<!-- for the blur effect -->
		<!-- by @derSchepp https://github.com/Schepp/CSS-Filters-Polyfill -->
		<script>
			// this is important for IEs
			var polyfilter_scriptpath = '/js/';
		</script>
		<script src="js/cssParser.js"></script>
		<script src="js/css-filters-polyfill.js"></script>
		<script type="text/javascript">
            var parts=[];
            parts[0]=$("#teamcre");
            parts[1]=$("#activity-about");
            parts[2]=$("#report-feedback");
            parts[3]=$("#others");
            var as=[];
            as[0]=$("#li0");
            as[1]=$("#li1");
            as[2]=$("#li2");
            as[3]=$("#li4");
            var spans=[];
            spans[0]=$("#span0");
            spans[1]=$("#span1");
            spans[2]=$("#span2");
            spans[3]=$("#span4");
            var pageNum=0;
            function showPart(index) {
                pageNum=index;
                for(var i=0;i<4;i++) {
                    if (i === index) {
                        parts[i].show();
                        spans[i].show();
                        as[i].css("background-color","#D0D0D0");
                    }
                    else {
                        parts[i].hide();
                        as[i].removeAttr("style");
                        spans[i].hide();
                    }
                }
            }

            showPart( <s:property value="page"/>);
            document.getElementById("display-all-Message").style.display="";
            var activityUnreadCount=<%=activityUnreadCount%>;
            var reportUnreadCount=<%=reportUnreadCount%>;
            var productUnreadCount=<%=productUnreadCount%>;
            var commentUnreadCount=<%=commentUnreadCount%>;
            var discussUnreadCount=<%=discussUnreadCount%>;
            function readActivity(obj) {
                if( document.getElementById("activity-new-"+obj).style.display=="none")
                    return;
                activityUnreadCount--;
                document.getElementById("activity-new-"+obj).style.display="none";
               /* var xmlhttp;
                if (window.XMLHttpRequest)
                {
                    //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                    xmlhttp=new XMLHttpRequest();
                }
                else
                {
                    // IE6, IE5 浏览器执行代码
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.open("get","/readMessage.action?message_id="+obj,true);
                xmlhttp.send();*/
               readMessage(obj);
                if(activityUnreadCount===0){
                    document.getElementById("activity-new").style.display="none";
				}
				//obj.style.display="none";
            }
            function readMessage(obj){
                var xmlhttp;
                if (window.XMLHttpRequest)
                {
                    //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                    xmlhttp=new XMLHttpRequest();
                }
                else
                {
                    // IE6, IE5 浏览器执行代码
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.open("get","/readMessage.action?message_id="+obj,true);
                xmlhttp.send();
			}
            function readProduct(obj){
                productUnreadCount--;
                if(document.getElementById("product-new-"+obj)!=null)
                document.getElementById("product-new-"+obj).style.display="none";
				document.getElementById("not-get-Product-"+obj).style.display="none";
                document.getElementById("get-Product-"+obj).style.display="";
               /* var xmlhttp;
                if (window.XMLHttpRequest)
                {
                    //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                    xmlhttp=new XMLHttpRequest();
                }
                else
                {
                    // IE6, IE5 浏览器执行代码
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.open("get","/readMessage.action?message_id="+obj,true);
                xmlhttp.send();*/
                readMessage(obj);
                if(productUnreadCount===0){
                    document.getElementById("product-new").style.display="none";
                }
               // obj.style.display="none";
			}
            function readReport(obj){
                if( document.getElementById("report-new-"+obj).style.display=="none")
                    return;
                reportUnreadCount--;
                document.getElementById("report-new-"+obj).style.display="none";
               /* var xmlhttp;
                if (window.XMLHttpRequest)
                {
                    //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                    xmlhttp=new XMLHttpRequest();
                }
                else
                {
                    // IE6, IE5 浏览器执行代码
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.open("get","/readMessage.action?message_id="+obj,true);
                xmlhttp.send();*/
                readMessage(obj);
                if(reportUnreadCount===0){
                    document.getElementById("report-new").style.display="none";
                }
                // obj.style.display="none";
            }
            function readAllComment(){
                var xmlhttp;
                if (window.XMLHttpRequest)
                {
                    //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                    xmlhttp=new XMLHttpRequest();
                }
                else
                {
                    // IE6, IE5 浏览器执行代码
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }

                <%--for(int i=0;i<commentMessage.size();i++){%>
                document.getElementById("report-new-"+<%=commentMessage.get(i).getMessage_id()%>).style.display="none";
                xmlhttp.open("get","/readMessage.action?message_id="+<%=commentMessage.get(i).getMessage_id()%>,true);
                xmlhttp.send();
                    document.getElementById("report-new").style.display="none";
                <%}---%>
			}
            function deleteMessage(id){
                var xmlhttp;
                if (window.XMLHttpRequest)
                {
                    //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                    xmlhttp=new XMLHttpRequest();
                }
                else
                {
                    // IE6, IE5 浏览器执行代码
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.open("get","/deleteMessage.action?message_id="+id,false);
                xmlhttp.send();
                window.location.href="/enterMessageBox.action?page="+pageNum;
                // obj.style.display="none";
            }
            function changeShopTeamID(obj){
                document.getElementById("change-shopteam-id").value=obj;
            }
            function changeProID(obj){
                document.getElementById("change-pro-id").value=obj;
            }
            // function readReport(obj){
            //     reportUnreadCount--;
            //     document.getElementById("report-new-"+obj).style.display="none";
            //     var xmlhttp;
            //     if (window.XMLHttpRequest)
            //     {
            //         //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
            //         xmlhttp=new XMLHttpRequest();
            //     }
            //     else
            //     {
            //         // IE6, IE5 浏览器执行代码
            //         xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            //     }
            //     xmlhttp.open("get","/readMessage.action?message_id="+obj,true);
            //     xmlhttp.send();
            //     if(productUnreadCount===0){
            //         document.getElementById("report-new").style.display="none";
            //     }
            //     // obj.style.display="none";
            // }
            function readComment(obj){
                if( document.getElementById("comment-new-"+obj).style.display=="none")
                    return;
                commentUnreadCount--;
                document.getElementById("comment-new-"+obj).style.display="none";
                readMessage(obj);
                if(commentUnreadCount===0){
                    document.getElementById("comment-new").style.display="none";
                }
            }
            function sendResponseMessage(obj){
                document.getElementById("messageResponse-"+obj).target="rfFrame";
                document.getElementById("messageResponse-"+obj).submit();
                document.getElementById("response-detail-"+obj+"-show").style.display="none";
                document.getElementById("response-tip-"+obj+"-show").style.display="";
            }
           function showDetail(obj){
               document.getElementById("response-detail-"+obj+"-show").style.display="";
               document.getElementById("response-tip-"+obj+"-show").style.display="none";
           }
		</script>
  </body>
</html>