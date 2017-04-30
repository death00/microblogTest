<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>头部</title>
</head>
<body>
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">
		<div class="navbar-inner">
			<!-- user dropdown starts -->
			<div class="btn-group pull-right">
					<button type="button" class="btn btn-default" onclick="logout()">
						退出
					</button>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function logout(){
			window.parent.location.href='${ctx }/admin_logout.action';
		}
	</script>
</body>
</html>