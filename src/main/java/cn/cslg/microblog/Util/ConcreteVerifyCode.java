package cn.cslg.microblog.Util;

import java.util.Random;

public class ConcreteVerifyCode {
	public static String[] genCode(){
		String s[]=new String[2];
		Random rand=new Random();
		rand.setSeed(System.currentTimeMillis());
		int x=rand.nextInt(100);
		int y=rand.nextInt(100);
		char op[]={'+','-','x'};
		int mop=rand.nextInt(1000)%2;
		int result=0;
		switch(mop){
		case 0:
			result=x+y; break;
		case 1:
			result=x-y;break;
		}
		s[0]=x+""+op[mop]+y;
		s[1]=new Integer(result).toString();
		return s;
	}
	
	
}
