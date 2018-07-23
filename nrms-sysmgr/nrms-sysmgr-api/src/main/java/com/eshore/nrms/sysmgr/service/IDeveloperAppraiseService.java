/**
 * 
 */
package com.eshore.nrms.sysmgr.service;

import java.util.List;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.api.IBaseService;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;
import com.eshore.nrms.vo.PageVo;

/**
 *评价Service接口
 */
public interface IDeveloperAppraiseService extends IBaseService<DeveloperAppraise> {
	/**
	 * 根据开发人员ID，开发人员姓名分页查询评价
	 * @param devId 开发人员ID
	 * @param devName 开发人员姓名
	 * @param pageConfig 分页信息
	 * @return 带有分页信息和列表的vo
	 */
	PageVo<DeveloperAppraise> queryPageBean(Integer devId, String devName, PageConfig pageConfig);
	
	/**
	 * 根据申请id和开发人员id列表查询评价信息
	 * @param apply 包含applyId 和developerIdList
	 * @return 评价列表
	 */
	List<DeveloperAppraise> queryAppraiseByApplyIdAndDevIdList(Apply apply);
	
	/**
	 * 查询唯一评价
	 * @param developerAppraise 待查询评价
	 * @return	查询到的评价
	 */
	DeveloperAppraise queryUniqueAppraise(DeveloperAppraise developerAppraise);
	
	/**
	 * 批量添加一个申请的所有开发人员评价，并修改申请的评价状态
	 * @param appraiseList 评价list
	 * @param applyId 申请ID
	 */
	void addTeamAppraise(List<DeveloperAppraise> appraiseList, String applyId);
}
