<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html >
<html>
<head>
<title>微博评论</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
	<script src="../ot/jquery-2.0.0.min.js"></script>
	<script src="../ot/bootstrap.min.js"></script>  
	<link href="../ot/bootstrap.min.css" rel="stylesheet" media="screen" >
	
	<script src="js/m_index.js" ></script> 
 	<link href="css/m_index.css" rel="stylesheet" >
 
</head>
<body>
	<div class='form-group'>
		<form method='post'>
			${ sessionScope.User.name}:<br/>
			<textarea rows='1' class='form-control remark_zone' id='remark_text${microblog.id}' ></textarea>
			<input type='button' onclick='remarkCreateMore(${microblog.id})' class='btn btn-info remark_button' value='评论' />
		</form>
	</div>
	<div class='list-group rf_content'>
		<c:forEach items="${Page.list}" var="r">
			<div class='list-group-item'>
			    <span class='rf'><a href='user_scan.action?id=${r.user.id }'>
				${r.user.name }</a>:
				<c:if test="${r.isreply}">
					回复<a href='user_scan.action?id=${r.user.id }'>@${r.replyUser.name }</a>:
				</c:if>
				${r.content }</span><br/>
				<span class='time'>${r.getNTime()}</span>
				<div class='pull-right'><a  href='javascript:toggleReply(${r.id})'>回复</a>
				<c:if test="${sessionScope.User.id == microblog.userid || r.user.id == sessionScope.User.id}">
				&nbsp;&nbsp;|&nbsp;&nbsp;<a href='javascript:remarkDeleteMore(${r.id},${r.microblogid})'>删除</a>
				</c:if>
				</div>
			</div>
			<input type="hidden" id="replyh${r.id }" value="0">
			<div class='well collapse'  id='reply${r.id}'>
				<form method='post'>
					<textarea rows='1' class='form-control reply_zone' id='reply_text${r.id}' ></textarea>
					<input type='button' onclick='remarkReplyMore(${r.id},${r.user.id},${microblog.id })' class='btn btn-info remark_button' value='回复' />
				</form>
			</div>
		</c:forEach>
	</div>
	<nav>
	<ul class="pager">
	<c:choose>
		<c:when test="${Page.beginPage == 1}">
	   		 <li><a href="javascript:void(0)">首页</a></li>
	    	 <li><a href="javascript:void(0)">上一页</a></li>
		</c:when>
		<c:otherwise>
	   		 <li><a href="javascript:certainPage(${microblog.id},1)">首页</a></li>
	    	 <li><a href="javascript:certainPage(${microblog.id},${Page.beginPage-1})">上一页</a></li>
		</c:otherwise>
	</c:choose>
		${Page.beginPage }/${Page.totalPage==0?1:Page.totalPage}
	<c:choose>
		<c:when test="${Page.beginPage >= Page.totalPage}">
		    <li><a href="javascript:void(0)">下一页</a></li>
	    	<li><a href="javascript:void(0)">尾页</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="javascript:certainPage(${microblog.id},${Page.beginPage+1})">下一页</a></li>
			<li><a href="javascript:certainPage(${microblog.id},${Page.totalPage })">尾页</a></li>
		</c:otherwise>
	</c:choose>
	</ul>
	</nav>
</body>
</html>