package com.eshore.nrms.sysmgr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.khala.core.service.impl.BaseServiceImpl;
import com.eshore.nrms.sysmgr.dao.IApplyDao;
import com.eshore.nrms.sysmgr.dao.ITaskPublishDao;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.service.ITaskPublishService;
import com.eshore.nrms.util.PageUtil;
import com.eshore.nrms.vo.PageVo;
/***
 * 
 * @author wh_zhangjx  任务发布接口实现
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class TaskPublishServiceImpl extends BaseServiceImpl<Task> implements ITaskPublishService {
  @Autowired
  private ITaskPublishDao taskPublishDao;
  @Autowired
  private IApplyDao applyDao;
  
  @Override
  public IBaseDao<Task> getDao() {
    return taskPublishDao;
  }

  @Override
  public PageVo<Task> queryTaskByPage(Task task, PageConfig page) {
    List<Task> list = this.taskPublishDao.getTaskList(task, page);
    return PageUtil.getPageList(page, list);
  }

  @Override
  public List<Integer> queryApplyIdsByTaskId(String taskId) {
		return applyDao.queryApplyerIdsByTaskId(taskId);
	
  }

	@Override
	public Integer AppliedWhetherOrNot(String taskId, Integer applyerId) {
		return applyDao.countApplyByTaskIdAndApplyerId(taskId, applyerId);
	}


}
