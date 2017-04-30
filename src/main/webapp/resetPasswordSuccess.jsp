<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html >
<html>
<head>
	<title>密码重置提示</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">		
	<script src="ot/jquery-2.0.0.min.js"></script>
	<script src="ot/bootstrap.min.js"></script>  
	<link href="ot/bootstrap.min.css" rel="stylesheet" media="screen" >
</head>
<body style="background:url(img/regbg.jpg);background-size: 100%;">
	<c:choose>
		<c:when test="${!requestScope.visited.equals('exist')}">
			<c:redirect url="index.jsp"></c:redirect>
		</c:when>
	</c:choose>
	<div class="container" style="margin-top:300px;">
		<div class="row" >
			<div class="col-md-4">
				<div class="panel panel-primary">
	  				<div class="panel-heading">提示信息</div>
	  				<div class="panel-body">
	  				密码重置成功，请重新登录！<br/>
	  				5s后跳转回首页，若未跳转，点击<a href="index.jsp">首页</a>
	  				<%
	  					response.setHeader("refresh", "5;url=index.jsp");
	  				%>
	  				</div>
				</div>
			</div>
		</div>
	</div>
</body>
