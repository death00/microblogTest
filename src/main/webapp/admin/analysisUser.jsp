<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>用户分析</title>
</head>
<body style="margin-top: 20px;">
	<div id="content" class="col-lg-10 col-sm-10">
		<div class="row">
			<div class="box col-md-12">
				<div class="box-inner">
					<div class="box-content">
						<div class="alert alert-info">用户被举报统计</div>
						<table
							class="table table-striped table-bordered bootstrap-datatable datatable responsive">
							<thead>
								<tr>
									<th>序号</th>
									<th>被举报者</th>
									<th>举报次数</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="user" items="${users}" varStatus="index">
									<tr>
										<td>${index.count}</td>
										<td class="center">
											<a href="${ctx}/admin_userScan.action?id=${user.id}" target="_blank" style="text-decoration: none;" >
												${user.name }
											</a>		
										</td>
										<td class="center">${user.reportCount }</td>
										<td class="center">
											<c:choose>
												<c:when test="${user.state == 1}">
													<a class="btn btn-success" href="${ctx }/admin_editUserState.action?id=${user.id}&state=2">禁止发微博</a> 
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${user.state == 2}">
															<a class="btn btn-success" href="${ctx }/admin_editUserState.action?id=${user.id}&state=1">允许发微博</a> 
															<a class="btn btn-danger" href="${ctx }/admin_editUserState.action?id=${user.id}&state=3"> 禁止登陆</a>
														</c:when>
														<c:otherwise>
															<a class="btn btn-danger" href="${ctx }/admin_editUserState.action?id=${user.id}&state=2"> 允许登陆</a>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!--/span-->
		</div>
	</div>
</body>
</html>