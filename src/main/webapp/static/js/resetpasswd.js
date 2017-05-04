/**
 * 重置密码检查
 */
$(document).ready(function(){
	$("#form4").submit(function(){
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