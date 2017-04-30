package cn.cslg.microblog.Service;

import java.util.List;

import cn.cslg.microblog.PO.Follow;
import cn.cslg.microblog.PO.User;

public interface FollowService {
	/**
	 * 找寻该用户关注的所有用户
	 * @param user
	 * @return
	 */
	List<Follow> findFollowsByUser(User user);
	
	/**
	 * user1是否已经关注了user2
	 * @param user1
	 * @param user2
	 * @return	是：true;否：false;
	 */
	Boolean findFollowIsExist(User user1, User user2);

	/**
	 * 创建关注关系，user1关注user2
	 * @param user1
	 * @param userId
	 */
	void createFollow(User user1, Integer userId);

	/**
	 * 删除关注关系，user1不再关注user2
	 * @param user1
	 * @param userId
	 */
	void removeFollow(User user1, Integer userId);

	/**
	 * 统计该用户的关注者人数
	 * @param user1
	 * @return
	 */
	Integer countFollows(User user1);

	/**
	 * 统计该用户的粉丝人数
	 * @param user1
	 * @return
	 */
	Integer countFollowers(User user1);
}
