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
<script src="${ctx }/user/js/m_index.js"></script>
<link href="${ctx }/user/css/m_index.css" rel="stylesheet">
</head>
<body>
	<div class='form-group  clearfix'>
		<form action="report_submit.action" method="post">
			<div class='list-group-item'>
				<c:choose>
					<%--用户举报 --%>
					<c:when test="${report.type == 1}">
						<div>
							我要举报的是“<span class="rf"><a
								href="user_scan.action?id=${reportedUser.id}" target="_blank">@${reportedUser.name }</a></span>”用户
						</div>
					</c:when>
					<c:otherwise>
						<c:choose>
							<%--微博举报 --%>
							<c:when test="${report.type == 2}">
								<div>
									我要举报的是“<span class="rf"><a
										href="user_scan.action?id=${reportedUser.id}" target="_blank">@${reportedUser.name }</a></span>”发的微博：
								</div>
								<div>
									<div>
										<div style="float: left;">
											<span class="rf"><a
												href="user_scan.action?id=${reportedUser.id}"
												target="_blank">${reportedUser.name}</a></span>
										</div>
									</div>
									<br />
									<div>
										<c:set var="m" value="${report.reported}" />
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
														<a href="user_scan.action?id=${r.userId}">//@${r.userName }</a>
									   			   :${r.remark }
								   			</c:forEach> </span>
												<div class="list-group-item original">
													<a href="user_scan.action?id=${m.sourceMicroblog.user.id}">@${m.sourceMicroblog.user.name }</a>
													<br />${m.content}
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</c:when>
							<%--评论举报 --%>
							<c:otherwise>
								我要举报的是“<span class="rf"><a
									href="user_scan.action?id=${reportedUser.id}" target="_blank">@${reportedUser.name }</a></span>”发表的评论：
								<c:set var="r" value="${report.reported}" />
								<div class='list-group-item'>
									<span class='rf'><a
										href='user_scan.action?id=${r.user.id }'> ${r.user.name }</a>:
										<c:if test="${r.isreply}">
											回复<a href='user_scan.action?id=${r.user.id }'>@${r.replyUser.name }</a>:
										</c:if> ${r.content }
									</span>
								</div>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
	</div>
	<div class='list-group-item'>
		<div>举报理由：</div>
		<div>
			<textarea rows="2" class="form-control " name="reportreason"
				id="reportreason"></textarea>
		</div>
	</div>
	<input type="hidden" name="type" id="type" value="${report.type}" />
	<input type="hidden" name="reportedid" id="reportedid"
		value="${report.reportedid}" />
	<input type="hidden" name="reportedUserId" id="reportedUserId"
		value="${report.reportedUserId}" />
	<input type="button" class='btn btn-info forward_button'
		onclick="reportSubmit()" value="举报" />
	</form>
	</div>
	<SCRIPT type="text/javascript">
		function reportSubmit() {
			var reportreason = $("#reportreason").val();
			if ($.trim(reportreason) == '') {
				alert("举报理由不能为空！");
				return;
			}
			var type = $("#type").val();
			var reportedid = $("#reportedid").val();
			var reportedUserId = $("#reportedUserId").val();
			$.ajax({
				data : {
					reportreason : reportreason,
					type : type,
					reportedid : reportedid,
					reportedUserId : reportedUserId
				},
				type : "post",
				url : "${ctx}/report_submit.action",
				async : false,
				success : function(data) {
					if (data == 0) {
						alert("举报失败，请稍后重试！");
					} else {
						alert("举报成功！");
						$("#closeButton").click();
					}
				}
			});
		}
	</SCRIPT>
</body>
</html>