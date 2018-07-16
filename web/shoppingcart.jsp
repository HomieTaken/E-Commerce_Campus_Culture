<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.ShoppingRecord" %>
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
			<a class="navbar-brand col-sm-2" href="index.jsp" style="font-size: 30px;text-shadow: 0 0 10px white; color:#FFFFFF;margin-top:12px;"> QinG MAng </a>
			<div class="col-sm-7 navbar-brand" style="font-size:23px;color:#FFFFFF;margin-top:18px;left:-35px">购物车</div>

			 <!------------------------------------------------------->
			 <!---消息显示按钮-->
			 <s:if test="#session.message_count!=null">
			<div class="col-md-1" style="margin-left:0px;margin-top:18px;">
				<a href="enterMessageBox.action"><button type="button" class="btn btn-info">
						 <span class="glyphicon glyphicon-envelope"></span>
					 </button></a>
			 </div>

				 <div id="messageCircle" class="badge-bg" style="margin-left:-70px;margin-top:10px;z-index:2; width:20px;
    height:20px;
    background-color:#F00;
    border-radius:25px;display:none;">
                            <span id="message_count"  class="badge-span" style="    height:20px;
    line-height:20px;
    display:block;
    color:#FFF;
    text-align:center;"><s:if test="#session.message_count>0">
								<s:property value="#session.message_count"/></s:if></span>
				 </div>
			 <s:if test="#session.message_count>0">
				 <script>document.getElementById("messageCircle").style.display=""</script></s:if>
			 </s:if>
			 <!---------------------------------------------->


			<li class="nav-item ">
						<div class="dropdown" style="margin-top:18px;margin-left:40px">
							<button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="text-shadow: black 5px 3px 3px;">
								<span class="glyphicon glyphicon-user"></span>&emsp;已登录
							</button>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
								<a class="dropdown-item" href="logout.action">退出登录</a>
							</div>
						</div>
					</li>
		</ul>
			<%ShoppingRecord[] records=(ShoppingRecord[]) request.getAttribute("cartDetail");
			if(records!=null){
			for(int i=0;i<records.length;i++){%>
		<div class="row" style="margin-top:5%">
				
			<div class="col-md-12">

				<div class="card" style="-webkit-box-shadow: #666 0px 0px 10px">
					<div class="card-header">
						<div class="row">
						 <a class="card-link collapsed col-md-11" data-toggle="collapse"  href="#card-element-1"><%=records[i].getName()%></a>
						 <a href="#modal-delete" deleteNum="<%=records[i].getProductID()%>&<%=records[i].getProductID()%>" onclick="deleteRecord(this)" data-toggle="modal" role="button" class="btn" style="height:30px; margin-left:50px"><span class="glyphicon glyphicon-trash"></span></a>
						</div>
					</div>
					<div id="card-element-1" class="collapse show">
					<div class="card-body">
							<div class="row" style="margin:10px">
								<!--图片-->
								<div class="col-md-4">
									<!--img class="img-thumbnail" alt="Bootstrap Image Preview" style="height:100px" src="img/WHUpro1.jpg" /-->
									<a href="enterProduct.action?productID=<%=records[i].getProductID()%>"><img class="img-thumbnail" alt="Bootstrap Image Preview" style="height:100px" src="<%=basePath%>/getPic.action?productID=<%=records[i].getProductID()%>" /></a>
								</div>
								<!--价格-->
								<div class="col-md-2" style="margin-top:35px">
									价格：<%=records[i].getPrice()%>
								</div>
								<!--数量-->
								购买数量：
								<div class="col-md-2" style="margin-top:35px">
                                    <form action="changeProNum">
									<input type="number"name="number" class="form-control" value="<%=records[i].getAmount()%>" min="1" style="height:30px;width:100px" onclick="changeAmount(<%=i%>,<%=records[i].getPrice()%>,this.value)">
                                    <iframe id="rfFrame" name="rfFrame" src="about:blank" style="display:none;"></iframe>
                                    <input type="hidden" name="category" value="<%=records[i].getProductID()%>" />
                                    <input type="hidden" name="userID" value="<%=records[i].getUserID()%>" />
                                    </form>
								</div>
								<!--总价-->
								<div id="checkbox<%=i%>money" money="<%=records[i].getPrice()*records[i].getAmount()%>" class="col-md-3 text-danger" style="margin-top:35px">
									总价：<%=records[i].getPrice()*records[i].getAmount()%>
								</div>
								<div class="checkbox checkbox-primary col-md-1" style="margin-top:35px;">
									<input id="checkbox<%=i%>" class="styled" type="checkbox" onclick="addMoney()">
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
<br><br><br>
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
  function changeAmount(index,price,amount){
          var sss="总价："+parseFloat(price*amount);
          document.getElementById("checkbox"+index+"money").innerHTML=sss;
      document.getElementById("checkbox"+index+"money").setAttribute("money",price*amount);
      if(document.getElementById('boxselectAll').checked){
          selectAll();
      }
      else{
          addMoney();
      }
      document.forms[0].target="rfFrame";
          document.forms[0].submit();
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
          <%for(int i=0;i<records.length;i++){%>
         if( document.getElementById('checkbox<%=i%>').checked) {
             xmlhttp.open("GET", "payMoney?record_id=" +<%=records[i].getRecord_id()%>, false);
             xmlhttp.send();
         }
          //-----------------------------添加删除该商品购物车记录和发送消息到商家代码-----------------------------
          <%}%>
      window.location.href="/enterShopping.action";
	  //------------------------------------------添加刷新本页面代码------------------------------------------------------------
  }
  </script>
  <%}%>
  </body>
</html>