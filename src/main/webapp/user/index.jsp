<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>主页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script src="../ot/jquery-2.0.0.min.js"></script>
<script src="../ot/bootstrap.min.js"></script>
<link href="../ot/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/m_index.css" rel="stylesheet">
<script src="js/m_index.js"></script>
<script src="js/publish_check.js"></script>
</head>
<body>

	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="javascript:void(0)"> <img
					alt="Brand" src="img/logo.png" style="width: 35px"></a>
			</div>
			<span id="logo"><i>weibo</i></span>
			<form class="navbar-form navbar-left" id="search_form"
				action="user_search.action" method="post" role="search">
				<div class="input-group">
					<input type="text" name="value" id="search_input"
						class="form-control" style="width: 420px;" placeholder="Search"><span
						class="input-group-btn">
						<button class="btn btn-info" type="submit">
							<span class="glyphicon glyphicon-search" style="color: white;"></span>
						</button>
					</span>
				</div>
			</form>
			<div id="slink">
				<a href="microblog_showAll.action"> <span
					class="glyphicon glyphicon-home"></span> <span>主页</span>
				</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a
					href="user_scan.action?id=${sessionScope.User.id}"> <span
					class="glyphicon glyphicon-user"></span> <span>${sessionScope.User.name}</span>
				</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a href="user_logout.action">
					<span class="glyphicon glyphicon-log-out"></span> <span>注销</span>
				</a>
			</div>
		</div>
	</nav>
	<div class="container" style="margin-top: 80px">
		<c:choose>
			<c:when test="${sessionScope.User.state != 2}">
				<div class="row">
					<div class="col-md-8">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">有什么新鲜事可以分享？</h3>
							</div>
							<div class="panel-body">
								<form action="microblog_publish.action" id="publish_form"
									method="post">
									<div class="form-group">
										<textarea class="form-control" id="publish_input" rows="5"
											name="content"></textarea>
									</div>
									<input type="hidden" name="userId"
										value="${sessionScope.User.id}" />
									<%-- <input type="hidden" name="sourceUserId" value="${sessionScope.User.id}" />
									<input type="hidden" name="sourceUserName" value="${sessionScope.User.name}" /> --%>
									<div class="form-group">
										<input type="submit" id="publish_button" class="btn btn-info"
											value="发布" />
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<div class="col-md-8">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">账号已被禁止发微博！</h3>
							</div>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="row">
			<div class="col-md-8 ">
				<c:if test="${Microblogs.size()==0 }">
					<div class="panel panel-primary">
						<div class="panel-heading">提示信息</div>
						<div class="panel-body">
							还没有微博，可以发表或关注他人<br />
						</div>
					</div>
				</c:if>
				<c:forEach items="${Microblogs}" var="m">
					<div class="list-group blog_content">
						<div class="list-group-item blog">
							<c:choose>
								<%-- 原创微博 --%>
								<c:when
									test="${sessionScope.User.id == m.userid && !m.isForward}">
									<a href="user_scan.action?id=${m.user.id}">${m.user.name}</a>
									<br />
									<span class="time">${m.getNTime()}</span>
									<br />
							${m.content}
								
						
						
						
						</div>
						<div class="list-group-item self_operation">
							<a href="${ctx }/user/microblog_delete.action?id=${m.id}"><span
								class="glyphicon glyphicon-trash"></span></a>|
							</c:when>
							<c:otherwise>
								<c:choose>
									<%-- 自己转发的微博 --%>
									<c:when test="${sessionScope.User.id == m.userid}">
										<a href="user_scan.action?id=${sessionScope.User.id}">${sessionScope.User.name}</a>
										<br />
										<span class="time">${m.getNTime()}</span>
										<br />${m.forwardRemark }
						   			<span class="rf"><c:forEach
												items="${m.forwardRemarks}" var="r">
												<a href="user_scan.action?id=${r.userId}">//@${r.userName}</a>
						   			    :${r.remark }
						   			</c:forEach> </span>
										<div class="list-group-item original">
											<a href="user_scan.action?id=${m.sourceMicroblog.user.id}">@${m.sourceMicroblog.user.name}</a>
											<br />${m.content}
										</div>
						</div>
						<div class="list-group-item self_operation">
							<a href="microblog_delete.action?id=${m.id}"><span
								class="glyphicon glyphicon-trash"></span></a>|
							</c:when>
							<%-- 关注者发布的微博（包括原创和转发） --%>
							<c:otherwise>
								<div>
									<div style="float: left;">
										<a href="user_scan.action?id=${m.user.id}">${m.user.name}</a>
									</div>
									<div style="float: right;">
										<a href="javascript:showReport(${m.id },2,${m.userid })"><span
											class="time">举报</span></a>
									</div>
								</div>

								<br />
								<c:choose>
									<c:when
										test="${m.forwardRemark == null || m.forwardRemark.equals('')}">
										<span class="time">${m.getNTime()}</span>
										<br />
							   	 			${m.content}
						</div>
						<div class="list-group-item follower_operation">
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
						</div>
						<div class="list-group-item follower_operation">
							</c:otherwise>
							</c:choose>
							</c:otherwise>
							</c:choose>
							</c:otherwise>
							</c:choose>
							<a href="javascript:toggleRemark(${m.id})"> <span
								class="glyphicon glyphicon-comment"></span>&nbsp;<span
								id="remarkSize${m.id }">${m.getRemarks().size()}</span>
							</a>| <a
								href="javascript:showForward(${m.id },${m.sourceMicroblogId==0?m.id:m.sourceMicroblogId })">
								<span class="glyphicon glyphicon-share"></span>&nbsp;<span
								id="forwardSize${m.id}">${m.getForwards()}</span>
							</a>
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
	<div class="modal fade" id="forwardModal" tabindex="-1" role="dialog"
		aria-labelledby="forwordModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="forwordModalLabel">转发微博</h4>
				</div>
				<div class="modal-body1"></div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="reportModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true" id="closeButton">&times;</span>
					</button>
					<h4 class="modal-title" id="reportModalLabel">举报</h4>
				</div>
				<div class="modal-body2"></div>
			</div>
		</div>
	</div>
</body>
</html>