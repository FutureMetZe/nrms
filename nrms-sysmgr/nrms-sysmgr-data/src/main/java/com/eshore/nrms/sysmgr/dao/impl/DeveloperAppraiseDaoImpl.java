package com.eshore.nrms.sysmgr.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.jpa.dao.impl.JpaDaoImpl;
import com.eshore.nrms.sysmgr.dao.IDeveloperAppraiseDao;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;

import javax.persistence.Query;

/**
 * 评价Dao实现类
 */
@Repository
public class DeveloperAppraiseDaoImpl extends JpaDaoImpl<DeveloperAppraise> implements IDeveloperAppraiseDao {

	/**
	 * 传入参数是developerId，developerName(模糊查询)，PageConfig
	 */
	@Override
	public List<DeveloperAppraise> queryDeveloperAppraise(PageConfig pageConfig, DeveloperAppraise appraise) {
		StringBuilder hql = new StringBuilder("from DeveloperAppraise da where 1 = 1");
		List<Object> params = new ArrayList<>();
		if (appraise.getDeveloperId() != null) {
			hql.append(" and da.developerId = ?");
			params.add(appraise.getDeveloperId());
		}
		if (!(appraise.getDeveloperName() == null 
				|| appraise.getDeveloperName().length() == 0)) {
			hql.append(" and da.developerName like ?");
			params.add("%" + appraise.getDeveloperName() + "%");
		}
		hql.append(" order by da.appraiseDate desc");
		return this.queryPage(hql.toString(), pageConfig, params.toArray());
	}

	/**
	 * 同时查询两个属性，结果唯一
	 */
	@Override
	public DeveloperAppraise queryUniqueDeveloperAppraise(DeveloperAppraise developerAppraise) {
		StringBuilder hql = new StringBuilder("from DeveloperAppraise da where 1 = 1");
		List<Object> params = new ArrayList<>();
		if (developerAppraise.getDeveloperId() != null) {
			hql.append(" and da.developerId = ?");
			params.add(developerAppraise.getDeveloperId());
		}
		if (!(developerAppraise.getApplyId() == null || developerAppraise.getApplyId().length() == 0)) {
			hql.append(" and da.applyId = ?");
			params.add(developerAppraise.getApplyId());
		}
		return this.getPojo(hql.toString(), params.toArray());
	}

	@Override
	public Integer queryCountByApplyId(String applyId) {
		/**
		 * 使用父类中的queryCount(hql,params)实现
		 */
		String hql = "select count(*) from DeveloperAppraise da where da.applyId = ?";
		List<Object> params = new ArrayList<>();
		params.add(applyId);
		return this.queryCount(hql,params.toArray());
		/*Query query = this.entityManager.createNativeQuery("select count(*) from developer_appraise where apply_id = ?");
		query.setParameter(1, applyId);
		return Integer.valueOf(query.getSingleResult().toString());*/
	}
}
