<%--
  Created by IntelliJ IDEA.
  User: 郑晓欣
  Date: 2018/7/11
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DataBase.DBOperation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.CultureProduct" %>
<%@ page import="Entity.Activity" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>testSend</title>
    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
</head>
<!----------------------------合代码新增部分------------------------------>
<%
    //    session.getAttribute("user_id");
    String sqlProduct="select * from product where product_team_id=4";
    String sqlActivity="select * from activity where activity_team_id=4";
    ArrayList<CultureProduct> products=new ArrayList<CultureProduct>();
    ArrayList<Activity> activities=new ArrayList<Activity>();
    try {
        ResultSet rsProduct=DBOperation.getRS(sqlProduct);
        while (rsProduct.next()){
            CultureProduct product=new CultureProduct();
            product.setProductID(rsProduct.getInt(1));
            product.setDescription(rsProduct.getString(2));
            product.setPicture(rsProduct.getBlob(3));
            product.setName(rsProduct.getString(4));
            product.setPrice(rsProduct.getDouble(5));
            product.setTeamID(rsProduct.getInt(6));
            product.setAmount(rsProduct.getInt(7));
            products.add(product);
        }

        ResultSet rsActivity=DBOperation.getRS(sqlActivity);
        while (rsActivity.next()){
            Activity activity=new Activity();
            activity.setActivityID(rsActivity.getInt(1));
            activity.setActivityName(rsActivity.getString(2));
            activity.setTeamID(rsActivity.getInt(3));
            activity.setReleaseDate(rsActivity.getDate(4));
            activity.setEndDate(rsActivity.getDate(5));
            activity.setDescription(rsActivity.getString(6));
            activity.setAddress(rsActivity.getString(7));
            activities.add(activity);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!---------------------------------------------------------->
<body>
发布活动动态：
<form enctype="multipart/form-data" method="post" action="sendMessage">
<label for="messageContent">
    信息：
</label>
<input name="message" type="text" id="messageContent">
<label for="messagePicture">
    上传图片:
</label>
<input name="pictureFile" type="file" id="messagePicture">
    <button type="submit">
        发布
    </button>
</form>
</body>
</html>
