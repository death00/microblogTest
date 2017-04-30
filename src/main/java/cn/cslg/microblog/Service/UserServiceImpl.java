package cn.cslg.microblog.Service;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.cslg.microblog.DAO.UserMapper;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Util.MD5;
@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserMapper userMapper;
		
	@Override
	public User findById(int id) {
		return this.userMapper.selectByPrimaryKey(id);
	}

	@Override
	public Boolean register(User user) {
		try {
			user.setPassword(MD5.md5(user.getPassword()));
			String base = "abcdefghijklmnopqrstuvwxyz0123456789";     
		    Random random = new Random();     
		    StringBuffer sb = new StringBuffer();     
		    for (int i = 0; i < 25; i++) {     
		        int number = random.nextInt(base.length());     
		        sb.append(base.charAt(number));     
		    }
		    user.setActivecode(sb.toString());
		    user.setState(0);
		    
		} catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(this.userMapper.insertSelective(user) == 0){
			return false;
		}else {
			return true;
		}
	}

	@Override
	public Boolean nameExist(String name) {
		if(this.userMapper.selectByName(name) == null){
			return false;
		}else {
			return true;
		}
	}

	@Override
	public Boolean emailExist(String email) {
		if(this.userMapper.selectByEmail(email) == null){
			return false;
		}else {
			return true;
		}
	}

	@Override
	public boolean active(User user) {
		User user1 = this.userMapper.selectByName(user.getName());
		if(user1.getActivecode().equals(user.getActivecode()) && (user1.getPassword().equals(user.getPassword()))){
			user1.setState(1);
			this.userMapper.updateByPrimaryKey(user1);
			return true;
		}else {
			return false;
		}
	}

	@Override
	public User findByName(String name) {
		return this.userMapper.selectByName(name);
	}

	@Override
	public boolean checkNameAndEmail(User user) {
		User user2 = this.userMapper.selectByEmail(user.getEmail());
		if(user2.getName().equals(user.getName())){
			return true;
		}else {
			return false;
		}
	}

	@Override
	public void resetPassword(User user) {
		try {
			user.setPassword(MD5.md5(user.getPassword()));
		} catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.userMapper.updateByName(user);
	}

	@Override
	public boolean isExist(String name) {
		if(this.userMapper.selectCountByName(name) == 0){
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean isFindPassword(User user) {
		User user2 = this.userMapper.selectByName(user.getName());
		if(user2.getEmail().equals(user.getEmail())){
			return true;
		}else {
			return false;
		}
	}

	@Override
	public User findByEmail(String email) {
		User user = this.userMapper.selectByEmail(email);
		return user;
	}

	@Override
	public List<User> countReport() {
		return this.userMapper.selectCountReport();
	}

	@Override
	public void editState(User user) {
		this.userMapper.updateByPrimaryKeySelective(user);
	}

}
