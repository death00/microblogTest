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
<link href="../ot/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="js/m_index.js"></script>
<link href="css/m_index.css" rel="stylesheet">
</head>
<body>
	<div class='form-group'>
		<form method='post'>
			${ sessionScope.User.name}:<br />
			<textarea rows='1' class='form-control remark_zone'
				id='remark_text${microblog.id}'></textarea>
			<input type='button' onclick='remarkCreate(${microblog.id})'
				class='btn btn-info remark_button' value='评论' />
		</form>
	</div>
	<div class='list-group rf_content'>
		<c:forEach items="${remarks}" var="r" varStatus="status" begin="0"
			end="2" step="1">
			<div class='list-group-item'>
				<span class='rf'><a href='user_scan.action?id=${r.user.id }'>
						${r.user.name }</a>: <c:if test="${r.isreply}">
					回复<a href='user_scan.action?id=${r.user.id }'>@${r.replyUser.name }</a>:
				</c:if> ${r.content }</span><br /> <span class='time'>${r.getNTime()}</span>
				<div class='pull-right'>
					<c:if test="${ sessionScope.User.id != r.user.id}">
						<a href="javascript:showReport(${r.id },3,${r.user.id })"><span class="time">举报&nbsp;&nbsp;|&nbsp;&nbsp;</span></a>
					</c:if>
					<a href='javascript:toggleReply(${r.id})'>回复</a>
					<c:if
						test="${sessionScope.User.id == microblog.userid || r.user.id == sessionScope.User.id}">
				&nbsp;&nbsp;|&nbsp;&nbsp;<a
							href='javascript:remarkDelete(${r.id},${r.microblogid})'>删除</a>
					</c:if>
				</div>
			</div>
			<input type="hidden" id="replyh${r.id }" value="0">
			<div class='well collapse' id='reply${r.id}'>
				<form method='post'>
					<textarea rows='1' class='form-control reply_zone'
						id='reply_text${r.id}'></textarea>
					<input type='button'
						onclick='remarkReply(${r.id},${r.user.id},${microblog.id })'
						class='btn btn-info remark_button' value='回复' />
				</form>
			</div>
		</c:forEach>
	</div>
	<c:if test="${remarks.size() > 3}">
		<a href="remark_showMore.action?microblogid=${microblog.id}">
			查看更多评论>></a>
	</c:if>
</body>
</html>