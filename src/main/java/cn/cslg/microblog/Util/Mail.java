package cn.cslg.microblog.Util;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;


//import cn.cslg.campus.config.MutableConfig;

/**
 * 邮件发送类
 * 
 * @author jimshen
 * 
 */
public class Mail {
	String mailhost;

	String sender;

	String senderName;

	String username;

	String password;

	boolean mailAuth;


	/**
	 * 构造方法
	 * 
	 * @param mailhost
	 *            邮件主机名或IP地址
	 * @param sender
	 *            邮件发送者电子邮件地址
	 * @param senderName
	 *            邮件发送者名称
	 * @param username
	 *            邮件帐号用户名
	 * @param password
	 *            邮件帐号密码
	 * @param mailAuth
	 *            邮件服务器是否需要认证
	 */
	public Mail(String mailhost, String sender, String senderName,
			String username, String password, boolean mailAuth) {
		this.mailhost = mailhost;
		this.sender = sender;
		this.senderName = senderName;
		this.username = username;
		this.password = password;
		this.mailAuth = mailAuth;
	}

	public void sendSimpleMail(String receiver, String receiverName,
			String subject, String content) throws EmailException {
		SimpleEmail email = new SimpleEmail();
		if (mailAuth)
			email.setAuthentication(username, password);
		email.setHostName(mailhost);
		email.addTo(receiver, receiverName);
		email.setFrom(sender, senderName);
		email.setCharset("utf-8");
		email.setSubject(subject);
		try {
			email.setMsg(new String(content.getBytes("UTF-8"), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		email.send();
	}

	public void sendHtmlMail(String receiver, String receiverName,
			String subject, String content) throws EmailException {
		HtmlEmail email = new HtmlEmail();
		if (mailAuth)
			email.setAuthentication(username, password);
		email.setHostName(mailhost);
		email.addTo(receiver, receiverName);
		email.setFrom(sender, senderName);
		email.setCharset("utf-8");
		email.setSubject(subject);
		email.setMsg(content);
		email.send();
	}

	public void sendMultiPartMail(String receiver, String receiverName,
			String subject, String content, EmailAttachment attachment)
			throws EmailException {
		MultiPartEmail email = new MultiPartEmail();
		if (mailAuth)
			email.setAuthentication(username, password);
		email.setHostName(mailhost);
		email.addTo(receiver, receiverName);
		email.setFrom(sender, senderName);
		email.setCharset("utf-8");
		email.setSubject(subject);
		email.setMsg(content);
		email.attach(attachment);
		email.send();
	}

	public EmailAttachment newAttachment(String path, String description,
			String name) throws MalformedURLException {
		EmailAttachment attachment = new EmailAttachment();
		attachment.setPath(path);
		attachment.setDisposition(EmailAttachment.ATTACHMENT);
		attachment.setDescription(description);
		attachment.setName(name);
		return attachment;
	}
	
	public static void main(String args[]) throws EmailException{
		Mail mail = new Mail("smtp.163.com","18601579143@163.com","john","18601579143@163.com","",true);
		mail.sendSimpleMail("katesmileses@outlook.com", "john","关于javamail电子邮件测试", "关于javamail电子邮件测试");
	}
}

