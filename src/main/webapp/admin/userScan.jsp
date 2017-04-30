<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>用户详情</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script src="${ctx }/ot/jquery-2.0.0.min.js"></script>
<script src="${ctx }/ot/bootstrap.min.js"></script>
<link href="${ctx }/ot/bootstrap.min.css" rel="stylesheet"
	media="screen">
<link href="${ctx }/user/css/m_index.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="javascript:void(0)"> <img
					alt="Brand" src="${ctx }/user/img/logo.png" style="width: 35px"></a>
			</div>
			<span id="logo"><i>weibo</i></span>
		</div>
	</nav>
	<div class="container" style="margin-top: 80px">
		<div class="row">
			<div class="col-md-8 user_info">
				<img src="${ctx }/user/img/user_avatar.png" style="width: 100px;" /><br />
				<br /> ${UserScan.name } <br />
				关注：${Follows}&nbsp;&nbsp;|&nbsp;&nbsp; 粉丝：<span
					id="followers${UserScan.id}">${Followers }</span>&nbsp;&nbsp;|&nbsp;&nbsp;
				微博：${Microblogs.size() }<br />
			</div>
		</div>
		<div class="row">
			<div class="col-md-8">
				<c:if test="${Microblogs.size()==0 }">
					<div class="panel panel-primary">
						<div class="panel-heading">提示信息</div>
						<div class="panel-body">
							此用户暂未发表微博 <br />
						</div>
					</div>
				</c:if>
				<c:forEach items="${Microblogs}" var="m">
					<div class="list-group blog_content">
						<div class="list-group-item blog">
							<div>
								<div style="float: left;">
									<a href="${ctx}/admin_userScan.action?id=${m.user.id}">${m.user.name}</a>
								</div>
							</div>
							<br />
							<c:choose>
								<c:when test="${m.forwardRemark == null || m.forwardRemark.equals('')}">
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
											<a href="${ctx}/admin_userScan.action?id=${r.userId}">//@${r.userName }</a>
										   			   :${r.remark }
										   			</c:forEach> </span>
									<div class="list-group-item original">
										<a href="${ctx}/admin_userScan.action?id=${m.sourceMicroblog.user.id}">@${m.sourceMicroblog.user.name }</a>
										<br />${m.content}
									</div>
								</c:otherwise>
							</c:choose>
							<div class="list-group-item follower_operation">
								<span class="glyphicon glyphicon-comment"></span>&nbsp;<span
									id="remarkSize${m.id }">${m.getRemarks().size()}</span>
								|
								<span class="glyphicon glyphicon-share"></span>&nbsp;<span
									id="forwardSize${m.id}">${m.getForwards()}</span>
							</div>
						</div>
					</div>
					<div class="container">
						<div class="row">
							<div class="col-md-8 remark_show">
								<input type="hidden" id="h${m.id }" value="0">
								<div class="well collapse" id="${m.id }"></div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>