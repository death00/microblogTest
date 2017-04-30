package cn.cslg.microblog.Controller;

import java.io.IOException;

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
import cn.cslg.microblog.PO.Report;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Service.MicroblogService;
import cn.cslg.microblog.Service.RemarkService;
import cn.cslg.microblog.Service.ReportService;
import cn.cslg.microblog.Service.UserService;

/**
 * 处理举报相关操作
 * 
 * @author Administrator
 *
 */
@Controller
@SessionAttributes({ "User", "Admin" })
public class ReportController {

	@Resource
	private MicroblogService microblogService;

	@Resource
	private RemarkService remarkService;

	@Resource
	private UserService userService;

	@Resource
	private ReportService reportService;

	@RequestMapping(value = "user/report_show")
	public String show(Report report, ModelMap modelMap) {
		int type = report.getType();
		int reportedId = report.getReportedid();
		User reportedUser = new User();
		// 用户举报
		if (type == 1) {
			User userTemp = this.userService.findById(reportedId);
			report.setReported(userTemp);
			reportedUser = userTemp;
		}
		// 微博举报
		else if (type == 2) {
			Microblog microblogTemp = this.microblogService.findOne(reportedId);
			report.setReported(microblogTemp);
			reportedUser = this.userService.findById(microblogTemp.getUserid());
		}
		// 评论举报
		else {
			Remark remarkTemp = this.remarkService.findById(reportedId);
			report.setReported(remarkTemp);
			reportedUser = this.userService.findById(remarkTemp.getUser().getId());
		}
		modelMap.addAttribute("report", report);
		modelMap.addAttribute("reportedUser", reportedUser);
		return "/report/show";
	}

	@RequestMapping(value = "/report_submit")
	public void submit(Report report, @ModelAttribute("User") User user, HttpServletResponse httpServletResponse) {
		report.setReporterid(user.getId());
		// 设置举报状态为“待处理”
		report.setState(1);
		int temp = this.reportService.submitReport(report);
		try {
			if(temp == 0){
				httpServletResponse.getWriter().println("0");
			}else{
				httpServletResponse.getWriter().println("1");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("report_userPass")
	public String userPass(Report report){
		//设置状态为通过
		report.setState(2);
		this.reportService.update(report);
		return "redirect:admin_showUserReport.action";
	}
	
	@RequestMapping("report_userUnpass")
	public String userUnpass(Report report){
		//设置状态为不通过
		report.setState(3);
		this.reportService.update(report);
		return "redirect:admin_showUserReport.action";
	}
	
	@RequestMapping("report_microblogPass")
	public String microblogPass(Report report){
		//设置状态为通过
		report.setState(2);
		this.reportService.update(report);
		return "redirect:admin_showMicroblogReport.action";
	}
	
	@RequestMapping("report_microblogUnpass")
	public String microblogUnpass(Report report){
		//设置状态为不通过
		report.setState(3);
		this.reportService.update(report);
		return "redirect:admin_showMicroblogReport.action";
	}
	
	@RequestMapping("report_remarkPass")
	public String remarkPass(Report report){
		//设置状态为通过
		report.setState(2);
		this.reportService.update(report);
		return "redirect:admin_showRemarkReport.action";
	}
	
	@RequestMapping("report_remarkUnpass")
	public String remarkUnpass(Report report){
		//设置状态为不通过
		report.setState(3);
		this.reportService.update(report);
		return "redirect:admin_showRemarkReport.action";
	}
	
	@RequestMapping("report_showMicroblog")
	public String showMicroblog(Report report, ModelMap modelMap){
		report = this.reportService.findById(report.getId());
		Microblog microblog = this.microblogService.findOne(report.getReportedid());
		modelMap.addAttribute("report", report);
		modelMap.addAttribute("microblog", microblog);
		return "/admin/show";
	}
	
	@RequestMapping("report_showRemark")
	public String showRemark(Report report, ModelMap modelMap){
		report = this.reportService.findById(report.getId());
		Remark remark = this.remarkService.findById(report.getReportedid());
		Microblog microblog = this.microblogService.findOne(remark.getMicroblogid());
		modelMap.addAttribute("report", report);
		modelMap.addAttribute("remark", remark);
		modelMap.addAttribute("microblog", microblog);
		return "/admin/show";
	}
}
