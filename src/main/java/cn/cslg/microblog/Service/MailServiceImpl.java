package cn.cslg.microblog.Service;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.mail.EmailException;
import org.springframework.stereotype.Service;

import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Util.MD5;
import cn.cslg.microblog.Util.Mail;

@Service("mailService")
public class MailServiceImpl implements MailService {

	@Override
	public void sendActivecode(User user) {
		Mail mail = new Mail("smtp.163.com","15501620270@163.com","微博",
				"15501620270@163.com","123456qwe",true);
		String string = "http://localhost:8080/microblogNew/user_active.action?name="+user.getName()+
						"&password="+user.getPassword()+"&activecode="+user.getActivecode();
		StringBuffer sf=new StringBuffer();  
        sf.append("http://localhost:8080/microblogNew/user_active.action?name=");  
        try {
			sf.append(java.net.URLEncoder.encode(user.getName(), "utf-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}  
        sf.append("&password=");  
        sf.append(user.getPassword());
        sf.append("&activecode=");  
        sf.append(user.getActivecode());  
		try {
			/*mail.sendSimpleMail(user.getEmail(),user.getName(),"邮箱激活",sf.toString());*/
			mail.sendSimpleMail(user.getEmail(),user.getName(),"邮箱激活",sf.toString());
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void sendResetPassword(User user) {
		Mail mail = new Mail("smtp.163.com","15501620270@163.com","微博",
				"15501620270@163.com","123456qwe",true);
		StringBuffer sf=new StringBuffer();  
        sf.append("http://localhost:8080/microblogNew/user_showResetPassword.action?name=");  
        try {
			sf.append(java.net.URLEncoder.encode(user.getName(), "utf-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}  
		try {
			mail.sendSimpleMail(user.getEmail(),user.getName(),"密码重置",sf.toString());
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
