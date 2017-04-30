<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html >
<html>
<head>
<title>搜索结果</title>
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
	<script src="js/search_result.js"></script>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
  		<div class="container">
    		<div class="navbar-header">
      			<a class="navbar-brand" href="#">
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
	
	<div class="container" style="margin-top:100px">
		<div class="row" style="margin-bottom:20px;">
			<div class="col-md-8">
			<form action="user_search.action" id="search_form2"  method="post" role="search">
  				<div class="input-group">
    				<input type="text" name="value" class="form-control" 
    				id="search_text" value="${value}" placeholder="Search" />
 					<button class="btn btn-info" id="search_button" type="submit">
 						<span id="text">搜索</span>
 					</button>
      			
      			</div>
      		</form>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8">
				<c:choose>
				<c:when test="${result == null}">
					<div class="panel panel-primary">
		  				<div class="panel-heading">查询结果</div>
		  				<div class="panel-body">无相关用户或内容</div>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${result}" var="map">
						<c:choose>
						<c:when test="${map.key.equals('users')}">
							<c:choose>
								<c:when test="${map.value == null}">
									<div class="panel panel-primary">
										<div class="panel-heading">用户查询结果</div>
										<div class="panel-body">无相关用户</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="panel panel-primary">
									<div class="panel-heading">用户查询结果</div>
					  				<div class="panel-body">
					  					共${map.value.size()}位相关用户
									    <div class="list-group">
											<c:forEach items="${map.value}" var="user">
									    		<div class="list-group-item blog"	>
													<a href="user_scan.action?id=${user.id}">${user.name}</a>
													<c:if test="${user.id != sessionScope.User.id}">
														<c:choose>
											   			<c:when test="${followList.contains(user.id)}">
											   				<button class="btn btn-info" id="cf${user.id }" onclick="changeFollowers('${user.id}')" >取消关注</button>
											   			</c:when>
											   			<c:otherwise>
											   				<button class="btn btn-info fc" id="cf${user.id }" onclick="changeFollowers('${user.id}')">关注</button>
											   			</c:otherwise>
														</c:choose>
													</c:if>
													<br />
					              	 				关注：${user.follows }&nbsp;&nbsp;|&nbsp;&nbsp;
													粉丝：<span id="followers${user.id}">${user.followers }</span>&nbsp;&nbsp;|&nbsp;&nbsp;
													微博：${user.microblogs }
												</div>
					            			</c:forEach>
					            		</div>
					            	</div>
					            	</div>
				            </c:otherwise>
					    	</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${map.value == null}">
									<div class="panel panel-primary">
										<div class="panel-heading">微博查询结果</div>
										<div class="panel-body">无相关微博</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="panel panel-primary">
										<div class="panel-heading">微博查询结果</div>
						  					<div class="panel-body">
						  					共${map.value.size()}条相关微博			           		
							           	</div>
						          	</div>
						          	
						          	<c:forEach items="${map.value}" var="m">
				<div class="list-group blog_content">
					<div class="list-group-item blog">
					<c:choose>
						<c:when test="${sessionScope.User.id == m.userid && !m.isForward}">
							<a href="user_scan.action?id=${sessionScope.User.id}">${sessionScope.User.name}</a><br/>
							<span class="time">${m.getNTime()}</span><br/>
							${m.content}
								</div>
							<div class="list-group-item self_operation">
								<a href="microblog_delete.action?id=${m.id}" ><span class="glyphicon glyphicon-trash"></span></a>|
						</c:when>
					   	<c:otherwise>
					   		<c:choose>
						   		<c:when test="${sessionScope.User.id == m.userid}">
						   			<a href="user_scan.action?id=${sessionScope.User.id}">${sessionScope.User.name}</a>
						   			<br/><span class="time">${m.getNTime()}</span>
						   			<br/>${m.forwardRemark }
						   			<span class="rf"><c:forEach items="${m.forwardRemarks}" var="r">
						   				<a href="user_scan.action?id=${r.userId}">//@${r.userName}</a>
						   			    :${r.remark }
						   			</c:forEach>
						   			</span>
						   			<div class="list-group-item original">
						   				<a href="user_scan.action?id=${m.sourceUser.id}">@${m.sourceUser.name}</a>
						   				<br/>${m.content}
						   	 		</div>
									</div>
									<div class="list-group-item self_operation">
										<a href="microblog_delete.action?id=${m.id}"><span class="glyphicon glyphicon-trash"></span></a>|
								</c:when>
						
						   	 	<c:otherwise>
						   	 		<a href="user_scan.action?id=${m.user.id}">${m.user.name}</a><br />
						   	 		<c:choose>
							   	 		<c:when test="${m.forwardRemark == null || m.forwardRemark.equals('')}">
							   	 			<span class="time">${m.getNTime()}</span><br/>
							   	 			${m.content}
											</div>
											<div class="list-group-item follower_operation">
							   	 		</c:when>
							   	 		
							   	 		<c:otherwise>
							   	 		<span class="time">${m.getNTime()}</span><br/>
							   	 			${m.forwardRemark }
								   			<span class="rf"><c:forEach items="${m.forwardRemarks}" var="r">
								   				<a href="user_scan.action?id=${r.userId}">//@${r.userName }</a>
								   			   :${r.remark }
								   			</c:forEach>
								   			</span>
								   			<div class="list-group-item original">
								   				<a href="user_scan.action?id=${m.sourceUser.id}">@${m.sourceUser.name }</a>
								   				<br/>${m.content}
											</div>
											</div>
							<div class="list-group-item follower_operation">
							   	 		</c:otherwise>
							   	 	</c:choose>
						   	 	</c:otherwise>
						   	 </c:choose>
						</c:otherwise>
					</c:choose>	
					<a href="javascript:toggleRemark(${m.id})">
						<span class="glyphicon glyphicon-comment"></span>&nbsp;<span id="remarkSize${m.id }">${m.getRemarks().size()}</span>
					</a>|
					<a href="javascript:showForward(${m.id },${m.sourceMicroblogId==0?m.id:m.sourceMicroblogId })" >
						<span class="glyphicon glyphicon-share"></span>&nbsp;<span id="forwardSize${m.id}">${m.getForwards()}</span>
					</a>
					</div>
				</div>
				<div  class="container">
					<div class="row">
						<div class="col-md-8 remark_show">
						<input type="hidden" id="h${m.id }" value="0">
						<div class="well collapse" id="${m.id }">
							
						</div>	
						</div>
					</div>
				</div>
			</c:forEach>
					            </c:otherwise>
					    	</c:choose>
						</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="modal fade" id="forwardModal" tabindex="-1" role="dialog" aria-labelledby="forwordModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="forwordModalLabel">转发微博</h4>
      </div>
      <div class="modal-body">
      </div>
    </div>
  </div>
</div>

</body>
</html>