package cn.cslg.microblog.DAO;

import java.util.List;

import cn.cslg.microblog.PO.Report;

public interface ReportMapper {

    int insert(Report record);

    int insertSelective(Report record);

    int updateByPrimaryKeySelective(Report record);

    int updateByPrimaryKey(Report record);

	int count(Report report);

	List<Report> selectPage(Integer type, Integer state, int i, int everyPage);

	List<Report> selectByReport(Integer type, Integer state);

	Report selectById(Integer id);
}