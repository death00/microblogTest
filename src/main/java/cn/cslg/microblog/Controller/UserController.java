package cn.cslg.microblog.Controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import cn.cslg.microblog.PO.Follow;
import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Service.FollowService;
import cn.cslg.microblog.Service.MailService;
import cn.cslg.microblog.Service.MicroblogService;
import cn.cslg.microblog.Service.SearchService;
import cn.cslg.microblog.Service.UserService;
import cn.cslg.microblog.Util.MD5;
@Controller
@SessionAttributes({"User"})		//此处定义此Controller中将要创建和使用哪些session中的对象名
public class UserController {
	@Resource
	private UserService userService;
	
	@Resource
	private MailService mailService;
	
	@Resource
	private MicroblogService microblogService;
	
	@Resource
	private FollowService followService;
	
	@Resource
	private SearchService searchService;
	
	@RequestMapping("user_isExist")
	public void exist(String name, HttpServletResponse httpServletResponse){
		try {
			//用户名是否存在
			if(this.userService.isExist(name)){
				httpServletResponse.getWriter().print("1");
			}else {
				httpServletResponse.getWriter().print("0");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("user_isFindPassword")
	public void isFindPassword(User user, HttpServletResponse httpServletResponse){
		try {
			if(this.userService.isFindPassword(user)){
				httpServletResponse.getWriter().println("1");
			}else {
				httpServletResponse.getWriter().println("0");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping("user_emailCheck")
	public void emailCheck(User user, HttpServletResponse httpServletResponse, ModelMap modelMap){	
		//modelMap自动与session对应，你在往modelmap中添加对应属性便是往session中添加属性（前提是你已经在@SessionAttributes注解中定义好）
		//根据邮箱查找用户
		User userTemp = this.userService.findByEmail(user.getEmail());
		try {
			if(userTemp != null){
				httpServletResponse.getWriter().println("1");
			}else {
				httpServletResponse.getWriter().println("0");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("user_loginCheck")
	@ResponseBody
	public String loginCheck(User user, ModelMap modelMap){	
		//modelMap自动与session对应，你在往modelmap中添加对应属性便是往session中添加属性（前提是你已经在@SessionAttributes注解中定义好）
		User userTemp = this.userService.findByName(user.getName());
		String result = "";
		try {
			//查看是否有这个用户名
			if(userTemp==null){
				result = "0";
			}
			//账号已被封
			if(userTemp.getState() == 3){
				result = "2";
			}
			//账号未激活
			if(userTemp.getState() == 0){
				result = "3";
			}
			//校对密码
			if(userTemp.getPassword().equals(MD5.md5(user.getPassword()))){
				modelMap.addAttribute("User", userTemp);		//成功将userTemp存入session中
				result = "1";
			}else {
				result = "0";
			}
		} catch (NoSuchAlgorithmException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("user_register")
	public String register(User user,HttpServletRequest request){
		if(this.userService.register(user)){
			this.mailService.sendActivecode(user);
			request.setAttribute("visited","exist");
			return "registerSuccess";
		}else {
			return "index";
		}
	}
	
	@RequestMapping(method=RequestMethod.GET,value="user_active")
	public String active(User user,HttpServletRequest request){
		request.setAttribute("visited","exist");
		if(this.userService.active(user)){
			return "activeSuccess";
		}else {
			return "activeError";
		}
	}
	
	@RequestMapping("user/user_logout")
	public String logout(@ModelAttribute("User") User user, SessionStatus sessionStatus){	
		//@ModelAttribute("User")相当于将session中名为"User"的对象注入user对象中
		//sessionStatus中的setComplete方法可以将session中的内容全部清空
		sessionStatus.setComplete();
		return "redirect:../index.jsp";
	}
	
	@RequestMapping("user_findPassword")
	public String findPassword(User user,HttpServletRequest request){
		request.setAttribute("visited","exist");
		if(userService.checkNameAndEmail(user)){
			this.mailService.sendResetPassword(user);
			return "findPasswordSuccess";
		}else {
			return "findPassword";
		}
	}
	
	@RequestMapping("user_showResetPassword")
	public String showResetPassword(User user){
		return "showResetPassword";
	}
	
	@RequestMapping("user_resetPassword")
	public String resetPassword(User user,HttpServletRequest request){
		request.setAttribute("visited","exist");
		userService.resetPassword(user);
		return "resetPasswordSuccess";
	}

	@RequestMapping("user/user_scan")
	public String scan(User user1, ModelMap modelMap){
		user1 = userService.findById(user1.getId());
		User user2 = (User) modelMap.get("User");
		List<Microblog> microblogs = this.microblogService.getAllNotFollow(user1);
		Boolean follow = this.followService.findFollowIsExist(user2, user1);	//是否是关注关系
		Integer follows = this.followService.countFollows(user1);				//关注者人数
		Integer followers = this.followService.countFollowers(user1);			//粉丝人数
		modelMap.addAttribute("Follow", follow);
		modelMap.addAttribute("UserScan", user1);
		modelMap.addAttribute("Follows", follows);
		modelMap.addAttribute("Followers", followers);
		modelMap.addAttribute("Microblogs", microblogs);
		return "/user/scan";
	}
	
	@RequestMapping("user/user_search")
	public String search(String value,ModelMap modelMap){
		if(value==null){
			return "/user/showSearchResult";
		}
		User user = (User) modelMap.get("User");
		modelMap.addAttribute("value", value);
		List<Follow> followList1 = this.followService.findFollowsByUser(user);
		List<Integer> followList = new ArrayList<Integer>();
		for(int i=0;i<followList1.size();i++){
			followList.add(followList1.get(i).getUserid2());
		}
		modelMap.addAttribute("followList", followList);
		HashMap<String, List> result = this.searchService.searchResult(value);
		modelMap.put("result", result);
		return "/user/showSearchResult";
	}

}
