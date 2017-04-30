<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>微博首页</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">	
	<script src="ot/jquery-2.0.0.min.js"></script>
	<script src="ot/bootstrap.min.js"></script>  
	<link href="ot/bootstrap.min.css" rel="stylesheet" media="screen" >
 	
 	<link href="css/p_index.css" rel="stylesheet">
 	<link href="css/loading.css" rel="stylesheet" >
 	<script src="js/loaded.js"></script>
</head>
<body style="background: url(img/bg.jpg);">
	<!-- Preloader -->
    <div id="loader-wrapper">
    <div id="loader"></div>
    <div class="loader-section section-left"></div>
    <div class="loader-section section-right"></div>
    </div>
    <!-- End Preloader -->
	<div class="container" >
		<div class="row" >
			<div class="col-md-4">				
				<p >
					<img src="img/logo.png" style="width:60px"/><span >微博</span>
				</p>
				<div class="tabbable" style="margin-right:100px;">  
				    <ul class="nav nav-tabs">  
				  	    <li class="active" ><a href="#1" data-toggle="tab" >登录</a></li>  
						<li ><a href="#2" data-toggle="tab">注册</a></li>  
				    </ul>  
					<div class="tab-content">
						
						<div class="tab-pane active" id="1">  
							<form action="user/microblog_showAll.action" method="post"  id="form1">
								<div class="form-group" >
									<span class="glyphicon glyphicon-user" >&nbsp;</span>
									<input name="name" id="name_login" class="form-control" 
										type="text" placeholder="用户名" />
								</div>
								<div class="form-group" >						
									<span class="glyphicon glyphicon-lock" >&nbsp;</span>
									<input name="password" id="password_login" class="form-control" 
										type="password" placeholder="密码" title="密码格式错误"/>
								</div>
								<div class="form-group" >
									<span class="glyphicon glyphicon-check" >&nbsp;</span>
									<input name="verifyCode" id="verifyCode" class="form-control" 
										style="width:140px;" type="text" placeholder="验证码" />
									<img id="verifyPic" src="img" onclick="this.src='img?'+Math.random()"/>
								</div>
								<div class="form-group">
									<button type="submit" id="login" class="btn btn-info" >登录</button>									
								</div>
								<span style="margin-left:180px;"><a style="color:lightgray;" href="findPassword.jsp">忘记密码</a></span>
							</form>
						</div>  
						
						<div class="tab-pane" id="2">
							<form action="user_register.action" method="post"  id="form2">
								<div class="form-group" >
									<span class="glyphicon glyphicon-user" >&nbsp;</span>
									<input name="name" id="name_reg" class="form-control" 
										type="text" placeholder="用户名(2-10位数字/字母/中文)" data-content="用户名已存在"/>
								</div>
								<div class="form-group" >
									<span class="glyphicon glyphicon-envelope" >&nbsp;</span>
									<input name="email" id="email" class="form-control" 
										type="text" placeholder="邮箱" data-content="邮箱已存在"/>
								</div>
								<div class="form-group" >
									<span class="glyphicon glyphicon-lock" >&nbsp;</span>
									<input name="password" id="password_reg" class="form-control" 
										type="password" placeholder="密码(6-12位数字/字母组合)" title="密码格式错误"/>
								</div>
								<div class="form-group" >	
									<span class="glyphicon glyphicon-lock" >&nbsp;</span>
									<input name="password2" id="password_conf" class="form-control" 
										type="password" placeholder="确认密码" title="确认密码不匹配"/>
								</div>
								<div class="form-group">
									<button type="submit" class="btn btn-info"  >注册</button>
								</div> 
							</form>
						</div> 
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>