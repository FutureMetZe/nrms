package com.eshore.nrms.sysmgr.dao;

import java.util.List;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.nrms.sysmgr.pojo.Task;
/**
 * 
 * @author wh_zhangjx 任务发布模块dao层接口
 *
 */
public interface ITaskPublishDao extends IBaseDao<Task> {
  /***
   * 
   * @param task  查询参数 task封装
   * @param page  分页查询参数
   * @return   返回任务链表
   */
  List<Task> getTaskList(Task task, PageConfig page);

}
