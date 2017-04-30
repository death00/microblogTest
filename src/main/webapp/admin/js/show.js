function showMicroblog(id){
	$(".modal-body").load(
	    "report_showMicroblog.action",
		{id:id},
	    function(){
			$("#myModal").modal();
	});
}

function showRemark(id){
	$(".modal-body").load(
	    "report_showRemark.action",
		{id:id},
	    function(){
			$("#myModal").modal();
	});
}

function showUserScan(id){
	var ctx = $("#ctx").val();
	window.open(ctx + "/admin_userScan.action?id="+id);
}

function checkAddAdmin(){
	var name = $("#name").val();
	var password = $("#password").val();
	if(name.trim().length == 0){
		alert("用户名不能为空！");
		return;
	}
	if(password.trim().length == 0){
		alert("密码不能为空！");
		return;
	}
	var ctx = $("#ctx").val();
	$.ajax({
		type: 'post',
		url: ctx + '/admin_addAdminCheck.action',
		async:false,
		data : {
			name : name,
			password : password
		},
		dataType: 'json',
		success : function(data) {
			if (data == 0) {
				alert("用户名重复，添加不成功！");
			}else{
				alert("管理员添加成功！");
			}
		}
	});
}