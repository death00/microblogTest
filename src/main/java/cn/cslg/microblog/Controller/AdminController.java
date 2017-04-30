package cn.cslg.microblog.Controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import cn.cslg.microblog.PO.Admin;
import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.Report;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Service.AdminService;
import cn.cslg.microblog.Service.FollowService;
import cn.cslg.microblog.Service.MicroblogService;
import cn.cslg.microblog.Service.ReportService;
import cn.cslg.microblog.Service.UserService;
import cn.cslg.microblog.Util.MD5;
import cn.cslg.microblog.Util.Page;

@Controller
@SessionAttributes({"Admin","User"})		//此处定义此Controller中将要创建和使用哪些session中的对象名
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private ReportService reportService;
	
	@Resource
	private UserService userService;
	
	@Resource
	private MicroblogService microblogService;
	
	@Resource
	private FollowService followService;
	
	@RequestMapping(method=RequestMethod.GET,value="admin_login")
	public String register(){
		return "/admin/login";
	}
	
	@RequestMapping("/admin_loginCheck")
	public void loginCheck(Admin admin, HttpServletResponse httpServletResponse, ModelMap modelMap){	
		//modelMap自动与session对应，你在往modelmap中添加对应属性便是往session中添加属性（前提是你已经在@SessionAttributes注解中定义好）
		Admin adminTemp = this.adminService.findByName(admin.getName());
		try {
			//用户名或密码错误，返回0
			if(adminTemp==null){
				httpServletResponse.getWriter().println("0");
				return ;
			}else if(adminTemp.getPassword().equals(MD5.md5(admin.getPassword()))){
				modelMap.addAttribute("Admin", adminTemp);
				httpServletResponse.getWriter().println("1");
				return;
			}else {
				httpServletResponse.getWriter().println("0");
				return;
			}
		} catch (NoSuchAlgorithmException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("登陆错误！");
			logger.error(e.getMessage());
		}
	}
	
	@RequestMapping(method=RequestMethod.POST,value="admin_showAll")
	public String showAll(ModelMap model){
		return "/admin/index";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_home")
	public String home(ModelMap model){
		return "/admin/right";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showUserReport")
	public String showUserReport(ModelMap model){
		Report report = new Report();
		report.setType(1);
		report.setState(1);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showUserReport";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showUserReportPass")
	public String showUserReportPass(ModelMap model){
		Report report = new Report();
		report.setType(1);
		report.setState(2);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showUserReportPass";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showUserReportUnpass")
	public String showUserReportUnpass(ModelMap model){
		Report report = new Report();
		report.setType(1);
		report.setState(3);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showUserReportUnpass";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showMicroblogReport")
	public String showMicroblogReport(ModelMap model){
		Report report = new Report();
		report.setType(2);
		report.setState(1);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showMicroblogReport";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showMicroblogReportPass")
	public String showMicroblogReportPass(ModelMap model){
		Report report = new Report();
		report.setType(2);
		report.setState(2);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showMicroblogReportPass";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showMicroblogReportUnpass")
	public String showMicroblogReportUnpass(ModelMap model){
		Report report = new Report();
		report.setType(2);
		report.setState(3);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showMicroblogReportUnpass";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showRemarkReport")
	public String showRemarkReport(ModelMap model){
		Report report = new Report();
		report.setType(3);
		report.setState(1);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showRemarkReport";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showRemarkReportPass")
	public String showRemarkReportPass(ModelMap model){
		Report report = new Report();
		report.setType(3);
		report.setState(2);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showRemarkReportPass";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showRemarkReportUnpass")
	public String showRemarkReportUnpass(ModelMap model){
		Report report = new Report();
		report.setType(3);
		report.setState(3);
		List<Report> reports = new ArrayList<>();
		reports = this.reportService.getReports(report);
		model.addAttribute("reports", reports);
		return "/admin/showRemarkReportUnpass";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_userScan")
	public String userScan(User user, ModelMap modelMap){
		user = this.userService.findById(user.getId());
		List<Microblog> microblogs = this.microblogService.getAllNotFollow(user);
		Integer follows = this.followService.countFollows(user);				//关注者人数
		Integer followers = this.followService.countFollowers(user);			//粉丝人数
		modelMap.addAttribute("UserScan", user);
		modelMap.addAttribute("Follows", follows);
		modelMap.addAttribute("Followers", followers);
		modelMap.addAttribute("Microblogs", microblogs);
		return "/admin/userScan";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_showAddAdmin")
	public String showAddAdmin(){
		return "/admin/showAddAdmin";
	}
	
	@RequestMapping(method=RequestMethod.POST,value="admin_addAdminCheck")
	public void addAdminCheck(Admin admin, HttpServletResponse httpServletResponse, ModelMap modelMap){	
		Admin adminTemp = this.adminService.findByName(admin.getName());
		try {
			//用户名或密码错误，返回0
			if(adminTemp==null){
				admin.setPassword(MD5.md5(admin.getPassword()));
				admin.setState(2);
				this.adminService.addAdmin(admin);
				httpServletResponse.getWriter().println("1");
				return;
			}else{
				httpServletResponse.getWriter().println("0");
				return ;
			}
		} catch (IOException | NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("添加管理员错误！");
			logger.error(e.getMessage());
		}
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_logout")
	public String logout(SessionStatus sessionStatus){
		sessionStatus.setComplete();
		return "/admin/login";
	}
	
	@RequestMapping(method=RequestMethod.GET,value="admin_analysisUser")
	public String analysisUser(ModelMap modelMap){
		List<User> users = this.userService.countReport();
		modelMap.addAttribute("users", users);
		return "/admin/analysisUser";
	}
	
	@RequestMapping("admin_editUserState")
	public String editUserState(User user){
		this.userService.editState(user);
		return "redirect:admin_analysisUser.action";
	}
}
