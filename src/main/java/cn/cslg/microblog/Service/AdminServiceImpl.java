package cn.cslg.microblog.Service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.cslg.microblog.DAO.AdminMapper;
import cn.cslg.microblog.PO.Admin;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Resource
	private AdminMapper adminMapper;
	
	@Override
	public Admin findByName(String name) {
		return adminMapper.selectByName(name);
	}

	@Override
	public void addAdmin(Admin admin) {
		adminMapper.insertSelective(admin);
	}

}
