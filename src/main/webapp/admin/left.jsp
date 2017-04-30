<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>菜单栏</title>
</head>
<body style="
    margin-top: -50px;
">
	<div class="col-sm-2 col-lg-2">
		<div class="">
			<div class="nav-canvas">
				<div class="nav-sm nav nav-stacked"></div>
				<ul class="nav nav-pills nav-stacked main-menu">
					<li class="nav-header">菜单</li>

					<li><a class="ajax-link" href="${ctx }/admin_home.action" target="main"><i
							class="glyphicon glyphicon-home"></i><span> 首页</span></a></li>
					<%-- <li><a class="ajax-link" href="${ctx }/admin_mainInfo.action" target="main"><i
							class="glyphicon glyphicon-star"></i><span> 主要信息</span></a></li> --%>
					<%--超级管理员才能添加管理员 --%>
					<c:if test="${sessionScope.Admin.state == 1}">
						<li><a class="ajax-link"
							href="${ctx }/admin_showAddAdmin.action" target="main"><i
								class="glyphicon glyphicon-plus"></i><span> 添加人员</span></a></li>
					</c:if>
					<li class="accordion"><a href="#"><i
							class="glyphicon glyphicon-eye-open"></i><span> 用户举报</span></a>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="${ctx }/admin_showUserReport.action" target="main">待处理</a></li>
							<li><a href="${ctx }/admin_showUserReportPass.action" target="main">已通过</a></li>
							<li><a href="${ctx }/admin_showUserReportUnpass.action" target="main">未通过</a></li>
						</ul></li>
					<li class="accordion"><a href="#"><i
							class="glyphicon glyphicon-edit"></i><span> 微博举报</span></a>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="${ctx }/admin_showMicroblogReport.action" target="main">待处理</a></li>
							<li><a href="${ctx }/admin_showMicroblogReportPass.action" target="main">已通过</a></li>
							<li><a href="${ctx }/admin_showMicroblogReportUnpass.action" target="main">未通过</a></li>
						</ul></li>
					<li class="accordion"><a href="#"><i
							class="glyphicon glyphicon-list-alt"></i><span> 评论举报</span></a>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="${ctx }/admin_showRemarkReport.action" target="main">待处理</a></li>
							<li><a href="${ctx }/admin_showRemarkReportPass.action" target="main">已通过</a></li>
							<li><a href="${ctx }/admin_showRemarkReportUnpass.action" target="main">未通过</a></li>
						</ul></li>
					<%--超级管理员才能进行用户分析 --%>
					<c:if test="${sessionScope.Admin.state == 1}">
					<li><a class="ajax-link" href="${ctx }/admin_analysisUser.action" target="main"><i
							class="glyphicon glyphicon-font"></i><span> 用户分析</span></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>