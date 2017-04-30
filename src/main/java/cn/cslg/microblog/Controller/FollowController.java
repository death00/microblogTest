package cn.cslg.microblog.Controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import cn.cslg.microblog.PO.Follow;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Service.FollowService;

@Controller
@SessionAttributes({"User"})
public class FollowController {
	@Resource
	private FollowService followService;

	@RequestMapping("user/follow_create")
	public void create(Integer userId, @ModelAttribute("User") User user1, ModelMap model, HttpServletResponse httpServletResponse){
		//添加关注
		this.followService.createFollow(user1, userId);
		User user = new User();
		user.setId(userId);
		Integer follows = this.followService.countFollowers(user);
		try {
			httpServletResponse.getWriter().println(follows);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("user/follow_remove")
	public void remove(Integer userId, @ModelAttribute("User") User user1, ModelMap model, HttpServletResponse httpServletResponse){
		//取消关注
		this.followService.removeFollow(user1, userId);
		User user = new User();
		user.setId(userId);
		Integer follows = this.followService.countFollowers(user);
		try {
			httpServletResponse.getWriter().println(follows);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
