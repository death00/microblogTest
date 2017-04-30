/**
 * 页面搜索为空检查
 */
$(function(){
	$("#search_form2").submit(function(){
		if($("#search_text").val().trim().length==0){
			return false;
		}
	});
});
