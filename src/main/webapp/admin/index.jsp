<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>管理员首页</title>

</head>
<frameset rows="100,*" frameborder="0" border="0">
	<frame src="${ctx}/admin/head.jsp"  frameborder="0" border="0"/>
	<frameset cols="225,*"  frameborder="0" border="0" >
		<frame src="${ctx}/admin/left.jsp" name="leftFrame"
				noresize="noresize" marginwidth="0" marginheight="0" frameborder="0"
				border="0" scrolling="no" />
		<frame src="${ctx}/admin/right.jsp" name="main"  noresize="noresize" marginheight="0" marginwidth="0"  frameborder="0" border="0" scrolling="auto" style="overflow-x:hidden;overflow-y: auto;"/>
	</frameset>
</frameset>
<noframes>
<body >

</body>
</noframes>  
</html>
