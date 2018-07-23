package com.eshore.nrms.sysmgr.service;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.api.IBaseService;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.vo.PageVo;

/**
 * 
 * @Description: 我的申请模块service层接口 
 * @author xx
 * @date 2018年5月25日
 * 
 */
public interface IApplyService extends IBaseService<Apply> {
	/**
	 * 
	 * @Description: 获得申请列表分页信息 
	 * @param apply	申请表pojo
	 * @param page	分页工具pojo
	 * @return PageVo<Apply>	包含申请列表的分页对象	 
	 * 
	 */
	PageVo<Apply> getApplyPageVO(Apply apply, PageConfig page);
	
	/**
	 * 
	 * @Description: 确认申请任务(保存申请信息，更新任务对象) 
	 * @param apply	申请pojo
	 * @param task	当前所申请任务pojo
	 * @return void	无
	 */
	void confirmApplyTask(Apply apply, Task task);
}