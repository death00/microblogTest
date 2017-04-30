<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>主要内容</title>
</head>
<body style="
    margin-top: 20px;
">
	<div id="content" class="col-lg-10 col-sm-10">
		<!-- content starts -->
		<div class=" row">
			<div class="col-md-3 col-sm-3 col-xs-6">
				<a data-toggle="tooltip" class="well top-block" href="${ctx }/admin_showUserReport.action" target="main"> <i
					class="glyphicon glyphicon-user blue"></i>

					<div>用户举报</div>
					<div>未处理</div>
				</a>
			</div>

			<div class="col-md-3 col-sm-3 col-xs-6">
				<a data-toggle="tooltip" class="well top-block" href="${ctx }/admin_showMicroblogReport.action" target="main"> <i
					class="glyphicon glyphicon-star green"></i>

					<div>微博举报</div>
					<div>未处理</div>
				</a>
			</div>

			<div class="col-md-3 col-sm-3 col-xs-6">
				<a data-toggle="tooltip" class="well top-block" href="${ctx }/admin_showRemarkReport.action" target="main"> <i
					class="glyphicon glyphicon-envelope red"></i>

					<div>评论举报</div>
					<div>未处理</div>

				</a>
			</div>
		</div>
	</div>
</body>
</html>