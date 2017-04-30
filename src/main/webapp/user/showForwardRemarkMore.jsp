<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html >
<html>
<head>
<title>微博转发</title>
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
	<div class='form-group  clearfix'>
	    <form  method='post'>
			<textarea rows='2' class='form-control' id="forwardRemarka${microblog.forwardMicroblogId }" ></textarea>
			<input type='button' onclick="forwardMorea(${microblog.forwardMicroblogId },${microblog.sourceMicroblogId})" class='btn btn-info forward_button' value='转发' />
		</form>
	</div>
	<div class='list-group rf_content'>
		<c:forEach var="m" items="${Page.list}">
			<div class='list-group-item'>
				<span class='rf'>
				<a href="user_scan.action?id=${m.user.id}">${m.user.name}</a>:${m.forwardRemark }
				<c:forEach items="${m.forwardRemarks}" var="r">
					<a href="user_scan.action?id=${r.userId}">//@${r.userName }</a>:${r.remark }
		   		</c:forEach>
		   		</span><br /> 
				<span class='time'>${m.getNTime()}</span>
			<div class='pull-right'>
				<a href='javascript:toggleForward(${m.id})' >转发</a>
				<c:if test="${sessionScope.User.id == m.userid }">
					&nbsp;&nbsp;|&nbsp;&nbsp;<a href='javascript:microblogDeleteMore(${m.id},${microblog.forwardMicroblogId},${microblog.sourceMicroblogId})'>删除</a>
				</c:if>
			</div>
			</div>
			<input type="hidden" id="forwardh${m.id }" value="0">
			<div class='well collapse clearfix' id='forward${m.id}'>
				<form  method='post'>
				    <textarea rows='2' class='form-control' id="forwardRemarkb${m.id }"></textarea>
				    <input type='button' onclick="forwardMoreb(${m.id},${m.sourceMicroblogId==0?m.id:m.sourceMicroblogId },${microblog.forwardMicroblogId })" class='btn btn-info forward_button' value='转发' />
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
		   		 <li><a href="javascript:certainfPage(${microblog.forwardMicroblogId},${microblog.sourceMicroblogId},1)">首页</a></li>
		    	 <li><a href="javascript:certainfPage(${microblog.forwardMicroblogId},${microblog.sourceMicroblogId},${Page.beginPage-1})">上一页</a></li>
		</c:otherwise>
	</c:choose>
		${Page.beginPage }/${Page.totalPage==0?1:Page.totalPage}
	<c:choose>
		<c:when test="${Page.beginPage >= Page.totalPage}">
		    <li><a href="javascript:void(0)">下一页</a></li>
	    	<li><a href="javascript:void(0)">尾页</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="javascript:certainfPage(${microblog.forwardMicroblogId},${microblog.sourceMicroblogId},${Page.beginPage+1})">下一页</a></li>
			<li><a href="javascript:certainfPage(${microblog.forwardMicroblogId},${microblog.sourceMicroblogId},${Page.totalPage })">尾页</a></li>
		</c:otherwise>
	</c:choose>
	</ul>
	</nav>
</body>
</html>