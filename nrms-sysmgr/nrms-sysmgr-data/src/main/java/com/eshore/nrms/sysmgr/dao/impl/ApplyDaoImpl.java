package com.eshore.nrms.sysmgr.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.jpa.dao.impl.JpaDaoImpl;
import com.eshore.nrms.sysmgr.dao.IApplyDao;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.Task;

/**
 * 
 * @Description: 我的申请模块dao层接口实现类  
 * @author xx
 * @date 2018年5月25日   
 *
 */
@Repository
public class ApplyDaoImpl extends JpaDaoImpl<Apply> implements IApplyDao {
	
	@Override
    public List<Apply> queryApplyPageList(Apply apply, PageConfig page) {
        StringBuilder hql = new StringBuilder("from Apply a where 1=1 ");
        List params = new ArrayList();

        if (apply.getApplyerId() != null) {
            hql.append(" and a.applyerId = ? ");
            params.add(apply.getApplyerId());      
        }  
        
        if (apply.getAppraiseStatus() != null) {
            hql.append(" and a.appraiseStatus = ? ");
            params.add(apply.getAppraiseStatus());      
        } 
        
        if (apply.getPublisherId() != null) {
            hql.append(" and a.publisherId = ? ");
            params.add(apply.getPublisherId());      
        } 
        
        
        if (apply.getTaskName() != null) {
            hql.append(" and a.taskName like ? ");
            params.add("%" + apply.getTaskName() + "%");      
        }                                                     
                                                              
        if (apply.getApplyStatus() != null) {                      
            hql.append(" and a.applyStatus = ? ");             
            params.add(apply.getApplyStatus());                
        }                                                      
                                                               
        if (apply.getTaskStatus() != null) {                       
            hql.append(" and a.taskStatus = ? ");              
            params.add(apply.getTaskStatus());                 
        } 
        
        if (apply.getTaskId() != null) {                       
            hql.append(" and a.taskId = ? ");              
            params.add(apply.getTaskId());                 
        } 
        hql.append("  order by a.applyStatus desc, a.applyDate desc");             
        return this.queryPage(hql.toString(), page, params.toArray());
    }
	
	@Override
	public List<Apply> queryApplyListByTaskId(String taskId) {
		 Query query = this.entityManager.createNativeQuery("select * from apply where task_Id = ?", Apply.class);
		 query.setParameter(1, taskId);
		 return query.getResultList();
	}
	
	@Override
	public void updateTaskStatusInApply(String taskId, Integer taskStatus) {
		List<Apply> applyList = queryApplyListByTaskId(taskId);
		for (Apply apply : applyList) {
			apply.setTaskStatus(taskStatus);
			entityManager.persist(apply);
		}
		entityManager.flush();
	}
	
	@Override
	public void updateApplyStatusById(String applyId, Integer applyStatus) {
		Apply apply = entityManager.find(Apply.class, applyId);
		apply.setApplyStatus(applyStatus);
		entityManager.persist(apply);
		entityManager.flush();
	}

	@Override
	public List<Integer> queryApplyerIdsByTaskId(String taskId) {
		List<Integer> applyerIdList = new ArrayList<Integer>();
		Query q = entityManager.createQuery("from Apply where taskId = ?");
		q.setParameter(1, taskId);
		List<Apply> list = q.getResultList();
		if (list == null || list.isEmpty()) {
			return null;
		} else {
			for(Apply apply : list) {
				applyerIdList.add(apply.getApplyerId());
			}
		}
		return applyerIdList;
	}

	@Override
	public Integer countApplyByTaskIdAndApplyerId(String taskId, Integer applyerId) {
		String hql = "select count(*) from Apply a where a.taskId=? and a.applyerId=?";
		List params = new ArrayList();
		params.add(taskId);
		params.add(applyerId);
		return queryCount(hql, params.toArray());
	}

}
