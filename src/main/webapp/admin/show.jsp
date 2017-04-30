<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>举报</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script src="${ctx }/ot/jquery-2.0.0.min.js"></script>
<script src="${ctx }/ot/bootstrap.min.js"></script>
<link href="${ctx }/ot/bootstrap.min.css" rel="stylesheet"
	media="screen">
<script src="${ctx }/admin/user/js/m_index.js"></script>
<link href="${ctx }/admin/user/css/m_index.css" rel="stylesheet">
</head>
<body>
	<div class='form-group  clearfix'>
		<div class='list-group-item'>
			<div>
				<c:if test="${not empty remark}">
					<div>
						“<span class="rf"><a onclick="showUserScan(${report.reportedUser.id})" href="#">
							@${report.reportedUser.name }</a></span>”发表的评论：
						<c:set var="r" value="${remark}" />
						<div class='list-group-item'>
							<span class='rf'><a onclick="showUserScan(${r.user.id})" href="#"> ${r.user.name }</a>: <c:if
									test="${r.isreply}">
											回复<a onclick="showUserScan(${r.user.id})" href="#">@${r.replyUser.name }</a>:
										</c:if> ${r.content } </span>
						</div>
					</div>
				</c:if>
				<div>
					<div style="float: left;">
						“<span class="rf"><a onclick="showUserScan(${report.reportedUser.id})" href="#">
						@${report.reportedUser.name}</a></span>”发表的微博：
					</div>
				</div>
				<br />
				<div>
					<c:set var="m" value="${microblog}" />
					<c:choose>
						<c:when
							test="${m.forwardRemark == null || m.forwardRemark.equals('')}">
							<span class="time">${m.getNTime()}</span>
							<br />
							   	 				${m.content}
											</c:when>
						<c:otherwise>
							<span class="time">${m.getNTime()}</span>
							<br />
								   	 			${m.forwardRemark }
									   			<span class="rf"><c:forEach
									items="${m.forwardRemarks}" var="r">
									<a onclick="showUserScan(${r.userId})" href="#">//@${r.userName }</a>
									   			   :${r.remark }
								   			</c:forEach> </span>
							<div class="list-group-item original">
								<a onclick="showUserScan(${m.sourceMicroblog.user.id})" href="#">@${m.sourceMicroblog.user.name }</a>
								<br />${m.content}
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<div class='list-group-item'>
		<div>举报理由：</div>
		<div class="list-group-item original">
			<span class="rf">${report.reportreason}</span>
		</div>
	</div>
</body>
</html>