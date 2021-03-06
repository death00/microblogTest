<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>用户举报未处理</title>
</head>
<body style="margin-top: 20px;">
	<div id="content" class="col-lg-10 col-sm-10">
		<div class="row">
			<div class="box col-md-12">
				<div class="box-inner">
					<div class="box-content">
						<div class="alert alert-info">用户举报未处理记录</div>
						<table
							class="table table-striped table-bordered bootstrap-datatable datatable responsive">
							<thead>
								<tr>
									<th>序号</th>
									<th>被举报者</th>
									<th>举报理由</th>
									<th>举报者</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="report" items="${reports}" varStatus="index">
									<tr>
										<td>${index.count}</td>
										<td class="center">
											<a href="${ctx}/admin_userScan.action?id=${report.reportedUser.id}" target="_blank" style="text-decoration: none;" >
												${report.reportedUser.name }
											</a>		
										</td>
										<td class="center">${report.reportreason }</td>
										<td class="center">
											<a href="${ctx}/admin_userScan.action?id=${report.reporterUser.id}" target="_blank" style="text-decoration: none;" >
												${report.reporterUser.name }</td>
											</a>
										<td class="center">
											<a class="btn btn-success" href="${ctx }/report_userPass.action?id=${report.id}">通过</a> 
											<a class="btn btn-danger" href="${ctx }/report_userUnpass.action?id=${report.id}"> 拒绝</a>
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