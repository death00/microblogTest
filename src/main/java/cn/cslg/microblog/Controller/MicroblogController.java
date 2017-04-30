package cn.cslg.microblog.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.Remark;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Service.MicroblogService;
import cn.cslg.microblog.Service.RemarkService;
import cn.cslg.microblog.Util.Page;

@Controller
@SessionAttributes({"User"})
public class MicroblogController {
	@Resource
	private MicroblogService microblogService;
	@Resource
	private RemarkService remarkService;
	
	@RequestMapping("user/microblog_showAll")
	public String showAll(@ModelAttribute("User") User user, ModelMap model){
		List<Microblog> microblogs = this.microblogService.getAll(user);
		model.addAttribute("Microblogs", microblogs);
		return "/user/index";
	}
	
	@RequestMapping("user/microblog_publish")
	public String publish(@ModelAttribute("User") User user, Microblog microblog){
		this.microblogService.publish(user, microblog);
		return "redirect:microblog_showAll.action";
	}
	
	@RequestMapping("user/microblog_showForward")
	public String showForward(Microblog microblog, ModelMap modelMap){
		List<Microblog> microblogs = this.microblogService.getFourByForward(microblog);
		modelMap.addAttribute("Microblog", microblog);
		modelMap.addAttribute("Microblogs", microblogs);
		return "/user/showForwardRemarkLess";
	}
	
	@RequestMapping("user/microblog_showForwardMore")
	public String showForwardMore(Microblog microblog, Page page, ModelMap modelMap){
		page = this.microblogService.getTenByForward(microblog,page);
		Microblog mic = this.microblogService.findOne(microblog.getForwardMicroblogId());
		modelMap.addAttribute("microblog", mic);
		modelMap.addAttribute("Page", page);
		modelMap.addAttribute("partSelect",1);
		return "/user/showMore";
	}
	
	@RequestMapping("user/forward_partMore")
	public String partMore(Microblog microblog, Page page, ModelMap modelMap){
		page = this.microblogService.getTenByForward(microblog,page);
		modelMap.addAttribute("microblog", microblog);
		modelMap.addAttribute("Page", page);
		return "/user/showForwardRemarkMore";
	}
	
	@RequestMapping("user/microblog_forward")
	public String forword(Microblog microblog, ModelMap modelMap){
		User user = (User) modelMap.get("User");
		Integer id = this.microblogService.forword(microblog, user);
		return "redirect:microblog_showAll.action";
	}
	
	@RequestMapping("user/microblog_forwardLess")
	public String forwordLess(Microblog microblog, ModelMap modelMap,Integer originfid){
		User user = (User) modelMap.get("User");
		Integer id = this.microblogService.forword(microblog, user);
		return "redirect:microblog_showForward.action?forwardMicroblogId="
		+originfid+"&sourceMicroblogId="+microblog.getSourceMicroblogId();
	}
	
	@RequestMapping("user/microblog_forwardMoreb")
	public String forwordMoreb(Microblog microblog, ModelMap modelMap,Integer originfid){
		User user = (User) modelMap.get("User");
		Integer id = this.microblogService.forword(microblog, user);
		return "redirect:forward_partMore.action?forwardMicroblogId="
		+originfid+"&sourceMicroblogId="+microblog.getSourceMicroblogId();
	}
	
	@RequestMapping("user/microblog_forwardMorea")
	public String forwordMorea(Microblog microblog, ModelMap modelMap){
		User user = (User) modelMap.get("User");
		Integer id = this.microblogService.forword(microblog, user);
		return "redirect:forward_partMore.action?forwardMicroblogId="
		+microblog.getForwardMicroblogId()+"&sourceMicroblogId="+microblog.getSourceMicroblogId();
	}
	
	@RequestMapping("user/microblog_delete")
	public String delete(Microblog microblog, ModelMap modelMap,HttpServletRequest request){
		this.microblogService.delete(microblog);
		String pathSource = request.getHeader("Referer");
		String backPath = pathSource.substring(pathSource.lastIndexOf("/")+1);
		if(backPath.indexOf("More")!=-1){
			return "redirect:microblog_showAll.action";
		}
		return "redirect:"+backPath;
	}
	
	@RequestMapping("user/microblog_deleteLess")
	public String deleteLess(Microblog microblog, ModelMap modelMap){
		this.microblogService.delete(microblog);
		return "redirect:microblog_showForward.action?forwardMicroblogId="
				+microblog.getForwardMicroblogId()+"&sourceMicroblogId="+microblog.getSourceMicroblogId();
	}
	
	@RequestMapping("user/microblog_deleteMore")
	public String deleteMore(Microblog microblog, ModelMap modelMap){
		this.microblogService.delete(microblog);
		return "redirect:forward_partMore.action?forwardMicroblogId="
				+microblog.getForwardMicroblogId()+"&sourceMicroblogId="+microblog.getSourceMicroblogId();
	}
}
