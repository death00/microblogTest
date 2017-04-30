package cn.cslg.microblog.DAO;

import java.util.List;

import cn.cslg.microblog.PO.Microblog;
import cn.cslg.microblog.PO.User;

public interface MicroblogMapper {
    /**
     * 删除微博
     * @param id
     * @return 1代表删除成功，0代表不存在这条微博。
     */
    int deleteByPrimaryKey(Integer id);

    int insertSelective(Microblog record);

    Microblog selectByPrimaryKey(Integer id);

	List<Microblog> selectByIds(List<Integer> users);
	
	/**
	 * 模糊匹配查找content中包含的内容
	 * @param search
	 * @return
	 */
	List<Microblog> selectIllegibilityByContent(List<String> search);

	List<Microblog> selectByUserId(Integer id);

	/**
	 * 查看当前博客被转发多少次
	 * @param id
	 * @return
	 */
	Integer countBySourceMicroblogId(Integer id);
	
	List<Microblog> selectFourByForwardMicroblogId(Integer forwardMicroblogId);

	/**
	 * 查看当前微博被转发数量
	 * @param id
	 * @return
	 */
	Integer countByForwardMicroblogId(Integer id);

	/**
	 * 查看当前页面的转发评论
	 * @param forwardMicroblogId
	 * @param beginPage	开始页（从0开始）
	 * @param everyPage	一页多少条记录
	 * @return
	 */
	List<Microblog> selectPageByForwardMicroblogId(Integer forwardMicroblogId, int beginPage, int everyPage);

	Integer countByUserId(Integer id);

	List<Microblog> selectPageBySourceMicroblogId(Integer forwardMicroblogId, int i, int everyPage);

	List<Microblog> selectFourBySourceMicroblogId(Integer forwardMicroblogId);
}