<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>添加管理员</title>
</head>
<body style="margin-top: 20px;">
	<div id="content" class="col-lg-10 col-sm-10">
		<!-- content starts -->
		<div class=" row">
			<div class="col-md-3 col-sm-3 col-xs-6">
				<div class="box-inner">
					<div class="box-content">
						<form role="form">
							<div class="form-group">
								<label for="exampleInputEmail1">用户名</label> <input
									type="email" class="form-control" id="name"
									placeholder="输入用户名">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">密码</label> <input
									type="password" class="form-control" id="password"
									placeholder="Password">
							</div>
							<button type="button" class="btn btn-default" onclick="checkAddAdmin()">提交</button>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>