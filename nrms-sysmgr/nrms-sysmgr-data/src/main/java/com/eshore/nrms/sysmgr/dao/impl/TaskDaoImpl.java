package com.eshore.nrms.sysmgr.dao.impl;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.jpa.dao.impl.JpaDaoImpl;
import com.eshore.nrms.sysmgr.dao.TaskDao;
import com.eshore.nrms.sysmgr.pojo.Task;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;


import java.util.ArrayList;
import java.util.List;

@Repository
public class TaskDaoImpl extends JpaDaoImpl<Task> implements TaskDao {

    @Override
    public List<Task> queryPageBean(Integer userId,String taskName, Integer taskStatus, PageConfig page) {
        StringBuilder hql = new StringBuilder("from Task t where 1=1 ");
        List params = new ArrayList();

        hql.append(" and t.publisherId = ? ");
        params.add(userId);

        if(StringUtils.isNotBlank(taskName)){
            hql.append(" and t.taskName like ? ");
            params.add("%" + taskName + "%");
        }
        if(taskStatus!=null){
            hql.append(" and t.taskStatus = ? ");
            params.add(taskStatus);
        }
        hql.append("  order by createdTime desc");
        return this.queryPage(hql.toString(), page, params.toArray());
    }
}
