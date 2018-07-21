<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.ShoppingRecord" %>
<%@ page import="Operations.ViewProduct" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-购物车</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

      <link rel="alternate icon" href="img/qm.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
	<link href="css/bootstrap.css" rel="stylesheet">
	<link rel="stylesheet" href="Font-Awesome/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/build.css"/>
	<link rel="stylesheet" type="text/css" href="css/default.css">

  </head>
  <body>
  <script src="js/server-01.js"></script>
  <%String path = request.getContextPath();
	  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
  <%if(request.getSession().getAttribute("user_id")!=null){%>
  <script>createConn();</script>
  <%}%>
  <script type="text/javascript">var deleteRecordNum=null;</script>

  <div class="container-fluid">
		<br />
		 <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
			<a class="navbar-brand col-sm-2" href="index.jsp" style="font-size: 30px; color:#FFFFFF;margin-top:12px;"> QinG MAng </a>
			<div class="col-sm-8 navbar-brand" style="font-size:23px;color:#FFFFFF;margin-top:18px;left:-35px">购物车</div>

			 <!------------------------------------------------------->
			 <!---消息显示按钮-->
			<%--<s:if test="#session.message_count!=null">--%>
			<%--<div class="col-md-1" style="margin-left:10px;margin-top: 18px;padding-left: 85px">--%>
				<%--<a href="enterMessageBox.action"><button type="button" class="btn btn-info">--%>
						 <%--<span class="glyphicon glyphicon-envelope"></span>--%>
					 <%--</button></a>--%>
			 <%--</div>--%>

				 <%--<div id="messageCircle" class="badge-bg" style="margin-left:-70px;margin-top:10px;z-index:2; width:20px;--%>
    <%--height:20px;--%>
    <%--background-color:#F00;--%>
    <%--border-radius:25px;display:none;">--%>
                            <%--<span id="message_count"  class="badge-span" style="    height:20px;--%>
    <%--line-height:20px;--%>
    <%--display:block;--%>
    <%--color:#FFF;--%>
    <%--text-align:center;"><s:if test="#session.message_count>0">--%>
								<%--<s:property value="#session.message_count"/></s:if></span>--%>
				 <%--</div>--%>
			 <%--<s:if test="#session.message_count>0">--%>
				 <%--<script>document.getElementById("messageCircle").style.display=""</script></s:if>--%>
			 <%--</s:if>--%>
             <%--<s:else>--%>
                 <%--<div class="col-md-1"></div>--%>
             <%--</s:else>--%>
			 <!---------------------------------------------->

             <li class="nav-item ">
                 <s:if test="#session.user_name==null">
                     <div style="margin-top:25px;margin-left:80px;">
                         <a href="login.jsp" style="color: white;margin-right: 5px">登录</a>
                         <span style="color: white">|</span>
                         <a href="register.jsp" style="color: white;margin-left: 5px">注册</a>
                     </div>
                 </s:if>
                 <s:else>
                     <div class="dropdown" style="margin-top:18px;margin-left:10px;padding-left: 30px">
                         <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                             <span class="glyphicon glyphicon-user"></span>&emsp;已登录
                         </button>
                         <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="left: 30px;">
                             <a class="dropdown-item" href="/enterShopping.action">购物车</a>
                             <a class="dropdown-item" href="/logout">退出登录</a>
                         </div>
                     </div>
                 </s:else>
             </li>
		</ul>
	  <div class="row" style="margin-top:5%">

		  <div class="col-md-12">
			<%ShoppingRecord[] records=(ShoppingRecord[]) request.getAttribute("cartDetail");
			if(records!=null){
			for(int i=0;i<records.length;i++){%>

				<div class="card" style="-webkit-box-shadow: #666 0px 0px 10px">
					<div class="card-header">
						<div class="row">
						 <a class="card-link collapsed col-md-11" data-toggle="collapse"  href="#card-element-<%=i%>"><%=records[i].getName()%></a>
						 <a href="#modal-delete" deleteNum="<%=records[i].getProductID()%>&<%=records[i].getProductID()%>" onclick="deleteRecord(this)" data-toggle="modal" role="button" class="btn" style="height:30px; margin-left:50px"><span class="glyphicon glyphicon-trash"></span></a>
						</div>
					</div>
					<div id="card-element-<%=i%>" class="collapse show">
					<div class="card-body">
							<div class="row" style="margin:10px">
								<!--图片-->
								<div class="col-md-2">
									<!--img class="img-thumbnail" alt="Bootstrap Image Preview" style="height:100px" src="img/WHUpro1.jpg" /-->
									<a href="enterProduct.action?productID=<%=records[i].getProductID()%>"><img class="img-thumbnail" alt="Bootstrap Image Preview" style="height:100px" src="<%=basePath%>/getPic.action?productID=<%=records[i].getProductID()%>" /></a>
								</div>
								<!--价格-->
								<div class="col-md-2" style="margin-top:35px">
									价格：<%=records[i].getPrice()%>
								</div>
								<div class="col-md-2" style="margin-top:35px">
									<%int maxNum=ViewProduct.viewGivenPro(records[i].getProductID()).getAmount();%>
									库存：<%=maxNum%>件
								</div>
								<!--数量-->
								<span style="margin-top:33px;">购买数量：</span>
								<div class="col-md-2" style="margin-top:33px">
                                    <!--form method="post" action="changeProNum" id="myForm<--%=i%>"-->
									<input type="number"name="number" id="recordNumChange<%=records[i].getRecord_id()%>" class="form-control" value="<%=records[i].getAmount()%>" min="1" max="<%=maxNum%>" style="height:30px;width:100px" oninput="checkNum(this);changeAmount(<%=i%>,<%=records[i].getRecord_id()%>,<%=records[i].getPrice()%>,this.value)" onclick="changeAmount(<%=i%>,<%=records[i].getRecord_id()%>,<%=records[i].getPrice()%>,this.value)">
                                    <!--input type="hidden" name="category" value="<--%=records[i].getProductID()%>" />
                                    <input type="hidden" name="userID" value="<--%=records[i].getUserID()%>" />
                                    </form-->
								</div>
								<!--总价-->
								<div id="checkbox<%=i%>money"   money="<%=records[i].getPrice()*records[i].getAmount()%>" class="col-md-2 text-danger" style="margin-top:35px">
									总价：<%=records[i].getPrice()*records[i].getAmount()%>
								</div>
								<div class="checkbox checkbox-primary col-md-1" style="margin-top:35px;">
									<input id="checkbox<%=i%>" class="styled" value="<%=records[i].getRecord_id()%>" type="checkbox" onclick="addMoney()">
									<label for="checkbox<%=i%>">
									</label>
								</div>
							</div>
						</div>
					</div>
					<div class="card-footer">
						<%String str=records[i].getTeamName();%>
							来自: <%=str%>
						</div>
				</div>
				<br />
				<%}%>
				<%}%>
				</div>		
		</div>
		<br />
		<!--提交-->
		<div class="col-md-12">
		<div class="row" style="background-color:#D0D0D0; height:50px">
		<div class="col-md-1" style="margin-top:13px">
			<strong>全选：</strong>
		</div>
		<div  class="checkbox checkbox-primary col-md-8" style="margin-top:5px; left:-60px">
		    <input id="boxselectAll" onclick="selectAll()" class="styled" type="checkbox">
		    <label for="boxselectAll">
		    </label>
		</div>
		
		<div class="col-md-1" style="margin-top:12px;left:40px">
			<strong>合计：</strong>
		</div>
		<div id="allmoney" class="text-danger col-md-1" style="margin-top:12px">
			0.00
		</div>
		<a href="#modal-pay" role="button" style="height:40px;margin-top:5px;margin-left:30px" class="btn btn-warning" data-toggle="modal">结算</a>
		</div>
		</div>
		<br/>
		
		<div class="modal fade" id="modal-pay" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel1">
							结算
						</h5> 
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">
						确认付款？
					</div>
					<div class="modal-footer">
						
						<button type="button" onclick="payMoney()" class="btn btn-primary">
							确认
						</button> 
						<button type="button" class="btn btn-secondary" data-dismiss="modal">
							取消
						</button>
					</div>
				</div>
				
			</div>
			
		</div>
		<div class="row">
		<div class="col-md-12">
			
			<div class="modal fade" id="modal-delete" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel2">
								删除
							</h5> 
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							确定删除该商品吗？
						</div>
						<div class="modal-footer">

							<button type="button" class="btn btn-primary" onclick="deleteSkipAddress();">
								确定
							</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">
								取消
							</button>
						</div>
					</div>
					
				</div>
				
			</div>
			
		</div>
		</div>
		<br /><br />
	
	</div>
  <!--iframe id="rfFrame" name="rfFrame" src="about:blank" style="display:none;"></iframe-->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>


  <!--复选框点击时事件 修改总价-->
  <%if(records!=null&&records.length>0){%>
  <script type="text/javascript">
      function addMoney(){
          document.getElementById("allmoney").innerHTML="0.00";
          <%for(int i=0;i<records.length;i++){%>
          if(document.getElementById('checkbox<%=i%>').checked){
            //  alert("123");
                  var d=document.getElementById("allmoney").innerHTML;
                  var m=document.getElementById('checkbox<%=i%>money').getAttribute("money");
                  d=d.trim();
                  document.getElementById("allmoney").innerHTML=(parseFloat(d)+parseFloat(m)).toString();
          }
          <%}%>
      }
  function changeAmount(index,record_id,price,amount){
          var sss="总价："+parseFloat(price*amount);
          document.getElementById("checkbox"+index+"money").innerHTML=sss;
      document.getElementById("checkbox"+index+"money").setAttribute("money",price*amount);
      if(document.getElementById('boxselectAll').checked){
          selectAll();
      }
      else{
          addMoney();
      }
      changeRecordNum(record_id,amount);
   /*   document.getElementById("myForm"+index).target="rfFrame";
      document.getElementById("myForm"+index).submit();*/
      /*document.forms[0].target="rfFrame";
          document.forms[0].submit();*/
  }
      function checkNum(item) {
          var value=item.value;
          var regx = /^[0-9]+$/;
          if(!regx.test(value)) {
              item.value = 1;
          }
      }
  function changeRecordNum(record_id,num){
      var xmlhttp;
      if (window.XMLHttpRequest)
      {
          // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
          xmlhttp=new XMLHttpRequest();
      }
      else
      {
          // IE6, IE5 浏览器执行代码
          xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
          xmlhttp.open("GET", "changeRecordNum?record_id=" +record_id+"&num="+num, true);
          xmlhttp.send();
  }
  function deleteRecord(obj){
          deleteRecordNum=obj.getAttribute("deleteNum");
  }
  function deleteSkipAddress() {
      window.location.href="deletePro?"+"category="+deleteRecordNum+"&userID="+<%=records[0].getUserID()%>;
  }
  function selectAll() {
      if(document.getElementById('boxselectAll').checked){
          document.getElementById("allmoney").innerHTML="0.00";
          <%for(int i=0;i<records.length;i++){%>
          document.getElementById('checkbox<%=i%>').checked=true;
          var d=document.getElementById("allmoney").innerHTML;
          var m=document.getElementById('checkbox<%=i%>money').getAttribute("money");
         // var m=document.getElementById('checkbox<%=i%>money').value;
          d=d.trim();
          document.getElementById("allmoney").innerHTML=(parseFloat(d)+parseFloat(m)).toString();
          <%}%>
      }
      else{
          document.getElementById("allmoney").innerHTML="0.00";
          <%for(int i=0;i<records.length;i++){%>
          document.getElementById('checkbox<%=i%>').checked=false;
          <%}%>
      }
  }
  function payMoney(){
          var str="";
      <%for(int i=0;i<records.length;i++){%>
      if(document.getElementById('checkbox<%=i%>').checked){
          var m=document.getElementById('checkbox<%=i%>').value;
          if(str=="")
              str=m;
          else{
              str=str+","+m;
		  }
      }
      <%}%>
      var xmlhttp;
      if (window.XMLHttpRequest)
      {
          // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
          xmlhttp=new XMLHttpRequest();
      }
      else
      {
          // IE6, IE5 浏览器执行代码
          xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
      xmlhttp.open("GET", "payTheMoney?str=" +str, false);
      xmlhttp.send();
      var info=xmlhttp.responseText;
      if(info=="fail"){
          alert("库存不足，购买失败")
	  }
      window.location.href="/enterShopping.action";
      /*    <--%for(int i=0;i<records.length;i++){%>
         if( document.getElementById('checkbox<--%=i%>').checked) {
             xmlhttp.open("GET", "payMoney?record_id=" +<--%=records[i].getRecord_id()%>, false);
             xmlhttp.send();
         }
          //-----------------------------添加删除该商品购物车记录和发送消息到商家代码-----------------------------
          <--%}%>
      window.location.href="/enterShopping.action";*/
	  //------------------------------------------添加刷新本页面代码------------------------------------------------------------
  }
  </script>
  <%}%>
  </body>
</html>