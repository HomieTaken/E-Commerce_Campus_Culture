<%--
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

    <!-- umeditor css -->
    <link href="umeditor/themes/default/css/umeditor.css" rel="stylesheet">

    <style>
        .title {
            text-align: center;
        }

        .chat-content-container {
            height: 29rem;
            overflow-y: scroll;
            border: 1px solid silver;
        }
    </style>
</head>
<body>
<!-- title start -->

<div class="title">
    <div class="am-g am-g-fixed">
        <div class="am-u-sm-12">
            <h1 class="am-text-primary">Interest_Group Chat</h1>
        </div>
    </div>
</div>
<!-- title end -->

<!-- chat content start -->
<div class="chat-content">
    <div class="am-g am-g-fixed chat-content-container">
        <div class="am-u-sm-12">
            <ul id="message-list" class="am-comments-list am-comments-list-flip"></ul>
        </div>
    </div>
</div>
<!-- chat content start -->

<!-- message input start -->
<div class="message-input am-margin-top">
    <div class="am-g am-g-fixed am-margin-top">
        <div class="am-u-sm-6">
            <div id="message-input-nickname" class="am-input-group am-input-group-primary">
                <span class="am-input-group-label">
                    <i class="am-icon-user">
                    </i>
                </span>
                <input id="messageToSend" type="text" class="am-form-field" placeholder="Please enter message"/>
            </div>
        </div>
        <div class="am-u-sm-6">
            <button id="send" type="button" class="am-btn am-btn-primary" onclick="send()">
                <i class="am-icon-send"></i> Send
            </button>
        </div>
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

        // $('#send').on('click', function() {
        //     if(message.val()===''){
        //         //昵称框获取焦点
        //         message.focus();
        //         // 添加抖动效果
        //         $('#message-input-nickname').addClass('am-animation-shake');
        //         setTimeout("$('#message-input-nickname').removeClass('am-animation-shake')", 1000);
        //     }else {
        //             // 发送消息
        //             socket.send(JSON.stringify({
        //                 content : message.val
        //             }));
        //     }
        //
        //     // if (!um.hasContents()) {	// 判断消息输入框是否为空
        //     //     // 消息输入框获取焦点
        //     //     um.focus();
        //     //     // 添加抖动效果
        //     //     $('.edui-container').addClass('am-animation-shake');
        //     //     setTimeout("$('.edui-container').removeClass('am-animation-shake')", 1000);
        //     // } else if (nickname === '') {	// 判断昵称框是否为空
        //     //     //昵称框获取焦点
        //     //     $('#nickname')[0].focus();
        //     //     // 添加抖动效果
        //     //     $('#message-input-nickname').addClass('am-animation-shake');
        //     //     setTimeout("$('#message-input-nickname').removeClass('am-animation-shake')", 1000);
        //     // } else {
        //     //     // 发送消息
        //     //     socket.send(JSON.stringify({
        //     //         content : um.getContent(),
        //     //         nickname : nickname
        //     //     }));
        //     //     // 清空消息输入框
        //     //     um.setContent('');
        //     //     // 消息输入框获取焦点
        //     //     um.focus();
        //     // }
        // });

    function addMessage(message) {
        message = JSON.parse(message);
        var liCss;
        var pic;
        if(message.isSelf==="true"){
            liCss='am-comment-flip';
            pic='self.png';
        }else {
            liCss='am-comment';
            pic='others.jpg';
        }
        var messageItem = '<li class=" '
            + liCss
            + '">'
            + '<a href="javascript:void(0)" ><img src="assets/images/'
            + pic
            + '" alt="" class="am-comment-avatar" width="48" height="48"/></a>'
            + '<div class="am-comment-main"><header class="am-comment-hd"><div class="am-comment-meta">'
            + '<a href="javascript:void(0)" class="am-comment-author">'
            + message.username +'</a> <time>' + message.date
            + '</time></div></header>'
            + '<div class="am-comment-bd">' + message.content
            + '</div></div></li>';
        $(messageItem).appendTo('#message-list');
        // 把滚动条滚动到底部
        $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
    }

    function encodeScript(data) {
        if(null == data || "" == data) {
            return "";
        }
        return data.replace("<", "&lt;").replace(">", "&gt;");
    }
</script>

</body>
</html>