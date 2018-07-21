<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.Message" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.opensymphony.xwork2.util.ValueStack" %>
<%@ page import="Entity.CultureProduct" %>
<%@ page import="Operations.ViewProduct" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-团队邮箱</title>

    <link rel="alternate icon" href="img/qm.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/extend.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/default1.css" />
    <link rel="stylesheet" type="text/css" href="css/component1.css" />
    <script src="js/modernizr.custom.js"></script>
    <script src="js/teamMessageServer.js"></script>
</head>
<body>
<%if(request.getSession().getAttribute("user_id")!=null){%>
<script>createConn();</script>
<%}%>
<%String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
<%Map<String,ArrayList<Message>> messages=new HashMap<String,ArrayList<Message>>();
   /* ArrayList<Message>activityMessage=new ArrayList<Message>();//活动动态消息列表
    ArrayList<Message>productMessage=new ArrayList<Message>();//产品动态消息列表
    ArrayList<Message>commentMessage=new ArrayList<Message>();//评论消息列表*/
     ArrayList<Message>activityMessage=null;//活动动态消息列表
    ArrayList<Message>productMessage=null;//产品动态消息列表
    ArrayList<Message>commentMessage=null;//评论消息列表
    int activityUnreadCount=0;//未读的活动消息数量
    int productUnreadCount=0;//未读的产品消息数量
    int commentUnreadCount=0;//未读的评论消息数量
    if(request.getAttribute("messages")!=null) {
        //product,activity,report,comment,other
        messages = (Map<String, ArrayList<Message>>) request.getAttribute("messages");
        activityMessage = messages.get("activity");//活动消息类型
        if(activityMessage==null)
            activityMessage=new ArrayList<Message>();
        activityUnreadCount = Message.haveNotRead(activityMessage);
        productMessage = messages.get("purchase");
        if(productMessage==null)
            productMessage=new ArrayList<Message>();
        productUnreadCount = Message.haveNotRead(productMessage);
        commentMessage = messages.get("comment");
        if(commentMessage==null)
            commentMessage=new ArrayList<Message>();
        commentUnreadCount = Message.haveNotRead(commentMessage);
    }
   /* if(activityMessage==null)
        activityMessage=new ArrayList<Message>();//活动动态消息列表
    if(productMessage==null)
        productMessage=new ArrayList<Message>();//产品动态消息列表
    if(commentMessage==null)
        commentMessage=new ArrayList<Message>();//评论消息列表*/
%>
<ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
    <a class="navbar-brand col-sm-10" href="teamPage.jsp" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng - 邮箱</a>

    <div class="dropdown" style="margin-top:18px;margin-left:40px">
        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="background-color: #E0E0E0">
            <span class="glyphicon glyphicon-user"></span>&emsp;已登录
        </button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <a class="dropdown-item" href="logout.action">退出登录</a>
        </div>
    </div>
</ul>

<!--导航栏-->
<ul class="vertical-ul">
    <li class="vertical-li" ><a class="homepg" href="javascript:return false;" style="font-size:16px;padding:13px;">团队邮箱&emsp;<span class="glyphicon glyphicon-envelope" style="margin-top:5px;"></span></a></li>
    <li id="li0" class="vertical-li" style="background-color:#D0D0D0;" onclick="showPart(0)">
        <a href="javascript:void(0)">&emsp;购货提醒<%if(productMessage!=null&&productUnreadCount>0){%><span id="product-new" style="color:#EA0000;position:relative;top:-10px;left: 4px">
          new</span>  <%}%><span id="span0" style="float: right;position: relative;top:5px;" class="glyphicon glyphicon-chevron-right"></span></a>

    </li>
    <li id="li1" class="vertical-li" onclick="showPart(1)">
        <a href="javascript:void(0)">&emsp;活动动态<%if(activityMessage!=null&&activityUnreadCount>0){%><span id="activity-new" style="color:#EA0000;position:relative;top:-10px;left: 4px">
          new</span>  <%}%><span id="span1" class="glyphicon glyphicon-chevron-right" style="float: right;position: relative;top:5px;display: none"></span></a>

    </li>
    <li id="li2" class="vertical-li" onclick="showPart(2)">
        <a href="javascript:void(0)">&emsp;顾客消息<%if(commentMessage!=null&&commentUnreadCount>0){%><span id="comment-new" style="color:#EA0000;position:relative;top:-10px;left: 4px">
          new</span>  <%}%><span id="span2" class="glyphicon glyphicon-chevron-right" style="float: right;position: relative;top:5px;display: none"></span></a>
    </li>
</ul>

