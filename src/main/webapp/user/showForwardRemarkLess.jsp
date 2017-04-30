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
		<form action="microblog_forward.action" method="post">
			<textarea rows="2" class="form-control " name="forwardRemark"></textarea>
			<input type="hidden" name="forwardMicroblogId" value="${Microblog.forwardMicroblogId}" /> 
			<input type="hidden" name="sourceMicroblogId" value="${Microblog.sourceMicroblogId}" /> 
			<input type="submit" class='btn btn-info forward_button' value="转发" />
		</form>
	</div>
	<div class='list-group rf_content'>
	<c:forEach var="m" items="${Microblogs}" varStatus="status" begin="0" end="2" step="1">
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
					&nbsp;&nbsp;|&nbsp;&nbsp;<a href='javascript:microblogDeleteLess(${m.id},${Microblog.forwardMicroblogId},${Microblog.sourceMicroblogId})'>删除</a>
				</c:if>
			</div>
		</div>
		<input type="hidden" id="forwardh${m.id }" value="0">
		<div class='well collapse clearfix' id='forward${m.id}'>
			<form  method='post'>
			    <textarea rows='2' class='form-control' id="forwardRemark${m.id }" name="forwardRemark"></textarea>
			    <input type='button' onclick="forwardLess(${m.id},${m.sourceMicroblogId==0?m.id:m.sourceMicroblogId },${Microblog.forwardMicroblogId })" class='btn btn-info forward_button' value='转发' />
			</form>
		</div>
	</c:forEach>
	</div>
	<c:if test="${Microblogs.size() > 3}">
	<div class='see_more'>
		<a href="microblog_showForwardMore.action?forwardMicroblogId=${Microblog.forwardMicroblogId }
				&sourceMicroblogId=${Microblog.sourceMicroblogId}">
			查看更多转发内容>>
		</a>  
	</div>
	</c:if>
</body>
</html>