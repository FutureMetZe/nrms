package com.eshore.nrms.sysmgr.dao;

import java.util.List;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;

/**
 * 评价Dao接口
 */
public interface IDeveloperAppraiseDao extends IBaseDao<DeveloperAppraise> {
	
	/**
	 * 查询评价列表
	 * @param pageConfig 分页信息
	 * @param appraise 待查询的评价
	 * @return 评价列表
	 */
	List<DeveloperAppraise> queryDeveloperAppraise(PageConfig pageConfig, DeveloperAppraise appraise);
	
	/**
	 * 查询唯一评价
	 * @param developerAppraise 待查询的评价
	 * @return 查询到的评价
	 */
	DeveloperAppraise queryUniqueDeveloperAppraise(DeveloperAppraise developerAppraise);

	/**
	 * 根据申请ID查询评价数
	 * @param applyId 申请ID
	 * @return 评价数
	 */
    Integer queryCountByApplyId(String applyId);
}
