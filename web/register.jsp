<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DataBase.DBOperation" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/4/004
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    ArrayList<String> schools=new ArrayList<String>();
    ResultSet rs=DBOperation.getRS("select school_name from school");
    while (rs.next()){
        schools.add(rs.getString(1));
    }
%>
<head>
    <title>青芒-注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="alternate icon" href="img/qm.ico">
    <!-- 引入 Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
</head>
<body background="img/registerbg.jpg">
<div class="container-fluid">
    <!--青芒logo-->
    <br />
    <br />
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-1">
            <img alt="Bootstrap Image Preview" height="50px" width="100px" src="img/logo%20.png">
        </div>
        <div class="col-md-7" style="margin-top:1%">
            <img alt="Bootstrap Image Preview" height="40px" width="320px" src="img/pintai1.png">
        </div>
    </div>

    <br />
    <br />

    <div class="col-sm-6 " style="margin-left:35%">
        <s:fielderror name="userNameMsg"/>
    </div>

    <form action="register.action" method="post" role="form" class="form-horizontal" onsubmit="return checkRegister()">

        <!--
        <div class="input-group mb-3">
        <div class="input-group-prepend">
        <div class="input-group-text">
          <input type="checkbox">
        </div>
        </div>
        <input type="text" class="form-control" placeholder="RUNOOB">
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">选择注册用户类型</label>
            <label class="radio-inline">
                <input name = "userType" type="radio" id="optionsRadios1" value="singerUser" checked> 个人用户
            </label>
            <label class="radio-inline">
                <input name = "userType" type="radio" id="optionsRadios2" value="teamUser">团队用户
            </label>
        </div>
        -->
        <div class="row">
            <div class="input-group col-sm-3 " style="margin-left:25.2%">
			<span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
			<input type="radio" name = "userType"  id="optionsRadios1" value="singerUser" checked>
			</span>
                <input type="text" class="form-control" placeholder="注册为个人用户" readonly="readonly">
            </div>
            <div class="input-group col-sm-3 ">
                <input type="text" class="form-control" placeholder="注册为团队用户" readonly="readonly">
                <span class="input-group-addon" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;">
			<input type="radio" name = "userType"  id="optionsRadios2" value="teamUser">
			</span>
            </div>
        </div>
        <br />


        <div class="row input-group col-sm-6" style="margin-left:25%">
			<span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
			<span class="glyphicon glyphicon-home">
			</span>
			</span>
            <select name ="school" class="form-control" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;">
                <%
                    for (String schoolName:schools){
                %>
                <option ><%=schoolName%></option>
                <%
                    }
                %>
            </select>
        </div>
        <br />
        <div class="row">
            <div id="nameCheck" class="input-group col-sm-6" style="margin-left:25%">
                <span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
                <span class="glyphicon glyphicon-user">
                </span>
                </span>
                <input name="name" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" type="text" class="form-control" id="username" aria-describedby="inputSuccess2Status" placeholder="请输入账户名">

            </div>
            <div class="col-sm-2">
                <em id="name"></em>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="input-group col-sm-6" style="margin-left:25%">
                <span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
                <span class="glyphicon glyphicon-lock">
                </span>
                </span>
                <input name = "password" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" id="userpwd1" placeholder="请输入密码" type="password" class="form-control">

            </div>
            <div class="col-sm-2">
                <em id="pwd1"></em>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="input-group col-sm-6" style="margin-left:25%">
                <span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
                <span class="glyphicon glyphicon-lock">
                </span>
                </span>
                <input name = "repeatPassword" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" id="userpwd2" placeholder="请确认密码" type="password" class="form-control">

            </div>
            <div class="col-sm-2">
                <em id="pwd2"></em>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="input-group col-sm-6" style="margin-left:25%">
                <span class="input-group-addon" style="border-top-left-radius: 20px; border-bottom-left-radius:20px;">
                <span class="glyphicon glyphicon-envelope">
                </span>
                </span>
                <input name = "email" style="border-top-right-radius: 20px; border-bottom-right-radius:20px;" id="useremail" placeholder="请输入邮箱" type="email" class="form-control">

            </div>
            <div class="col-sm-2">
                <em id="email"></em>
            </div>
        </div>
        <br />
        <div class="form-group" style="margin-left:34%">
            <div class="col-sm-offset-2 col-md-6">
                <button id="submitBtn" type="submit" class="btn btn-info btn-block">申请注册&emsp;
                    <span class="glyphicon glyphicon-share-alt" >
			</span></button>
            </div>
        </div>

        <!--
        <div class="form-group has-success has-feedback">
            <label class="control-label" for="inputSuccess1">成功状态</label>
            <input type="text" class="form-control" id="inputSuccess1" placeholder="成功状态">
            <span class="glyphicon glyphicon-ok form-control-feedback"></span>
        </div>
        <div class="form-group has-warning has-feedback">
            <label class="control-label" for="inputWarning1">警告状态</label>
            <input type="text" class="form-control" id="inputWarning" placeholder="警告状态">
            <span class="glyphicon glyphicon-warning-sign form-control-feedback"></span>
        </div>
        <div class="form-group has-error has-feedback">
            <label class="control-label" for="inputError1">错误状态</label>
            <input type="text" class="form-control" id="inputError1" placeholder="错误状态">
            <span class="glyphicon glyphicon-remove form-control-feedback"></span>
        </div>
        <div class="form-group has-error has-feedback">
            <label class="control-label" for="inputEmail1">email地址</label>
            <input type="email" class="form-control" id="inputEmail1" placeholder="错误状态">
        <span class="glyphicon glyphicon-remove form-control-feedback"></span>
        </div>
        -->


    </form>



