<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DataBase.DBOperation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="Operations.MessageOperate" %>
<%@ page import="Entity.*" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/12/012
  Time: 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-学校主页</title>

    <link rel="alternate icon" href="img/qm.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/extend.css" rel="stylesheet">

    <style>
        .mytextarea {
            overflow: auto;
            word-break: break-all;
            height: 80px;
            width: 400px;
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
    </style>

</head>
<%
    ArrayList<User> teams=new ArrayList<User>();
    ArrayList<TeamApplication> teamApplications=new ArrayList<TeamApplication>();
    String userName= (String)session.getAttribute("user_name");
    String schoolName="";
    try {
        ResultSet rs=DBOperation.getRS("select user_school_name from user where user_name=\'"+userName+"\'");
        if(rs.next()){
            schoolName=rs.getString(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if(!schoolName.equals("")){
        try {
            ResultSet rs=DBOperation.getRS("select * from user where user_type='TEAM' and user_school_name=\'"+schoolName+"\'");
            while (rs.next()){
                User team=new User();
                team.setId(rs.getInt("user_id"));
                team.setUserEmail(rs.getString("user_email"));
                team.setUserName(rs.getString("user_name"));
                team.setUserType(UserType.TEAM);
                teams.add(team);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            ResultSet rs=DBOperation.getRS("select * from team_apply where team_school_name=\'"+schoolName+"\' and apply_state='nocheck'");
            while (rs.next()){
                TeamApplication teamApplication=new TeamApplication();
                teamApplication.setTeamName(rs.getString(1));
                teamApplication.setTeamEmail(rs.getString(2));
                teamApplication.setTeamPassword(rs.getString(3));
                teamApplication.setTeamSchool(rs.getString(4));
                teamApplication.setTeamApplyTime(rs.getString(5));
                teamApplications.add(teamApplication);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<body>
<ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
    <a class="navbar-brand col-sm-9" href="javascript:void(0)" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng </a>

    <a class="navbar-brand col-sm-1" href="javascript:void(0)" style="color:#FFFFFF;margin-top:12px;font-size:25px;margin-left: 10px;"><%=schoolName%></a>
    <li class="nav-item col-sm-2">
        <s:if test="#session.user_name==null">
            <div style="margin-top:25px;margin-left:80px;">
                <a href="login.jsp" style="color: white;margin-right: 5px">登录</a>
                <span style="color: white">|</span>
                <a href="register.jsp" style="color: white;margin-left: 5px">注册</a>
            </div>
        </s:if>
        <s:else>
            <div class="dropdown" style="margin-top:18px;margin-left:20px">
                <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-user"></span>&emsp;已登录
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="logout.action">退出登录</a>
                </div>
            </div>
        </s:else>
    </li>
</ul>

<!--导航栏-->
<ul class="vertical-ul">
    <li class="vertical-li"><a class="homepg" href="javascript:return false;">学校主页</a></li>
    <li class="vertical-li">
        <a id="a0" href="javascript:void(0)" onclick="showPart(0)" style="background-color:#D0D0D0;">
            管理团队
            <span id="span0" class="glyphicon glyphicon-chevron-right" style="float: right;top:5px;"></span>
        </a>
    </li>
    <li class="vertical-li">
        <a id="a1" href="javascript:void(0)" onclick="showPart(1)">
            团创申请
            <span id="span1" class="glyphicon glyphicon-chevron-right" style="float: right;top:5px;display: none"></span>
        </a>
    </li>
    <li class="vertical-li">
        <a id="a2" href="javascript:void(0)" onclick="showPart(2)">
            用户举报
            <span id="span2" class="glyphicon glyphicon-chevron-right" style="float: right;top:5px;display: none"></span>
        </a>
    </li>
    <li class="vertical-li">
        <a id="a3" href="javascript:void(0)" onclick="showPart(3)">
            其他信息
            <span id="span3" class="glyphicon glyphicon-chevron-right" style="float: right;top:5px;display: none"></span>
        </a>
    </li>
</ul>

<!--主体内容-->
<div style="margin-left:16%;margin-top:5%;padding:1px 16px;">
    <div class="card" style="-webkit-box-shadow: #666 0 0 10px;margin-top:20px;" id="teamlist">
        <div class="card-header">
            团队列表
        </div>
        <div class="card-body">
            <!--团队列表/表格-->
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>
                        团队名
                    </th>
                    <th>
                        ID
                    </th>
                    <th>
                        邮箱
                    </th>
                    <th>
                        管理
                    </th>
                </tr>
                </thead>
                <tbody>
                <%
                    int index=0;
                    for(int i=0;i<teams.size();i++,index++){
                        switch (i%5){
                            case 0:
                %>
                <tr id="team_id_<%=teams.get(i).getId()%>">
                <%
                                break;
                            case 1:
                %>
                <tr class="table-active" id="team_id_<%=teams.get(i).getId()%>">
                <%
                                break;
                            case 2:
                %>
                <tr class="table-success" id="team_id_<%=teams.get(i).getId()%>">
                <%
                                break;
                            case 3:
                %>
                <tr class="table-warning" id="team_id_<%=teams.get(i).getId()%>">
                <%
                                break;
                            case 4:
                %>
                <tr class="table-danger" id="team_id_<%=teams.get(i).getId()%>">
                <%
                                break;
                        }
                %>
                    <td>
                        <%=teams.get(i).getUserName()%>
                    </td>
                    <td>
                        <%=teams.get(i).getId()%>
                    </td>
                    <td>
                        <%=teams.get(i).getUserEmail()%>
                    </td>
                    <td>
                        <span>
                            <a href="#modal-delete-team" id="delete_id_<%=teams.get(i).getId()%>" onclick="setToDeleteID(this)" data-toggle="modal" role="button" class="btn" style="height:25px; margin-left:-10px;margin-top:-10px;">
                                <span class="glyphicon glyphicon-trash"></span>
                            </a>
                        </span>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="modal-delete-team" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel">
                        注销团队
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    确认将此团队注销？
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="deleteTeam()">
                        确认
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        取消
                    </button>
                </div>
            </div>

        </div>

    </div>

    <div class="modal fade" id="modal-agree-apply" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel1">
                        团队创建申请
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    确认批准此团队创建？
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="agree(0)">
                        确认
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        取消
                    </button>
                </div>
            </div>

        </div>

    </div>

    <div class="modal fade" id="modal-disagree-apply" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel2">
                        团队创建申请
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    确认拒绝此团队创建？
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="agree(1)">
                        确认
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        取消
                    </button>
                </div>
            </div>

        </div>

    </div>


    <!--团创申请-->
    <div id="teamcre" style="display: none;">
        <%
            for(int i=0;i<teamApplications.size();i++){
                switch (i%4){
                    case 0:
                        if(i==0){
        %>
        <div id="apply_<%=teamApplications.get(i).getTeamName()%>" class="alert alert-dismissable alert-success" style="margin-top:20px">
        <%}
                        if(i!=0){
        %>
        <div id="apply_<%=teamApplications.get(i).getTeamName()%>" class="alert alert-dismissable alert-success">
        <%}
                        break;
                    case 1:
        %>
        <div id="apply_<%=teamApplications.get(i).getTeamName()%>" class="alert alert-dismissable alert-info">
        <%
                        break;
                    case 2:
        %>
        <div id="apply_<%=teamApplications.get(i).getTeamName()%>" class="alert alert-dismissable alert-warning">
        <%
                        break;
                    case 3:
        %>
        <div id="apply_<%=teamApplications.get(i).getTeamName()%>" class="alert alert-dismissable alert-danger">
        <%
                        break;
                }
        %>
            <h4>
                团队创建申请
            </h4>
            邮箱为 <a href="javascript:void(0)" class="alert-link">
            <%=teamApplications.get(i).getTeamEmail()%>
            </a>的用户申请创建团队&emsp;
            <strong style="font-size:20px;"><%="\""+teamApplications.get(i).getTeamName()+"\""%></strong>
            <a href="#modal-agree-apply" id="apply_agree_<%=teamApplications.get(i).getTeamName()%>" data-toggle="modal" role="button" onclick="setDealApplyName(this,0)" class="btn" style="float:right;height:35px; margin-top:-20px;margin-right:150px">
                <span class="glyphicon glyphicon-ok"></span>
            </a>
            <a href="#modal-disagree-apply" id="apply_disagree_<%=teamApplications.get(i).getTeamName()%>" data-toggle="modal" role="button" onclick="setDealApplyName(this,1)" class="btn" style="float:right;height:35px; margin-top:-20px;margin-right:-150px">
                <span class="glyphicon glyphicon-remove"></span>
            </a>
        </div>
        <%
            }
        %>
    </div>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
    Object id=session.getAttribute("user_id");
    Message[] messages=new Message[0];
   // ArrayList<Message>message=new ArrayList<Message>();
    if(id!=null){
       /* messages=MessageOperate.getAllMessage(Integer.parseInt(id.toString()));
        for(int i=0;i<messages.length;i++){
            if(messages[i].getType().equals("report")){
                message.add(messages[i]);
            }
        }*/
       messages=MessageOperate.getReportedMessage(Integer.parseInt(id.toString()));
    }
%>

            <!--处理举报-->
    <div id="card-sum" style="margin-top:20px;display:none;">
        <%
            for(int i=0;i<messages.length;i++){
        %>
        <div class="card">
            <div class="card-header">
                <a class="card-link collapsed" data-toggle="collapse" data-parent="#card-sum" href="#card-report-<%=messages[i].getMessage_id()%>">
                    收到来自用户<span style="color:red;"><%=messages[i].getSender_name()%></span>对<strong style="font-size:15px;"><%=Team.getTeam(messages[i].getReportedTeamID()).getTeamName()%></strong>团队的举报
                    <%
                        if(!messages[i].getHaveRead()){
                    %>
                    <span style="color: red;float: right;" id="new_<%=messages[i].getMessage_id()%>">new!</span>
                    <%
                        }
                    %>
                </a>
            </div>
            <div id="card-report-<%=messages[i].getMessage_id()%>" class="collapse">
                <div class="card-body">
                    <table class="table">
                        <tr><td>举报类型：<%=messages[i].getReportReason()%></td></tr>
                        <tr><td>详细描述：<%=messages[i].getReportDetail()%></td></tr>
                        <%if(messages[i].getHavePic()){%>

                        <tr><td>附件图片：<img height="200px"

                                          src="<%=basePath%>/getPic.action?messageID=<%=messages[i].getMessage_id()%>" /></td></tr>

                        <tr><td>查看原图：<a href="<%=basePath%>/getPic.action?messageID=<%=messages[i].getMessage_id()%>"  target="_blank">附件图片</a></td></tr>

                        <%}%>

                        <tr><td>
                            <%
                                if(!messages[i].getHaveRead()){
                            %>
                            <div id="form_<%=messages[i].getMessage_id()%>">
                                <input id="send_id_<%=messages[i].getMessage_id()%>" type="hidden" name="sender_id" value="<%=id%>" />
                                <input id="receiver_id_<%=messages[i].getMessage_id()%>" type="hidden" name="receiver" value="<%=messages[i].getSender_id()%>" />
                                <input id="team_id_<%=messages[i].getMessage_id()%>" type="hidden" name="teamID" value="<%=messages[i].getReportedTeamID()%>" />
                                <span style="position: relative;top:-65px;margin-left:31px ">反馈：</span>
                                <textarea id="backMessage_<%=messages[i].getMessage_id()%>" type="text" name="message" class="mytextarea" style="position: relative;top: 3px;left: -3px;"></textarea>
                                <br>
                                <button id="message_btn_<%=messages[i].getMessage_id()%>" class="btn btn-info" style="margin-top: 20px;margin-left: 80px" onclick="sendBack(this)">提交</button>
                            </div>
                            <%
                            }else {
                            %>
                            <%
                                }
                            %>
                        </td></tr>
                    </table>
                </div>
            </div>
        </div>
        <%
            }
        %>


        <%%>
        <%%>
    </div>
    <br /><br /><br />

    <blockquote class="blockquote" id="otherinfo" style="display: none">
        <p class="mb-0">
            优秀的学校必定有很浓厚的研究学术的风气，进了大学就应不忘记推进学术文化这个神圣的使命。
        </p>
        <footer class="blockquote-footer">
            朱光潜
        </footer>
    </blockquote>

</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript">
    var toDeleteID;
    var dealApplyName;
    var parts=[];
    parts[0]=$("#teamlist");
    parts[1]=$("#teamcre");
    parts[2]=$("#card-sum");
    parts[3]=$("#otherinfo");
    var as=[];
    as[0]=$("#a0");
    as[1]=$("#a1");
    as[2]=$("#a2");
    as[3]=$("#a3");
    var spans=[];
    spans[0]=$("#span0");
    spans[1]=$("#span1");
    spans[2]=$("#span2");
    spans[3]=$("#span3");

    function showPart(index) {
        for(var i=0;i<4;i++) {
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

    function setToDeleteID(self) {
        toDeleteID=self.getAttribute("id");
    }

    function deleteTeam() {
        var teamID=toDeleteID;
        var url = "deleteATeam";
        var args = {
            "teamID" : teamID.replace("delete_id_","")
        };
        $.post(url, args, function(data) {
            if(data==="0"){
                var selector="#team_id_"+teamID.replace("delete_id_","");
                $(selector).remove();
            }
        });
    }

    function setDealApplyName(self,index) {
        dealApplyName=self.getAttribute("id");
        if(index===0)
            dealApplyName=dealApplyName.replace("apply_agree_","");
        else if(index===1)
            dealApplyName=dealApplyName.replace("apply_disagree_","");
    }

    var index=<%=teams.get(index-1).getId()%>;
    function agree(pass) {
        var passOrFailed;
        if(pass===0){
            passOrFailed="pass";
        }else
            passOrFailed="failed";
        var url="dealApply";
        var args={
            "teamName":dealApplyName,
            "passOrFailed":passOrFailed
        };
        $.post(url,args,function (data) {
            var backData=JSON.parse(data);
            var selector="#apply_"+dealApplyName;

            if(backData.state==="0") {
                $("#team_id_"+index).after("<tr class=\"table-danger\" id=\"team_id_\""+backData.teamID+">" +
                    "<td>" + backData.teamName +
                    "</td><td>" + backData.teamID +
                    "</td><td>" + backData.teamEmail +
                    "</td><td><span><a href=\"#modal-delete-team\" onclick=\"setToDeleteID(this)\" data-toggle=\"modal\" role=\"button\" class=\"btn\" style=\"height:25px; margin-left:-10px;margin-top:-10px;\">" +
                    "<span class=\"glyphicon glyphicon-trash\"></span></a></span></td></tr>");
                $(selector).remove();
                index=backData.teamID;
            }else if(backData.state==="1"){
                $(selector).remove();
            }else {
                alert("服务器错误!");
            }
        })
    }

    function sendBack(self) {
        var msg_id=self.getAttribute('id');
        msg_id=msg_id.replace("message_btn_","");
        //send_id_,receiver_id_,team_id_,message_id_获取传值
        //form_，new_删除
        var id="#send_id_"+msg_id;
        var send_id=$(id).val();
        id="#receiver_id_"+msg_id;
        var receiver_id=$(id).val();
        id="#team_id_"+msg_id;
        var team_id=$(id).val();
        id="#backMessage_"+msg_id;
        var content=$(id).val();
        var args={
            sender_id:send_id,
            receiver:receiver_id,
            teamID:team_id,
            message:content,
            messageID:msg_id
        };
        $.post("testSend",args,function (data) {
            if(data==="true"){
                $("#form_"+msg_id).remove();
                $("#new_"+msg_id).remove();
            }else if(data==="false")
                alert("消息反馈失败！");
            else
                alert("数据返回异常！");
        });

    }
</script>
</body>
</html>