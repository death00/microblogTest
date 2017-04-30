/**
 * 发布为空检查
 */
$(function(){
	$("#publish_form").submit(function(){
		if($("#publish_input").val().trim().length==0){
			return false;
		}
	});
});
