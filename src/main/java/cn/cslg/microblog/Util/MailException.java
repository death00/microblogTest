package cn.cslg.microblog.Util;

import java.io.PrintStream;

/**
 * �ʼ��쳣��
 * 
 * @author jimshen
 * 
 */
public class MailException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6522165416907877028L;
	private Exception innerException;
	
	public MailException() {
		super();
		innerException=null;
	}
	
	public MailException(Exception innerException) {
		super();
		this.innerException=innerException;
	}
	
	public MailException(String message) {
		super(message);
		innerException = null;
	}
	
	public MailException(String message, Exception innerException) {
		super(message);
		this.innerException = innerException;
	}
	
	public String getMessage() {
		String message = super.getMessage() + "\n"
				+ (innerException == null ? "" : innerException.getMessage());
		return message;
	}
	
	public void printStackTrace(PrintStream ps) {
		super.printStackTrace(ps);
		innerException.printStackTrace(ps);
	}
}
