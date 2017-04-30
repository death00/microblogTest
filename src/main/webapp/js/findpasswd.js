/**
 * 找回密码的用户检查
 */
$(document).ready(function(){
	//tooltip设置手动化显示
	$(".form-control").tooltip({trigger:'manual'});
	//focus后tooltip销毁
	$(".form-control").focus(function(){
		$(".form-control").tooltip("destroy");
	});
	$("#name_login").focus();
	
	$("#form3").submit(function(){
		var name = $("#name").val();
		var patt = /[a-zA-Z0-9\u4e00-\u9fa5]{2,10}/;
		if(!patt.test(name)){
			$("#name").tooltip({title:'用户名格式错误'}).tooltip('show');
			return false;
		}
		patt = /[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?/;
		var email = $("#email").val();
	   		if(!patt.test(email)){ 
	   		$("#email").tooltip('show');
	   		return false;
	    }
	   	var flag = true;
		$.ajax({
			data:{name:name,email:email},
			type:"get",
			url:"user_isFindPassword.action",
			async:false,
			success:function(data){
				if(data==0){	
					$("#name").tooltip({title:'用户名或邮箱错误'}).tooltip('show');
					flag = false;
				}
			}
		});
		return flag;
	});
});