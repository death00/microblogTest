<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ include file="/include/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>管理员登陆</title>
</head>
<body>
<div class="ch-container">
    <div class="row">
        
    <div class="row">
        <div class="col-md-12 center login-header">
            <h2>管理员登陆</h2>
        </div>
        <!--/span-->
    </div><!--/row-->

    <div class="row">
        <div class="well col-md-5 center login-box">
            <div class="alert alert-info">
                	请输入用户名和密码
            </div>
            <form class="form-horizontal" id="loginForm" action="${ctx}/admin_showAll.action" method="post">
                <fieldset>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user red"></i></span>
                        <input id="name" name="name" type="text" class="form-control" placeholder="用户名">
                    </div>
                    <div class="clearfix"></div><br>

                    <div class="input-group input-group-lg">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock red"></i></span>
                        <input id="password" name="password" type="password" class="form-control" placeholder="密码">
                    </div>
                    <div class="clearfix"></div>

                    <div class="input-prepend">
                        <label class="remember" for="remember"><input type="checkbox" id="remember"> 记住我</label>
                    </div>
                    <div class="clearfix"></div>

                    <p class="center col-md-5">
                        <button type="button" class="btn btn-primary" onclick="login()">登陆</button>
                    </p>
                </fieldset>
            </form>
        </div>
        <!--/span-->
    </div><!--/row-->
</div><!--/fluid-row-->

</div><!--/.fluid-container-->

<SCRIPT type="text/javascript">
	function login(){
		var name = $("#name").val();
		var password = $("#password").val();
		$.ajax({
			type: 'post',
			url: '${ctx}/admin_loginCheck.action',
			async:false,
			data : {
				name : name,
				password : password
			},
			dataType: 'json',
			success : function(data) {
				if (data == 0) {
					$("#name").tooltip({title:'用户名或密码错误'}).tooltip('show');
				}else{
					$("#loginForm").submit();
				}
			}
		});
	}
</SCRIPT>

</body>
</html>