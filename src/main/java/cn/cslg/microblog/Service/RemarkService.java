package cn.cslg.microblog.Service;

import java.util.ArrayList;
import java.util.List;

import cn.cslg.microblog.PO.Remark;
import cn.cslg.microblog.Util.Page;

public interface RemarkService {

	ArrayList<Remark> findByMicroblogid(Integer microblogid);

	void addReply(Remark remark);

	void addRemark(Remark remark);

	/**
	 * 寻找出四条评论
	 * @param microblogid
	 * @return
	 */
	List<Remark> findFourByMicroblogid(Integer microblogid);

	/**
	 * 找出当前页面的评论
	 * @param microblogid
	 * @param page
	 * @return
	 */
	Page getTenByMicroblogId(Integer microblogid, Page page);

	void deleteRemark(Remark remark);
	
	Remark findById(Integer id);
}
