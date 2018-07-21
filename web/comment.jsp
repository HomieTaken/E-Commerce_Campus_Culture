<%@ page import="Entity.CultureProduct" %><%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/7/14
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String comment = (String)session.getAttribute("comment");
    String name = (String)session.getAttribute("user_name");
    if(name==null){
        name="#";
    }
    CultureProduct product = (CultureProduct)session.getAttribute("comment_product");
%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-商品评论</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/extend.css" rel="stylesheet">

    <style>
        .container{
            width: 1000px;
        }
        .commentbox{
            width: 900px;
            margin: 20px auto;
        }
        .mytextarea {
            width: 100%;
            overflow: auto;
            word-break: break-all;
            height: 100px;
            color: #000;
            font-size: 1em;
            resize: none;
            box-shadow: 2px 2px 2px #F0F0F0 inset;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            border-bottom-left-radius:5px;
            border-bottom-right-radius:5px;
        }

        .mytextarea:focus{
            outline: 0;
            border-color: rgba(82, 168, 236, 0.8);
            -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
            -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
        }

        .comment-list{
            width: 900px;
            margin: 20px auto;
            clear: both;
            padding-top: 20px;
        }
        .comment-list .comment-info{
            position: relative;
            margin-bottom: 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid #ccc;
        }
        .comment-list .comment-info header{
            width: 10%;
            position: absolute;
        }
        .comment-list .comment-info header img{
            width: 100%;
            border-radius: 50%;
            padding: 5px;
        }
        .comment-list .comment-info .comment-right{
            padding:5px 0px 5px 11%;
        }
        .comment-list .comment-info .comment-right h3{
            margin: 5px 0px;
        }
        .comment-list .comment-info .comment-right .comment-content-header{
            height: 25px;
        }
        .comment-list .comment-info .comment-right .comment-content-header span,.comment-list .comment-info .comment-right .comment-content-footer span{
            padding-right: 2em;
            color: #aaa;
        }
        .comment-list .comment-info .comment-right .comment-content-header span,.comment-list .comment-info .comment-right .comment-content-footer span.reply-btn,.send,.cancel,.reply-list-btn{
            cursor: pointer;
        }
        .comment-list .comment-info .comment-right .reply-list {
            border-left: 3px solid #ccc;
            padding-left: 7px;
        }
        .comment-list .comment-info .comment-right .reply-list .reply {
            border-bottom: 1px dashed #ccc;
        }
        .comment-list .comment-info .comment-right .reply-list .reply div span{
            padding-left: 10px;
        }
        .comment-list .comment-info .comment-right .reply-list .reply p span{
            padding-right: 2em;
            color: #aaa;
        }
    </style>

</head>
<body>

<div class="container-fluid">

    <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
        <a class="navbar-brand col-sm-10" href="index.jsp" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng-评论 </a>

        <li class="nav-item ">
            <div class="dropdown" style="margin-top:18px;margin-left:40px">
                <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
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

    <div class="row" style="margin-top: 8%;margin-left: 15%">
        <div class="col-md-2">
            <img src="<%=basePath%>/getPic.action?productID=<%=product.getProductID()%>" class="img-thumbnail img-fluid" style="height: 150px;width: 150px;object-fit: cover;">
        </div>
        <div class="col-md-8">
            <div style="padding: 5px">品名：&emsp;&emsp;&emsp;<strong><%=product.getName()%></strong></div>

            <div class="row" style="padding: 5px">
                <div class="col-sm-2">
                    描述：
                </div>
                <div class="col-sm-10" style="margin-left: -50px;">
                    <%=product.getDescription()%>
                </div>
            </div>

            <div style="padding: 5px">价格：&emsp;&emsp;&emsp;<span style="color: red;">￥<%=product.getPrice()%></span></div>
        </div>
    </div>

    <div class="card" style="width: 850px;margin-top: 2%;margin-left: 15%" >
        <div class="card-header">
            同学们都需要你的意见呢！发表你的评价吧
            <span class="glyphicon glyphicon-comment" style="margin-left: 57%"></span>
        </div>
        <div class="card-body">
            <div class="input-group" style="margin-top: 20px;margin-left: 30px;">
                <span class="col-md-3" style="margin-left:10px">评价商品:</span>
                <div class="commentbox" style="position:relative; left: -10%;top:-20px;">
                    <textarea cols="80" rows="50" placeholder="来说几句吧......" class="mytextarea" id="content"></textarea>
                    <br><br>
                    <div class="btn btn-info pull-right" id="comment">发表</div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="comment-list">
