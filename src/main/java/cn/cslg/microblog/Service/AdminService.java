package cn.cslg.microblog.Service;

import cn.cslg.microblog.PO.Admin;
import cn.cslg.microblog.PO.User;

public interface AdminService {

	Admin findByName(String name);

	void addAdmin(Admin admin);

}
