package cn.cslg.microblog.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.cslg.microblog.DAO.RemarkMapper;
import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.Remark;
import cn.cslg.microblog.Util.Page;

@Service("remarkService")
public class RemarkServiceImpl implements RemarkService{
	@Resource
	private RemarkMapper remarkMapper;

	@Override
	public ArrayList<Remark> findByMicroblogid(Integer microblogid) {
		return remarkMapper.selectByMicroblogid(microblogid);
	}

	@Override
	public void addReply(Remark remark) {
		remark.setIsreply(true);
		remark.setTime(new Date());
		remark.setIsread(false);
		remarkMapper.insert(remark);
	}

	@Override
	public void addRemark(Remark remark) {
		remark.setIsreply(false);
		remark.setReplyId(0);
		remark.setTime(new Date());
		remark.setIsread(false);
		remarkMapper.insert(remark);
	}

	@Override
	public List<Remark> findFourByMicroblogid(Integer microblogid) {
		// TODO Auto-generated method stub
		return remarkMapper.selectFourByMicroblogid(microblogid);
	}

	@Override
	public Page getTenByMicroblogId(Integer microblogid, Page page) {
		List<Remark> remarks = this.remarkMapper.selectPageByMicroblogId(
				microblogid, (page.getBeginPage() - 1)*page.getEveryPage(), page.getEveryPage());
		int totalCount = this.remarkMapper.countByMicroblogId(microblogid);
		page.setList(remarks);
		page.setTotalCount(totalCount);
		page.init();
		return page;
	}

	@Override
	public void deleteRemark(Remark remark) {
		this.remarkMapper.deleteByPrimaryKey(remark.getId());
	}

	@Override
	public Remark findById(Integer id) {
		return remarkMapper.selectByPrimaryKey(id);
	}
	
	
}
