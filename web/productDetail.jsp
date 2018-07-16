<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/5/005
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.CultureProduct" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>青芒-商品</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>
<body>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script src="js/server-01.js"></script>
<%String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>

<%CultureProduct product= (CultureProduct) request.getAttribute("productDetail");%>
<%String str=(String)request.getParameter("havenotlog");
    if(str!=null){%>
<script type="text/javascript">
    window.open("login.jsp");
</script>
<%}%>
<%if(request.getSession().getAttribute("user_id")!=null){%>
<script>createConn();</script>
<%}%>
<div class="container-fluid">

    <!--导航栏，也是页头-->
    <ul class="nav fixed-top" style="background-color: #6C6C6C; height:70px;">
        <a class="navbar-brand col-sm-6" href="enterTeam?teamID=<%=product.getTeamID()%>" style="color:#FFFFFF;margin-top:12px;font-size:25px"> QinG MAng-商品 </a>


        <li class="nav-item col-sm-3">
            <form class="form-inline" style="margin-top:18px;">
                <input class="form-control mr-sm-2" type="text" style="width: 200px;" placeholder="搜本店">
                <button class="btn btn-default my-2 my-sm-0" type="submit" >
                    <span class="glyphicon glyphicon-search"></span>
                </button>
            </form>
        </li>
        <!------------------------------------------------------->
        <!---消息显示按钮-->
        <s:if test="#session.message_count!=null">
       <div class="col-md-1" style="margin-left:0px;margin-top: 18px;">
           <a href="enterMessageBox.action"><button type="button" class="btn btn-info">
                    <span class="glyphicon glyphicon-envelope"></span>
           </button></a>
        </div></a>

            <div id="messageCircle" class="badge-bg" style="margin-left:-70px;margin-top:10px;z-index:2; width:20px;
    height:20px;
    background-color:#F00;
    border-radius:25px;display:none;">
                            <span id="message_count" class="badge-span" style="    height:20px;
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
            <s:if test="#session.user_name==null">
                <div style="margin-top:18px;margin-left:40px">
                    <a href="login.jsp">登录</a>
                    <a href="register.jsp">注册</a>
                </div>
            </s:if>
            <s:else>
                <div class="dropdown" style="margin-top:18px;margin-left:40px">
                    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="text-shadow: black 5px 3px 3px;">
                        <span class="glyphicon glyphicon-user"></span>&emsp;已登录
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item disabled" href="#">Action</a>
                        <a class="dropdown-item" href="/enterShopping.action">购物车</a>
                        <a class="dropdown-item" href="/logout">退出登录</a>
                    </div>
                </div>
            </s:else>
        </li>
    </ul>

    <!--商品图片展示及描述-->
    <div class="row" style="margin-top:5%">
        <div class="col-md-6">
            <div class="col-md-12">
                <!--product picture-->
                <br />
                <img height="200px" class="img-thumbnail img-fluid" alt="Carousel Bootstrap Second" src="<%=basePath%>/getPic.action?productID=<%=product.getProductID()%>" />
            </div>
            <br />
            <!--product description-->
            <div class="col-md-12">
                <dl>
                    <dt>
                        商品描述
                    </dt>
                    <br />
                    <dd>
                        <%=product.getDescription()%>
                    </dd>
                </dl>
            </div>
        </div>

        <br />
        <div class="col-md-6" style="margin-top:2%">
            <div class="card" style="overflow:hidden; border-top-left-radius: 20px; border-top-right-radius: 20px; border-bottom-left-radius:20px; border-bottom-right-radius:20px; box-shadow: 10px 10px 5px #888888;">
                <div class="card-header">
                    <div style="FILTER: shadow(color=#6495ED, strength=50); WIDTH:600px; HEIGHT: 40px">
                        <div align=center>
				<span style="FONT-SIZE: 24pt; COLOR: blue; FONT-FAMILY: 华文行楷; mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-CN; mso-bidi-language: AR-SA; mso-hansi-font-family: 'Times New Roman'; mso-bidi-font-family: 'Times New Roman'">
				<%=product.getName()%>
				</span>
                        </div>
                    </div>
                </div>
                <br />

                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-2">
                            价格：
                        </div>
                        <div class="col-md-4 text-danger" style="font-size:18px">
                            <%=product.getPrice()%>
                        </div>
                    </div>

                    <form class="form" role="form" action="addProduct">
                        <!--配送地址-->
                        <input type="hidden" name ="category" value="<%=product.getProductID()%>"/>
                        <br />
                        <div class="form-group">
                            <label class="control-label" for="shipaddress">选择配送地点</label>
                            <a href="#modal-addaddress" data-toggle="modal" role="button" class="btn" style="height:37px;margin-left:0px"><span class="glyphicon glyphicon-plus-sign"></span></a>
                            <select name="address" class="form-control" id="shipaddress">
                                <%String[] addressed=(String[])request.getAttribute("addressDetail");
                                    if(addressed==null){%>
                                <option>湖北省武汉市信息学部</option>
                                <option>美国洛杉矶</option>
                                <%}
                                else{
                                    for(int i=0;i<addressed.length;i++){%>
                                <option><%=addressed[i]%></option>>
                                <%}
                                }%>
                            </select>
                        </div>
                        <!--配送数量-->
                        <br />
                        <div class="form-group">
                            <label for="pronum" class="control-label">
                                选择数量：(现存<%=product.getAmount()%>件)
                            </label>
                            <input name="number" type="number" min="1" value="1" class="form-control" id="pronum">
                        </div>
                        <br />

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <span class="glyphicon glyphicon-shopping-cart"></span> 加入购物车
                            </button>
                            <%str=(String)request.getParameter("havenotlog");
                                if(str!=null){%>
                            请先登录
                            <%}%>
                            <%str=(String)request.getParameter("add");
                            if(str!=null){%>
                            已成功加入购物车
                            <%}%>
                        </div>

                    </form>






                    <div class="row">
                        <div class="col-md-12">
                            <div class="modal fade" id="modal-addaddress" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="myModalLabel">
                                                增加收货地址
                                            </h5>
                                            <button type="button" class="close" data-dismiss="modal">
                                                <span aria-hidden="true">×</span>
                                            </button>
                                        </div>
                                        <!--增加收货地址表单主体-->
                                        <div class="modal-body">
                                            <form role="form" class="form-horizontal" action="addAddress">
                                                <input type="hidden" name="productID" value=<%=request.getParameter("productID")%> />
                                                <br />
                                                <div class="input-group">
                                                    <span class="col-md-3" style="margin-left:10px">所在地区:</span>
                                                    <input name="province" style="left:-15px;top:-6px;border-top-left-radius: 5px; border-top-right-radius: 5px;border-bottom-left-radius:5px; border-bottom-right-radius:5px; " type="text" class="form-control col-md-4" placeholder="省份">
                                                    <input name="city" style="left:-5px;top:-6px; border-top-left-radius: 5px; border-top-right-radius: 5px;border-bottom-left-radius:5px; border-bottom-right-radius:5px; " type="text" class="form-control col-md-4" placeholder="城市">
                                                </div>
                                                <br />
                                                <div class="input-group">
                                                    <span class="col-md-3" style="margin-left:10px">详细地址:</span>
                                                    <textarea name="addressDetail" cols="4" class="form-control" style="left:-15px; border-top-left-radius: 5px; border-top-right-radius: 5px;border-bottom-left-radius:5px; border-bottom-right-radius:5px;" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea>
                                                </div>
                                                <br/>
                                                <div class="input-group">
                                                    <span class="col-md-3" style="margin-left:-5px">收货人姓名:</span>
                                                    <input name="userName" style="left:0px;top:-6px;width:250px;border-top-left-radius: 5px; border-top-right-radius: 5px;border-bottom-left-radius:5px; border-bottom-right-radius:5px; " type="text" class="form-control col-md-8" placeholder="长度不超过10个字">
                                                </div>
                                                <br />
                                                <div class="input-group">
                                                    <span class="col-md-3" style="margin-left:10px">手机号码:</span>
                                                    <input name="phoneNumber" style="left:-15px;top:-6px;width:250px;border-top-left-radius: 5px; border-top-right-radius: 5px;border-bottom-left-radius:5px; border-bottom-right-radius:5px; " type="phone" class="form-control col-md-8" placeholder="中国大陆+86">
                                                </div>
                                                <br />
                                                <div class="checkbox checkbox-primary col-md-8" style=" margin-top:-20px;left:21%">
                                                    <input id="checkbox4" class="styled" type="checkbox">
                                                    <label for="checkbox4" style="font-size:15px">
                                                        设为默认收货地址
                                                    </label>
                                                </div>
                                                <br />
                                                <div class="form-group" style="margin-left:34%">
                                                    <div class="col-sm-offset-2 col-md-6">
                                                        <button type="submit" class="btn btn-warning btn-block">保存</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                </div>

                            </div>

                        </div>
                    </div>








                    <br />
                </div>

            </div>
        </div>
    </div>
</div>










</body>
</html>