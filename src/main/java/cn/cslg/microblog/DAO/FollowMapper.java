package cn.cslg.microblog.DAO;

import java.util.List;

import cn.cslg.microblog.PO.Follow;

public interface FollowMapper {
    /*int deleteByPrimaryKey(Integer id);*/
    
    /*int insert(Follow record);*/
    
    /*Follow selectByPrimaryKey(Integer id);*/

    /*int updateByPrimaryKeySelective(Follow record);*/

    /*int updateByPrimaryKey(Follow record);*/
	
	/**
	 * 取消关注
	 * @param follow
	 * @return 1代表删除成功，0代表不存在这条关注关系。
	 */
    int deleteByUserId1AndUserId2(Follow follow);
    
    /**
     * 根据userId1找寻所有关注者
     * @param id
     * @return 
     */
	List<Follow> selectByUserId1(Integer id);

	/**
	 * 查找两人之间是否存在关注关系
	 * @param id
	 * @param id2
	 * @return
	 */
	Follow selectByUserId1AndUserId2(Integer id, Integer id2);

	/**
	 * 统计关注了多少人
	 * @param id
	 * @return
	 */
	Integer countByUserId1(Integer id);

	/**
	 * 统计被多少人关注
	 * @param id
	 * @return
	 */
	Integer countByUserId2(Integer id);
	
	/**
	 * 产生一个关注关系
	 * （可以提高的地方：如果插入的userid在user表中不存在的话，会报错）
	 * @param record
	 * @return
	 */
	int insert(Follow record);
}