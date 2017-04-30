/**
 * 导航栏搜索为空检查
 */
$(function(){
	$("#search_form").submit(function(){
		if($("#search_input").val().trim().length==0){
			return false;
		}
	});
});
/**
 * 关注与取消关注
 * @param {Object} id
 */
function changeFollowers(id){

	if($("#cf"+id).text()=="取消关注"){
		$.get("follow_remove.action",{userId:id},function(data){
			$("#followers"+id).text(data);
		});
		$("#cf"+id).text("关注");
	}
	else{
		$.get("follow_create.action",{userId:id},function(data){
			$("#followers"+id).text(data);
		});
		$("#cf"+id).text("取消关注");
	}
}
/**
 * 评论的加载、显示与隐藏
 * @param {} id
 */
function toggleRemark(id){
	if($("#h"+id).val()==0){
		$("#"+id).load("remark_showLess.action",{microblogid:id},function(){
			$("#"+id).collapse('show');
			$("#h"+id).val(1);
		});
	}
	else{
		$("#"+id).collapse('hide');
		$("#h"+id).val(0);
	}
}
/**
 * 新增评论
 * @param {} id
 */
function remarkCreate(id){
	var content = $("#remark_text"+id).val();
	if(content.trim().length==0) return;
	$("#"+id).load("remark_create.action",{content:content,microblogid:id},function(){
		$("#"+id).collapse('show');
		$("#h"+id).val(1);
		var old = $("#remarkSize"+id).text();
		$("#remarkSize"+id).text(parseInt(old)+1);
	});
}
/**
 * 删除评论
 * @param {} rid
 * @param {} rmid
 */
function remarkDelete(rid,rmid){
	$("#"+rmid).load("remark_delete.action",{id:rid,microblogid:rmid},function(){
		$("#"+rmid).collapse('show');
		$("#h"+rmid).val(1);
		var old = $("#remarkSize"+rmid).text();
		$("#remarkSize"+rmid).text(parseInt(old)-1);
	});
}

/**
 * 回复评论
 * @param {} rid
 * @param {} ruid
 * @param {} id
 */
function remarkReply(rid,ruid,id){
	var content = $("#reply_text"+rid).val();
	if(content.trim().length==0) return;
	$("#"+id).load("remark_reply.action",{replyId:ruid,content:content,microblogid:id},function(){
		$("#"+id).collapse('show');
		$("#h"+id).val(1);
		var old = $("#remarkSize"+id).text();
		$("#remarkSize"+id).text(parseInt(old)+1);
	});
}
/**
 * 显示回复框
 * @param {} id
 */
function toggleReply(id){
	if($("#replyh"+id).val()==0){
		$("#reply"+id).collapse('show');
		$("#replyh"+id).val(1);
	}
	else{
		$("#reply"+id).collapse('hide');
		$("#replyh"+id).val(0);
	}
}
/**
 * 显示转发
 * @param {} id
 * @param {} sid
 */
function showForward(id,sid){
	$(".modal-body1").load(
	    "microblog_showForward.action",
		{forwardMicroblogId:id,sourceMicroblogId:sid},
	    function(){
			$("#forwardModal").modal();
	});
}
/**
 * 显示转发列表里的转发
 * @param {} id
 */
function toggleForward(id){
	if($("#forwardh"+id).val()==0){
		$("#forward"+id).collapse('show');
		$("#forwardh"+id).val(1);
	}
	else{
		$("#forward"+id).collapse('hide');
		$("#forwardh"+id).val(0);
	}
}
/**
 * 详情界面切换到评论列表
 * @param {} id
 */
function remarkMore(id){
	$(function(){
		$("#rorf").load("remark_partMore.action",{microblogid:id});
	});
}
/**
 * 详情界面切换到转发列表
 * @param {} fid
 * @param {} sid
 */
function forwardMore(fid,sid){
	$(function(){
		$("#rorf").load("forward_partMore.action",{forwardMicroblogId:fid,sourceMicroblogId:sid});
	});
}
/**
 * 详情界面的新增评论
 * @param {} rid
 * @param {} ruid
 * @param {} id
 */
function remarkCreateMore(id){
	var content = $("#remark_text"+id).val();
	if(content.trim().length==0) return;
	$("#rorf").load("remark_createMore.action",{content:content,microblogid:id},function(){
		var old = $("#remarkSize"+id).text();
		$("#remarkSize"+id).text(parseInt(old)+1);
	});
}
/**
 * 详情界面的删除评论
 * @param {} rid
 * @param {} rmid
 */
function remarkDeleteMore(rid,rmid){
	$("#rorf").load("remark_deleteMore.action",{id:rid,microblogid:rmid},function(){
		var old = $("#remarkSize"+rmid).text();
		$("#remarkSize"+rmid).text(parseInt(old)-1);
	});
}

