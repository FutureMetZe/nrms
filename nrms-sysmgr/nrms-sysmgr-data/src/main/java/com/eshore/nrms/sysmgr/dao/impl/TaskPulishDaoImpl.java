package com.eshore.nrms.sysmgr.dao.impl;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.jpa.dao.impl.JpaDaoImpl;

import com.eshore.nrms.sysmgr.dao.ITaskPublishDao;
import com.eshore.nrms.sysmgr.pojo.Task;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;
 /**
  * 
  * @author wh_zhangjx 任务发布模块dao层实现
  *
  */
@Repository
public class TaskPulishDaoImpl extends JpaDaoImpl<Task> implements ITaskPublishDao {

  @Override
  public List<Task> getTaskList(Task task, PageConfig page) {
    StringBuilder hql = new StringBuilder("from Task t where 1=1 ");
    //默认只查询任务状态为开启的任务
    hql.append(" and t.taskStatus = 1");
    List params = new ArrayList();
    if (StringUtils.isNotBlank(task.getTaskName())) {
      hql.append(" and t.taskName like ? ");
      params.add("%" + task.getTaskName() + "%");
    }
    if (StringUtils.isNotBlank(task.getPublishName())) {
      hql.append(" and t.publishName like ? ");
      params.add("%" + task.getPublishName() + "%");
    }
    /*hql.append(" and t.overTime > CURDATE()");*/
    hql.append(" order by t.createdTime desc ");
    return this.queryPage(hql.toString(), page, params.toArray());
  }



}
