<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
	<title>找回密码提示</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">	
	<script src="ot/jquery-2.0.0.min.js"></script>
	<script src="ot/bootstrap.min.js"></script>  
	<link href="ot/bootstrap.min.css" rel="stylesheet" media="screen" >
	
	<link href="css/p_index.css" rel="stylesheet">
	<script src="js/findpasswd.js"></script>
</head>
<body  >
	<div class="container center-block" style="width:960px;height:600px;background:url(img/fpbg.jpg);">
		<div class="row" >
			<div class="col-md-9">
				<div class="panel panel-primary" style="margin-left:230px;margin-top:197px;">
	  				<div class="panel-heading text-center" >获取重置密码链接</div>
	  				<div class="panel-body text-center">
						<form action="user_findPassword.action" id="form3" method="post" >
							<div class="form-group" style="margin-bottom: 20px;margin-top:22px;">
								<span class="glyphicon glyphicon-user" >&nbsp;</span>
								<input name="name" id="name" class="form-control" 
									type="text" placeholder="用户名"/>
							</div>
							<div class="form-group" style="margin-bottom: 32px;">
								<span class="glyphicon glyphicon-envelope" >&nbsp;</span>
								<input name="email" id="email" class="form-control" 
									type="text" placeholder="邮箱" title="邮箱格式错误"/>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-info" >获取链接</button>
							</div> 
						</form>
	  				</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>