</div>

<!-- 包括所有已编译的插件 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-3.3.1.js"></script>
<script type="text/javascript">
    var validate;
    $(function() {
        $("#username").blur(function() {
            var val = $(this).val();
            val = $.trim(val);

            var $this = $(this);
            var name=$("#name");

            if (val !== "") {
                //把当前节点后面的所有 font 兄弟节点删除
                name.nextAll("font").remove();
                var url = "user_checkName";
                var args = {
                    "userName" : val
                };
                $.post(url, args, function(data) {
                    //表示可用
                    validate = data;
                    if (data === "1") {
                        name.after("<font color='green'>*用户名可用!</font>");
                    }
                    //不可用
                    else if (data === "0") {
                        name.after("<font color='red'>*用户名已被注册!</font>");
                    }
                    //服务器错误
                    else {
                        alert("服务器错误!");
                    }
                });
            } else {

                $(this).val("");
                $this.focus();
            }
        });
    });

    function checkRegister(){

        var username= document.getElementById("username");
        if(username.value.trim()===""){//没有输入用户名是显示提示
            //获取所有子节点
            var findNodes = document.getElementById("name").children;
            if(findNodes.length===0){//只添加一次span
                var appdom= document.createElement("span");
                appdom.innerHTML="*用户名不能为空";
                appdom.style.color="red";
                document.getElementById("name").appendChild(appdom);
            }
            return false;
        }else{//输入了内容后清除节点内容
            var findNodes =document.getElementById("name").children;
            if(findNodes.length>0){
                document.getElementById("name").removeChild(findNodes[0]);
            }
        }
        ////
        var userpwd1 = document.getElementById("userpwd1");
        if(userpwd1.value.trim()===""){
            var findNodes2 = document.getElementById("pwd1").children;
            if(findNodes2.length===0){
                var appdom2 = document.createElement("span");
                appdom2.innerHTML="*密码不能为空";
                appdom2.style.color="red";
                document.getElementById("pwd1").appendChild(appdom2);
            }
            return false;
        }else{
            var findNodes2 = document.getElementById("pwd1").children;
            if(findNodes2.length>0){
                document.getElementById("pwd1").removeChild(findNodes2[0]);
            }
        }
        ////
        var userpwd2 = document.getElementById("userpwd2");
        var appdom3 = document.createElement("span");
        if(userpwd2.value.trim()===""){
            var findNodes2 = document.getElementById("pwd2").children;
            if(findNodes2.length>0){
                document.getElementById("pwd2").removeChild(findNodes2[0]);
            }
            appdom3.innerHTML="*请确认密码";
            appdom3.style.color="red";
            document.getElementById("pwd2").appendChild(appdom3);
            return false;
        }else if(userpwd2.value.trim() !== userpwd1.value.trim() && userpwd2.value.trim() !== "" && userpwd1.value.trim() !== ""){
            var findNodes2 = document.getElementById("pwd2").children;
            if(findNodes2.length>0){
                document.getElementById("pwd2").removeChild(findNodes2[0]);
            }
            appdom3.innerHTML="*密码不一致";
            appdom3.style.color="red";
            document.getElementById("pwd2").appendChild(appdom3);
            return false;
        }
        else{
            var findNodes2 = document.getElementById("pwd2").children;
            if(findNodes2.length>0){
                document.getElementById("pwd2").removeChild(findNodes2[0]);
            }
        }


        ////
        var useremail = document.getElementById("useremail");
        if(useremail.value.trim()===""){
            var findNodes2 = document.getElementById("email").children;
            if(findNodes2.length===0){
                var appdom2 = document.createElement("span");
                appdom2.innerHTML="*邮箱不能为空";
                appdom2.style.color="red";
                document.getElementById("email").appendChild(appdom2);
            }
            return false;
        }else{
            var findNodes2 = document.getElementById("email").children;
            if(findNodes2.length>0){
                document.getElementById("email").removeChild(findNodes2[0]);
            }
        }
        if(validate!=="1")
            return false;
        document.forms[0].submit();
    }
