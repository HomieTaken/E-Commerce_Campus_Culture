<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.InterestGroup" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DataBase.DBOperation" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/7/007
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Chat</title>

    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">

    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="alternate icon" href="assets/i/favicon.ico">
    <link rel="stylesheet" href="assets/css/amazeui.min.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/extend.css" rel="stylesheet">

    <!-- umeditor css -->

    <style>
        .title {
            text-align: center;
        }

        .chat-content-container {
            height: 29rem;
            overflow-y: scroll;
            border: 1px solid silver;
        }

        .list-group a{
            height:50px;
            font-size: 14px;
        }

        .list-group a:hover:not(.active){
            background-color:#80FFFF;
        }

        .chatul li{
            height:50px;
            font-size: 14px;
        }

        .grayimg {
            -webkit-filter: grayscale(1); /* Webkit */
            filter: gray; /* IE6-9 */
            filter: grayscale(1); /* W3C */
        }

    </style>
</head>
<%
    ArrayList<InterestGroup> groups=new ArrayList<InterestGroup>();
    try {
        ResultSet rs=DBOperation.getRS("select * from interest_group where group_id in (select group_id from group_members where user_id=\'"+session.getAttribute("user_id")+"\')");
        while (rs.next()){
            InterestGroup group=new InterestGroup();
            group.setOwnerID(rs.getInt("group_owner_id"));
            group.setGroupID(rs.getInt("group_id"));
            group.setGroupName(rs.getString("group_name"));
            group.setGroupInfo(rs.getString("group_info"));
            groups.add(group);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<body>
<!-- title start -->
<ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
    <a class="navbar-brand col-sm-7" href="index.jsp" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng-兴趣小组 </a>

    <li class="nav-item col-sm-3">
        <form class="form-inline" style="margin-top:18px;">
            <input class="form-control mr-sm-2" type="text" style="width: 200px;height: 36px;font-size: 16px;" placeholder="搜小组">
            <button class="btn btn-default my-2 my-sm-0" type="submit" style="font-size: 16px;height: 34px;">
                <span class="glyphicon glyphicon-search"></span>
            </button>
        </form>
    </li>
    <li class="nav-item ">
        <div class="dropdown" style="margin-top:18px;margin-left:40px;">
            <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="text-shadow: black 5px 3px 3px;height: 36px;font-size: 16px;margin-left: 30px;">
                <span class="glyphicon glyphicon-user"></span>&emsp;已登录
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item disabled" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="#">Something else here</a>
            </div>
        </div>
    </li>
</ul>

<div class="row" style="margin-top: 5%;">

    <!--兴趣小组列表-->
    <div class="col-md-3">
        <div class="list-group" style="margin-left: 20px;margin-top: 20px;">
            <a href="javascript:return false;" class="list-group-item list-group-item-action active" style="">兴趣小组</a>
            <%
                for (InterestGroup group : groups) {
            %>
            <a id="group_id_<%=group.getGroupName()%>" role="button" href="enterChat.action?groupName=<%=group.getGroupName()%>" class="list-group-item list-group-item-action"><%=group.getGroupName()%></a >
            <%
                }
            %>
            <%--<a href="#" class="list-group-item list-group-item-action">小组1</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">小组2</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">小组3</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">小组4</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">小组5</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">小组6</a>--%>
        </div>
    </div>

    <!--聊天室主体-->
    <div class="col-md-6" style="margin-top: 2%;margin-left: -1%">
        <div class="title">
            <div class="am-g am-g-fixed">
                <div class="am-u-sm-12">
                    <s:if test="#session.group_name==null">
                    <h1 class="am-text-primary">ChatRoom NoConnect!</h1>
                    </s:if>
                    <s:else>
                        <h1 class="am-text-primary"><%=session.getAttribute("group_name")%></h1>
                    </s:else>
                </div>
            </div>
        </div>
        <!-- title end -->

        <!-- chat content start 聊天界面 -->
        <div class="chat-content">
            <div class="am-g am-g-fixed chat-content-container">
                <div class="am-u-sm-12">
                    <ul id="message-list" class="am-comments-list am-comments-list-flip"></ul>
                </div>
            </div>
        </div>
        <!-- chat content start -->

        <!-- message input start 输入框 -->
        <div class="message-input am-margin-top">
            <div class="am-g am-g-fixed am-margin-top">
                <div class="am-u-sm-10">
                    <div id="message-input-nickname" class="am-input-group am-input-group-primary">
                <span class="am-input-group-label">
                    <i class="am-icon-user">
                    </i>
                </span>
                        <input id="messageToSend" type="text" class="am-form-field" placeholder="Please enter message"/>
                    </div>
                </div>
                <div class="am-u-sm-2">
                    <button id="send" type="button" class="am-btn am-btn-primary" onclick="send()">
                        <i class="am-icon-send"></i> Send
                    </button>
                </div>
            </div>
        </div>
        <!-- message input end -->
    </div>

    <!--在线列表-->
    <div class="col-md-3" style="margin-top: 2%;">
        <ul class="list-group chatul" id="onlineLists">
            <li class="list-group-item list-group-item-success">
                <div style="width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;">
                    <img src="assets/images/self.png" width="40" height="40" />
                </div>
                &emsp;<%=session.getAttribute("user_name")%>
            </li>
            <%--<li class="list-group-item list-group-item-success">--%>
                <%--<div style="width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;">--%>
                    <%--<img src="img/WHUpro2.jpg" width="40" height="40" />--%>
                <%--</div>--%>
                <%--&emsp;在线成员2--%>
            <%--</li>--%>
            <%--<li class="list-group-item list-group-item-success">--%>
                <%--<div style="width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;">--%>
                    <%--<img src="img/WHUpro3.jpg" width="40" height="40" />--%>
                <%--</div>--%>
                <%--&emsp;在线成员3--%>
            <%--</li>--%>
            <%--<li class="list-group-item list-group-item-success">--%>
                <%--<div style="width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;">--%>
                    <%--<img src="img/WHUpro1.jpg" width="40" height="40" />--%>
                <%--</div>--%>
                <%--&emsp;在线成员4--%>
            <%--</li>--%>


            <%--<li class="list-group-item list-group-item-light">--%>
                <%--<div style="width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;">--%>
                    <%--<img class="grayimg" src="img/WHUpro1.jpg" width="40" height="40" />--%>
                <%--</div>--%>
                <%--&emsp;不在线成员1--%>
            <%--</li>--%>
            <%--<li class="list-group-item list-group-item-light">--%>
                <%--<div style="width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;">--%>
                    <%--<img class="grayimg" src="img/WHUpro1.jpg" width="40" height="40" />--%>
                <%--</div>--%>
                <%--&emsp;不在线成员2--%>
            <%--</li>--%>
        </ul>
    </div>
</div>
<!-- message input end -->
<script src="assets/js/jquery.min.js"></script>
<script>
    var ws;//websocket实例
    var lockReconnect = false;//避免重复连接
    var wsUrl = 'ws://localhost:8080/ws/chatRoom/';
    //信息输入框
    var message=document.getElementById("messageToSend");
    message.focus();

    function createWebSocket(url) {
        try {
            ws = new WebSocket(url);
            initEventHandle();
        } catch (e) {
            reconnect(url);
        }
    }

    function initEventHandle() {
        ws.onclose = function (e) {
            console.log("WebSocket连接断开:"+e.code);
            console.log(e);
            reconnect(wsUrl);
        };
        ws.onerror = function (e) {
            console.log("WebSocket连接错误:"+e.code);
            console.log(e);
            reconnect(wsUrl);
        };
        ws.onopen = function () {
            //心跳检测重置
            heartCheck.reset().start();
        };
        ws.onmessage = function (event) {
            //如果获取到消息，心跳检测重置
            //拿到任何消息都说明当前连接是正常的
            heartCheck.reset().start();
            addMessage(event.data);
        }
    }

    var heartCheck = {
        timeout: 60000,//60秒
        timeoutObj: null,
        serverTimeoutObj: null,
        reset: function(){
            clearTimeout(this.timeoutObj);
            clearTimeout(this.serverTimeoutObj);
            return this;
        },
        start: function(){
            var self = this;
            this.timeoutObj = setTimeout(function(){
                //这里发送一个心跳，后端收到后，返回一个心跳消息，
                //onmessage拿到返回的心跳就说明连接正常
                // ws.send("HeartBeat");
                self.serverTimeoutObj = setTimeout(function(){//如果超过一定时间还没重置，说明后端主动断开了
                    ws.close();//如果onclose会执行reconnect，我们执行ws.close()就行了.如果直接执行reconnect 会触发onclose导致重连两次
                }, self.timeout)
            }, this.timeout)
        }
    };

    function reconnect(url) {
        if(lockReconnect) return;
        lockReconnect = true;
        //没连接上会一直重连，设置延迟避免请求过多
        setTimeout(function () {
            createWebSocket(url);
            lockReconnect = false;
        }, 0);
    }

    createWebSocket(wsUrl);

    //

    function send() {
        if(message.value===''){
            //昵称框获取焦点
            message.focus();
            // 添加抖动效果
            $('#message-input-nickname').addClass('am-animation-shake');
            setTimeout("$('#message-input-nickname').removeClass('am-animation-shake')", 1000);
        }else {
            // 发送消息
            var str=JSON.stringify({
                content : message.value
            });
            ws.send(JSON.stringify({
                content : encodeScript(message.value),
                username:<%="\""+session.getAttribute("user_name")+"\""%>
            }));
        }
    }

    function addMessage(msg) {
        msg = JSON.parse(msg);
        if(msg.type==="message") {
            var liCss;
            var pic;
            if (msg.isSelf === "true") {
                liCss = 'am-comment-flip';
                pic = 'self.png';
            } else {
                liCss = 'am-comment';
                pic = 'others.jpg';
            }
            var messageItem = '<li class=" '
                + liCss
                + '">'
                + '<a href="javascript:void(0)" ><img src="assets/images/'
                + pic
                + '" alt="" class="am-comment-avatar" width="48" height="48"/></a>'
                + '<div class="am-comment-main"><header class="am-comment-hd"><div class="am-comment-meta">'
                + '<a href="javascript:void(0)" class="am-comment-author">'
                + msg.username + '</a> <time>' + msg.date
                + '</time></div></header>'
                + '<div class="am-comment-bd">' + msg.content
                + '</div></div></li>';
            $(messageItem).appendTo('#message-list');
            // 把滚动条滚动到底部
            $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
            message.value = "";
        }else if(msg.type==="onlineUsers"){
            var data=msg.data.replace("[","").replace("]","");
            var d=[];
            d=getUsers(data);
            var insertStr="";
            for(var i=0;i<d.length;i++){
                insertStr+="<li class=\"list-group-item list-group-item-success\">" +
                "<div style=\"width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;\">" +
                "<img src=\"assets/images/self.png\" width=\"40\" height=\"40\" /></div>&emsp;"+d[i]+"</li>";
            }
            var lists=$("#onlineLists");
            lists.empty();
            lists.append(insertStr);
        }
    }

    function getUsers(data) {
        var users=data.split(',');
        return users;
    }

    function connectChat(self) {
        var groupName=self.getAttribute("id").replace("group_id_","");
    }

    function encodeScript(data) {
        if(null == data || "" === data) {
            return "";
        }
        return data.replace("<", "&lt;").replace(">", "&gt;");
    }
</script>

</body>
</html>