package cn.cslg.microblog.Service;

import java.util.List;

import cn.cslg.microblog.PO.Report;
import cn.cslg.microblog.Util.Page;

public interface ReportService {

	/**
	 * 用户提交举报
	 * @param report
	 */
	int submitReport(Report report);

	/**
	 * 查询举报数量（根据提供的report的属性值）
	 * @param report
	 * @return
	 */
	int countRport(Report report);

	/**
	 * 根据report的type和state，以及page里的beginPage来获取report
	 * @param report
	 * @param page
	 * @return
	 */
	Page getTenReport(Report report, Page page);

	/**
	 * 根据report的type和state取出所有reports
	 * @param report
	 * @return
	 */
	List<Report> getReports(Report report);

	/**
	 * 根据id更改举报状态
	 * @param report
	 */
	void update(Report report);

	/**
	 * 根据id寻找report
	 * @param id
	 * @return
	 */
	Report findById(Integer id);


}
