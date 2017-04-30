<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
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
	<script src="js/resetpasswd.js"></script> 
</head>
<body  >
	<div class="container center-block" style="width:960px;height:600px;background:url(img/fpbg.jpg);">
	<c:choose>
		<c:when test="${user==null}">
			<c:redirect url="index.jsp"></c:redirect>
		</c:when>
	</c:choose>
		<div class="row" >
			<div class="col-md-9">
				<div class="panel panel-primary" style="margin-left:230px;margin-top:197px;">
	  				<div class="panel-heading text-center" >重置密码</div>
	  				<div class="panel-body text-center">
						<form action="user_resetPassword.action" id="form4" method="post" >
							<div class="form-group" >
								<span class="glyphicon glyphicon-user" >&nbsp;</span>
								<input name="name" id="name_reg" class="form-control" value="${user.name}"
									type="text" readonly="readonly"/>
							</div>
							<div class="form-group" >
								<span class="glyphicon glyphicon-lock" >&nbsp;</span>
								<input name="password" id="password_reg" class="form-control" 
									type="password" placeholder="新密码(6-12位数字/字母)" title="密码格式错误"/>
							</div>
							<div class="form-group" >	
								<span class="glyphicon glyphicon-lock" >&nbsp;</span>
								<input name="password2" id="password_conf" class="form-control" 
									type="password" placeholder="确认密码" title="确认密码不匹配"/>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-info" >重置密码</button>
							</div> 
						</form>
	  				</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>