package com.eshore.nrms.sysmgr.dao;

import java.util.List;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.nrms.sysmgr.pojo.Apply;

/**
 * 
 * @Description: 我的申请模块dao层接口 
 * @author xx
 * @date 2018年5月25日   
 *
 */
public interface IApplyDao extends IBaseDao<Apply> {
	/**
	 * 
	 * @Description: 查询申请列表(分页) 
	 * @param apply
	 * @param page
	 * @return List<Apply>
	 *
	 */
	List<Apply> queryApplyPageList(Apply apply,PageConfig page);
    
	/**
	 * 
	 * @Description: 根据任务id查询申请列表(不分页) 
	 * @param taskId 任务id
	 * @return List<Apply>
	 * 
	 */
    List<Apply> queryApplyListByTaskId(String taskId);
    
   
    /**
     * 
     * @Description: 根据任务id查询所有申请该任务的申请记录，然后修改申请记录中的任务状态
     * @param taskId
     * @param taskStatus
     * @return void
     *
     */
    void updateTaskStatusInApply(String taskId, Integer taskStatus);
    
    /**
     * 
     * @Description: 根据主键查询申请记录，然后修改申请记录中的申请状态 
     * @param @param applyId	申请表主键
     * @param @param applyStatus    要更新为的申请状态  
     * @return void    
     *
     */
    void updateApplyStatusById(String applyId, Integer applyStatus);
    
    /**
     * 
     * @Description: 根据任务id查询所有已申请人的id 
     * @param taskId    任务id  
     * @return List<Integer>    该任务所有申请人的id集合  
     *
     */
    List<Integer> queryApplyerIdsByTaskId(String taskId);
    
    /**
     * 
     * @Description: 根据任务id查询所有已申请人的id 
     * @param taskId    任务id  
     * @return List<Integer>    该任务所有申请人的id集合  
     *
     */
    Integer countApplyByTaskIdAndApplyerId(String taskId, Integer applyerId);
}