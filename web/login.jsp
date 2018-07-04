<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/4/004
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div align="center">
    <label title="login">Login</label>
</div>
<div align="center">
<form action="login.action" method="post">
    <input name="user" title="user:"/>
    <input name="password" type="password" title="pwd:">
    <input type="submit" value="login">
    <input type="reset" value="reset">
</form>
</div>
</body>
</html>