</script>
</body>
</html>
<%--<html>--%>
<%--<head>--%>
    <%--<title>Bootstrap 模板</title>--%>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
    <%--<!-- 引入 Bootstrap -->--%>
    <%--<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">--%>

<%--</head>--%>

<%--<body>--%>
<%--<div class="container-fluid">--%>
    <%--<div class="row-fluid">--%>
        <%--<div class="span12">--%>
            <%--<div class="page-header">--%>
                <%--<h2>--%>
                    <%--<em>易学购 <small>一个年轻的校园文化电子商务平台</small></em>--%>
                <%--</h2>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<form role="form" class="form-horizontal" action="register.action" method="post">--%>
        <%--<div class="form-group">--%>
            <%--<label class="col-sm-2 control-label">选择注册用户类型</label>--%>
            <%--<label class="radio-inline">--%>
                <%--<input type="radio" name="userType" id="optionsRadios1" value="singerUser" checked> 个人用户--%>
            <%--</label>--%>
            <%--<label class="radio-inline">--%>
                <%--<input type="radio" name="userType" id="optionsRadios2" value="teamUser">团队用户--%>
            <%--</label>--%>
        <%--</div>--%>

        <%--<div class="form-group">--%>
            <%--<label class="col-sm-2 control-label" for="collegeName">选择所属学校</label>--%>
            <%--<div class="col-sm-4">--%>
                <%--<select class="form-control" id="collegeName" name="school">--%>
                    <%--<option>武汉大学</option>--%>
                    <%--<option>华中科技大学</option>--%>
                    <%--<option>湖北大学</option>--%>
                    <%--<option>中国科技大学</option>--%>
                    <%--<option>南京大学</option>--%>
                <%--</select>--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="form-group">--%>
            <%--<label for="firstname" class="col-sm-2 control-label">账户名</label>--%>
            <%--<div class="col-sm-4">--%>
                <%--<input name="name" type="text" class="form-control" id="firstname" placeholder="name" onblur="">--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="form-group">--%>
            <%--<label class="col-sm-2 control-label" for="password" >输入密码</label>--%>
            <%--<div class="col-sm-4">--%>
                <%--<input name="password" id="password" placeholder="password" type="password" class="form-control" onblur="">--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="form-group">--%>
            <%--<label class="col-sm-2 control-label" for="repeatPassword" >确认密码</label>--%>
            <%--<div class="col-sm-4">--%>
                <%--<input id="repeatPassword" placeholder="repeatPassword" type="password" class="form-control" onblur="">--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="form-group">--%>
            <%--<label class="col-sm-2 control-label" for="mail" >电子邮箱</label>--%>
            <%--<div class="col-sm-4">--%>
                <%--<input name="email" id="mail" placeholder="email" type="email" class="form-control" onblur="">--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<br><br>--%>
        <%--<div class="form-group">--%>
            <%--<div class="col-sm-offset-2 col-sm-10">--%>
                <%--<button type="submit" class="btn btn-default" onsubmit="">申请注册</button>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<!----%>
        <%--<div class="form-group has-success has-feedback">--%>
            <%--<label class="control-label" for="inputSuccess1">成功状态</label>--%>
            <%--<input type="text" class="form-control" id="inputSuccess1" placeholder="成功状态">--%>
            <%--<span class="glyphicon glyphicon-ok form-control-feedback"></span>--%>
        <%--</div>--%>
        <%--<div class="form-group has-warning has-feedback">--%>
            <%--<label class="control-label" for="inputWarning1">警告状态</label>--%>
            <%--<input type="text" class="form-control" id="inputWarning" placeholder="警告状态">--%>
            <%--<span class="glyphicon glyphicon-warning-sign form-control-feedback"></span>--%>
        <%--</div>--%>
        <%--<div class="form-group has-error has-feedback">--%>
            <%--<label class="control-label" for="inputError1">错误状态</label>--%>
            <%--<input type="text" class="form-control" id="inputError1" placeholder="错误状态">--%>
            <%--<span class="glyphicon glyphicon-remove form-control-feedback"></span>--%>
        <%--</div>--%>
        <%--<div class="form-group has-error has-feedback">--%>
            <%--<label class="control-label" for="inputEmail1">email地址</label>--%>
            <%--<input type="email" class="form-control" id="inputEmail1" placeholder="错误状态">--%>
        <%--<span class="glyphicon glyphicon-remove form-control-feedback"></span>--%>
        <%--</div>--%>
        <%---->--%>


    <%--</form>--%>



<%--</div>--%>

<%--<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->--%>
<%--<script src="js/jquery-3.3.1.js"></script>--%>
<%--<!-- 包括所有已编译的插件 -->--%>
<%--<script src="js/bootstrap.min.js"></script>--%>
<%--<script type="text/javascript">--%>
    <%--function x() {--%>
        <%----%>
    <%--}--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>