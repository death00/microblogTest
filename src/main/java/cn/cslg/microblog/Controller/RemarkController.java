package cn.cslg.microblog.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.Remark;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Service.MicroblogService;
import cn.cslg.microblog.Service.RemarkService;
import cn.cslg.microblog.Util.Page;

@Controller
@SessionAttributes({"User"})
public class RemarkController {
	@Resource
	private RemarkService remarkService;
	@Resource
	private MicroblogService microblogService;
	
	@RequestMapping("user/remark_showLess")
	public String showLess(Integer microblogid, ModelMap modelMap,HttpServletResponse response){
		List<Remark> remarks = remarkService.findFourByMicroblogid(microblogid);
		Microblog microblog = microblogService.findOne(microblogid);
		modelMap.addAttribute("remarks", remarks);
		modelMap.addAttribute("microblog", microblog);
		return "/user/remarkLess";
	}
	
	@RequestMapping("user/remark_showMore")
	public String showMore(Integer microblogid, ModelMap modelMap, Page page){
		page = remarkService.getTenByMicroblogId(microblogid,page);
		Microblog microblog = microblogService.findOne(microblogid);
		modelMap.addAttribute("Page", page);
		modelMap.addAttribute("microblog", microblog);
		modelMap.addAttribute("partSelect", 0);
		return "/user/showMore";
	}
	
	@RequestMapping("user/remark_partMore")
	public String partMore(Integer microblogid, ModelMap modelMap, Page page){
		page = remarkService.getTenByMicroblogId(microblogid,page);
		Microblog microblog = microblogService.findOne(microblogid);
		modelMap.addAttribute("Page", page);
		modelMap.addAttribute("microblog", microblog);
		return "/user/remarkMore";
	}

	@RequestMapping("user/remark_create")
	public String create(Remark remark, ModelMap modelMap, @ModelAttribute("User") User user){
		remark.setUserId(user.getId());
		remarkService.addRemark(remark);
		return "redirect:remark_showLess.action?microblogid="+remark.getMicroblogid();
	}
	
	@RequestMapping("user/remark_createMore")
	public String createMore(Remark remark, ModelMap modelMap, @ModelAttribute("User") User user){
		remark.setUserId(user.getId());
		remarkService.addRemark(remark);
		return "redirect:remark_partMore.action?microblogid="+remark.getMicroblogid();
	}
	
	@RequestMapping("user/remark_reply")
	public String reply(Remark remark, ModelMap modelMap, @ModelAttribute("User") User user){
		remark.setUserId(user.getId());
		remarkService.addReply(remark);
		return "redirect:remark_showLess.action?microblogid="+remark.getMicroblogid();
	}
	
	@RequestMapping("user/remark_replyMore")
	public String replyMore(Remark remark, ModelMap modelMap, @ModelAttribute("User") User user){
		remark.setUserId(user.getId());
		remarkService.addReply(remark);
		return "redirect:remark_partMore.action?microblogid="+remark.getMicroblogid();
	}
	
	@RequestMapping("user/remark_delete")
	public String delete(Remark remark){
		remarkService.deleteRemark(remark);
		return "redirect:remark_showLess.action?microblogid="+remark.getMicroblogid();
	}
	
	@RequestMapping("user/remark_deleteMore")
	public String deleteMore(Remark remark){
		remarkService.deleteRemark(remark);
		return "redirect:remark_partMore.action?microblogid="+remark.getMicroblogid();
	}
}
