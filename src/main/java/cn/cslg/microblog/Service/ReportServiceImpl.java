package cn.cslg.microblog.Service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.cslg.microblog.DAO.ReportMapper;
import cn.cslg.microblog.PO.Report;
import cn.cslg.microblog.PO.User;
import cn.cslg.microblog.Util.Page;

@Service("reportService")
public class ReportServiceImpl implements ReportService {

	@Resource
	private ReportMapper reportMapper;
	
	@Resource
	private UserService userService;
	
	@Override
	public int submitReport(Report report) {
		return this.reportMapper.insertSelective(report);
	}

	@Override
	public int countRport(Report report) {
		return this.reportMapper.count(report);
	}

	@Override
	public Page getTenReport(Report report, Page page) {
		List<Report> reports = new ArrayList<>();
		reports = this.reportMapper.selectPage(report.getType(), report.getState(), 
				(page.getBeginPage() - 1)*page.getEveryPage(), page.getEveryPage());
		page.setList(reports);
		int totalCount = this.reportMapper.count(report);
		page.setTotalCount(totalCount);
		page.init();
		return page;
	}

	@Override
	public List<Report> getReports(Report report) {
		List<Report> reports = new ArrayList<>();
		reports = this.reportMapper.selectByReport(report.getType(), report.getState());
		for (Report reportTemp : reports) {
			User user1 = userService.findById(reportTemp.getReporterid());
			reportTemp.setReporterUser(user1);
			User user2 = userService.findById(reportTemp.getReportedUserId());
			reportTemp.setReportedUser(user2);
		}
		return reports;
	}

	@Override
	public void update(Report report) {
		this.reportMapper.updateByPrimaryKeySelective(report);
	}

	@Override
	public Report findById(Integer id) {
		Report report = this.reportMapper.selectById(id);
		User user1 = userService.findById(report.getReporterid());
		report.setReporterUser(user1);
		User user2 = userService.findById(report.getReportedUserId());
		report.setReportedUser(user2);
		return report;
	}

}
