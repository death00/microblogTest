<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html >
<html>
<head>
<title>微博详情</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
	<script src="../ot/jquery-2.0.0.min.js"></script>
	<script src="../ot/bootstrap.min.js"></script>  
	<link href="../ot/bootstrap.min.css" rel="stylesheet" media="screen" >

 	<script src="js/m_index.js" ></script> 
 	<link href="css/m_index.css" rel="stylesheet" >
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top" >
  		<div class="container">
    		<div class="navbar-header">
      			<a class="navbar-brand" href="javascript:void(0)">
        			<img alt="Brand" src="img/logo.png" style="width:35px">
      			</a>
    		</div>
    		<span id="logo"><i>weibo</i></span>
    		<form class="navbar-form navbar-left" id="search_form" action="user_search.action" method="post" role="search">
  				<div class="input-group">
    				<input type="text" name="value" id="search_input" class="form-control" style="width:420px;"placeholder="Search">
    				<span class="input-group-btn">
        				<button class="btn btn-info" type="submit"><span class="glyphicon glyphicon-search" style="color: white;"></span></button>
      				</span>
      			</div>
      		</form>
    		<div id="slink">
		    	<a href="microblog_showAll.action">
		    		<span class="glyphicon glyphicon-home" ></span>
		    		<span>主页</span>
		    	</a>
		    	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		    	<a href="user_scan.action?id=${sessionScope.User.id}">
		    		<span class="glyphicon glyphicon-user" ></span>
		    		<span>${sessionScope.User.name}</span>
		    	</a>
		    	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		    	<a href="user_logout.action">
		    		<span class="glyphicon glyphicon-log-out" ></span>
		    		<span>注销</span>
		    	</a>
    		</div>
  		</div>
	</nav>

	<div class="container" style="margin-top:80px">
		<div class="row">
			<div class="col-md-8">
				<div class="list-group blog_content">
					<div class="list-group-item blog">
					<c:choose>
						<c:when test="${sessionScope.User.id == microblog.userid && !microblog.isForward}">
							<a href="user_scan.action?id=${microblog.sourceMicroblog.user.id}">${microblog.sourceMicroblog.user.name}</a><br/>
							<span class="time">${microblog.getNTime()}</span><br/>
							${microblog.content}
								</div>
							<div class="list-group-item self_operation">
								<a href="microblog_delete.action?id=${microblog.id}" ><span class="glyphicon glyphicon-trash"></span></a>|
						</c:when>
					   	<c:otherwise>
					   		<c:choose>
						   		<c:when test="${sessionScope.User.id == microblog.userid}">
						   			<a href="user_scan.action?id=${sessionScope.User.id}">${sessionScope.User.name}</a>
						   			<br/><span class="time">${microblog.getNTime()}</span>
						   			<br/>${microblog.forwardRemark }
						   			<span class="rf"><c:forEach items="${microblog.forwardRemarks}" var="r">
						   				<a href="user_scan.action?id=${r.userId}">//@${r.userName}</a>
						   			    :${r.remark }
						   			</c:forEach>
						   			</span>
						   			<div class="list-group-item original">
						   				<a href="user_scan.action?id=${microblog.sourceMicroblog.user.id}">@${microblog.sourceMicroblog.user.name}</a>
						   				<br/>${microblog.content}
						   	 		</div>
									</div>
									<div class="list-group-item self_operation">
										<a href="microblog_delete.action?id=${microblog.id}"><span class="glyphicon glyphicon-trash"></span></a>|
								</c:when>
						
						   	 	<c:otherwise>
						   	 		<a href="user_scan.action?id=${microblog.user.id}">${microblog.user.name}</a><br />
						   	 		<c:choose>
							   	 		<c:when test="${microblog.forwardRemark == null || microblog.forwardRemark.equals('')}">
							   	 			<span class="time">${microblog.getNTime()}</span><br/>
							   	 			${microblog.content}
											</div>
											<div class="list-group-item follower_operation">
							   	 		</c:when>
							   	 		
							   	 		<c:otherwise>
							   	 		<span class="time">${microblog.getNTime()}</span><br/>
							   	 			${microblog.forwardRemark }
								   			<span class="rf"><c:forEach items="${microblog.forwardRemarks}" var="r">
								   				<a href="user_scan.action?id=${r.userId}">//@${r.userName }</a>
								   			   :${r.remark }
								   			</c:forEach>
								   			</span>
								   			<div class="list-group-item original">
								   				<a href="user_scan.action?id=${microblog.user.id}">@${microblog.user.name }</a>
								   				<br/>${microblog.content}
											</div>
											</div>
							<div class="list-group-item follower_operation">
							   	 		</c:otherwise>
							   	 	</c:choose>
						   	 	</c:otherwise>
						   	 </c:choose>
						</c:otherwise>
					</c:choose>	
					<a href="javascript:remarkMore(${microblog.id})">
						<span class="glyphicon glyphicon-comment"></span>&nbsp;<span id="remarkSize${microblog.id }">${microblog.getRemarks().size()}</span>
					</a>|
					<a href="javascript:forwardMore(${microblog.id },${microblog.sourceMicroblogId==0?microblog.id:microblog.sourceMicroblogId })" >
						<span class="glyphicon glyphicon-share"></span>&nbsp;<span id="forwardSize${microblog.id}">${microblog.getForwards()}</span>
					</a>
					</div>
				</div>
				<c:choose>
					<c:when test="${partSelect==0}">
						<script>
							remarkMore('${microblog.id}');
						</script>
					</c:when>
					<c:otherwise>
						<script>
							forwardMore('${microblog.id }','${microblog.sourceMicroblogId==0?microblog.id:microblog.sourceMicroblogId }');
						</script>
					</c:otherwise>
				</c:choose>
				<div  class="container">
					<div class="row">
						<div class="col-md-8 remark_show">
						<div class="well" id="rorf">
							
						</div>	
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>