</div>

<input hidden id="user_name" value="<%=name%>">

<script type="text/javascript" src="js/jquery.min.js" ></script>
<script type="text/javascript" src="js/jquery.comment.js" ></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript">
    //初始化数据
    var arr = <%=comment%>
//        [
//        //{id:1,img:"img/qm.png",replyName:"帅大叔",beReplyName:"匿名",content:"同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。",time:"2017-10-17 11:42:53",address:"深圳",osname:"",browse:"谷歌",replyBody:[]},
//        //{id:2,img:"img/qm.png",replyName:"匿名",beReplyName:"",content:"到菜市场买菜，看到一个孩子在看摊，我问：“一只鸡多少钱？” 那孩子回答：“23。” 我又问：“两只鸡多少钱？” 孩子愣了一下，一时间没算过来，急中生智大吼一声：“一次只能买一只！”",time:"2017-10-17 11:42:53",address:"深圳",osname:"",browse:"谷歌",replyBody:[{id:3,img:"",replyName:"帅大叔",beReplyName:"匿名",content:"来啊，我们一起吃鸡",time:"2017-10-17 11:42:53",address:"",osname:"",browse:"谷歌"}]},
//        //{id:3,img:"img/qm.png",replyName:"帅大叔",beReplyName:"匿名",content:"同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。",time:"2017-10-17 11:42:53",address:"深圳",osname:"win10",browse:"谷歌",replyBody:[]}
//    ];
    $(function(){
        $(".comment-list").addCommentList({data:arr,add:""});
        $("#comment").click(function(){
            <%--<%--%>
            <%--if(name==null){--%>
            <%--%>--%>
            <%--var name=<%=name%>;--%>
            <%--<%}%>--%>
            if("#"==="<%=name%>"){
                alert("请登录后再进行此操作！");
            }
            else {
                var obj = {};
                obj.img = "img/qm.png";
                obj.replyName = "<%=name%>";
                obj.content = $("#content").val();
                obj.osname = "个人用户";
                obj.replyBody = "";
                obj.time = getNowDateFormat();
                if (obj.content === "")
                    return;
                var args = {
                    replyName: obj.replyName,
                    beReplyName: obj.beReplyName,
                    content: obj.content,
                    time: obj.time,
                    type: "COMMENT"
                };
                $.post("addComment", args, function (data) {
                    var d = JSON.parse(data);
                    if (d.success === "false") {
                        alert("回复内容插库失败！");
                    }
                });
                $(".comment-list").addCommentList({data: [], add: obj});
            }

        });
    });


    function getNowDateFormat(){
        var nowDate = new Date();
        var year = nowDate.getFullYear();
        var month = filterNum(nowDate.getMonth()+1);
        var day = filterNum(nowDate.getDate());
        var hours = filterNum(nowDate.getHours());
        var min = filterNum(nowDate.getMinutes());
        var seconds = filterNum(nowDate.getSeconds());
        return year+"-"+month+"-"+day+" "+hours+":"+min+":"+seconds;
    }

    function filterNum(num){
        if(num < 10){
            return "0"+num;
        }else{
            return num;
        }
    }
</script>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script src="js/popper.min.js"></script>
<script type="text/javascript" src="js/jquery.comment.js" ></script>
</body>
</html>