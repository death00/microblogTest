package cn.cslg.microblog.Service;

import cn.cslg.microblog.PO.User;

public interface MailService {
	public void sendActivecode(User user);
	
	public void sendResetPassword(User user);
}
