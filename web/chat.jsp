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
    <title>ShiYanLou Chat</title>

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
                <input id="message" type="text" class="am-form-field" placeholder="Please enter message"/>
            </div>
        </div>
        <div class="am-u-sm-6">
            <button id="send" type="button" class="am-btn am-btn-primary">
                <i class="am-icon-send"></i> Send
            </button>
        </div>
    </div>
</div>
<!-- message input end -->
<script src="assets/js/jquery.min.js"></script>
<script src="js/jquery.min.js"></script>
<script>
    $(function () {
        //信息输入框
        var message=$('message');
        message[0].focus();

        //新建WebSocket对象
        var socket=new WebSocket('ws://localhost:8080/websocket');

        //
        socket.onmessage=function (ev) {

        };

        function addMessage(message) {
            message=JSON.parse(message);
            var messageItem='<li class=" '
                + (message.isSelf ? 'am-comment-flip' : 'am-comment')
                + '">'
                + '<a href="javascript:void(0)" ><img src="assets/images/'
                + (message.isSelf ? 'self.png' : 'others.jpg')
                + '" alt="" class="am-comment-avatar" width="48" height="48"/></a>'
                + '<div class="am-comment-main"><header class="am-comment-hd"><div class="am-comment-meta">'
                + '<a href="javascript:void(0)" class="am-comment-author">'
                + message.nickname + '</a> <time>' + message.date
                + '</time></div></header>'
                + '<div class="am-comment-bd">' + message.content
                + '</div></div></li>';
        }
    })
</script>

</body>
</html>