/**
 * 详情界面的回复评论
 * @param {} rid
 * @param {} ruid
 * @param {} id
 */
function remarkReplyMore(rid,ruid,id){
	var content = $("#reply_text"+rid).val();
	if(content.trim().length==0) return;
	$("#rorf").load("remark_replyMore.action",{replyId:ruid,content:content,microblogid:id},function(){
		var old = $("#remarkSize"+id).text();
		$("#remarkSize"+id).text(parseInt(old)+1);
	});
}
/**
 * 加载某页的评论
 * @param {} id
 */
function certainPage(id,page){
	$("#rorf").load("remark_partMore.action",{microblogid:id,beginPage:page});
}
/**
 * 加载某页的转发
 * @param {} fid
 * @param {} sid
 * @param {} page
 */
function certainfPage(fid,sid,page){
	$("#rorf").load("forward_partMore.action",{forwardMicroblogId:fid,sourceMicroblogId:sid,beginPage:page});
}
/**
 * 删除转发列表里的转发
 * @param {} id
 * @param {} fid
 * @param {} sid
 */
function microblogDeleteLess(id,fid,sid){
	$(".modal-body1").load(
	    "microblog_deleteLess.action",
		{id:id,forwardMicroblogId:fid,sourceMicroblogId:sid},
	    function(){
	    	var old = $("#forwardSize"+fid).text();
	    	$("#forwardSize"+fid).text(parseInt(old)-1);
	    	if(fid!=sid){
	    		old = $("#forwardSize"+sid).text();
	    		$("#forwardSize"+sid).text(parseInt(old)-1);
	    	}
			$("#forwardModal").modal();
	});
}
/**
 * 转发转发列表里对当前微博的转发
 * @param {} fid
 * @param {} sid
 * @param {} rfid
 */
function forwardLess(fid,sid,rfid){
	var content = $("#forwardRemark"+fid).val();
	$(".modal-body1").load(
	    "microblog_forwardLess.action",
		{forwardRemark:content,forwardMicroblogId:fid,sourceMicroblogId:sid,originfid:rfid},
	    function(){
	    	var old = $("#forwardSize"+fid).text();
	    	$("#forwardSize"+fid).text(parseInt(old)+1);
	    	if(fid!=sid){
	    		old = $("#forwardSize"+sid).text();
	    		$("#forwardSize"+sid).text(parseInt(old)+1);
	    	}
			$("#forwardModal").modal();
	});
}
/**
 * 转发详情页里的删除转发
 * @param {} id
 * @param {} fid
 * @param {} sid
 */
function microblogDeleteMore(id,fid,sid){
	$("#rorf").load(
	    "microblog_deleteMore.action",
		{id:id,forwardMicroblogId:fid,sourceMicroblogId:sid},
	    function(){
	    	var old = $("#forwardSize"+fid).text();
	    	$("#forwardSize"+fid).text(parseInt(old)-1);
	    	if(fid!=sid){
	    		old = $("#forwardSize"+sid).text();
	    		$("#forwardSize"+sid).text(parseInt(old)-1);
	    	}
	});
}
/**
 * 转发详情页里的转发他人对当前微博的转发
 * @param {} fid
 * @param {} sid
 * @param {} rfid
 */
function forwardMoreb(fid,sid,rfid){
	var content = $("#forwardRemarkb"+fid).val();
	$("#rorf").load(
	    "microblog_forwardMoreb.action",
		{forwardRemark:content,forwardMicroblogId:fid,sourceMicroblogId:sid,originfid:rfid},
	    function(){
    		var old = $("#forwardSize"+fid).text();
	    	$("#forwardSize"+fid).text(parseInt(old)+1);
	    	if(fid!=sid){
	    		old = $("#forwardSize"+sid).text();
	    		$("#forwardSize"+sid).text(parseInt(old)+1);
	    	}
	});
}
/**
 * 转发详情页里对当前微博的转发
 * @param {} fid
 * @param {} sid
 */
function forwardMorea(fid,sid){
	var content = $("#forwardRemarka"+fid).val();
	$("#rorf").load(
	    "microblog_forwardMorea.action",
		{forwardRemark:content,forwardMicroblogId:fid,sourceMicroblogId:sid},
	    function(){
    		var old = $("#forwardSize"+fid).text();
	    	$("#forwardSize"+fid).text(parseInt(old)+1);
	    	if(fid!=sid){
	    		old = $("#forwardSize"+sid).text();
	    		$("#forwardSize"+sid).text(parseInt(old)+1);
	    	}
	});
}

/**
 * 显示举报
 * @param {} id
 * @param {} sid
 */
function showReport(reportedid,type,reportedUserId){
	$(".modal-body2").load(
	    "report_show.action",
		{reportedid:reportedid,type:type,reportedUserId:reportedUserId},
	    function(){
			$("#reportModal").modal();
	});
}