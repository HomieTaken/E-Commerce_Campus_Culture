<%@ page import="Entity.Message" %>
<%@ page import="Entity.Activity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: 郑晓欣
  Date: 2018/7/12
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>enterMessageBox</title>
    <link rel="alternate icon" href="img/qm.ico">
</head>
<body>
<%String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
<%Message[]messages=new Message[0];
    if(request.getAttribute("messages")!=null){
    messages=(Message[]) request.getAttribute("messages");
}%>
<%for(int i=0;i<messages.length;i++){%>
    发件者：<%=messages[i].getSender_name()%><br>
<%if(messages[i].getType().equals("activity")){%>
信息来源：<%=messages[i].getActivity_name()%>活动动态<br>
<%}%>
<%SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String str = df.format(messages[i].getDate());%>
发送时间：<%=str%><br>
信息内容：<%=messages[i].getMessage_text()%><br>
附件图片：<%if(messages[i].getHavePic()==true){%><img height="200px"
          src="<%=basePath%>/getPic.action?messageID=<%=messages[i].getMessage_id()%>" /><br><%}%>
<br>
<br>
<%}%>
</body>
</html>
