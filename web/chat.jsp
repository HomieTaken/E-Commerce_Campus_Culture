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

    <link rel="alternate icon" href="img/qm.ico">
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
            background-color: #d0d6d6;
        }

        .chatul li{
            height:50px;
            font-size: 14px;
        }

        /*.grayimg {*/
            /*-webkit-filter: grayscale(1); !* Webkit *!*/
            /*filter: gray; !* IE6-9 *!*/
            /*filter: grayscale(1); !* W3C *!*/
        /*}*/

    </style>
</head>
<%
    ArrayList<InterestGroup> groups=new ArrayList<InterestGroup>();
    ArrayList<InterestGroup> ownerGroups=new ArrayList<InterestGroup>();
    int user_id=-1;
    if(session.getAttribute("user_id")!=null) {
        user_id = (int) session.getAttribute("user_id");
        try {
//        String sql="select * from interest_group where group_id in (select group_id from group_members where user_id=\'"+session.getAttribute("user_id")+"\')";
            String sql = "select * from interest_group";
            ResultSet rs = DBOperation.getRS(sql);

            while (rs.next()) {
                InterestGroup group = new InterestGroup();
                group.setOwnerID(rs.getInt("group_owner_id"));
                group.setGroupID(rs.getInt("group_id"));
                group.setGroupName(rs.getString("group_name"));
                group.setGroupInfo(rs.getString("group_info"));
                if (user_id == rs.getInt("group_owner_id"))
                    ownerGroups.add(group);
                else
                    groups.add(group);
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<%
    if(user_id==-1){
%>
<script>
    window.location.href="login.jsp";
</script>
<%
    }
%>
<body>
<!-- title start -->
<ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
    <a class="navbar-brand col-sm-7" href="index.jsp" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng-兴趣小组 </a>

    <li class="nav-item col-sm-3">
        <div class="row" style="margin-top:18px;">
            <input id="searchValue" class="form-control mr-sm-2" type="text" style="width: 200px;height: 36px;font-size: 16px;" placeholder="搜小组">
            <button class="btn btn-default my-2 my-sm-0" style="font-size: 16px;height: 34px;" onclick="searchGroup()">
                <span class="glyphicon glyphicon-search"></span>
            </button>
        </div>
    </li>

</ul>

<div class="row" style="margin-top: 5%;">

    <div class="modal fade" id="modal-agree-apply" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel1">
                        创建兴趣小组
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" method="post">
                    </form>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary" data-dismiss="modal" >
                        确认
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        取消
                    </button>
                </div>
            </div>

        </div>

    </div>

    <!--兴趣小组列表-->
    <div id="groupList" class="col-md-2">
        <div class="list-group">
            <%--<a href="javascript:return false;" class="list-group-item list-group-item-action active">兴趣小组</a>--%>
            <%--<div class="row">--%>
                <%--<a href="javascript:void(0)" class="list-group-item list-group-item-info" style="background-color: #3C6C6C;color: white">我创建的--%>
                    <%--&lt;%&ndash;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ndash;%&gt;--%>
                <%--</a>--%>
                    <%--&lt;%&ndash;<a href="javascript:void(0)" data-toggle="modal" style="background-color: #3C6C6C;color: white;padding-right: 4px;padding-top: 17px">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<span class="glyphicon glyphicon-plus"></span></a>&ndash;%&gt;--%>


            <%--</div>--%>
            <a href="javascript:void(0)" class="list-group-item list-group-item-info" style="background-color: #3C6C6C;color: white">群组列表
                <%--&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;--%>
            </a>
            <div id="ownerGroups">
                <%
                    for (InterestGroup group : ownerGroups) {
                %>
                <a id="group_id_<%=group.getGroupName()%>" href="enterChat.action?groupName=<%=group.getGroupName()%>" class="list-group-item list-group-item-action">
                    <div style='width:100px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='<%=group.getGroupName()%>'>
                        <%=group.getGroupName()%>
                    </div>
                </a >
                <%
                    }
                %>
                <%
                    for (InterestGroup group : groups) {
                %>
                <a id="group_id_<%=group.getGroupName()%>" href="enterChat.action?groupName=<%=group.getGroupName()%>" class="list-group-item list-group-item-action">
                    <div style='width:100px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='<%=group.getGroupName()%>'>
                        <%=group.getGroupName()%>
                    </div>
                </a >
                <%
                    }
                %>
            </div>
            <%--<a href="javascript:void(0)" class="list-group-item list-group-item-info" style="background-color: #3C6C6C;color: white">我加入的</a>--%>
            <%--<div id="otherGroups">--%>
            <%--<%--%>
                <%--for (InterestGroup group : groups) {--%>
            <%--%>--%>
            <%--<a id="group_id_<%=group.getGroupName()%>" href="enterChat.action?groupName=<%=group.getGroupName()%>" class="list-group-item list-group-item-action">--%>
                <%--<div style='width:100px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='<%=group.getGroupName()%>'>--%>
                    <%--<%=group.getGroupName()%>--%>
                <%--</div>--%>
            <%--</a >--%>
            <%--<%--%>
                <%--}--%>
            <%--%>--%>
            <%--</div>--%>
            <div id="groupsEmpty" href="javascript:void(0)" class="list-group-item list-group-item-action" style="height: 500px"></div>
        </div>
    </div>

    <!--聊天室主体-->
    <div class="col-md-8" style="margin-top: 1%;-webkit-box-shadow: #666 0 0 10px">
        <div class="title" style="margin-top: 2%;">
            <div class="am-g am-g-fixed">
                <div class="am-u-sm-12">
                    <s:if test="#session.group_name==null">
                        <div class="am-u-sm-12">
                            <h1 class="am-text-primary">No Connect!</h1>
                        </div>
                    </s:if>
                    <s:else>
                        <div class="am-u-sm-12">
                            <h1 class="am-text-primary"><%=session.getAttribute("group_name")%></h1>
                        </div>
                    </s:else>
                </div>
            </div>
        </div>
        <!-- title end -->

<!-- chat content start 聊天界面 -->
<div class="chat-content" style="margin-top: 1%;">
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
    <div  id="memberList" class="col-md-2">
        <ul class="list-group chatul">
            <li class="list-group-item" style="background-color: #4db14d;color: #FFFFFF">
                在线列表<span class="glyphicon glyphicon-globe" style="margin-left: 55%"></span>
            </li>
            <div id="onlineLists">
                <li class="list-group-item list-group-item-success">
                    <div style="width: 40px; height: 40px; float:left; border-radius: 50%; border: 3px solid #eee; overflow: hidden;">
                        <img src="img/touxiang.jpeg" width="40" height="40" />
                    </div>
                    &emsp;<%=session.getAttribute("user_name")%>
                </li>
            </div>
            <%--<div id="membersEmpty" href="javascript:void(0)" class="list-group-item list-group-item-action" style="height: 400px">--%>
            <%--</div>--%>
        </ul>
    </div>
</div>
<!-- message input end -->
<script src="assets/js/jquery.min.js"></script>

<script type="text/javascript">
    function searchGroup() {
        var value=$("#searchValue").val();
        if(value==="")
            return;
        var url="searchGroup";
        var args={
            "searchStr":value,
            "ownerID":<%=session.getAttribute("user_id")%>
        };
        $.post(url,args,function (data) {
            var groups=JSON.parse(data);
            if(groups.success==="true"){
                var ownerGroups=groups.ownerGroups;
                ownerGroups=init(ownerGroups);
                var otherGroups=groups.otherGroups;
                otherGroups=init(otherGroups);

                var insertStr="";

                for(var i=0;i<ownerGroups.length;i++) {
                    if(ownerGroups[i]==="")
                        continue;
                    insertStr += "<a href=\"enterChat.action?groupName=" + ownerGroups[i] + "\" class=\"list-group-item list-group-item-action\">" +
                        "<div style='width:100px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='" + ownerGroups[i] + "'>" +
                        ownerGroups[i] + "</div></a >";
                }
                var ownerPart=$("#ownerGroups");


                for(i=0;i<otherGroups.length;i++) {
                    if(otherGroups[i]==="")
                        continue;
                    insertStr += "<a href=\"enterChat.action?groupName=" + otherGroups[i] + "\" class=\"list-group-item list-group-item-action\">" +
                        "<div style='width:100px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;' title='" + otherGroups[i] + "'>" +
                        otherGroups[i] + "</div></a >";
                }
                ownerPart.empty();
                ownerPart.append(insertStr);
                // var otherPart=$("#otherGroups");
                // otherPart.empty();
                // otherPart.append(insertStr);
            } else{
                setTimeout(alert("搜索失败，请尝试输入关键短语重新搜索！"),1000);
            }
        });

    }

    function init(data) {
        data=data.replace("[","").replace("]","");
        data=data.split(',');
        return data;
    }

</script>

<%--消息接收、发送--%>
<script>
    $(function () {
         var ge = $('#groupList').find('a');
        // var me = $('#memberList').find('li');
         var geH = 580 - ge.length * 50;
        // var meH = 500 - me.length * 50;
         if (geH > 0)
             $('#groupsEmpty').css("height", geH+'px');
        // if(meH>0)
        //     $('#membersEmpty').css("height", meH+'px');
    });
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
                pic = 'touxiang.jpeg';
            } else {
                liCss = 'am-comment';
                pic = 'touxiang.jpeg';
            }
            var messageItem = '<li class=" '
                + liCss
                + '">'
                + '<a href="javascript:void(0)" ><img src="img/'
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
                "<img src=\"img/touxiang.jpeg\" width=\"40\" height=\"40\" /></div>&emsp;"+d[i]+"</li>";
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