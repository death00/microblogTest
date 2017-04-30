/**
 * 网页加载完成，动画结束
 */
$(window).load(function() {
	// Remove preloader
	$('body').addClass('loaded');
});

/**
 * 登录、注册的检查和提示
 */
$(document).ready(function(){

	//tooltip设置手动化显示
	$(".form-control").tooltip({trigger:'manual'});
	//focus后tooltip销毁
	$(".form-control").focus(function(){
		$(".form-control").tooltip("destroy");
	});
	//可能由于tooltip默认由focus等事件触发，所以改成手动触发之后，需要focus，完成触发方式的改变。
	$("#name_login").focus();
	var userExist = 0; 
	var verifyMis = 0;
	/*var emailExsit = 0;*/
	
	//验证码验证
	$("#verifyCode").blur(function(){
		var code = $("#verifyCode").val();
		if(code.trim().length==0)return;
		$.get("getVerifyCode",function(data){
			if(data!=code){	
				$("#verifyCode").tooltip({title:'验证码错误'}).tooltip('show');
				verifyMis = 1;
				$("#verifyPic").attr("src","img?"+Math.random());
			}
		});
	});
	$("#verifyCode").focus(function(){
		$("#verifyCode").tooltip('destroy');
		verifyMis = 0;
	});
	
	//登录验证
	$("#form1").submit(function(){
		var name = $("#name_login").val();
		var patt = /[a-zA-Z0-9\u4e00-\u9fa5]{2,10}/;
		if(!patt.test(name)){
			$("#name_login").tooltip({title:'用户名格式错误'}).tooltip('show');
			return false;
		}
		var passwd = $("#password_login").val();
		patt = /\w{6,12}/;
		if(!patt.test(passwd)){
			$("#password_login").tooltip('show');
			return false;
		}

		var verifyCode = $("#verifyCode").val();
		if(verifyCode.trim().length==0){
			$("#verifyCode").tooltip({title:'验证码不能为空'}).tooltip('show');
			return false;
		}
		else{
			if(verifyMis==1){
				return false;
			}
		}
		var flag = true;
		$.ajax({
			data:{name:name,password:passwd},
			type:"get",
			url:"user_loginCheck.action",
			async:false,
			success:function(data){
				if(data==0){	
					$("#name_login").tooltip({title:'用户名或密码错误'}).tooltip('show');
					flag = false;
				}
				if(data==2){	
					$("#name_login").tooltip({title:'账号已被封，无法登陆'}).tooltip('show');
					flag = false;
				}
				if(data==3){	
					$("#name_login").tooltip({title:'账号未激活，无法登陆'}).tooltip('show');
					flag = false;
				}
			}
		});
		return flag;
	});
	
	//用户存在验证
	$("#name_reg").blur(function(){
		var name = $("#name_reg").val();
		if(name.trim().length==0)return;
		$("#name_reg").popover({trigger:'manual'}).popover({placement:'right'});
		$.get("user_isExist.action",{name:name},function(data){
			if(data==0){	
				$("#name_reg").popover('show');
				userExist = 1;
			}
		});
	});
	$("#name_reg").focus(function(){
		//弹出提示隐藏
		$("#name_reg").popover('destroy');
		userExist = 0;
	});
	
	//邮箱存在验证
	$("#email").blur(function(){
		var email = $("#email").val();
		if(email.trim().length==0)return;
		$("#email").popover({trigger:'manual'}).popover({placement:'right'});
		$.get("user_emailCheck.action",{email:email},function(data){
			if(data==1){	
				$("#email").popover('show');
				emailExist = 1;
			}
		});
	});
	$("#email").focus(function(){
		//弹出提示隐藏
		$("#email").popover('destroy');
		emailExist = 0;
	});
	
	//注册验证
	$("#form2").submit(function(){
		var name = $("#name_reg").val();
		var patt = /[a-zA-Z0-9\u4e00-\u9fa5]{2,10}/;
		if(!patt.test(name)){
			$("#name_reg").tooltip({title:'用户名格式错误'}).tooltip('show');
			return false;
		}
		else{
			if(userExist==1){
				return false;
			}
		}
		patt = /[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?/;
		var email = $("#email").val();
   		if(!patt.test(email)){ 
   			$("#email").tooltip({title:'邮箱格式错误'}).tooltip('show');
   			return false;
    	}
    	else{
    		if(emailExist==1){
				return false;
			}
    	}
		var passwd = $("#password_reg").val();
		patt = /\w{6,12}/;
		if(!patt.test(passwd)){
			$("#password_reg").tooltip('show');
			return false;
		}
		var passConfirm = $("#password_conf").val();
		if(passConfirm!=passwd){
			$("#password_conf").tooltip('show');
			return false;
		}
		
	});
});
