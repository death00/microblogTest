package cn.cslg.microblog.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import cn.cslg.microblog.DAO.MicroblogMapper;
import cn.cslg.microblog.DAO.UserMapper;
import cn.cslg.microblog.PO.Follow;
import cn.cslg.microblog.PO.ForwardRemark;
import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.Remark;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Util.Page;

@Service("microblogService")
public class MicroblogServiceImpl implements MicroblogService {
	@Resource
	private MicroblogMapper microblogMapper;
	@Resource
	private FollowService followService;
	@Resource
	private UserService userService;
	@Resource
	private RemarkService remarkService;

	@Override
	public void publish(User user, Microblog microblog) {
		microblog.setIsForward(false);
		microblog.setUserid(user.getId());
		microblog.setTime(new Timestamp(System.currentTimeMillis()));
		microblog.setSourceMicroblogId(0);
		microblog.setForwardMicroblogId(0);
		microblog.setForwardRemark(null);
		this.microblogMapper.insertSelective(microblog);
	}

	@Override
	public List<Microblog> getAll(User user) {
		List<Follow> follows = this.followService.findFollowsByUser(user);
		List<Integer> users = new ArrayList<Integer>();
		for (int i = 0; i < follows.size(); i++) {
			users.add(follows.get(i).getUserid2());
		}
		users.add(user.getId());
		List<Microblog> microblogs = this.microblogMapper.selectByIds(users);
		for (int i = 0; i < microblogs.size(); i++) {
			Microblog microblogTemp = microblogs.get(i);
			microblogs.get(i).setRemarkSys();
			microblogs.get(i).setRemarks(remarkService.findByMicroblogid(microblogTemp.getId()));
			if (!microblogs.get(i).getIsForward()) {
				microblogs.get(i).setForwards(this.microblogMapper.countBySourceMicroblogId(microblogTemp.getId()));
			} else {
				microblogs.get(i).setForwards(this.microblogMapper.countByForwardMicroblogId(microblogTemp.getId()));
			}
		}
		return microblogs;
	}

	@Override
	public Integer forword(Microblog microblog, User user) {
		Microblog microblogTemp = microblog;
		String forwardRemarkNow = microblog.getForwardRemark();
		if(forwardRemarkNow == null || forwardRemarkNow.equals("")){
			forwardRemarkNow = "转发微博";
		}
		// 获得被转发的那个微博
		microblog = this.microblogMapper.selectByPrimaryKey(microblog.getForwardMicroblogId());
		Integer id = microblog.getUserid();
		User user2 = this.userService.findById(id);
		microblogTemp.setContent(microblog.getContent());
		microblogTemp.setTime(new Timestamp(System.currentTimeMillis()));
		microblogTemp.setUserid(user.getId());
		microblogTemp.setId(null);
		String remarkBefore = microblog.getForwardRemark();
		
		//转发原创作者的
		if (!microblog.getIsForward()) {
			microblogTemp.setForwardRemark(forwardRemarkNow);
		}
		// 转发的是别人转发过的
		else {
			ForwardRemark forwardRemark = new ForwardRemark();
			forwardRemark.setRemark(forwardRemarkNow);
			forwardRemark.setUserId(user.getId());
			forwardRemark.setUserName(user.getName());
			String[] temp = remarkBefore.split("##\\$\\$");
			remarkBefore = "";
			for (int i = 0; i < temp.length - 1; i++) {
				remarkBefore += temp[i] + "##$$";
			}
			remarkBefore += temp[temp.length - 1];
			microblogTemp.setForwardRemark(
					forwardRemarkNow + "##$$" + user2.getId() + "#$" + user2.getName() + "#$" + remarkBefore);
		}
		microblogTemp.setIsForward(true);
		this.microblogMapper.insertSelective(microblogTemp);
		return id;
	}

	@Override
	public Microblog findOne(Integer id) {
		Microblog microblog = microblogMapper.selectByPrimaryKey(id);
		microblog.setRemarkSys();
		microblog.setRemarks(remarkService.findByMicroblogid(microblog.getId()));
		if (!microblog.getIsForward()) {
			microblog.setForwards(this.microblogMapper.countBySourceMicroblogId(microblog.getId()));
		} else {
			microblog.setForwards(this.microblogMapper.countByForwardMicroblogId(microblog.getId()));
		}
		return microblog;
	}

	@Override
	public List<Microblog> getAllNotFollow(User user1) {
		List<Microblog> microblogs = microblogMapper.selectByUserId(user1.getId());
		for (int i = 0; i < microblogs.size(); i++) {
			Microblog microblogTemp = microblogs.get(i);
			microblogs.get(i).setRemarkSys();
			microblogs.get(i).setRemarks(remarkService.findByMicroblogid(microblogTemp.getId()));
			if (!microblogs.get(i).getIsForward()) {
				microblogs.get(i).setForwards(this.microblogMapper.countBySourceMicroblogId(microblogTemp.getId()));
			} else {
				microblogs.get(i).setForwards(this.microblogMapper.countByForwardMicroblogId(microblogTemp.getId()));
			}
		}
		return microblogs;
	}

	@Override
	public List<Microblog> getFourByForward(Microblog microblog) {
		List<Microblog> microblogs;
		if(microblog.getSourceMicroblogId().intValue() != microblog.getForwardMicroblogId().intValue()){
			microblogs = this.microblogMapper
					.selectFourByForwardMicroblogId(microblog.getForwardMicroblogId());
		}else {
			microblogs = this.microblogMapper.selectFourBySourceMicroblogId(microblog.getForwardMicroblogId());
		}
		for (int i = 0; i < microblogs.size(); i++) {
			microblogs.get(i).setRemarkSys();
		}
		return microblogs;
	}

	@Override
	public Page getTenByForward(Microblog microblog, Page page) {
		List<Microblog> microblogs;
		if(microblog.getSourceMicroblogId().intValue() != microblog.getForwardMicroblogId().intValue()){
			microblogs = this.microblogMapper.selectPageByForwardMicroblogId(
					microblog.getForwardMicroblogId(), (page.getBeginPage() - 1)*page.getEveryPage(), page.getEveryPage());
		}else {
			microblogs = this.microblogMapper.selectPageBySourceMicroblogId(
					microblog.getForwardMicroblogId(), (page.getBeginPage() - 1)*page.getEveryPage(), page.getEveryPage());
		}

		for (int i = 0; i < microblogs.size(); i++) {
			microblogs.get(i).setRemarkSys();
		}
		int totalCount;
		if(microblog.getSourceMicroblogId().intValue()!=microblog.getForwardMicroblogId().intValue()){
			totalCount = this.microblogMapper.countByForwardMicroblogId(microblog.getForwardMicroblogId());
		}
		else{
			totalCount = this.microblogMapper.countBySourceMicroblogId(microblog.getForwardMicroblogId());
		}
		page.setList(microblogs);
		page.setTotalCount(totalCount);
		page.init();
		return page;
	}

	@Override
	public void delete(Microblog microblog) {
		this.microblogMapper.deleteByPrimaryKey(microblog.getId());
	}

}
