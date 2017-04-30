package cn.cslg.microblog.Service;

import java.util.List;

import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Util.Page;

public interface MicroblogService {
	/**
	 * 用户发布微博
	 * @param user 
	 * @param microblog
	 */
	public void publish(User user, Microblog microblog);

	/**
	 * 获得该用户的所有微博（包括自己发的、转发的、关注者的）
	 * @param user
	 * @return
	 */
	public List<Microblog> getAll(User user);

	/**
	 * 用户转发微博
	 * @param microblog
	 * @param user
	 */
	public Integer forword(Microblog microblog, User user);

	public Microblog findOne(Integer id);

	/**
	 * 显示该用户所有微博（包括自己写的以及自己转发的）
	 * @param user1
	 * @return
	 */
	public List<Microblog> getAllNotFollow(User user1);

	/**
	 * 显示转发这条微博的最多4条评论
	 * @param microblog
	 * @return
	 */
	public List<Microblog> getFourByForward(Microblog microblog);

	/**
	 * 显示10条转发评论（要有页数）
	 * @param microblog
	 * @param page
	 * @return
	 */
	public Page getTenByForward(Microblog microblog, Page page);

	/**
	 * 删除微博
	 * @param microblog
	 */
	public void delete(Microblog microblog);
	
}
