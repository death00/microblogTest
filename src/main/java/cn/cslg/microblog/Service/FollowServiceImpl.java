package cn.cslg.microblog.Service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.cslg.microblog.DAO.FollowMapper;
import cn.cslg.microblog.PO.Follow;
import cn.cslg.microblog.PO.User;
@Service("followService")
public class FollowServiceImpl implements FollowService {
	@Resource
	private FollowMapper followMapper;
	
	@Override
	public List<Follow> findFollowsByUser(User user) {
		return this.followMapper.selectByUserId1(user.getId());
	}

	@Override
	public Boolean findFollowIsExist(User user1, User user2) {
		Follow follow = this.followMapper.selectByUserId1AndUserId2(user1.getId(), user2.getId());
		if(follow == null){
			return false;
		}else {
			return true;
		}
	}

	@Override
	public void createFollow(User user1, Integer userId) {
		Follow follow = new Follow();
		follow.setUserid1(user1.getId());
		follow.setUserid2(userId);
		this.followMapper.insert(follow);
	}

	@Override
	public void removeFollow(User user1, Integer userId) {
		Follow follow = new Follow();
		follow.setUserid1(user1.getId());
		follow.setUserid2(userId);
		this.followMapper.deleteByUserId1AndUserId2(follow);
	}

	@Override
	public Integer countFollows(User user1) {
		return this.followMapper.countByUserId1(user1.getId());
	}

	@Override
	public Integer countFollowers(User user1) {
		return this.followMapper.countByUserId2(user1.getId());
	}

}
