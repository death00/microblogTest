package cn.cslg.microblog.Service;

import java.util.List;

import cn.cslg.microblog.PO.User;

public interface UserService {
	public User findById(int id);
	
	public Boolean nameExist(String name);
	
	public Boolean emailExist(String email);
	
	public Boolean register(User user);

	public boolean active(User user);

	public User findByName(String name);

	public boolean checkNameAndEmail(User user);

	public void resetPassword(User user);

	public boolean isExist(String name);

	public boolean isFindPassword(User user);

	public User findByEmail(String email);

	/**
	 * 统计用户被举报次数（必须是用户state为正常且举报已通过）
	 * @return
	 */
	public List<User> countReport();

	/**
	 * 根据id修改用户状态
	 * @param user
	 */
	public void editState(User user);

}
