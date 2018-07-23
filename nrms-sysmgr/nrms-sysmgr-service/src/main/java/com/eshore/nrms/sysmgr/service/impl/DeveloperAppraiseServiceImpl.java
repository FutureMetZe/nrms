package com.eshore.nrms.sysmgr.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.khala.core.service.impl.BaseServiceImpl;
import com.eshore.nrms.sysmgr.dao.IApplyDao;
import com.eshore.nrms.sysmgr.dao.IDeveloperAppraiseDao;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;
import com.eshore.nrms.sysmgr.service.IDeveloperAppraiseService;
import com.eshore.nrms.util.DateUtils;
import com.eshore.nrms.util.PageUtil;
import com.eshore.nrms.vo.PageVo;

/**
 * 评价Service实现类
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class DeveloperAppraiseServiceImpl 
		extends BaseServiceImpl<DeveloperAppraise> 
		implements IDeveloperAppraiseService {

	@Autowired
	private IDeveloperAppraiseDao developerAppraiseDao;
	
	@Autowired
	private IApplyDao applyDao;
	
	@Override
	public IBaseDao<DeveloperAppraise> getDao() {
		return developerAppraiseDao;
	}
	
	@Override
	@Transactional(readOnly = true)
	public PageVo<DeveloperAppraise> queryPageBean(Integer devId, String devName, PageConfig pageConfig) {
		DeveloperAppraise appraise = new DeveloperAppraise();
		appraise.setDeveloperId(devId);
		appraise.setDeveloperName(devName);
		List<DeveloperAppraise> developerAppraiseList 
				= developerAppraiseDao.queryDeveloperAppraise(pageConfig, appraise);
		return PageUtil.getPageList(pageConfig, developerAppraiseList);
	}

	@Override
	public DeveloperAppraise queryUniqueAppraise(DeveloperAppraise developerAppraise) {
		return developerAppraiseDao.queryUniqueDeveloperAppraise(developerAppraise);
	}

	@Override
	public void addTeamAppraise(List<DeveloperAppraise> appraiseList, String applyId) {
		for(DeveloperAppraise appraise : appraiseList) {
			DeveloperAppraise findAppraise = this.get(appraise.getId());
			findAppraise.setScore(appraise.getScore());
			findAppraise.setAppraiseContent(appraise.getAppraiseContent());
			findAppraise.setAppraiseDate(DateUtils.getDate());
			this.update(findAppraise);
		}
		Apply apply = applyDao.get(applyId);
		apply.setAppraiseStatus(1);
		applyDao.update(apply);
	}

	@Override
	public List<DeveloperAppraise> queryAppraiseByApplyIdAndDevIdList(Apply apply) {
		String[] devIdArray = apply.getDeveloperIdList().split(",");
		List<DeveloperAppraise> appraiseList = new ArrayList<>();
		for (String id : devIdArray) {
			Integer idToInt = Integer.valueOf(id);
			DeveloperAppraise appraise = new DeveloperAppraise();
			appraise.setApplyId(apply.getApplyId());
			appraise.setDeveloperId(idToInt);
			DeveloperAppraise a = this.queryUniqueAppraise(appraise);
			if (a != null) {
				appraiseList.add(a);
			}
		}
		return appraiseList;
	}

}