<!--主体内容-->
<div style="margin-left:16%;margin-top:5%;padding:1px 16px;">

    <!--发货提醒-->
    <div id="teamcre" style="padding: 20px;">
        <%if(productMessage!=null&&productMessage.size()>0){
            for(int i=productMessage.size()-1;i>=0;i--){%>
        <%CultureProduct pro=ViewProduct.viewGivenPro(productMessage.get(i).getProduct_id());%>

        <div class="alert alert-dismissable alert-success row">
            <div class="col-sm-10">
            <img  class="mr-3 img-thumbnail" style="height:100px;width:100px;" alt="商品缩略图" height="100px"
                  src="<%=basePath%>/getPic.action?productID=<%=productMessage.get(i).getProduct_id()%>" />
            用户 <strong style="color: #2fa8ec"><%=productMessage.get(i).getSender_name()%></strong> 已购买你团队的商品<a href="/enterProduct.action?<%=productMessage.get(i).getProduct_id()%>"
                                                                                                           class="alert-link" style="font-size:20px;">  <%=pro.getName()%></a> <span style="font-size: large">x<%=productMessage.get(i).getMessage_text()%></span>！
            &emsp;<%if(productMessage.get(i).getHaveRead()==false){%><span id="product-new-<%=productMessage.get(i).getMessage_id()%>" style="color: #A5281B">new</span><%}%>
            <br><%=productMessage.get(i).getDate()%>
            </div>
            <div class="col-sm-2">
            <%if(!productMessage.get(i).getHaveRead()){%>
            <a href="#" id="have-not-send-<%=productMessage.get(i).getMessage_id()%>" onclick="readProduct(<%=productMessage.get(i).getMessage_id()%>);" role="button" class="btn btn-primary" style="margin-left:30%;margin-top:43px">一键发货</a>
            <a href="#" id="have-send-<%=productMessage.get(i).getMessage_id()%>" role="button" class="btn btn-primary" style="margin-left:30%;margin-top:43px;display:none;">已发货</a>
            <%}else{%>
            <a href="#"  role="button" class="btn btn-primary" style="margin-left:30%;margin-top: 43px">已发货</a>
            <%}%>
            </div>
        </div>
        <%}}else{%>
        <img  src="img/nocontent.png">
        <%}%>


        <!--div class="alert alert-dismissable alert-warning" style="margin-top:2%;">
            <img class="mr-3 img-thumbnail" style="height:100px;width:100px;" alt="商品缩略图" src="img/WHUpro1.jpg">
            用户 <strong style="color: #2fa8ec">"hanyang"</strong> 已购买你团队的商品<a href="#" class="alert-link" style="font-size:20px;"> 武汉大学纪念册 </a> <span style="font-size: large">x4</span>！
            <a href="#" role="button" class="btn btn-primary" style="margin-left:30%;">一键发货</a>
        </div>
        <div class="alert alert-dismissable alert-warning" style="margin-top:2%;">
            <img class="mr-3 img-thumbnail" style="height:100px;width:100px;" alt="商品缩略图" src="img/WHUpro2.jpg">
            用户 <strong style="color: #2fa8ec">"hanyang"</strong> 已购买你团队的商品<a href="#" class="alert-link" style="font-size:20px;"> 武汉大学纪念册 </a> <span style="font-size: large">x4</span>！
            <a href="#" role="button" class="btn btn-primary" style="margin-left:30%;">一键发货</a>
        </div>
        <div class="alert alert-dismissable alert-warning" style="margin-top:2%;">
            <img class="mr-3 img-thumbnail" style="height:100px;width:100px;" alt="商品缩略图" src="img/WHUpro3.jpg">
            用户 <strong style="color: #2fa8ec">"hanyang"</strong> 已购买你团队的商品<a href="#" class="alert-link" style="font-size:20px;"> 武汉大学纪念册 </a> <span style="font-size: large">x4</span>！
            <a href="#" role="button" class="btn btn-primary" style="margin-left:30%;">一键发货</a>
        </div-->



    </div>

    <!--活动动态-->
    <div id="activity-about" class="activity-about" style="margin-top:2%;display: none">
        <!--新动态-->
        <%if(activityMessage!=null&&activityMessage.size()>0){
            for(int i=activityMessage.size()-1;i>=0;i--){%>
        <%if(activityMessage.get(i).getHaveRead()==false){%><span id="activity-new-<%=activityMessage.get(i).getMessage_id()%>" style="color: #A5281B">new</span><%}%>
        <div class="alert alert-dismissable alert-info" style="margin-top:1%;">
            用户 <strong><%=activityMessage.get(i).getSender_name()%></strong>
            已<%=activityMessage.get(i).getMessage_text()%>活动<a href="#" class="alert-link" style="font-size:20px;">
            <%=activityMessage.get(i).getActivity_name()%> </a><%=activityMessage.get(i).getDate()%>
        </div>
        <%}}else{%>
        <img  src="img/nocontent.png">
        <%}%>

        <!--div class="alert alert-dismissable alert-info" style="margin-top:1%;">
            用户 <strong>"hanyang"</strong> 已加入活动<a href="#" class="alert-link" style="font-size:20px;"> 珞珈寻宝 </a>
        </div>
        <div class="alert alert-dismissable alert-warning" style="margin-top:1%;">
            用户 <strong>"hanyang"</strong> 已加入活动<a href="#" class="alert-link" style="font-size:20px;"> 珞珈寻宝 </a>
        </div>
        <div class="alert alert-dismissable alert-danger" style="margin-top:1%;">
            用户 <strong>"hanyang"</strong> 已加入活动<a href="#" class="alert-link" style="font-size:20px;"> 珞珈寻宝 </a>
        </div>
        <div class="alert alert-dismissable alert-success" style="margin-top:1%;">
            用户 <strong>"hanyang"</strong> 已加入活动<a href="#" class="alert-link" style="font-size:20px;"> 珞珈寻宝 </a>
        </div-->
    </div>

    <div id="report-feedback" class="report-feedback" style="margin-top:2%;display: none">
        <%if(commentMessage!=null&&commentMessage.size()>0){
            for(int i=commentMessage.size()-1;i>=0;i--){%>
        <div class="alert alert-dismissable alert-info" style="margin-top:2%; ">
           在您这购买了<%
            CultureProduct pro=ViewProduct.viewGivenPro(commentMessage.get(i).getRelatedProID());
            if(pro!=null){
               out.write(pro.getName());
        }%> 的用户 <strong><%=commentMessage.get(i).getSender_name()%></strong> 给您发来了新消息！
            <br><%=commentMessage.get(i).getDate()%>
            <%if(commentMessage.get(i).getHaveRead()==false){%>
            <span id="comment-new-<%=commentMessage.get(i).getMessage_id()%>" style="color:#EA0000;position:relative;top:-10px;left: 4px">new</span><%}%>
            <button class="md-trigger btn-success button-arr btn-fill" onclick="showDetail(<%=commentMessage.get(i).getMessage_id()%>)" data-modal="modal-response-<%=commentMessage.get(i).getMessage_id()%>"><span>回复</span></button>
            <button class="md-trigger btn-info button-arr btn-fill" data-modal="modal-<%=commentMessage.get(i).getMessage_id()%>" ><span>查看详情</span></button>
        </div>
        <!--------------------------------------------------------------------------------------------------------------------------->
        <div class="md-modal md-effect-13" id="modal-response-<%=commentMessage.get(i).getMessage_id()%>">
            <div class="md-content">
               <h3>回复内容 <span style="margin-left: 50%"><a  role="button" class="md-close btn" data-dismiss="modal">x</a></span></h3>
                <div  id="response-detail-<%=commentMessage.get(i).getMessage_id()%>-show">
                    <form method="post" enctype="multipart/form-data" action="responseUser.action">
                    <ul>
                        <input type="hidden" name="receivedUser" value="<%=commentMessage.get(i).getSender_id()%>" />
                        <input type="hidden" name="relatedProID" value="<%=commentMessage.get(i).getRelatedProID()%>" />
                        <iframe id="rfFrame" name="rfFrame" src="about:blank" style="display:none;"></iframe>
                        <li><strong>回复用户:</strong> <%=commentMessage.get(i).getSender_name()%></li>
                        <li><strong>回复描述:</strong><textarea class="form-control" name="updateMessage" style="left:-90px; border-top-left-radius: 5px;
                                             border-top-right-radius: 5px;border-bottom-left-radius:5px;
                                              border-bottom-right-radius:5px;" placeholder="回复用户"></textarea></li>
                        <li><strong>附件图片:</strong><label for="pictureFile">
                            添加图片：
                        </label>
                            <input type="file" name="pictureFile" class="form-control-file" id="pictureFile" accept=".png,.jpg,.jpeg,image/png,image/jpg,image/jpeg"/></ul>
                    </form>
                    <br>
                    <button class="md-close btn-primary" onclick="sendResponseMessage(<%=commentMessage.get(i).getMessage_id()%>)">发送</button>

                </div>
                <div id="response-tip-<%=commentMessage.get(i).getMessage_id()%>-show" style="display:none;">
                    <h4>回复已发送</h4>
                </div>
            </div>
        </div>
        <!--------------------------------------------------------------------------------------------------------------------------->
        <div class="md-modal md-effect-13" id="modal-<%=commentMessage.get(i).getMessage_id()%>">
            <div class="md-content">
                <h3>用户消息</h3>
                <div>
                    <ul>
                        <li><strong>用户:</strong> <%=commentMessage.get(i).getSender_name()%></li>
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
        <!--未读消息-->
        <!--div class="alert alert-dismissable alert-info" style="margin-top:2%; ">
            用户 <strong>"yanghan"</strong> 给您发来了新消息！<span style="color:#EA0000;position:relative;top:-10px;left: 4px">new</span>
            <button class="md-trigger btn-info button-arr btn-fill" data-modal="modal-2" ><span>查看详情</span></button>
        </div>
        <div class="alert alert-dismissable alert-info" style="margin-top:2%;">
            用户 <strong>"珞珈风梓"</strong> 给您发来了新消息！<span style="color:#EA0000;position:relative;top:-10px;left: 4px">new</span>
            <button class="md-trigger btn-info button-arr btn-fill" data-modal="modal-2" ><span>查看详情</span></button>
        </div>
        <!--已读消息-->
        <!--div class="alert alert-dismissable alert-success" style="margin-top:2%;">
            用户 <strong>"yanghan"</strong> 给您发来了新消息！
            <button class="md-trigger btn-success button-arr btn-fill" data-modal="modal-2" ><span>查看详情</span></button>
        </div>
        <div class="alert alert-dismissable alert-success" style="margin-top:2%;">
            用户 <strong>"yanghan"</strong> 给您发来了新消息！
            <button class="md-trigger btn-success button-arr btn-fill" data-modal="modal-2"><span>查看详情</span></button>
        </div>
        <button class="btn btn-info" style="margin-left: 80%;border-top-right-radius:0;border-bottom-right-radius:0;border-top-left-radius:15px;border-bottom-left-radius:15px;"><span>一键已读</span></button>
        <button class="btn btn-success" style="margin-left: -6px;border-top-left-radius:0;border-bottom-left-radius:0;border-top-right-radius:15px;border-bottom-right-radius:15px;"><span>删除已读</span></button>
        <!--弹出框-->
        <!--div class="md-modal md-effect-13" id="modal-">
            <div class="md-content">
                <h3>用户消息</h3>
                <div>
                    <ul>
                        <li><strong>用户:</strong> yanghan</li>
                        <li><strong>详细描述:</strong>我买这本书已经五天了，怎么还没到？？？</li>
                    </ul>
                    <button class="md-close btn-primary">已读</button>
                </div>
            </div>
        </div-->
    </div>


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
    var as=[];
    as[0]=$("#li0");
    as[1]=$("#li1");
    as[2]=$("#li2");
    var spans=[];
    spans[0]=$("#span0");
    spans[1]=$("#span1");
    spans[2]=$("#span2");
    var pageNum=0;
    function showPart(index) {
        pageNum=index;
        if(pageNum==1){
            <%for(int i=0;i<activityMessage.size();i++){
            if(activityMessage.get(i).getHaveRead()==false){%>
            readMessage(<%=activityMessage.get(i).getMessage_id()%>);
            document.getElementById("activity-new-<%=activityMessage.get(i).getMessage_id()%>").style.display="none";
            document.getElementById("activity-new").style.display="none";
            <%}}%>
        }
        for(var i=0;i<3;i++) {
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
    var activityUnreadCount=<%=activityUnreadCount%>;
    var productUnreadCount=<%=productUnreadCount%>;
    var commentUnreadCount=<%=commentUnreadCount%>;
    function readActivity(obj) {
        activityUnreadCount--;
        document.getElementById("activity-new-"+obj).style.display="none";
        readMessage(obj);
        if(activityUnreadCount==0){
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
        document.getElementById("product-new-"+obj).style.display="none";
        document.getElementById("have-not-send-"+obj).style.display="none";
        document.getElementById("have-send-"+obj).style.display="";
        readMessage(obj);
        if(productUnreadCount==0){
            document.getElementById("product-new").style.display="none";
        }
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
        xmlhttp.open("GET","/sendProductMessage.action?message_id="+obj,true);
        xmlhttp.send();
        // obj.style.display="none";
    }
    function readReport(obj){
        reportUnreadCount--;
        document.getElementById("report-new-"+obj).style.display="none";
        readMessage(obj);
        if(reportUnreadCount==0){
            document.getElementById("report-new").style.display="none";
        }
        // obj.style.display="none";
    }
    function readComment(obj){
        commentUnreadCount--;
        document.getElementById("comment-new-"+obj).style.display="none";
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
        if(commentUnreadCount==0){
            document.getElementById("comment-new").style.display="none";
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
    function sendResponseMessage(obj){
        document.forms[0].target="rfFrame";
        document.forms[0].submit();
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