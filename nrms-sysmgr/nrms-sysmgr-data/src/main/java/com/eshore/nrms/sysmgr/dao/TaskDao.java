package com.eshore.nrms.sysmgr.dao;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.nrms.sysmgr.pojo.Task;

import java.util.List;

public interface TaskDao extends IBaseDao<Task>{

    /**
     * 查询任务列表
     * @param userId 发布人ID
     * @param taskName 任务名
     * @param taskStatus 任务状态
     * @param page 分页对象
     * @return 返回任务列表
     */
    List<Task> queryPageBean(Integer userId,String taskName, Integer taskStatus, PageConfig page);


}
